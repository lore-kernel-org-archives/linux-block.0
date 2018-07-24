Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36408 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388248AbeGXQiw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jul 2018 12:38:52 -0400
Received: by mail-qk0-f181.google.com with SMTP id a132-v6so2873476qkg.3
        for <linux-block@vger.kernel.org>; Tue, 24 Jul 2018 08:31:51 -0700 (PDT)
Message-ID: <1532446308.9819.7.camel@redhat.com>
Subject: Re: data corruption with 'splt' workload to XFS on DM cache with
 its 3 underlying devices being on same NVMe device
From: Laurence Oberman <loberman@redhat.com>
To: Mike Snitzer <snitzer@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Brett Hull <bhull@redhat.com>
Date: Tue, 24 Jul 2018 11:31:48 -0400
In-Reply-To: <20180724151845.GB3235@redhat.com>
References: <20180723163357.GA29658@redhat.com>
         <e761830f-e3f7-3e88-1697-b4b150e84e5f@suse.de>
         <20180724130703.GA30804@redhat.com>
         <27cadfb3-2442-3931-6d58-58aa6adb2e2b@suse.de>
         <1532440623.9819.4.camel@redhat.com> <20180724151845.GB3235@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2018-07-24 at 11:18 -0400, Mike Snitzer wrote:
> On Tue, Jul 24 2018 at  9:57am -0400,
> Laurence Oberman <loberman@redhat.com> wrote:
> 
> > On Tue, 2018-07-24 at 15:51 +0200, Hannes Reinecke wrote:
> > > 
> > > _Actually_, I would've done it the other way around; after all,
> > > where't the point in running dm-multipath on a partition?
> > > Anything running on the other partitions would suffer from the
> > > issues dm-multipath is designed to handle (temporary path loss
> > > etc), so I'm
> > > not quite sure what you are trying to achieve with your testcase.
> > > Can you enlighten me?
> > > 
> > > Cheers,
> > > 
> > > Hannes
> 
> I wasn't looking to deply this (multipath on partition) in production
> or
> suggest it to others.  It was a means to experiment.  More below.
> 
> > This came about because a customer is using nvme for a dm-cache
> > device
> > and created multiple partitions so as to use the same nvme to cache
> > multiple different "slower" devices. The corruption was noticed in
> > XFS
> > and I engaged Mike to assist in figuring out what was going on.
> 
> Yes, so topology for the customer's setup is:
> 
> 1) MD raid1 on 2 NVMe partitions (from separate NVMe devices).
> 2) Then DM cache's "fast" and "metadata" devices layered on dm-linear
>    mapping ontop of the MD raid1.
> 3) Then Ceph's rbd for DM-cache's slow device.
> 
> I was just looking to simplify the stack to try to assess why XFS
> corruption was being seen without all the insanity.
> 
> One issue was corruption due to incorrect shutdown order (network was
> getting shutdown out from underneath rbd, and in turn DM-cache
> couldn't
> complete its IO migrations during cache_postsuspend()).
> 
> So I elected to try using DM multipath with queue_if_no_path to try
> to
> replicate rbd losing network _without_ needing a full Ceph/rbd setup.
> 
> The rest is history... a rat-hole of corruption that likely is very
> different than the customer's setup.
> 
> Mike
Not to muddy the waters here, and as Mike said the issue he tripped
over may not be the direct issue we originally started with.

In the lab reproducer with rbd as a slow devices we do not have an MD
raided nvme for the dm-cache, but we still see the corruption only on
the rbd based test.

We used the nvme partitioned but no DM raid to try an F/C device-
mapper-multipath LUNS cached via dm-cache.

The last test we ran where we did not see corruption was a partition
where the second partition was used to cache F/C luns

nvme0n1                             259:0    0 372.6G  0 disk  
├─nvme0n1p1                         259:1    0   150G  0 part  
└─nvme0n1p2                         259:2    0   150G  0 part  
  ├─cache_FC-nvme_blk_cache_cdata   253:42   0    20G  0 lvm   
  │ └─cache_FC-fc_disk              253:45   0    48G  0
lvm   /cache_FC
  └─cache_FC-nvme_blk_cache_cmeta   253:43   0    40M  0 lvm   
    └─cache_FC-fc_disk              253:45   0    48G  0
lvm   /cache_FC

cache_FC-fc_disk (253:45)
 ├─cache_FC-fc_disk_corig (253:44)
 │  └─3600140508da66c2c9ee4cc6aface1bab (253:36) Multipath
 │     ├─ (68:224)
 │     ├─ (69:240)
 │     ├─ (8:192)
 │     └─ (8:64)
 ├─cache_FC-nvme_blk_cache_cdata (253:42)
 │  └─ (259:2)
 └─cache_FC-nvme_blk_cache_cmeta (253:43)
    └─ (259:2)

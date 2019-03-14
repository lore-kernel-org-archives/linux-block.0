Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BB5C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 12:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5040C20854
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 12:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfCNMNr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:13:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfCNMNr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 08:13:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78B0718DF7B;
        Thu, 14 Mar 2019 12:13:46 +0000 (UTC)
Received: from gondolin (ovpn-116-124.ams2.redhat.com [10.36.116.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E7EB60CD1;
        Thu, 14 Mar 2019 12:13:42 +0000 (UTC)
Date:   Thu, 14 Mar 2019 13:13:39 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
Message-ID: <20190314131339.1b61fff6.cohuck@redhat.com>
In-Reply-To: <a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
        <20190312183351.74764f4f.cohuck@redhat.com>
        <173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
        <20190313103900.1ea7f996.cohuck@redhat.com>
        <a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 14 Mar 2019 12:13:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 14 Mar 2019 14:12:32 +0800
Dongli Zhang <dongli.zhang@oracle.com> wrote:

> On 3/13/19 5:39 PM, Cornelia Huck wrote:
> > On Wed, 13 Mar 2019 11:26:04 +0800
> > Dongli Zhang <dongli.zhang@oracle.com> wrote:
> >   
> >> On 3/13/19 1:33 AM, Cornelia Huck wrote:  
> >>> On Tue, 12 Mar 2019 10:22:46 -0700 (PDT)
> >>> Dongli Zhang <dongli.zhang@oracle.com> wrote:

> >>>> Is this by design on purpose, or can we fix with below?
> >>>>
> >>>>
> >>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> >>>> index 4bc083b..df95ce3 100644
> >>>> --- a/drivers/block/virtio_blk.c
> >>>> +++ b/drivers/block/virtio_blk.c
> >>>> @@ -513,6 +513,8 @@ static int init_vq(struct virtio_blk *vblk)
> >>>>  	if (err)
> >>>>  		num_vqs = 1;
> >>>>  
> >>>> +	num_vqs = min(num_possible_cpus(), num_vqs);
> >>>> +
> >>>>  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
> >>>>  	if (!vblk->vqs)
> >>>>  		return -ENOMEM;    
> >>>
> >>> virtio-blk, however, is not pci-specific.
> >>>
> >>> If we are using the ccw transport on s390, a completely different
> >>> interrupt mechanism is in use ('floating' interrupts, which are not
> >>> per-cpu). A check like that should therefore not go into the generic
> >>> driver.
> >>>     
> >>
> >> So far there seems two options.
> >>
> >> The 1st option is to ask the qemu user to always specify "-num-queues" with the
> >> same number of vcpus when running x86 guest with pci for virtio-blk or
> >> virtio-scsi, in order to assign a vector for each queue.  
> > 
> > That does seem like an extra burden for the user: IIUC, things work
> > even if you have too many queues, it's just not optimal. It sounds like
> > something that can be done by a management layer (e.g. libvirt), though.
> >   
> >> Or, is it fine for virtio folks to add a new hook to 'struct virtio_config_ops'
> >> so that different platforms (e.g., pci or ccw) would use different ways to limit
> >> the max number of queues in guest, with something like below?  
> > 
> > That sounds better, as both transports and drivers can opt-in here.
> > 
> > However, maybe it would be even better to try to come up with a better
> > strategy of allocating msix vectors in virtio-pci. More vectors in the
> > num_queues > num_cpus case, even if they still need to be shared?
> > Individual vectors for n-1 cpus and then a shared one for the remaining
> > queues?
> > 
> > It might even be device-specific: Have some low-traffic status queues
> > share a vector, and provide an individual vector for high-traffic
> > queues. Would need some device<->transport interface, obviously.
> >   
> 
> This sounds a little bit similar to multiple hctx maps?
> 
> So far, as virtio-blk only supports set->nr_maps = 1, no matter how many hw
> queues are assigned for virtio-blk, blk_mq_alloc_tag_set() would use at most
> nr_cpu_ids hw queues.
> 
> 2981 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
> ... ...
> 3021         /*
> 3022          * There is no use for more h/w queues than cpus if we just have
> 3023          * a single map
> 3024          */
> 3025         if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
> 3026                 set->nr_hw_queues = nr_cpu_ids;
> 
> Even the block layer would limit the number of hw queues by nr_cpu_ids when
> (set->nr_maps == 1).

Correct me if I'm wrong, but there seem to be two kinds of limitations
involved here:
- Allocation of msix vectors by the virtio-pci transport. We end up
  with shared vectors if we have more virtqueues than vcpus. Other
  transports may or may not have similar issues, but essentially, this
  is something that applies to all kind of virtio devices attached via
  the virtio-pci transport.
- The block layer limits the number of hw queues to the number of
  vcpus. This applies only to virtio devices that interact with the
  block layer, but regardless of the virtio transport.

> That's why I think virtio-blk should use the similar solution as nvme
> (regardless about write_queues and poll_queues) and xen-blkfront.

Ok, the hw queues limit from above would be an argument to limit to
#vcpus in the virtio-blk driver, regardless of the transport used. (No
idea if there are better ways to deal with this, I'm not familiar with
the interface.)

For virtio devices that don't interact with the block layer and are
attached via the virtio-pci transport, it might still make sense to
revisit vector allocation.

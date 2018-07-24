Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388352AbeGXO5n (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jul 2018 10:57:43 -0400
Subject: Re: data corruption with 'splt' workload to XFS on DM cache with its
 3 underlying devices being on same NVMe device
To: Mike Snitzer <snitzer@redhat.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com
References: <20180723163357.GA29658@redhat.com>
 <e761830f-e3f7-3e88-1697-b4b150e84e5f@suse.de>
 <20180724130703.GA30804@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <27cadfb3-2442-3931-6d58-58aa6adb2e2b@suse.de>
Date: Tue, 24 Jul 2018 15:51:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180724130703.GA30804@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/24/2018 03:07 PM, Mike Snitzer wrote:
> On Tue, Jul 24 2018 at  2:00am -0400,
> Hannes Reinecke <hare@suse.de> wrote:
> 
>> On 07/23/2018 06:33 PM, Mike Snitzer wrote:
>>> Hi,
>>>
>>> I've opened the following public BZ:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1607527
>>>
>>> Feel free to add comments to that BZ if you have a redhat bugzilla
>>> account.
>>>
>>> But otherwise, happy to get as much feedback and discussion going purely
>>> on the relevant lists.  I've taken ~1.5 weeks to categorize and isolate
>>> this issue.  But I've reached a point where I'm getting diminishing
>>> returns and could _really_ use the collective eyeballs and expertise of
>>> the community.  This is by far one of the most nasty cases of corruption
>>> I've seen in a while.  Not sure where the ultimate cause of corruption
>>> lies (that the money question) but it _feels_ rooted in NVMe and is
>>> unique to this particular workload I've stumbled onto via customer
>>> escalation and then trying to replicate an rbd device using a more
>>> approachable one (request-based DM multipath in this case).
>>>
>> I might be stating the obvious, but so far we only have considered
>> request-based multipath as being active for the _entire_ device.
>> To my knowledge we've never tested that when running on a partition.
> 
> True.  We only ever support mapping the partitions ontop of
> request-based multipath (via dm-linear volumes created by kpartx).
> 
>> So, have you tested that request-based multipathing works on a
>> partition _at all_? I'm not sure if partition mapping is done
>> correctly here; we never remap the start of the request (nor bio,
>> come to speak of it), so it looks as if we would be doing the wrong
>> things here.
>>
>> Have you checked that partition remapping is done correctly?
> 
> It clearly doesn't work.  Not quite following why but...
> 
> After running the test the partition table at the start of the whole
> NVMe device is overwritten by XFS.  So likely the IO destined to the
> dm-cache's "slow" (dm-mpath device on NVMe partition) was issued to the
> whole NVMe device:
> 
> # pvcreate /dev/nvme1n1
> WARNING: xfs signature detected on /dev/nvme1n1 at offset 0. Wipe it? [y/n]
> 
> # vgcreate test /dev/nvme1n1
> # lvcreate -n slow -L 512G test
> WARNING: xfs signature detected on /dev/test/slow at offset 0. Wipe it?
> [y/n]: y
>    Wiping xfs signature on /dev/test/slow.
>    Logical volume "slow" created.
> 
> Isn't this a failing of block core's partitioning?  Why should a target
> that is given the entire partition of a device need to be concerned with
> remapping IO?  Shouldn't block core handle that mapping?
> 
Only if the device is marked a 'partitionable', which device-mapper 
devices are not.
But I thought you knew that ...

> Anyway, yesterday I went so far as to hack together request-based
> support for DM linear (because request-based DM cannot stack on
> bio-based DM) .  With this, request-based linear devices instead of
> conventional partitioning, I no longer see the XFS corruption when
> running the test:
> 
_Actually_, I would've done it the other way around; after all, where't 
the point in running dm-multipath on a partition?
Anything running on the other partitions would suffer from the issues 
dm-multipath is designed to handle (temporary path loss etc), so I'm not 
quite sure what you are trying to achieve with your testcase.
Can you enlighten me?

Cheers,

Hannes

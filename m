Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932204AbeGDF7C (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Jul 2018 01:59:02 -0400
Subject: Re: [PATCH blktests v2 3/3] Add tests for the SRP initiator and
 target drivers
To: Omar Sandoval <osandov@osandov.com>,
        Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180627214908.26379-1-bart.vanassche@wdc.com>
 <20180627214908.26379-4-bart.vanassche@wdc.com>
 <20180628234305.GB14953@vader> <90b8682d-7010-5f57-9ecd-3a4c733ccc18@wdc.com>
 <20180703194913.GA25954@vader> <20180703195010.GB25954@vader>
 <20180703213918.GC25954@vader>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f454f087-c672-0495-3209-5f65114daab6@suse.de>
Date: Wed, 4 Jul 2018 07:59:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180703213918.GC25954@vader>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/03/2018 11:39 PM, Omar Sandoval wrote:
> On Tue, Jul 03, 2018 at 12:50:10PM -0700, Omar Sandoval wrote:
>> On Tue, Jul 03, 2018 at 12:49:13PM -0700, Omar Sandoval wrote:
>>> On Fri, Jun 29, 2018 at 09:13:53AM -0700, Bart Van Assche wrote:
>>>> On 06/28/18 16:43, Omar Sandoval wrote:
>>>>> On Wed, Jun 27, 2018 at 02:49:08PM -0700, Bart Van Assche wrote:
>>>>> [ ... ]
>>>>> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
>>>>> runtime  6.680s  ...  6.640s
>>>>>      --- tests/srp/002.out       2018-06-28 15:18:36.537169282 -0700
>>>>>      +++ results/nodev/srp/002.out.bad   2018-06-28 16:21:59.930603931 -0700
>>>>>      @@ -3,5 +3,4 @@
>>>>>       Unloaded the rdma_rxe kernel module
>>>>>       Configured SRP target driver
>>>>>       Unloaded the ib_srp kernel module
>>>>>      -Unloaded the ib_srpt kernel module
>>>>>      -Unloaded the rdma_rxe kernel module
>>>>>      +/dev/disk/by-id/dm-uuid-mpath-3600140572616d6469736b31000000000: not found
>>>>>
>>>>> And everything else fails like srp/002.
>>>>
>>>> I think that indicates a problem with the multipathing software on your
>>>> setup. Was multipathd running? Had the proper multipath configuration
>>>> (/etc/multipath.conf) been provided? Was multipathing enabled in the kernel
>>>> config?
>>>
>>> Ah, the README says /etc/multipathd.conf. Fixing it to multipath.conf
>>> didn't work, either, though.
>>
>> Hit send too early. multipathd is running, but I did find this in my
>> dmesg:
>>
>> [ 1844.347561] multipath[6558]: segfault at 100 ip 00007fbb7cda51e6 sp 00007fffe9241798 error 4 in libc-2.27.so[7fbb7cd0e000+1b3000]
>>
>> I'll look into that.
> 
> Alright, I installed multipath-tools from source and the segfaults are
> gone, but I still don't get these symlinks. Instead, they show up as
> 
> /dev/disk/by-id/scsi-3600140572616d6469736b32000000000
> 
> Any ideas?
> 
Yes.

Symlink generation strongly depends on the OS you're running. With a
recent distro you should be getting a lot of symlinks with the WWN of
the disk in it, like

/dev/disk/by-id/dm-uuid-mpath-<WWN>
/dev/disk/by-id/dm-name-<WWN>
/dev/disk/by-id/scsi-<WWN>
/dev/disk/by-id/wwn-<nearly the same WWN>

originally we just specified /dev/disk/by-id/scsi-<WWN> to be stable,
and that's also the one you're most likely to find.

However, you might get more than _one_ /dev/disk/by-id/scsi-<wwn>, as
these merely reflect the contents of the VPD page 83. So if that
provides more than one identifier per disk you'll get more than one link.

Rule of thumb: Use the WWN starting with the highest number; that is
having the best chance of being actually persistent.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)

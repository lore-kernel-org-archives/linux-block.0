Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7FEC43219
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 09:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiKRJt2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiKRJtP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 04:49:15 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520F44AF39
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 01:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668764954; x=1700300954;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=3V24MFLVHFLKz82bRi79j12G4NmD/xx6ifgd/kxVlUs=;
  b=pHVj+l6w3nV1R9n7HBryvCK1w8NCxTl0xVHMWnmTJSZ/fszYwILSt6x/
   VYgqDotxyeBiHUY5dr02BAew5NX68+jPPgzzvQvH2bW86DskfzzDfvO6k
   Rv3NB4SItEqgAMPlTXI8TKM7itLoe+ih64sF5t1AlhMgQcQhMTaG8MSVL
   J4QM5JaqTS/Lu2vcthoV2AqRfn+1z9ZHFNMLseD0yxr3CX3gGf6FnLJ+l
   KmGrULosMCscnx4zo6+fvpPboalOIvaurw06jDg+EinM0SC9kNVvODsCo
   Jm+xo8+501xODXPLG0FlEKTufdb3GUded/Zt/8Bxlu3r6C7OslTRUsmn0
   w==;
X-IronPort-AV: E=Sophos;i="5.96,173,1665417600"; 
   d="scan'208";a="221758194"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2022 17:49:13 +0800
IronPort-SDR: c/EFlB5OZ4XKuV6c9TH1yOu+QCXGdfrathPDIuCLKWDVR/EJ0ZkpAANgJulaxlW494aTRWDWYw
 0Uk5vwGxsi55A+edQ185PE8xPGyXHfAJxLd5rXwk30/9NQdHdlxgNbcfHHrEkcnyxgkmIh4Z/k
 l+wfh0o+X2yu6tI+q/FGpTdZ9Xrd6ZY8NWoW6H6hS5qtiIY//XUvBj8Y9p68gJyEqxdM2Q26T4
 XcpkZJkgu866QSg0CaXcmTd0urYHUiynA9rScRPIOhB4EEzTtUQBX4N+60vtvJv85UR1/dVOLp
 PIM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2022 01:08:07 -0800
IronPort-SDR: EchVa34z1+sdnBcoE3mUjnq33CCf5C55HRslq8z6ntwP9rQ+GlTLy8Th5Zhzolxvrmj7NbeJWy
 PlIaYOh6bfLkEbOX+N47Fv99Mfv5oj0JohATbluKT152dUz9IDM1YbfN1v+5pxZvnbNiN9cJTa
 UFyHWfdtDrYBsmNZXOAdkSKo9S4q3ZpGnXSQ9kqIgrgLCkA0JozKRuQw2c3Qmvz+SgO9sYOSUa
 00YmR5Vpk4brm7+RRgYgSMz5zKunifEm8qvPTeERN8bavQT/g+yhMSunCb9QLJOaJGlDgup7id
 Jdo=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO localhost) ([10.200.210.81])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Nov 2022 01:49:12 -0800
References: <87sfii99e7.fsf@wdc.com> <Y3WZ41tKFZHkTSHL@T590>
 <87o7t67zzv.fsf@wdc.com> <Y3X2M3CSULigQr4f@T590> <87k03u7x3r.fsf@wdc.com>
 <Y3YfUjrrLJzPWc4H@T590> <87fseh92aa.fsf@wdc.com> <Y3cGM0es14vj3n3N@T590>
 <2f86eb58-148b-03ac-d2bf-d67c5756a7a6@opensource.wdc.com>
 <Y3chDDdbuN99l7v7@T590>
User-agent: mu4e 1.8.11; emacs 28.2.50
From:   Andreas Hindborg <andreas.hindborg@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Andreas Hindborg <andreas.hindborg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: Reordering of ublk IO requests
Date:   Fri, 18 Nov 2022 10:41:31 +0100
In-reply-to: <Y3chDDdbuN99l7v7@T590>
Message-ID: <8735ag8ueg.fsf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming Lei <ming.lei@redhat.com> writes:

> CAUTION: This email originated from outside of Western Digital. Do not click on
> links or open attachments unless you recognize the sender and know that the
> content is safe.
>
>
> On Fri, Nov 18, 2022 at 01:35:29PM +0900, Damien Le Moal wrote:
>> On 11/18/22 13:12, Ming Lei wrote:
>> [...]
>> >>> You can only assign it to zoned write request, but you still have to check
>> >>> the sequence inside each zone, right? Then why not just check LBAs in
>> >>> each zone simply?
>> >>
>> >> We would need to know the zone map, which is not otherwise required.
>> >> Then we would need to track the write pointer for each open zone for
>> >> each queue, so that we can stall writes that are not issued at the write
>> >> pointer. This is in effect all zones, because we cannot track when zones
>> >> are implicitly closed. Then, if different queues are issuing writes to
>> >
>> > Can you explain "implicitly closed" state a bit?
>> >
>> > From https://zonedstorage.io/docs/introduction/zoned-storage, only the
>> > following words are mentioned about closed state:
>> >
>> >     ```Conversely, implicitly or explicitly opened zoned can be transitioned to the
>> >     closed state using the CLOSE ZONE command.```
>>
>> When a write is issued to an empty or closed zone, the drive will
>> automatically transition the zone into the implicit open state. This is
>> called implicit open because the host did not (explicitly) issue an open
>> zone command.
>>
>> When there are too many implicitly open zones, the drive may choose to
>> close one of the implicitly opened zone to implicitly open the zone that
>> is a target for a write command.
>>
>> Simple in a nutshell. This is done so that the drive can work with a
>> limited set of resources needed to handle open zones, that is, zones that
>> are being written. There are some more nasty details to all this with
>> limits on the number of open zones and active zones that a zoned drive may
>> have.
>
> OK, thanks for the clarification about implicitly closed, but I
> understand this close can't change the zone's write pointer.

You are right, it does not matter if the zone is implicitly closed, I
was mistaken. But we still have to track the write pointer of every zone
in open or active state, otherwise we cannot know if a write that arrive
to a zone with no outstanding IO is actually at the write pointer, or
whether we need to hold it.

>
>>
>> >
>> > zone info can be cached in the mapping(hash table)(zone sector is the key, and zone
>> > info is the value), which can be implemented as one LRU style. If any zone
>> > info isn't hit in the mapping table, ioctl(BLKREPORTZONE) can be called for
>> > obtaining the zone info.
>> >
>> >> the same zone, we need to sync across queues. Userspace may have
>> >> synchronization in place to issue writes with multiple threads while
>> >> still hitting the write pointer.
>> >
>> > You can trust mq-dealine, which guaranteed that write IO is sent to ->queue_rq()
>> > in order, no matter MQ or SQ.
>> >
>> > Yes, it could be issue from multiple queues for ublksrv, which doesn't sync
>> > among multiple queues.
>> >
>> > But per-zone re-order still can solve the issue, just need one lock
>> > for each zone to cover the MQ re-order.
>>
>> That lock is already there and using it, mq-deadline will never dispatch
>> more than one write per zone at any time. This is to avoid write
>> reordering. So multi queue or not, for any zone, there is no possibility
>> of having writes reordered.
>
> oops, I miss the single queue depth point per zone, so ublk won't break
> zoned write at all, and I agree order of batch IOs is one problem, but
> not hard to solve.

The current implementation _does_ break zoned write because it reverses
batched writes. But if it is an easy fix, that is cool :)

Best regards,
Andreas


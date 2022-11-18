Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EC7C4332F
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 12:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiKRMJJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 07:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241645AbiKRMJI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 07:09:08 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDFE8FF8F
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 04:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668773347; x=1700309347;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=jOxFdQQbcBixRYcV3ZuJ42x168Womfym5U9VG2s8I+8=;
  b=SeZlHq4dI5L0qEI7E12N8qyotTA/K0S82nvVXKFA+lbnfGuc6NKKYLcq
   YFQmkaS3dWa/ONAgjTebidK6TRirbi+wGIV+/EVaBdnwmf3qxlSrRkvV1
   wQ+KMkCKsXGz1CvfwsDms/PcnOWroQCBn1vaL16o0cp8zM/Akkn35YOID
   oDNbQ/lDUqJIANFBdbBHnlUE7tvhxRW1e4J+MFXDPBk5cD62vyjo7nS+u
   RzvM0hvKvxH71jDIJJhBnUCnmiJBnMKreQfMYfuFLUqL41iqoxKh3n+c2
   2dZVhl0kmhsg1X5cL4g42IylbtG9hl50PKHlHJ0VsoXAQOeEGSsTRzMOu
   g==;
X-IronPort-AV: E=Sophos;i="5.96,174,1665417600"; 
   d="scan'208";a="214865990"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2022 20:09:06 +0800
IronPort-SDR: L5AgiqY2X5xdEQu7L37ZDWGa0TwCGB8M7zWZ41XdZ2042r7d+0qDfspc6tMJ2gKyliKoqyOlg5
 fnVZLyc8egyDD0x7+Sw/fSDbYC7E6EmqOA4n13qUjeBEDrBapS6huWw3aWyWyglEA+nv5fTe+J
 ouaX00Ks7Y0NSym0fnUUEP9zi2h2YvAg935DuSJKBpH+GpB59qZyd3GgKUuNLPTtj8HycU5a9Q
 MJELLYUKgN4Hee99lgkKMd4Y2Ez8igOI3aQtMUrgDRXMUZ1DeTP5aL190MqgzRrK8ii0eSxtUk
 a4g=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2022 03:22:16 -0800
IronPort-SDR: AAVVtVF5hvS9GNmpuzVaZIu4EB4qwKoJMq+Mlrm9vqIzCnMZF7T/MRLAwTr3sRGDSNILSfWFxA
 WtCy22NO/9/j2HWTF/qzDGqnGTESA4/EsIRst04Y9bjcDDI/Kxc0uGlTrBw9JRaB+OmSunbLLj
 JT274pXYBB0n464Js9WDgXTSPMXWvYcGAcJToXA9I7vcDFUYd66vMDUC3c0X8IiapYqHMTm+FM
 5Qlfkr7L6EKma2D/ZqY6dns2P8tfVcmbBVZKgBkGt7+Mck+h4KAdYRyxYT6RESWj0mTB6QZtuo
 Bxo=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO localhost) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2022 04:09:05 -0800
References: <Y3WZ41tKFZHkTSHL@T590> <87o7t67zzv.fsf@wdc.com>
 <Y3X2M3CSULigQr4f@T590> <87k03u7x3r.fsf@wdc.com> <Y3YfUjrrLJzPWc4H@T590>
 <87fseh92aa.fsf@wdc.com> <Y3cGM0es14vj3n3N@T590>
 <2f86eb58-148b-03ac-d2bf-d67c5756a7a6@opensource.wdc.com>
 <Y3chDDdbuN99l7v7@T590> <8735ag8ueg.fsf@wdc.com> <Y3dscKle5oqLjSNT@T590>
User-agent: mu4e 1.8.11; emacs 28.2.50
From:   Andreas Hindborg <andreas.hindborg@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Andreas Hindborg <andreas.hindborg@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: Reordering of ublk IO requests
Date:   Fri, 18 Nov 2022 12:49:15 +0100
In-reply-to: <Y3dscKle5oqLjSNT@T590>
Message-ID: <87v8nc79cv.fsf@wdc.com>
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
> On Fri, Nov 18, 2022 at 10:41:31AM +0100, Andreas Hindborg wrote:
>>
>> Ming Lei <ming.lei@redhat.com> writes:
>>
>> > CAUTION: This email originated from outside of Western Digital. Do not click on
>> > links or open attachments unless you recognize the sender and know that the
>> > content is safe.
>> >
>> >
>> > On Fri, Nov 18, 2022 at 01:35:29PM +0900, Damien Le Moal wrote:
>> >> On 11/18/22 13:12, Ming Lei wrote:
>> >> [...]
>> >> >>> You can only assign it to zoned write request, but you still have to check
>> >> >>> the sequence inside each zone, right? Then why not just check LBAs in
>> >> >>> each zone simply?
>> >> >>
>> >> >> We would need to know the zone map, which is not otherwise required.
>> >> >> Then we would need to track the write pointer for each open zone for
>> >> >> each queue, so that we can stall writes that are not issued at the write
>> >> >> pointer. This is in effect all zones, because we cannot track when zones
>> >> >> are implicitly closed. Then, if different queues are issuing writes to
>> >> >
>> >> > Can you explain "implicitly closed" state a bit?
>> >> >
>> >> > From https://zonedstorage.io/docs/introduction/zoned-storage, only the
>> >> > following words are mentioned about closed state:
>> >> >
>> >> >     ```Conversely, implicitly or explicitly opened zoned can be transitioned to the
>> >> >     closed state using the CLOSE ZONE command.```
>> >>
>> >> When a write is issued to an empty or closed zone, the drive will
>> >> automatically transition the zone into the implicit open state. This is
>> >> called implicit open because the host did not (explicitly) issue an open
>> >> zone command.
>> >>
>> >> When there are too many implicitly open zones, the drive may choose to
>> >> close one of the implicitly opened zone to implicitly open the zone that
>> >> is a target for a write command.
>> >>
>> >> Simple in a nutshell. This is done so that the drive can work with a
>> >> limited set of resources needed to handle open zones, that is, zones that
>> >> are being written. There are some more nasty details to all this with
>> >> limits on the number of open zones and active zones that a zoned drive may
>> >> have.
>> >
>> > OK, thanks for the clarification about implicitly closed, but I
>> > understand this close can't change the zone's write pointer.
>>
>> You are right, it does not matter if the zone is implicitly closed, I
>> was mistaken. But we still have to track the write pointer of every zone
>> in open or active state, otherwise we cannot know if a write that arrive
>> to a zone with no outstanding IO is actually at the write pointer, or
>> whether we need to hold it.
>>
>> >
>> >>
>> >> >
>> >> > zone info can be cached in the mapping(hash table)(zone sector is the key, and zone
>> >> > info is the value), which can be implemented as one LRU style. If any zone
>> >> > info isn't hit in the mapping table, ioctl(BLKREPORTZONE) can be called for
>> >> > obtaining the zone info.
>> >> >
>> >> >> the same zone, we need to sync across queues. Userspace may have
>> >> >> synchronization in place to issue writes with multiple threads while
>> >> >> still hitting the write pointer.
>> >> >
>> >> > You can trust mq-dealine, which guaranteed that write IO is sent to ->queue_rq()
>> >> > in order, no matter MQ or SQ.
>> >> >
>> >> > Yes, it could be issue from multiple queues for ublksrv, which doesn't sync
>> >> > among multiple queues.
>> >> >
>> >> > But per-zone re-order still can solve the issue, just need one lock
>> >> > for each zone to cover the MQ re-order.
>> >>
>> >> That lock is already there and using it, mq-deadline will never dispatch
>> >> more than one write per zone at any time. This is to avoid write
>> >> reordering. So multi queue or not, for any zone, there is no possibility
>> >> of having writes reordered.
>> >
>> > oops, I miss the single queue depth point per zone, so ublk won't break
>> > zoned write at all, and I agree order of batch IOs is one problem, but
>> > not hard to solve.
>>
>> The current implementation _does_ break zoned write because it reverses
>> batched writes. But if it is an easy fix, that is cool :)
>
> Please look at Damien's comment:
>
>>> That lock is already there and using it, mq-deadline will never dispatch
>>> more than one write per zone at any time. This is to avoid write
>>> reordering. So multi queue or not, for any zone, there is no possibility
>>> of having writes reordered.
>
> For zoned write, mq-deadline is used to limit at most one inflight write
> for each zone.
>
> So can you explain a bit how the current implementation breaks zoned
> write?

Like Damien wrote in another email, mq-deadline will only impose
ordering for requests submitted in batch. The flow we have is the
following:

 - Userspace sends requests to ublk gendisk
 - Requests go through block layer and is _not_ reordered when using
   mq-deadline. They may be split.
 - Requests hit ublk_drv and ublk_drv will reverse order of _all_
   batched up requests (including split requests).
 - ublk_drv sends request to ublksrv in _reverse_ order.
 - ublksrv sends requests _not_ batched up to target device.
 - Requests that enter mq-deadline at the same time are reordered in LBA
   order, that is all good.
 - Requests that enter the kernel in different batches are not reordered
   in LBA order and end up missing the write pointer. This is bad.

So, ublk_drv is not functional for zoned storage as is. Either we have
to fix up the ordering in userspace in ublksrv, and that _will_ have a
performance impact. Or we fix the bug in ublk_drv that causes batched
requests to be _reversed_.

Thanks,
Andreas

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D702C4332F
	for <linux-block@archiver.kernel.org>; Sat, 19 Nov 2022 07:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiKSHmw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Nov 2022 02:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKSHmv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Nov 2022 02:42:51 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D15BA5AE
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 23:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668843769; x=1700379769;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=ZexaDD703a3dxUU6Mwxi7ifsi7A3J8lmi/O8v/NiTdw=;
  b=ATNHKB9jFszULYy2ldyZlliAjnp/4W71/ZomVobXycGBfE4/Jwnu8hjL
   pM5MC7L+rBmV9ciqjfG0EADu2AEsvymG1OGCCzZkv8TAJC2YQuHplfBup
   gCtFsSkAnFlFN290fwITSbinbub4H/2oZoEhp2cKlt8W+VDJ3AA0ZX1wE
   tBc9CFINYiIWSc8PHcm3gL+iiHMxKXHnXcLL+HJ9wZrEIEiuz+8QfixSP
   UdNZyGHyPK0LS2IyxcdV6o6uzOvAb5O4CxK8a4LwbobiPcK9ZZEvyYOAO
   mRpbyA2lY+773Sw3otAlf5dBXy1AYmQzU46AfVWiL9RIL4sUw/rX6FLUo
   w==;
X-IronPort-AV: E=Sophos;i="5.96,175,1665417600"; 
   d="scan'208";a="214920222"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2022 15:42:48 +0800
IronPort-SDR: cvkruacSZJ6yMwjN7QDgWSSxiX95sXRFbaRfRq0j6Nrou9g0edpPHpuCyBhN317tPgVumg8sqB
 YPitzPWQfpXz3tYZVJ+iT4y/sZvHn5j187bSOeq4aXZKwgEmFeD5e72oqOLroGUUhFBncDLDFv
 fHVgHlJX4SrPRKzEZvH+ccCz22FPy8Wb58NGl+G0Ba0Zez49FAi7jgRSQFV1SRdFpzEEUpYDGO
 xE7+v3nnnA5iyiFjTWeIHzq/kJiMGMybsP520ZqRHRTDMAMexwnVhi5WcT/tbwT1PUfdOobtDC
 +lg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2022 23:01:41 -0800
IronPort-SDR: Pu/4tpClWMQLb/8mi98L/NfEvaiZGno974/JjsUoby0vLH61w2LuJHZdUyfz22RQeEKkvwv4X0
 lOEvi6mBu7uQEo/je5ZGfW0nXfo6+ZkIDnp9T252/m0p4OWCEQDd/bRAdNY7cx5lQMXrFcsrsj
 1+nd2lC7R0x7i4/++H3X+690IpKQvkyln1pHryd7+1ywmcZTLpQpCztFu9RPTSsUUkuqu6V6Ce
 ScF6TDnodO7oou/D7aYCPHXVJ2aqaMjgHvlHwcwuGhqUT5NIwHrlVmdXym6U/gprGBaYeDyoPK
 Xy4=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO localhost) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2022 23:42:47 -0800
References: <Y3X2M3CSULigQr4f@T590> <87k03u7x3r.fsf@wdc.com>
 <Y3YfUjrrLJzPWc4H@T590> <87fseh92aa.fsf@wdc.com> <Y3cGM0es14vj3n3N@T590>
 <2f86eb58-148b-03ac-d2bf-d67c5756a7a6@opensource.wdc.com>
 <Y3chDDdbuN99l7v7@T590> <8735ag8ueg.fsf@wdc.com> <Y3dscKle5oqLjSNT@T590>
 <87v8nc79cv.fsf@wdc.com> <Y3d+78qMOusdYUAG@T590>
 <be6940cf-7b23-4b11-1f6f-f3d4853d9a34@opensource.wdc.com>
User-agent: mu4e 1.8.11; emacs 28.2.50
From:   Andreas Hindborg <andreas.hindborg@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Andreas Hindborg <andreas.hindborg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: Reordering of ublk IO requests
Date:   Sat, 19 Nov 2022 08:36:38 +0100
In-reply-to: <be6940cf-7b23-4b11-1f6f-f3d4853d9a34@opensource.wdc.com>
Message-ID: <87cz9j75l5.fsf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Damien Le Moal <damien.lemoal@opensource.wdc.com> writes:

> On 11/18/22 21:47, Ming Lei wrote:
>> On Fri, Nov 18, 2022 at 12:49:15PM +0100, Andreas Hindborg wrote:
>>>
>>> Ming Lei <ming.lei@redhat.com> writes:
>>>
>>>> CAUTION: This email originated from outside of Western Digital. Do not click on
>>>> links or open attachments unless you recognize the sender and know that the
>>>> content is safe.
>>>>
>>>>
>>>> On Fri, Nov 18, 2022 at 10:41:31AM +0100, Andreas Hindborg wrote:
>>>>>
>>>>> Ming Lei <ming.lei@redhat.com> writes:
>>>>>
>>>>>> CAUTION: This email originated from outside of Western Digital. Do not click on
>>>>>> links or open attachments unless you recognize the sender and know that the
>>>>>> content is safe.
>>>>>>
>>>>>>
>>>>>> On Fri, Nov 18, 2022 at 01:35:29PM +0900, Damien Le Moal wrote:
>>>>>>> On 11/18/22 13:12, Ming Lei wrote:
>>>>>>> [...]
>>>>>>>>>> You can only assign it to zoned write request, but you still have to check
>>>>>>>>>> the sequence inside each zone, right? Then why not just check LBAs in
>>>>>>>>>> each zone simply?
>>>>>>>>>
>>>>>>>>> We would need to know the zone map, which is not otherwise required.
>>>>>>>>> Then we would need to track the write pointer for each open zone for
>>>>>>>>> each queue, so that we can stall writes that are not issued at the write
>>>>>>>>> pointer. This is in effect all zones, because we cannot track when zones
>>>>>>>>> are implicitly closed. Then, if different queues are issuing writes to
>>>>>>>>
>>>>>>>> Can you explain "implicitly closed" state a bit?
>>>>>>>>
>>>>>>>> From https://zonedstorage.io/docs/introduction/zoned-storage, only the
>>>>>>>> following words are mentioned about closed state:
>>>>>>>>
>>>>>>>>     ```Conversely, implicitly or explicitly opened zoned can be transitioned to the
>>>>>>>>     closed state using the CLOSE ZONE command.```
>>>>>>>
>>>>>>> When a write is issued to an empty or closed zone, the drive will
>>>>>>> automatically transition the zone into the implicit open state. This is
>>>>>>> called implicit open because the host did not (explicitly) issue an open
>>>>>>> zone command.
>>>>>>>
>>>>>>> When there are too many implicitly open zones, the drive may choose to
>>>>>>> close one of the implicitly opened zone to implicitly open the zone that
>>>>>>> is a target for a write command.
>>>>>>>
>>>>>>> Simple in a nutshell. This is done so that the drive can work with a
>>>>>>> limited set of resources needed to handle open zones, that is, zones that
>>>>>>> are being written. There are some more nasty details to all this with
>>>>>>> limits on the number of open zones and active zones that a zoned drive may
>>>>>>> have.
>>>>>>
>>>>>> OK, thanks for the clarification about implicitly closed, but I
>>>>>> understand this close can't change the zone's write pointer.
>>>>>
>>>>> You are right, it does not matter if the zone is implicitly closed, I
>>>>> was mistaken. But we still have to track the write pointer of every zone
>>>>> in open or active state, otherwise we cannot know if a write that arrive
>>>>> to a zone with no outstanding IO is actually at the write pointer, or
>>>>> whether we need to hold it.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> zone info can be cached in the mapping(hash table)(zone sector is the key, and zone
>>>>>>>> info is the value), which can be implemented as one LRU style. If any zone
>>>>>>>> info isn't hit in the mapping table, ioctl(BLKREPORTZONE) can be called for
>>>>>>>> obtaining the zone info.
>>>>>>>>
>>>>>>>>> the same zone, we need to sync across queues. Userspace may have
>>>>>>>>> synchronization in place to issue writes with multiple threads while
>>>>>>>>> still hitting the write pointer.
>>>>>>>>
>>>>>>>> You can trust mq-dealine, which guaranteed that write IO is sent to ->queue_rq()
>>>>>>>> in order, no matter MQ or SQ.
>>>>>>>>
>>>>>>>> Yes, it could be issue from multiple queues for ublksrv, which doesn't sync
>>>>>>>> among multiple queues.
>>>>>>>>
>>>>>>>> But per-zone re-order still can solve the issue, just need one lock
>>>>>>>> for each zone to cover the MQ re-order.
>>>>>>>
>>>>>>> That lock is already there and using it, mq-deadline will never dispatch
>>>>>>> more than one write per zone at any time. This is to avoid write
>>>>>>> reordering. So multi queue or not, for any zone, there is no possibility
>>>>>>> of having writes reordered.
>>>>>>
>>>>>> oops, I miss the single queue depth point per zone, so ublk won't break
>>>>>> zoned write at all, and I agree order of batch IOs is one problem, but
>>>>>> not hard to solve.
>>>>>
>>>>> The current implementation _does_ break zoned write because it reverses
>>>>> batched writes. But if it is an easy fix, that is cool :)
>>>>
>>>> Please look at Damien's comment:
>>>>
>>>>>> That lock is already there and using it, mq-deadline will never dispatch
>>>>>> more than one write per zone at any time. This is to avoid write
>>>>>> reordering. So multi queue or not, for any zone, there is no possibility
>>>>>> of having writes reordered.
>>>>
>>>> For zoned write, mq-deadline is used to limit at most one inflight write
>>>> for each zone.
>>>>
>>>> So can you explain a bit how the current implementation breaks zoned
>>>> write?
>>>
>>> Like Damien wrote in another email, mq-deadline will only impose
>>> ordering for requests submitted in batch. The flow we have is the
>>> following:
>>>
>>>  - Userspace sends requests to ublk gendisk
>>>  - Requests go through block layer and is _not_ reordered when using
>>>    mq-deadline. They may be split.
>>>  - Requests hit ublk_drv and ublk_drv will reverse order of _all_
>>>    batched up requests (including split requests).
>> 
>> For ublk-zone, ublk driver needs to be exposed as zoned device by
>> calling disk_set_zoned() finally, which definitely isn't supported now,
>> so mq-deadline at most sends one write IO for each zone after ublk-zone
>> is supported, see blk_req_can_dispatch_to_zone().
>> 
>>>  - ublk_drv sends request to ublksrv in _reverse_ order.
>>>  - ublksrv sends requests _not_ batched up to target device.
>>>  - Requests that enter mq-deadline at the same time are reordered in LBA
>>>    order, that is all good.
>>>  - Requests that enter the kernel in different batches are not reordered
>>>    in LBA order and end up missing the write pointer. This is bad.
>> 
>> Again, please read Damien's comment:
>> 
>>>> That lock is already there and using it, mq-deadline will never dispatch
>>>> more than one write per zone at any time.
>> 
>> Anytime, there is at most one write IO for each zone, how can the single
>> write IO be re-order?
>
> If the user issues writes one at a time out of order (not aligned to the
> write pointer), mq-deadline will not help at all. The zone write locking
> will still limit write dispatching to one per zone, but the writes will fail.
>
> mq-deadline will reorder write commands in the correct lba order only if:
> - the commands are inserted as a batch (more than on request passed to
> ->insert_requests)
> - commands are inserted individually when the target zone is locked (a
> write is already being executed)
>
> This has been the semantic from the start: the block layer has no
> guarantees about the correct ordering of writes to zoned drive. What is
> guaranteed is that (1) if the user issues writes in order AND (2)
> mq-deadline is used, then writes will be dispatched in the same order to
> the device.
>
> I have not looked at the details of ublk, but from the thread, I think (1)
> is not done and (2) is missing-ish as the ublk device is not marked as zoned.

I have a patch in the works for adding zoned storage support to ublk. It
sets up the ublk device as a zoned device. It is very much work in
progress, but it lives here [1] for now.

I am pretty sure that I saw large writes to zoned ublk device being
split and issued to the device (same zone) with multiple outstanding
requests at the same time. I'll verify on Monday and provide a test case
if that is the case. Might be I configured the ublk device wrong? I set
it up as host managed zoned and set up zone size, max active, max open.

Best regards,
Andreas

[1] https://github.com/metaspace/linux/tree/ublk-zoned

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5F1C4332F
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 01:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKUBZH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Nov 2022 20:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKUBZG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Nov 2022 20:25:06 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C4418375
        for <linux-block@vger.kernel.org>; Sun, 20 Nov 2022 17:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668993904; x=1700529904;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sRDjXJ+czi6lGfGxPyUMyBs74P3+jTQu+dxA2yqhikQ=;
  b=m+IpTKbZMmB/atFvJf6R0myP7zJ8BbqZbtLLEZTp6SrkZyj1a96qYIbU
   WuQf+rUklB2/niWNMESNydhOkf3436CODGG5Bb0zv65T889YGMuQBcaOy
   OlOoAWyZEyYiuAmVuZ8sl98oPP5bWMA2udGF5iek39m7Gj/b0gv0ovO/O
   56ARa4uD0f7ytes9w1T47V74IkXMj900yZt5UYaTfvZEcMXbmVZCwTmZ/
   HlTRGPwrYrNLwycMvG2I2s15luKIuXCDmU4HPtQQutaY0XVHuJqYKRy84
   QUhQ55G8xonoN7hPqyqoMiAgy1HpTgPeeOGCdBHaSIOIs3MUHYe9RF9Tp
   A==;
X-IronPort-AV: E=Sophos;i="5.96,180,1665417600"; 
   d="scan'208";a="214995107"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 09:25:04 +0800
IronPort-SDR: FoTF8K3yX33sf2IPYPlBCWzPEJFI8dy0nZcDflaZAWEifXRrIBaSEbxedJPOpi1KKzCC9NJBoT
 M4jHjbKMCT1Eg7wBTgCy6eLfELJOzJNsfcw1oV3f9m62rkBcOiLDsnj4V7dgvpDcH4z8OaklVN
 Gs6rlv1kOc+GQ8E0+3oljMXhQ9cl72QiGRgBdlJuDNWe1KjUKCfgipnECE4OrysewPovan2VhF
 LsYggPjZUt2NVxx68pO85puYUezlwV+sA9JMy1iVnqVcU9+fQgRGwe/ocpHA/SML9WVsuoVvfM
 sYg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 16:38:11 -0800
IronPort-SDR: etDc4OXXy5hrVprqtjwXyTeSmHW+G/X1ifoyEI2GI0Cyb8IOhgCilhti5pybY1ZNRRVCe8ePNg
 BGhL2yzQuSTKu3dH1Yx7Yte1rv7szdEe1lmzOAHFznu3DriSzQjrHuZ4BLDMRhSLWjPFQItpz2
 CaEFZjecfv0/j/JuvmDxKosY34dCtT2TEQD7sVU5g7m5zKoNaoAXCEfJIGp2B4mkdqBSIaXJGo
 Iqcm2EQpUqDwsFM2MNJKxPbJmMXvxDC1x8E5AY3KAVgWUNGya0WKC5/GRwnZtDnF7GNOAxysJD
 Aks=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 17:25:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NFqSc0Y4wz1RwqL
        for <linux-block@vger.kernel.org>; Sun, 20 Nov 2022 17:25:04 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668993903; x=1671585904; bh=sRDjXJ+czi6lGfGxPyUMyBs74P3+jTQu+dx
        A2yqhikQ=; b=KEBcAsVUzLEF6v0Ih+ra0nZtH/GYVUQ6JZHR+z9sY039v/tDe/v
        HYKlKI+RHT+esNfz9TrECIYzrr0HOP1wG1rIUMHrHASOqjmQySQjjv3mh+bmeMYc
        4ZLmB8zuyjtUu9VxeQCWpXd1LD+kFRE1Y2tdiPml1BOuPHuYbRn8A2gRnUkz+Lj7
        AnJPC9ajqiJpjmjp5kuNinkTC+1Ni03xawdhv8isENuzT+UH07xzD5rtOGTOu/Gc
        e4wtTuRKkFthunLpaCKBLw+obX5uAfe8vuKCDUw5+xN+qWXBTJnj4jK81ZTSI/uG
        RBKZHnPkMeho1CYer0oSQXWWSFZkBwfpgkA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id krGiIaPAAFhY for <linux-block@vger.kernel.org>;
        Sun, 20 Nov 2022 17:25:03 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NFqSZ1gbmz1RvLy;
        Sun, 20 Nov 2022 17:25:01 -0800 (PST)
Message-ID: <5ae82efd-7142-1684-1ea3-e3239b8cedd7@opensource.wdc.com>
Date:   Mon, 21 Nov 2022 10:25:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Reordering of ublk IO requests
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Andreas Hindborg <andreas.hindborg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <Y3YfUjrrLJzPWc4H@T590> <87fseh92aa.fsf@wdc.com>
 <Y3cGM0es14vj3n3N@T590>
 <2f86eb58-148b-03ac-d2bf-d67c5756a7a6@opensource.wdc.com>
 <Y3chDDdbuN99l7v7@T590> <8735ag8ueg.fsf@wdc.com> <Y3dscKle5oqLjSNT@T590>
 <87v8nc79cv.fsf@wdc.com> <Y3d+78qMOusdYUAG@T590>
 <be6940cf-7b23-4b11-1f6f-f3d4853d9a34@opensource.wdc.com>
 <Y3o7n9EaCXZuGVm7@T590>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y3o7n9EaCXZuGVm7@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/20/22 23:37, Ming Lei wrote:
> On Sat, Nov 19, 2022 at 09:24:01AM +0900, Damien Le Moal wrote:
>> On 11/18/22 21:47, Ming Lei wrote:
>>> On Fri, Nov 18, 2022 at 12:49:15PM +0100, Andreas Hindborg wrote:
>>>>
>>>> Ming Lei <ming.lei@redhat.com> writes:
>>>>
>>>>> CAUTION: This email originated from outside of Western Digital. Do not click on
>>>>> links or open attachments unless you recognize the sender and know that the
>>>>> content is safe.
>>>>>
>>>>>
>>>>> On Fri, Nov 18, 2022 at 10:41:31AM +0100, Andreas Hindborg wrote:
>>>>>>
>>>>>> Ming Lei <ming.lei@redhat.com> writes:
>>>>>>
>>>>>>> CAUTION: This email originated from outside of Western Digital. Do not click on
>>>>>>> links or open attachments unless you recognize the sender and know that the
>>>>>>> content is safe.
>>>>>>>
>>>>>>>
>>>>>>> On Fri, Nov 18, 2022 at 01:35:29PM +0900, Damien Le Moal wrote:
>>>>>>>> On 11/18/22 13:12, Ming Lei wrote:
>>>>>>>> [...]
>>>>>>>>>>> You can only assign it to zoned write request, but you still have to check
>>>>>>>>>>> the sequence inside each zone, right? Then why not just check LBAs in
>>>>>>>>>>> each zone simply?
>>>>>>>>>>
>>>>>>>>>> We would need to know the zone map, which is not otherwise required.
>>>>>>>>>> Then we would need to track the write pointer for each open zone for
>>>>>>>>>> each queue, so that we can stall writes that are not issued at the write
>>>>>>>>>> pointer. This is in effect all zones, because we cannot track when zones
>>>>>>>>>> are implicitly closed. Then, if different queues are issuing writes to
>>>>>>>>>
>>>>>>>>> Can you explain "implicitly closed" state a bit?
>>>>>>>>>
>>>>>>>>> From https://zonedstorage.io/docs/introduction/zoned-storage, only the
>>>>>>>>> following words are mentioned about closed state:
>>>>>>>>>
>>>>>>>>>     ```Conversely, implicitly or explicitly opened zoned can be transitioned to the
>>>>>>>>>     closed state using the CLOSE ZONE command.```
>>>>>>>>
>>>>>>>> When a write is issued to an empty or closed zone, the drive will
>>>>>>>> automatically transition the zone into the implicit open state. This is
>>>>>>>> called implicit open because the host did not (explicitly) issue an open
>>>>>>>> zone command.
>>>>>>>>
>>>>>>>> When there are too many implicitly open zones, the drive may choose to
>>>>>>>> close one of the implicitly opened zone to implicitly open the zone that
>>>>>>>> is a target for a write command.
>>>>>>>>
>>>>>>>> Simple in a nutshell. This is done so that the drive can work with a
>>>>>>>> limited set of resources needed to handle open zones, that is, zones that
>>>>>>>> are being written. There are some more nasty details to all this with
>>>>>>>> limits on the number of open zones and active zones that a zoned drive may
>>>>>>>> have.
>>>>>>>
>>>>>>> OK, thanks for the clarification about implicitly closed, but I
>>>>>>> understand this close can't change the zone's write pointer.
>>>>>>
>>>>>> You are right, it does not matter if the zone is implicitly closed, I
>>>>>> was mistaken. But we still have to track the write pointer of every zone
>>>>>> in open or active state, otherwise we cannot know if a write that arrive
>>>>>> to a zone with no outstanding IO is actually at the write pointer, or
>>>>>> whether we need to hold it.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> zone info can be cached in the mapping(hash table)(zone sector is the key, and zone
>>>>>>>>> info is the value), which can be implemented as one LRU style. If any zone
>>>>>>>>> info isn't hit in the mapping table, ioctl(BLKREPORTZONE) can be called for
>>>>>>>>> obtaining the zone info.
>>>>>>>>>
>>>>>>>>>> the same zone, we need to sync across queues. Userspace may have
>>>>>>>>>> synchronization in place to issue writes with multiple threads while
>>>>>>>>>> still hitting the write pointer.
>>>>>>>>>
>>>>>>>>> You can trust mq-dealine, which guaranteed that write IO is sent to ->queue_rq()
>>>>>>>>> in order, no matter MQ or SQ.
>>>>>>>>>
>>>>>>>>> Yes, it could be issue from multiple queues for ublksrv, which doesn't sync
>>>>>>>>> among multiple queues.
>>>>>>>>>
>>>>>>>>> But per-zone re-order still can solve the issue, just need one lock
>>>>>>>>> for each zone to cover the MQ re-order.
>>>>>>>>
>>>>>>>> That lock is already there and using it, mq-deadline will never dispatch
>>>>>>>> more than one write per zone at any time. This is to avoid write
>>>>>>>> reordering. So multi queue or not, for any zone, there is no possibility
>>>>>>>> of having writes reordered.
>>>>>>>
>>>>>>> oops, I miss the single queue depth point per zone, so ublk won't break
>>>>>>> zoned write at all, and I agree order of batch IOs is one problem, but
>>>>>>> not hard to solve.
>>>>>>
>>>>>> The current implementation _does_ break zoned write because it reverses
>>>>>> batched writes. But if it is an easy fix, that is cool :)
>>>>>
>>>>> Please look at Damien's comment:
>>>>>
>>>>>>> That lock is already there and using it, mq-deadline will never dispatch
>>>>>>> more than one write per zone at any time. This is to avoid write
>>>>>>> reordering. So multi queue or not, for any zone, there is no possibility
>>>>>>> of having writes reordered.
>>>>>
>>>>> For zoned write, mq-deadline is used to limit at most one inflight write
>>>>> for each zone.
>>>>>
>>>>> So can you explain a bit how the current implementation breaks zoned
>>>>> write?
>>>>
>>>> Like Damien wrote in another email, mq-deadline will only impose
>>>> ordering for requests submitted in batch. The flow we have is the
>>>> following:
>>>>
>>>>  - Userspace sends requests to ublk gendisk
>>>>  - Requests go through block layer and is _not_ reordered when using
>>>>    mq-deadline. They may be split.
>>>>  - Requests hit ublk_drv and ublk_drv will reverse order of _all_
>>>>    batched up requests (including split requests).
>>>
>>> For ublk-zone, ublk driver needs to be exposed as zoned device by
>>> calling disk_set_zoned() finally, which definitely isn't supported now,
>>> so mq-deadline at most sends one write IO for each zone after ublk-zone
>>> is supported, see blk_req_can_dispatch_to_zone().
>>>
>>>>  - ublk_drv sends request to ublksrv in _reverse_ order.
>>>>  - ublksrv sends requests _not_ batched up to target device.
>>>>  - Requests that enter mq-deadline at the same time are reordered in LBA
>>>>    order, that is all good.
>>>>  - Requests that enter the kernel in different batches are not reordered
>>>>    in LBA order and end up missing the write pointer. This is bad.
>>>
>>> Again, please read Damien's comment:
>>>
>>>>> That lock is already there and using it, mq-deadline will never dispatch
>>>>> more than one write per zone at any time.
>>>
>>> Anytime, there is at most one write IO for each zone, how can the single
>>> write IO be re-order?
>>
>> If the user issues writes one at a time out of order (not aligned to the
>> write pointer), mq-deadline will not help at all. The zone write locking
>> will still limit write dispatching to one per zone, but the writes will fail.
>>
>> mq-deadline will reorder write commands in the correct lba order only if:
>> - the commands are inserted as a batch (more than on request passed to
>> ->insert_requests)
>> - commands are inserted individually when the target zone is locked (a
>> write is already being executed)
>>
>> This has been the semantic from the start: the block layer has no
>> guarantees about the correct ordering of writes to zoned drive. What is
>> guaranteed is that (1) if the user issues writes in order AND (2)
>> mq-deadline is used, then writes will be dispatched in the same order to
>> the device.
>>
>> I have not looked at the details of ublk, but from the thread, I think (1)
>> is not done and (2) is missing-ish as the ublk device is not marked as zoned.
> 
> (2) is supposed to be done for support ublk-zone, at least in the
> Andreas's PR, which just implements one ublk-loop over one real backing
> zoned disk.
> 
> mq-deadline dispatches one write IO for each zone on /dev/ublkbN(
> supposed to be exposed as zoned, not done yet), and this write IO will
> be forwarded to ublksrv, so ublksrv can only see one such write IO for
> each zone, which will be re-issued to the backing real zoned disk, so
> there can't be the write io reorder issue, cause the write batch just
> has one write IO for each zone.

Good point !

> 
> 
> [1] https://github.com/ming1/ubdsrv/pull/28/files
> 
> Thanks,
> Ming
> 

-- 
Damien Le Moal
Western Digital Research


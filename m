Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3B2C43217
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 10:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiKUKRt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 05:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiKUKRs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 05:17:48 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767D612ACF
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 02:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669025862; x=1700561862;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=U9te+FvGTRyaYt+gf96c00lFB2CXMQmEQSehS1RuRC4=;
  b=Alrg4c8onr8OG68Lh3RveoPdGbGuhNXKW0GvFBQNmmId7T00aqg8271o
   UCggiPos5Rbj12OuyEHCG/trYx5ZTAbRxSgGNPYKz0Rn9yKX61XaDiU9C
   MV7UeFSaCYRHpWOrQNvUlt+5RrLArawPUdXGxYefxUk37kH9yJuFlBdnb
   bqBXWryRpUKM1vznAE9qCQpZYewSH3uKisE6tjuOPYgi/m3eifqK+7Izd
   a/Osff/QQMreW1yCmJmbxCnVbCNpuZ5iy6uQyH7Te2rG20soWFCv8seEy
   vV26VCXR2qeSm2QTPFg5/d51enybLZsu29apxfQ379eOOM9jIfAaiCgM2
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665417600"; 
   d="scan'208";a="321129220"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 18:17:40 +0800
IronPort-SDR: nKvgoCPXmiIzavFKd0Abj4LP8ssb62stG2dXYUCSA99LmcEQK6O3NM1xHMSR7MKgMN1kwfaM8K
 f0C+s4y7kQdwrPIsLmd9XlY9lEZh2vojzGtByPikCsOHqPE5m0HHtrS7UCbJHklIiqyscLhgx/
 jRfwC96ZHGrNleQes9uoZVVY156euode+f8KXQ36Hhiv4HjDLyeLTiBv4fZCTtksHIt8xi+Usu
 6apRmFH2chvBLfR8L9dbNCMJgvUAUJY+g4/6M3dbUOCqx6/0ELwkyJ7lqo8b3yBqVY2KUxiVkM
 wL8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 01:36:30 -0800
IronPort-SDR: yilgiRCR3qOlnchThYwirL3M8EeXEbeVmcriMZj9qmXN/2z8VXvKMkzJxXODC8oG9xND0TIijW
 lSadzQJCzeYM9ujVQjmHgASvJ/05c9NvksisPHa723KQc+XhzI57n6AL1uSXQzW4ofSGUvPqiP
 sunR13ZPelcej1momBSaqfESTJSy/hXo+C+2Qa+KWjG1s0t/Us/pbwZucAtu6vdsLS4gWtsI40
 vexvICl2o4Qo4uQ9LgnjwsXhZ+QQSrmowKn1jD7Y7BGbPga0pCh8u4bKVQLwjf7cE1W/LhbsTY
 r80=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO localhost) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Nov 2022 02:17:40 -0800
References: <Y3X2M3CSULigQr4f@T590> <87k03u7x3r.fsf@wdc.com>
 <Y3YfUjrrLJzPWc4H@T590> <87fseh92aa.fsf@wdc.com> <Y3cGM0es14vj3n3N@T590>
 <2f86eb58-148b-03ac-d2bf-d67c5756a7a6@opensource.wdc.com>
 <Y3chDDdbuN99l7v7@T590> <8735ag8ueg.fsf@wdc.com> <Y3dscKle5oqLjSNT@T590>
 <87v8nc79cv.fsf@wdc.com> <Y3d+78qMOusdYUAG@T590>
 <be6940cf-7b23-4b11-1f6f-f3d4853d9a34@opensource.wdc.com>
 <87cz9j75l5.fsf@wdc.com>
User-agent: mu4e 1.8.11; emacs 28.2.50
From:   Andreas Hindborg <andreas.hindborg@wdc.com>
To:     Andreas Hindborg <andreas.hindborg@wdc.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: Reordering of ublk IO requests
Date:   Mon, 21 Nov 2022 11:15:02 +0100
In-reply-to: <87cz9j75l5.fsf@wdc.com>
Message-ID: <878rk47gsd.fsf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Andreas Hindborg <andreas.hindborg@wdc.com> writes:

> Damien Le Moal <damien.lemoal@opensource.wdc.com> writes:
>
>> On 11/18/22 21:47, Ming Lei wrote:
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
> I have a patch in the works for adding zoned storage support to ublk. It
> sets up the ublk device as a zoned device. It is very much work in
> progress, but it lives here [1] for now.
>
> I am pretty sure that I saw large writes to zoned ublk device being
> split and issued to the device (same zone) with multiple outstanding
> requests at the same time. I'll verify on Monday and provide a test case
> if that is the case. Might be I configured the ublk device wrong? I set
> it up as host managed zoned and set up zone size, max active, max open.

Turns out I was not setting up the zone bitmaps. I was missing a call to
blk_revalidate_disk_zones() and that took out the zone lock in the
deadline scheduler. With that in place, everything works as it should.

Thanks for the help everyone!

Best regards,
Andreas

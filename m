Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B413BC4332F
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 12:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiLUM1s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 07:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiLUM1q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 07:27:46 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C789BF56
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 04:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671625665; x=1703161665;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RNlW0+fIcW3m2vCSw6QYV3V/gnOzaaTcThuzTSPmc5k=;
  b=RotrV5LAL1sWsZX7Z58Arum92LNbEYmLoL+bGqISFADA1RnnLF42ODLV
   4tcuuBz6Fr5U4XJ2Ddi7fp57EDUKZIu9wnwrpVbm14oS62z3E5EKts6o6
   w8LMO/lHktOmJJAPlEeLGE9KnIzs9zyBk+7EBRsnK13hHfN8vVRI3njvS
   8OhJUfkJ0/fE7EV6j5hci/UQ/Y5It3AO/BuwNxv30FCFz2AxmtPL8IOI4
   eVmfyu58jSdM7KpQT8vnK7izfrarttJwZYpFGRcfeC8wqTFFLlzLWTJm+
   JpVsubttnL6vHZP0syU4zsV0y3OQeaoH9PePBB7G6JTAc2fcCk2ahcANy
   g==;
X-IronPort-AV: E=Sophos;i="5.96,262,1665417600"; 
   d="scan'208";a="323515718"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Dec 2022 20:27:43 +0800
IronPort-SDR: EynlJtbH2PhvDvm35URDPva/iUxlwCDdqqqQs0HAanpTgyON5l8nzEd5nZHhCrn0eGWKlKyJ1X
 MunrggDUJqrU0OmxLSWSuMNcHBLiCLbGs+dbu/xcSXw3ttCyrjopG3xIe7do252sSRNfQGPdVb
 VSWfjvPk6BtLSRJrjL0fC/39kczqrpd8ykIkyDsIm61ggsu9jTBraOkIB4hhsCTbuXbOT0+aPf
 ZCy/0F31xVGXkUrovDe/3bMSYFFttQN/jSnaMv6Wpk8JLFS8eX7d5BA+qumOgN1j/GITA9sVuu
 Exo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Dec 2022 03:40:13 -0800
IronPort-SDR: u5NyQSM4hvO5L0neL04BWmEsXM6sGSHekJZM6qO6bOyO8jNuzBQZVq2WGMDYvoyLl/goO2n4Ph
 ICbRDK/qn+TwRwZrKjpwexXhMmbdDr6W0KKYCdlyqEdShxbVWZmxpi/6meEF74u/5DjvGlDxC2
 4nkUOBHC7TUDHlHnxUdEUa+t0qBQ+c8PbpRWeAe4HvsTl2m6vk3WcMdPA0GDNR61XI6rU4dkIJ
 P6uCkvYIbCe79Crj9u/nmN+9iaxIo0Ur2nFI3liWq7ccrov/scXlX50wx+GhchY7aJXqorsmKt
 S1o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Dec 2022 04:27:43 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NcXlM2hSQz1RwvL
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 04:27:43 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671625662; x=1674217663; bh=RNlW0+fIcW3m2vCSw6QYV3V/gnOzaaTcThu
        zTSPmc5k=; b=L9ayiGvKGO4K07eJpXYVJejCte1SqIBsbBjo1+KrKbBII5tm98L
        9v1x3AZpyOKPskGac+tO7WGQxkhNN5TFLr8epPaPxXZSw05KRSrGEPX9UEB4BBwa
        xwxt2x6mcKLnZegCZsnDmC0xcWPuD2Oz55Dh/fQ7YM2DIw+fj41l4NbChOvzbTQ9
        f52cNd8pj5ijsQR7DqICbxovQdH4hDCLi4WADYDrfuaOyO9eJVo1trq9UIh1bou9
        hdj7GgZYzf7CGql31x1/0K1ZOB8uSOpe6CFVdv95X5k1b6amPZVZQaGodn5brCaC
        LfhuXLevKErz3byPKboHl/cQ0FezMLzkvOQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZsNEJMLe-W7T for <linux-block@vger.kernel.org>;
        Wed, 21 Dec 2022 04:27:42 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NcXlJ62MDz1RvLy;
        Wed, 21 Dec 2022 04:27:40 -0800 (PST)
Message-ID: <017f3dbd-4586-490a-2f21-948586391515@opensource.wdc.com>
Date:   Wed, 21 Dec 2022 21:27:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH V11 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
References: <20221220095013.55803-1-paolo.valente@linaro.org>
 <20221220095013.55803-2-paolo.valente@linaro.org>
 <8a49432d-642f-cd58-8e4d-2b320aef5edd@opensource.wdc.com>
 <D429FA01-9510-41FF-AD85-F74EB8AD171F@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <D429FA01-9510-41FF-AD85-F74EB8AD171F@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/12/21 19:27, Paolo Valente wrote:
> 
> 
>> Il giorno 21 dic 2022, alle ore 01:46, Damien Le Moal <damien.lemoal@opensource.wdc.com> ha scritto:
>>
>>
>> [...]
>>
>>> -static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
>>> +static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync,
>>> +			      unsigned int actuator_idx)
>>> {
>>> -	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync);
>>> +	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync, actuator_idx);
>>> 	struct bfq_data *bfqd;
>>>
>>> 	if (bfqq)
>>
>> With your current bic_to_bfqq() implementation, you will *never* get NULL as a
>> return value.
> 
> I'm afraid this is not true.  A bic is associated with a sync and an
> async queue, or with both.  So, in the hunk above, bic_to_bfqq returns
> NULL if:
> - either the bic is associated with a sync queue, but is_sync happens to be false;
> - or the bic is associate with an async queue, but is_sync happens to be true.
> 
> Of course, with these patches, the associations move from "with a
> sync/async queue" to "with a set of sync/async queues, one per
> actuator".

My bad... The bic->bfqq[][actuator_idx] is an array of pointers... I was reading
it as "&bic->bfqq[1][actuator_idx]". So please ignore. Apologies for the noise.

> 
>> So why is this if necessary ?
>>> 		bfqd = bfqq->bfqd; /* NULL if scheduler already exited */
>>>
>>> 	if (bfqq && bfqd) {
>>> -		unsigned long flags;
>>> -
>>> -		spin_lock_irqsave(&bfqd->lock, flags);
>>> 		bfqq->bic = NULL;
>>> 		bfq_exit_bfqq(bfqd, bfqq);
>>> -		bic_set_bfqq(bic, NULL, is_sync);
>>> -		spin_unlock_irqrestore(&bfqd->lock, flags);
>>> +		bic_set_bfqq(bic, NULL, is_sync, actuator_idx);
>>> 	}
>>> }
>>>
>>> static void bfq_exit_icq(struct io_cq *icq)
>>> {
>>> 	struct bfq_io_cq *bic = icq_to_bic(icq);
>>> +	struct bfq_data *bfqd = bic_to_bfqd(bic);
>>> +	unsigned long flags;
>>> +	unsigned int act_idx;
>>> +	/*
>>> +	 * If bfqd and thus bfqd->num_actuators is not available any
>>> +	 * longer, then cycle over all possible per-actuator bfqqs in
>>> +	 * next loop. We rely on bic being zeroed on creation, and
>>> +	 * therefore on its unused per-actuator fields being NULL.
>>> +	 */
>>> +	unsigned int num_actuators = BFQ_MAX_ACTUATORS;
>>>
>>> -	if (bic->stable_merge_bfqq) {
>>> -		struct bfq_data *bfqd = bic->stable_merge_bfqq->bfqd;
>>> +	/*
>>> +	 * bfqd is NULL if scheduler already exited, and in that case
>>> +	 * this is the last time these queues are accessed.
>>> +	 */
>>> +	if (bfqd) {
>>
>> Same here. bfqd can never be NULL. Or I am really missing something... Lots of
>> other places like this where checking bic_to_bfqd() seems unnecessary.
> 
> As written in the comment above, bfqd is NULL if the scheduler already
> exited.  That is, bic->icq.q->elevator->elevator_data == NULL.  This
> is an event I have checked several years ago, probably while porting
> cfq to bfq.  If boundary conditions changed later, and nobody realized
> that this was not true any longer, then bfqd would never be NULL as
> you say.  At any rate, I guess that such a change would then belong to
> a separate patch series.
> 
> Thanks,
> Paolo

-- 
Damien Le Moal
Western Digital Research


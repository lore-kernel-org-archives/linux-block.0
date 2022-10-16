Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E85C4332F
	for <linux-block@archiver.kernel.org>; Sun, 16 Oct 2022 10:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJPKBu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Oct 2022 06:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJPKBt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Oct 2022 06:01:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FE711837
        for <linux-block@vger.kernel.org>; Sun, 16 Oct 2022 03:01:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id d26so19027987ejc.8
        for <linux-block@vger.kernel.org>; Sun, 16 Oct 2022 03:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJRh4siJnFIjBNJk1Xn4atDpOEvVNkQosaIacwqE+Po=;
        b=DvnXAl7BM/sVTZw0VJMAhPjH1qmApbzcJwedg0uMqpxlmMA/80xx16hrjRasPzGfGq
         NJj/emLvX7O1UbpUFzJIdfDzkFoGGuV5FP2p4qcBtCMh2cSARvJiIDMCxP/hSbpHwgdg
         CjIeqMB/6FGXlIM5W9zQ/ksDtHBvCWCvgX2RSsSM+sozhYL9lSBxg3rU+Gamid5FWxU2
         40Fl4VpG8Coy74PeC/mLiZPoB5Dvyxe+Y+vn6DYVjcGg0+IHNjrANzo4dXa/d2f2rQwT
         FTAp/XdOoDGU6Lei0vw6B4BSPOfW+EUBsFSg1Bf3j4LlR25bJYGErzTyLjuodMDJEobY
         BsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJRh4siJnFIjBNJk1Xn4atDpOEvVNkQosaIacwqE+Po=;
        b=zv4fBmb3GqQBKjQfE39la+1VVNxWwcug69gXVU0XOCj+BRR82c+uOnnJFsvxr9chEx
         o+pkNIajN/DHefA7DH2v7s+Y0VNykx1jOeV9fi0PT3qFS7DYvNxZsu1X1eGr8pqkjm5z
         Cs3s2BkwTqmpmENwPZnrJMsFpN7AuqeJFC+pDiukgUmM4wFMqT87f+5PenjyJn1eyfxW
         TaumZ7+F7ncPlGsczAysgrO/EYj+GziPjmhFHz4gkWK4MQcSxN3YdYGnDUKtCRmTj+sj
         od5EIwlnCq3U6AhnYpAIlQNamYgUA3a0yXwupeobPLlCppPF5fS3pj891UPYTPoApOGd
         SQLg==
X-Gm-Message-State: ACrzQf3vM7EglqdNPFujm7U8lJh/uCISbzEyISVySw4Ry1qXbyDIMZ3L
        LC9d7j70wULSERXvl207I/dLzA==
X-Google-Smtp-Source: AMsMyM7cT3Je5DARqBMqDLzHzu/YZtfclonk6NB71sSXCykR5sOvYMHVST4OxWPNFglY7F2olwyvZw==
X-Received: by 2002:a17:907:2702:b0:78e:e94:2ac4 with SMTP id w2-20020a170907270200b0078e0e942ac4mr4629103ejk.679.1665914502526;
        Sun, 16 Oct 2022 03:01:42 -0700 (PDT)
Received: from mbp-di-paolo.station (net-2-37-204-83.cust.vodafonedsl.it. [2.37.204.83])
        by smtp.gmail.com with ESMTPSA id v25-20020aa7dbd9000000b00456c6b4b777sm5101871edt.69.2022.10.16.03.01.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Oct 2022 03:01:41 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] bfq: do try insert merge before bfq_init_rq() call
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <57bd392b-45a6-929c-8be1-b0f6cff1da31@gmail.com>
Date:   Sun, 16 Oct 2022 12:01:39 +0200
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2EA88BDB-9C3B-4EF6-BF8B-3CCF7DB304C1@linaro.org>
References: <20221013135321.174-1-Yuwei.Guan@zeekrlife.com>
 <20221014145004.gqqpa5uvgg576tej@quack3>
 <57bd392b-45a6-929c-8be1-b0f6cff1da31@gmail.com>
To:     Yuwei Guan <ssawgyw@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 15 ott 2022, alle ore 05:32, Yuwei Guan <ssawgyw@gmail.com> =
ha scritto:
>=20
>=20
> On 2022/10/14 22:50, Jan Kara wrote:
>> On Thu 13-10-22 21:53:21, Yuwei Guan wrote:
>>> It's useless to do bfq_init_rq(rq), if the rq can do merge first.
>>>=20
>>> In the patch 5f550ede5edf8, it moved to bfq_init_rq() before
>>> blk_mq_sched_try_insert_merge(), but it's pointless,
>>> as the fifo_time of next is not set yet,
>>> and !list_empty(&next->queuelist) is 0, so it does not
>>> need to reposition rq's fifo_time.
>>>=20
>>> And for the "hash lookup, try again" situation, as follow,
>>> bfq_requests_merged() call can work normally.
>>>=20
>>> blk_mq_sched_try_insert_merge
>>>   elv_attempt_insert_merge
>>>     elv_rqhash_find
>>>=20
>>> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
>> OK, after some thinking I agree. How much testing has this patch got?
>> Because I'd like to verify we didn't overlook something.
>>=20
>> 							Honza
> Thanks for reviewing.
> I tested it with fio seq read case like bellow,
> then check blk trace and bfq log.
>=20
> [global]
> name=3Dfio-seq-reads
> filename=3Dfio-seq-reads
> rw=3Dread
> bs=3D16K
> direct=3D1
> numjobs=3D4
>=20
> [file1]
> size=3D32m
> ioengine=3Dpsync
>=20
> What kinds of test cases you perfer to do, I will deal with them,
> or we verify this patch together, if you have free time. :)


Hi guys,
thank you Yuwei for proposing this.  Yet, I'm a little doubtful, for
the case where blk_mq_sched_try_insert_merge returns true, and then to
bfq_init_rq() does not get called.  In this case, all the code for
handling bursts, splits, ioprio changes and the other stuff in to
bfq_init_rq() is not executed.  This worries me a little bit.  Can you
show me why not executing these operations is fine?

Thanks,
Paolo

>>> ---
>>>  block/bfq-iosched.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>> index 7ea427817f7f..9845370a701c 100644
>>> --- a/block/bfq-iosched.c
>>> +++ b/block/bfq-iosched.c
>>> @@ -6147,7 +6147,7 @@ static void bfq_insert_request(struct =
blk_mq_hw_ctx *hctx, struct request *rq,
>>>  		bfqg_stats_update_legacy_io(q, rq);
>>>  #endif
>>>  	spin_lock_irq(&bfqd->lock);
>>> -	bfqq =3D bfq_init_rq(rq);
>>> +
>>>  	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
>>>  		spin_unlock_irq(&bfqd->lock);
>>>  		blk_mq_free_requests(&free);
>>> @@ -6156,6 +6156,7 @@ static void bfq_insert_request(struct =
blk_mq_hw_ctx *hctx, struct request *rq,
>>>    	trace_block_rq_insert(rq);
>>>  +	bfqq =3D bfq_init_rq(rq);
>>>  	if (!bfqq || at_head) {
>>>  		if (at_head)
>>>  			list_add(&rq->queuelist, &bfqd->dispatch);
>>> --=20
>>> 2.34.1


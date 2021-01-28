Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11E2C433DB
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 18:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D40364E1B
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 18:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhA1SBQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhA1Ry2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 12:54:28 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C29DC06178A
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 09:54:09 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m1so2001157wml.2
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 09:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mGZTM3yvpmS+geghqoe2o92hSRGxzv0Mdafe6Ewpzbw=;
        b=v+cFStDVjuQvo2Hh516Yee2QrV8bhJg5a6X0bZI68iBLfsCtC6l6OEw6yTDCM/gS0Z
         m2ZIHaS1jVlnqovj0T8NEASVSW7/bgBs3lNxCJtkMNxvfM2V5f/Tw0gi/V35hQtWXkn7
         d0nYFfpxom5dvB/Rh6SuGhwpNWaLQ60NaDUPHNNVgdUsFXiDxV4tvv0D1pdSDYSYoT7Z
         9kRZPLGIg3wZ1MnyI8HkPJVY/uSjK4qlNr/cIYX+UGq2bRXje1hzsw8KKPIKHzin8ZDL
         v2hpI2x/D61cceGgStdseoMghoEe4p8kjLZQS7+6J7Bub+z+9a1QO9b5tN1w2/MEy1xj
         njEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mGZTM3yvpmS+geghqoe2o92hSRGxzv0Mdafe6Ewpzbw=;
        b=WNszN7VQzITRSTt2q2vZPV5ttjUZmfbaed0ScLqClq3BwYiQqHbpCmT9J9Ta1HeolV
         u+z9VNlBDAFyogLVoYK9jHxyws7IXYUbgCO4wkkj0og66JqS5hE4xFB/SDcb5GTsR0ZH
         IuFrD6QsNBHlkz1x+14eih6DEScjSHG335W/adJTWLzKcTUASD4+7qBFNovZfPm1/Zxc
         JHPsOSQ7nvJAt8qbTRscs5DkDv0eSj0IEfIzfjFVFztinbzK1oWq/O9OpnPt3OSLEIdK
         CqyX5VO2hsHOVdhWrh7D5Ls/TV8Q7hJlqcm0QGEPa8304tpEmuizh/pBiOvbE39DIE41
         r7Jg==
X-Gm-Message-State: AOAM531vIoSlDBRqEwpJvZNaFSNnFbqI49ALtZj8wHtjgH0UhpHzxC1e
        Klk3U9TO+ig/7XCruWr3gtDD7Q==
X-Google-Smtp-Source: ABdhPJyjTtBG5Tdf8h+jFBgIEgYPPNLJw8w+a2q0tehjKkiUE0tTGgqWViyVxC1+YL4zhQbE4oD4vQ==
X-Received: by 2002:a1c:5608:: with SMTP id k8mr374290wmb.91.1611856448254;
        Thu, 28 Jan 2021 09:54:08 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id c18sm12802900wmk.0.2021.01.28.09.54.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2021 09:54:07 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 2/6] block, bfq: put reqs of waker and
 woken in dispatch list
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <36ecc71d-ef51-c667-74f8-d8f289e2f7db@kernel.dk>
Date:   Thu, 28 Jan 2021 18:54:05 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5A6D401-D774-4D9E-A68B-08D46368653E@linaro.org>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
 <20210126105102.53102-3-paolo.valente@linaro.org>
 <36ecc71d-ef51-c667-74f8-d8f289e2f7db@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 26 gen 2021, alle ore 17:18, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 1/26/21 3:50 AM, Paolo Valente wrote:
>> Consider a new I/O request that arrives for a bfq_queue bfqq. If, =
when
>> this happens, the only active bfq_queues are bfqq and either its =
waker
>> bfq_queue or one of its woken bfq_queues, then there is no point in
>> queueing this new I/O request in bfqq for service. In fact, the
>> in-service queue and bfqq agree on serving this new I/O request as
>> soon as possible. So this commit puts this new I/O request directly
>> into the dispatch list.
>>=20
>> Tested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>> ---
>> block/bfq-iosched.c | 17 ++++++++++++++++-
>> 1 file changed, 16 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index a83149407336..e5b83910fbe0 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -5640,7 +5640,22 @@ static void bfq_insert_request(struct =
blk_mq_hw_ctx *hctx, struct request *rq,
>>=20
>> 	spin_lock_irq(&bfqd->lock);
>> 	bfqq =3D bfq_init_rq(rq);
>> -	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
>> +
>> +	/*
>> +	 * Additional case for putting rq directly into the dispatch
>> +	 * queue: the only active bfq_queues are bfqq and either its
>> +	 * waker bfq_queue or one of its woken bfq_queues. In this
>> +	 * case, there is no point in queueing rq in bfqq for
>> +	 * service. In fact, the in-service queue and bfqq agree on
>> +	 * serving this new I/O request as soon as possible.
>> +	 */
>> +	if (!bfqq ||
>> +	    (bfqq !=3D bfqd->in_service_queue &&
>> +	     bfqd->in_service_queue !=3D NULL &&
>> +	     bfq_tot_busy_queues(bfqd) =3D=3D 1 + bfq_bfqq_busy(bfqq) &&
>> +	     (bfqq->waker_bfqq =3D=3D bfqd->in_service_queue ||
>> +	      bfqd->in_service_queue->waker_bfqq =3D=3D bfqq)) ||
>> +	    at_head || blk_rq_is_passthrough(rq)) {
>> 		if (at_head)
>> 			list_add(&rq->queuelist, &bfqd->dispatch);
>> 		else
>>=20
>=20
> This is unreadable... Just seems like you are piling heuristics in to
> catch some case, and it's neither readable nor clean.
>=20

Yeah, these comments inappropriately assume that the reader knows the
waker mechanism in depth.  And they do not stress at all how important
this improvement is.

I'll do my best to improve these comments.

To try to do a better job, let me also explain the matter early here.
Maybe you or others can give me some early feedback (or just tell me
to proceed).

This change is one of the main improvements that boosted
throughput in Jan's tests.  Here is the rationale:
- consider a bfq_queue, say Q1, detected as a waker of another
  bfq_queue, say Q2
- by definition of a waker, Q1 blocks the I/O of Q2, i.e., some I/O of
  of Q1 needs to be completed for new I/O of Q1 to arrive.  A notable
  example is journald
- so, Q1 and Q2 are in any respect two cooperating processes: if the
  service of Q1's I/O is delayed, Q2 can only suffer from it.
  Conversely, if Q2's I/O is delayed, the purpose of Q1 is just =
defeated.
- as a consequence if some I/O of Q1/Q2 arrives while Q2/Q1 is the
  only queue in service, there is absolutely no point in delaying the
  service of such an I/O.  The only possible result is a throughput
  loss, detected by Jan's test
- so, when the above condition holds, the most effective and efficient
  action is to put the new I/O directly in the dispatch list
- as an additional restriction, Q1 and Q2 must be the only busy queues
  for this commit to put the I/O of Q2/Q1 in the dispatch list.  This is
  necessary, because, if also other queues are waiting for service, then
  putting new I/O directly in the dispatch list may evidently cause a
  violation of service guarantees for the other queues

If these comments make things clearer, then I'll put them in the
commit message and the code, and I'll proceed with a V2.

Thanks,
Paolo


> --=20
> Jens Axboe
>=20


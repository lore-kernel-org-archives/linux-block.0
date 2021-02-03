Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA10AC433DB
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 11:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B3264E42
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 11:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhBCLC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 06:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbhBCLCF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Feb 2021 06:02:05 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206ADC06174A
        for <linux-block@vger.kernel.org>; Wed,  3 Feb 2021 03:01:25 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q7so23657827wre.13
        for <linux-block@vger.kernel.org>; Wed, 03 Feb 2021 03:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7mDAVT43Ii95qQUxVDhSZzPhYWrl5GdEHsDDvDHhjMM=;
        b=jRIZ0RioZPfDm1U8nElE7FFlSchJ6iDdtPnjkIOBNNgfYGE33w253jwX5CZiDEAfPb
         RRq0jql3eclOHRcRPWQTbR1mIufpQ6hUqJ10WVi31lRjaXLcTPwLkSrJD5Fd8JU3crFN
         OoOgSStbF/DaOoogu0U/0qKAHQGpUbR/z/bId5yugP75a2/Gc5a2c2R4+eSx5BAjO0Ce
         46Es124VuWI5stnzvz3uqd58OwPeKfuzQwyqYtrB9lNDmLoDNfUUimDeLWmiZTifX6He
         7wEoviEAwfNB/RE+4j7xaaIL5qLH5oVmJC9GMvLMEsdve1NavPm0IR+s7Fg8f0S+77Q1
         /kiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7mDAVT43Ii95qQUxVDhSZzPhYWrl5GdEHsDDvDHhjMM=;
        b=NkfZCMKnH4dcFlxRWTgJEq1fts/Ydzqgo9uDN35RetEVoe3SI0/GTysTw1QUSVy1qS
         9txzTZ/uN5lXdOJoJs1wYJipgfjSPp3fyMguLE3Eqx5hc/BqOrA8UyzzhtIEpt+n9koH
         8VIl/wggeGSyB1jrnDjz3qyFwylKGsn9hMj7tHb2NCzRlDz6sERlzJdNdRSeeTsQmnf4
         qWwMEqj4yWQh0khe32VJ/837+YxxDKJVR4bAEvPu3xV52Q7noTQFLtRxM3tT2c8xRvSt
         8a4hPsyzv3Sf1KzuelVNAOs3QVbJ3OWaNX2A0ldE/g+D42LHUZU0Nbik22qCfVgbComq
         pgFQ==
X-Gm-Message-State: AOAM532ddRU8uNgrRBwvtcbY2RyiFCEVOZCYwx00fHxfzy2Fp7UNlyyw
        ZrLqNRtVBBg7+o2p70sjF28ANQ==
X-Google-Smtp-Source: ABdhPJyswltrM2rN1pcUlAXQp/9LNfdSC3z7tpm57Mm9MBq1FZUvlLEi8VJwDEgwo52BM00+I6petg==
X-Received: by 2002:adf:e610:: with SMTP id p16mr2809395wrm.169.1612350083620;
        Wed, 03 Feb 2021 03:01:23 -0800 (PST)
Received: from [192.168.159.233] ([37.161.2.176])
        by smtp.gmail.com with ESMTPSA id l10sm3104948wro.4.2021.02.03.03.01.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 03:01:22 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 2/6] block, bfq: put reqs of waker and
 woken in dispatch list
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <A5A6D401-D774-4D9E-A68B-08D46368653E@linaro.org>
Date:   Wed, 3 Feb 2021 12:01:21 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <33968C7F-58AF-4635-B10A-9F9D53E0A128@linaro.org>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
 <20210126105102.53102-3-paolo.valente@linaro.org>
 <36ecc71d-ef51-c667-74f8-d8f289e2f7db@kernel.dk>
 <A5A6D401-D774-4D9E-A68B-08D46368653E@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 28 gen 2021, alle ore 18:54, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 26 gen 2021, alle ore 17:18, Jens Axboe <axboe@kernel.dk> =
ha scritto:
>>=20
>> On 1/26/21 3:50 AM, Paolo Valente wrote:
>>> Consider a new I/O request that arrives for a bfq_queue bfqq. If, =
when
>>> this happens, the only active bfq_queues are bfqq and either its =
waker
>>> bfq_queue or one of its woken bfq_queues, then there is no point in
>>> queueing this new I/O request in bfqq for service. In fact, the
>>> in-service queue and bfqq agree on serving this new I/O request as
>>> soon as possible. So this commit puts this new I/O request directly
>>> into the dispatch list.
>>>=20
>>> Tested-by: Jan Kara <jack@suse.cz>
>>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>>> ---
>>> block/bfq-iosched.c | 17 ++++++++++++++++-
>>> 1 file changed, 16 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>> index a83149407336..e5b83910fbe0 100644
>>> --- a/block/bfq-iosched.c
>>> +++ b/block/bfq-iosched.c
>>> @@ -5640,7 +5640,22 @@ static void bfq_insert_request(struct =
blk_mq_hw_ctx *hctx, struct request *rq,
>>>=20
>>> 	spin_lock_irq(&bfqd->lock);
>>> 	bfqq =3D bfq_init_rq(rq);
>>> -	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
>>> +
>>> +	/*
>>> +	 * Additional case for putting rq directly into the dispatch
>>> +	 * queue: the only active bfq_queues are bfqq and either its
>>> +	 * waker bfq_queue or one of its woken bfq_queues. In this
>>> +	 * case, there is no point in queueing rq in bfqq for
>>> +	 * service. In fact, the in-service queue and bfqq agree on
>>> +	 * serving this new I/O request as soon as possible.
>>> +	 */
>>> +	if (!bfqq ||
>>> +	    (bfqq !=3D bfqd->in_service_queue &&
>>> +	     bfqd->in_service_queue !=3D NULL &&
>>> +	     bfq_tot_busy_queues(bfqd) =3D=3D 1 + bfq_bfqq_busy(bfqq) &&
>>> +	     (bfqq->waker_bfqq =3D=3D bfqd->in_service_queue ||
>>> +	      bfqd->in_service_queue->waker_bfqq =3D=3D bfqq)) ||
>>> +	    at_head || blk_rq_is_passthrough(rq)) {
>>> 		if (at_head)
>>> 			list_add(&rq->queuelist, &bfqd->dispatch);
>>> 		else
>>>=20
>>=20
>> This is unreadable... Just seems like you are piling heuristics in to
>> catch some case, and it's neither readable nor clean.
>>=20
>=20
> Yeah, these comments inappropriately assume that the reader knows the
> waker mechanism in depth.  And they do not stress at all how important
> this improvement is.
>=20
> I'll do my best to improve these comments.
>=20
> To try to do a better job, let me also explain the matter early here.
> Maybe you or others can give me some early feedback (or just tell me
> to proceed).
>=20
> This change is one of the main improvements that boosted
> throughput in Jan's tests.  Here is the rationale:
> - consider a bfq_queue, say Q1, detected as a waker of another
>  bfq_queue, say Q2
> - by definition of a waker, Q1 blocks the I/O of Q2, i.e., some I/O of
>  of Q1 needs to be completed for new I/O of Q1 to arrive.  A notable
>  example is journald
> - so, Q1 and Q2 are in any respect two cooperating processes: if the
>  service of Q1's I/O is delayed, Q2 can only suffer from it.
>  Conversely, if Q2's I/O is delayed, the purpose of Q1 is just =
defeated.
> - as a consequence if some I/O of Q1/Q2 arrives while Q2/Q1 is the
>  only queue in service, there is absolutely no point in delaying the
>  service of such an I/O.  The only possible result is a throughput
>  loss, detected by Jan's test
> - so, when the above condition holds, the most effective and efficient
>  action is to put the new I/O directly in the dispatch list
> - as an additional restriction, Q1 and Q2 must be the only busy queues
>  for this commit to put the I/O of Q2/Q1 in the dispatch list.  This =
is
>  necessary, because, if also other queues are waiting for service, =
then
>  putting new I/O directly in the dispatch list may evidently cause a
>  violation of service guarantees for the other queues
>=20
> If these comments make things clearer, then I'll put them in the
> commit message and the code, and I'll proceed with a V2.
>=20

Hi Jens,
may I proceed with a V2?

Thanks,
Paolo

> Thanks,
> Paolo
>=20
>=20
>> --=20
>> Jens Axboe


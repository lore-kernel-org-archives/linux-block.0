Return-Path: <SRS0=4wZT=BB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C580C433E2
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 09:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0526B20729
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 09:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsiQyKbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbgGVJNc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgGVJNc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 05:13:32 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE15FC0619DC
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2020 02:13:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w6so1426883ejq.6
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2020 02:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Jykpt/Kb2fIe75xsqlTS0vliRxM4ipl7gvFFaG21xG0=;
        b=AsiQyKbc+e9nzeW+S+gzkMe7A3+2fPTqxGAa33Ix7mL5qJGLQGDpFrd6nl6vVhqGIJ
         776ax402SIffwek2MvDgJY28LOp+ZRSz5+w3DmSyQZ2Nap107Q+N5CyV+l3IFn9/9kS7
         dEEGQ1i7Ut1v9FkB1l3M73oMiJ5DOPhlXhpku6QSh7xY4vmE/1v14QVyQZrhYvL1Tora
         oDffH1Vv/KmQQ0V9jGQ2LqtEFV6qchBUoLJBRfMxGt3bT7dl1SWZQ6eyAyj+wEqeMagt
         sIhBtAaYwHPrJwsGq7/ZYxaxERJIiyQgReU7JShQO6e0boDg2ONB0JVo4CUtEXvKgFxY
         mWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Jykpt/Kb2fIe75xsqlTS0vliRxM4ipl7gvFFaG21xG0=;
        b=IF4rgsy7sDXT6Rszdyeh6/EWNA5ckBBcALNYw5cTzTC4WiKvL79LNbDCvmjOp/YESS
         YHALaZhMhxiWomHdZ5dL+BLJaEzMgXhdiLvsHTY5X75p9RlhcX8Dm1JPZJdMb1Uk0h4T
         iUPvq/6Xwh2ChOBXyQaG4dgmmgBoqWi2tA4RjUwcXiECKGRuxxKo0Vu3PschMMvSIB90
         XCCaGXZUV4CyWx2Bt39SmJ7HtJIRGwnRMbu2qk8gJv79kC0XWxpGvokSXv+QouJwuJQF
         JJg91qSCdmPF93eQiRPNLfTdWoJxeVSa8l3rA63kyLSJMQGG9+xV1St6Yav2ut3fmPMb
         ULBw==
X-Gm-Message-State: AOAM532WBYrA2njhOXuBB1vgIqqL0WFmadDper/id+fsfYwMMdWpBbXH
        EpBF6o2WZTi8iDHDtvEjWTZnnc91pyG7Eg==
X-Google-Smtp-Source: ABdhPJzg0bwXNZjhl7ury7bO6Uo/g0VYGxZKYqqCLM+GiSM6TaPpIQgNr4caqVEnwdNZ5/g1mu4V4A==
X-Received: by 2002:a17:906:1c05:: with SMTP id k5mr28489553ejg.320.1595409210287;
        Wed, 22 Jul 2020 02:13:30 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id m14sm17871507ejx.80.2020.07.22.02.13.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2020 02:13:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 3/3] bfq: Use only idle IO periods for think time
 calculations
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20200611143912.GC19132@quack2.suse.cz>
Date:   Wed, 22 Jul 2020 11:13:28 +0200
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7BE4BFD7-F8C1-49DE-A318-9E038B9A19BC@linaro.org>
References: <20200605140837.5394-1-jack@suse.cz>
 <20200605141629.15347-3-jack@suse.cz>
 <934FEB51-BB23-4ACA-BCEC-310E56A910CC@linaro.org>
 <20200611143912.GC19132@quack2.suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 11 giu 2020, alle ore 16:39, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> On Thu 11-06-20 16:11:10, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 5 giu 2020, alle ore 16:16, Jan Kara <jack@suse.cz> ha =
scritto:
>>>=20
>>> Currently whenever bfq queue has a request queued we add now -
>>> last_completion_time to the think time statistics. This is however
>>> misleading in case the process is able to submit several requests in
>>> parallel because e.g. if the queue has request completed at time T0 =
and
>>> then queues new requests at times T1, T2, then we will add T1-T0 and
>>> T2-T0 to think time statistics which just doesn't make any sence =
(the
>>> queue's think time is penalized by the queue being able to submit =
more
>>> IO).
>>=20
>> I've thought about this issue several times.  My concern is that, by
>> updating the think time only when strictly meaningful, we reduce the
>> number of samples.  In some cases, we may reduce it to a very low
>> value.  For this reason, so far I have desisted from changing the
>> current scheme.  IOW, I opted for dirtier statistics to avoid the =
risk
>> of too scarse statistics.  Any feedback is very welcome.
>=20
> I understand the concern.

Hi,
sorry for the sidereal delay.

> But:
>=20
> a) I don't think adding these samples to statistics helps in any way =
(you
> cannot improve the prediction power of the statistics by including in =
it
> some samples that are not directly related to the thing you try to
> predict). And think time is used to predict the answer to the =
question: If
> bfq queue becomes idle, how long will it take for new request to =
arrive? So
> second and further requests are simply irrelevant.
>=20

Yes, you are super right in theory.

Unfortunately this may not mean that your patch will do only good, for
the concerns in my previous email.=20

So, here is a proposal to move forward:
1) I test your patch on my typical set of
   latency/guaranteed-bandwidth/total-throughput benchmarks
2) You test your patch on a significant set of benchmarks in mmtests

What do you think?

Thanks,
Paolo

> b) =46rom my testing with 4 fio sequential readers (the workload =
mentioned in
> the previous patch) this patch caused a noticeable change in computed =
think
> time and that allowed fio processes to be reliably marked as having =
short
> think time (without this patch they were oscilating between short =
ttime and
> not short ttime) and consequently achieving better throughput because =
we
> were idling for new requests from these bfq queues. Note that this was =
with
> somewhat aggressive slice_idle setting (2ms). Having slice_idle >=3D =
4ms was
> enough hide the ttime computation issue but still this demonstrates =
that
> these bogus samples noticeably raise computed average.
>=20
> 								Honza
>=20
>>> So add to think time statistics only time intervals when the queue
>>> had no IO pending.
>>>=20
>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>> ---
>>> block/bfq-iosched.c | 12 ++++++++++--
>>> 1 file changed, 10 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>> index c66c3eaa9e26..4b1c9c5f57b6 100644
>>> --- a/block/bfq-iosched.c
>>> +++ b/block/bfq-iosched.c
>>> @@ -5192,8 +5192,16 @@ static void bfq_update_io_thinktime(struct =
bfq_data *bfqd,
>>> 				    struct bfq_queue *bfqq)
>>> {
>>> 	struct bfq_ttime *ttime =3D &bfqq->ttime;
>>> -	u64 elapsed =3D ktime_get_ns() - bfqq->ttime.last_end_request;
>>> -
>>> +	u64 elapsed;
>>> +=09
>>> +	/*
>>> +	 * We are really interested in how long it takes for the queue =
to
>>> +	 * become busy when there is no outstanding IO for this queue. =
So
>>> +	 * ignore cases when the bfq queue has already IO queued.
>>> +	 */
>>> +	if (bfqq->dispatched || bfq_bfqq_busy(bfqq))
>>> +		return;
>>> +	elapsed =3D ktime_get_ns() - bfqq->ttime.last_end_request;
>>> 	elapsed =3D min_t(u64, elapsed, 2ULL * bfqd->bfq_slice_idle);
>>>=20
>>> 	ttime->ttime_samples =3D (7*ttime->ttime_samples + 256) / 8;
>>> --=20
>>> 2.16.4
>>>=20
>>=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


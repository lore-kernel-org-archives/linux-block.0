Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D988C04FF3
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 16:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E596140A
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 16:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhEXQ64 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 12:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhEXQ64 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 12:58:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D780EC061574
        for <linux-block@vger.kernel.org>; Mon, 24 May 2021 09:57:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j14so27499914wrq.5
        for <linux-block@vger.kernel.org>; Mon, 24 May 2021 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Y283bYKqjjFZpote81xgBydq2szeeXJF4HwUcfZ5G4U=;
        b=Ad94wcini9D/PjJs/+s68njOEjpI8+Hrls2SQ8ZZOPS9SZlP4rnfCqaxJNnC9ZUnYg
         agZpu6eNh8w3wqaVWjyVTutEZARhPn2YCOhvsO0fCXI7c6nVGsGzeuplUAcfPclsYgq9
         Dsn0P76w44QDmaE/liX2aqJz3Ap961SMFSwUNiPbHKv68oAFR3hcMVc/Fp4M1RDRcEew
         kNDsBXGIcuy7BbzfIVIZlGpEOxijQ5BCuxG2kdMsDyeKclbHyIVwaWvcWBOS6AGz9UYu
         b9uf/E3FabxqJz4xKhv7t25c+2fE4PMBUyFUosVLRN2+83KtKeGknqCBe4/5+BMwstX0
         G+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Y283bYKqjjFZpote81xgBydq2szeeXJF4HwUcfZ5G4U=;
        b=cA5eOpi5lVts4c4EAnhEyxL/sMKjCXmcrAQC3eGRWG4rupK3fCNVeZk3zW1kwoMQVt
         RR8REfuipZZ6tovXMvHgPQSqLQyxVkCaRizVnm8TUQaTbcYgzDDVzMctxJWiyOOyp+aN
         geS2NsZDesIUJG24Pl+4MKFfaxcbbd2OTh4VLT4NSDWsOgyS2c4J/TsBzO7uZyWTmdlP
         Ii7Y2Bx4ZnybyreHXbQ4MKdLiiIKOZkZMDDLP7oOmnOLripbq25VOqoyI6J1Tp7PeP+2
         3LJTXSbIQTUMWePc7ukwMdJfXeA0ipFNeTxNEYDiphukqAOndH6t44YSRifrHJApxw2U
         h5vQ==
X-Gm-Message-State: AOAM533GQNabG2BtuRRzHvG25VpOlIvDEmQBxhSV0kHf3Ue6t0CRPrcw
        +NKE0uNkTlDUei12rgvEmAl/gg==
X-Google-Smtp-Source: ABdhPJwwavN74nDwv05tGswbJ7OGRH1nN6+NEZ0UaCGEKFsbEO/Wss6ugU34uvxPj3YfzR0i2svnrQ==
X-Received: by 2002:adf:e589:: with SMTP id l9mr23795092wrm.361.1621875446480;
        Mon, 24 May 2021 09:57:26 -0700 (PDT)
Received: from [192.168.228.233] ([37.162.61.33])
        by smtp.gmail.com with ESMTPSA id b81sm57504wmd.18.2021.05.24.09.57.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 May 2021 09:57:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX] block, bfq: fix delayed stable merge check
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <f23f8090-4a55-3c16-1bdd-f86634cd6f3b@applied-asynchrony.com>
Date:   Mon, 24 May 2021 18:57:23 +0200
Cc:     Luca Mariotti <mariottiluca1@hotmail.it>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Pietro Pedroni <pedroni.pietro.96@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E9D95C99-D07B-4A63-8C0E-67356887DE23@linaro.org>
References: <DB8PR01MB59647C41BF6C964467EAFE0D882C9@DB8PR01MB5964.eurprd01.prod.exchangelabs.com>
 <f23f8090-4a55-3c16-1bdd-f86634cd6f3b@applied-asynchrony.com>
To:     =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 20 mag 2021, alle ore 09:15, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>=20
> On 2021-05-18 12:43, Luca Mariotti wrote:
>> When attempting to schedule a merge of a given bfq_queue with the =
currently
>> in-service bfq_queue or with a cooperating bfq_queue among the =
scheduled
>> bfq_queues, delayed stable merge is checked for rotational or =
non-queueing
>> devs. For this stable merge to be performed, some conditions must be =
met.
>> If the current bfq_queue underwent some split from some merged =
bfq_queue,
>> one of these conditions is that two hundred milliseconds must elapse =
from
>> split, otherwise this condition is always met.
>> Unfortunately, by mistake, time_is_after_jiffies() was written =
instead of
>> time_is_before_jiffies() for this check, verifying that less than two
>> hundred milliseconds have elapsed instead of verifying that at least =
two
>> hundred milliseconds have elapsed.
>> Fix this issue by replacing time_is_after_jiffies() with
>> time_is_before_jiffies().
>> Signed-off-by: Luca Mariotti <mariottiluca1@hotmail.it>
>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>> Signed-off-by: Pietro Pedroni <pedroni.pietro.96@gmail.com>
>> ---
>>  block/bfq-iosched.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index acd1f881273e..2adb1e69c9d2 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -2697,7 +2697,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, =
struct bfq_queue *bfqq,
>>  	if (unlikely(!bfqd->nonrot_with_queueing)) {
>>  		if (bic->stable_merge_bfqq &&
>>  		    !bfq_bfqq_just_created(bfqq) &&
>> -		    time_is_after_jiffies(bfqq->split_time +
>> +		    time_is_before_jiffies(bfqq->split_time +
>>  					  msecs_to_jiffies(200))) {
>>  			struct bfq_queue *stable_merge_bfqq =3D
>>  				bic->stable_merge_bfqq;
>=20
> Not sure why but with this patch I quickly got a division-by-zero in =
BFQ and
> complete system halt. Unfortunately I couldn't capture the exact stack =
trace,
> but it read something like bfq_calc_weight() or something ike that.
> I looked through the code and found bfq_delta(), so maybe weight got
> reduced to 0?
>=20

Hi Holger,
is this (easily) reproducible for you?  If so, I'd like to propose you
a candidate fix.

Thanks,
Paolo

> -h


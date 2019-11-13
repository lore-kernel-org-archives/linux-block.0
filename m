Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75426C43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 13:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E1F222CA
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 13:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zrv3Y0pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfKMNwu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:52:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37312 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfKMNwu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 08:52:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id t1so2465044wrv.4
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2019 05:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TRSUK0G723bpvyeCvufO8ci+CtgHDJUd3CuID3y6wMI=;
        b=zrv3Y0pasZ/2e0T00aZYXOvxU26Sl+l2FaytzxpMv6IDqdCg0E9/HgCGz0vZcowzjN
         fOJULF0hgZm5LavTh66vqi0aKmtL4XZvJEO3jpxmlRd72dj7tW9P41763iPFqLkPV+6u
         z58C0jKJmR7Z8MYj0EnsGguxgVia301X/benzAhkTEBs7wu22E4cK0muKwLXxrfkCm1E
         5DR8Y8fENPEMDMmWWLNkIababCzH1z4y7oyFPZCRa8OE0kVkgZuofMdBW9rdEK/6D+m6
         N/EL+ADAcx2BOeYlhun75c0F0tNz7lxiEq45vTPH9NaP7XrCuC79Vx1KHoipP+lucAAu
         XRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TRSUK0G723bpvyeCvufO8ci+CtgHDJUd3CuID3y6wMI=;
        b=fD9brULY2nFvjLlZ0YsxIQ2/494Y6vvV0DX4TigT1UZXYzxNoMxJf8vdxtAcxcaPq5
         PyqLvwF9R8UzEMU7k5fME67+NfVSSJnHT4w2duL2txaPy4fWtSNAkzNCr62RGe6feqm3
         kh1n7sJsJIsqflMfApo4hCMGpN91QR4nD8qI8JUnEY5IQxg3XWaK5Xq+7ait1azzQ0j8
         PR3tT4SreLG+VjfXOKPTKLcLqQdPo2YXGGByUyaCe5b8IaWWXkvnWu5twDQTG9MJpcjI
         k41rfxA3AEJTT4/je+Z7517QvGFAlxDhsByCDeMHLrRqnLxKRoUCMCcxWjiAQBctPVl/
         KXFw==
X-Gm-Message-State: APjAAAVkNGNdZkyFvCgIEOfchmMXIvOd/e6BenOOPYYnWBGccYrgOCmf
        JSs8BeAQdIe752+xnJcRNYBGPw==
X-Google-Smtp-Source: APXvYqxfNQIU8IceAKVMRAZXAaTSGZ18ShF9wDh2LssOqvtNQD91gzj5/ZOJ4WJ0Z1Y7JGZv40LE9g==
X-Received: by 2002:adf:d083:: with SMTP id y3mr2838979wrh.53.1573653167206;
        Wed, 13 Nov 2019 05:52:47 -0800 (PST)
Received: from nbvalente.mat.unimo.it (nbvalente.mat.unimo.it. [155.185.5.181])
        by smtp.gmail.com with ESMTPSA id v128sm2973798wmb.14.2019.11.13.05.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 05:52:46 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BUGFIX] block, bfq: deschedule empty bfq_queues not
 referred by any process
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <bb393dcaa426786e0963cf0e70f0b062@natalenko.name>
Date:   Wed, 13 Nov 2019 14:52:45 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        Chris Evich <cevich@redhat.com>,
        Patrick Dung <patdung100@gmail.com>,
        Thorsten Schubert <tschubert@bafh.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2FB3736A-693E-44B9-9D1F-39AE0D016644@linaro.org>
References: <20191112074856.40433-1-paolo.valente@linaro.org>
 <bb393dcaa426786e0963cf0e70f0b062@natalenko.name>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 13 nov 2019, alle ore 13:57, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>=20
> Hi.
>=20
> On 12.11.2019 08:48, Paolo Valente wrote:
>> Since commit 3726112ec731 ("block, bfq: re-schedule empty queues if
>> they deserve I/O plugging"), to prevent the service guarantees of a
>> bfq_queue from being violated, the bfq_queue may be left busy, i.e.,
>> scheduled for service, even if empty (see comments in
>> __bfq_bfqq_expire() for details). But, if no process will send
>> requests to the bfq_queue any longer, then there is no point in
>> keeping the bfq_queue scheduled for service.
>> In addition, keeping the bfq_queue scheduled for service, but with no
>> process reference any longer, may cause the bfq_queue to be freed =
when
>> descheduled from service. But this is assumed to never happen, and
>> causes a UAF if it happens. This, in turn, caused crashes [1, 2].
>> This commit fixes this issue by descheduling an empty bfq_queue when
>> it remains with not process reference.
>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1767539
>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D205447
>> Fixes: 3726112ec731 ("block, bfq: re-schedule empty queues if they
>> deserve I/O plugging")
>> Reported-by: Chris Evich <cevich@redhat.com>
>> Reported-by: Patrick Dung <patdung100@gmail.com>
>> Reported-by: Thorsten Schubert <tschubert@bafh.org>
>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>> ---
>> block/bfq-iosched.c | 31 +++++++++++++++++++++++++------
>> 1 file changed, 25 insertions(+), 6 deletions(-)
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 0319d6339822..ba68627f7740 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -2713,6 +2713,27 @@ static void bfq_bfqq_save_state(struct =
bfq_queue *bfqq)
>> 	}
>> }
>> +
>> +static
>> +void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue =
*bfqq)
>> +{
>> +	/*
>> +	 * To prevent bfqq's service guarantees from being violated,
>> +	 * bfqq may be left busy, i.e., queued for service, even if
>> +	 * empty (see comments in __bfq_bfqq_expire() for
>> +	 * details). But, if no process will send requests to bfqq any
>> +	 * longer, then there is no point in keeping bfqq queued for
>> +	 * service. In addition, keeping bfqq queued for service, but
>> +	 * with no process ref any longer, may have caused bfqq to be
>> +	 * freed when dequeued from service. But this is assumed to
>> +	 * never happen.
>> +	 */
>> +	if (bfq_bfqq_busy(bfqq) && RB_EMPTY_ROOT(&bfqq->sort_list))
>> +		bfq_del_bfqq_busy(bfqd, bfqq, false);
>> +
>> +	bfq_put_queue(bfqq);
>> +}
>> +
>> static void
>> bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
>> 		struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
>> @@ -2783,8 +2804,7 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct
>> bfq_io_cq *bic,
>> 	 */
>> 	new_bfqq->pid =3D -1;
>> 	bfqq->bic =3D NULL;
>> -	/* release process reference to bfqq */
>> -	bfq_put_queue(bfqq);
>> +	bfq_release_process_ref(bfqd, bfqq);
>> }
>> static bool bfq_allow_bio_merge(struct request_queue *q, struct =
request *rq,
>> @@ -4899,7 +4919,7 @@ static void bfq_exit_bfqq(struct bfq_data =
*bfqd,
>> struct bfq_queue *bfqq)
>> 	bfq_put_cooperator(bfqq);
>> -	bfq_put_queue(bfqq); /* release process reference */
>> +	bfq_release_process_ref(bfqd, bfqq);
>> }
>> static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
>> @@ -5001,8 +5021,7 @@ static void bfq_check_ioprio_change(struct
>> bfq_io_cq *bic, struct bio *bio)
>> 	bfqq =3D bic_to_bfqq(bic, false);
>> 	if (bfqq) {
>> -		/* release process reference on this queue */
>> -		bfq_put_queue(bfqq);
>> +		bfq_release_process_ref(bfqd, bfqq);
>> 		bfqq =3D bfq_get_queue(bfqd, bio, BLK_RW_ASYNC, bic);
>> 		bic_set_bfqq(bic, bfqq, false);
>> 	}
>> @@ -5963,7 +5982,7 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct
>> bfq_queue *bfqq)
>> 	bfq_put_cooperator(bfqq);
>> -	bfq_put_queue(bfqq);
>> +	bfq_release_process_ref(bfqq->bfqd, bfqq);
>> 	return NULL;
>> }
>=20
> I'm not sure if I see things right, but this commit along with v5.3.11 =
kernel causes almost all boots to hang (for instance, on mounting the =
FS). Once the scheduler is changed to something else than BFQ (I set the =
I/O scheduler early via udev rule), multiple reboots go just fine.
>=20

If you switch back to bfq after the boot, can you still reproduce the =
hang?

> Is this commit also applicable to 5.3 kernels?

It is.

Thanks,
Paolo

> Or I'm testing a dumb thing?
>=20



> Thanks.
>=20
> --=20
>  Oleksandr Natalenko (post-factum)


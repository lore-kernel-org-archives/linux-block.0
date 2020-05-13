Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5ACC433DF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 22:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898CA20659
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 22:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsVEMSvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgEMWCc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 18:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729775AbgEMWCc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 18:02:32 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA153C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 15:02:31 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f134so15985700wmf.1
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 15:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NV0I+PQ/bP/GA960hSqWWInbdEsB8a3xj+0T2OplAI8=;
        b=zsVEMSvo5zRFkbrslR/SdvibGufMZDtISasn8y9CWtnpLwCfNzl+dWWIAZlfDRuvaV
         KSiXNBfONGMdbb/AXdKQZSrDQ1jE2S01iY3DcRHwn4etS+X6xW4Wpf39VwNuT7EuvqZO
         jVXiiiNntcKfOOo0jry4K0jYp4Rpko9Fdee90BapxMOcX0c57DfdeCMDOyNzO2VgTQkQ
         8UZ/6mkllgUWApck4F8HPz/03Ijyl5NixHXCfFZIa6w4tTAkmNGt5PLK/rcK50dTRNCw
         RcLQ/O00CFgzIr8hBxSb+bEF7Z2gLkDSgbilQBmnmX6hBqIGKbJYPEFBa+eWtiMjvYZ6
         UL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NV0I+PQ/bP/GA960hSqWWInbdEsB8a3xj+0T2OplAI8=;
        b=Ca5Bz4UbX3IsBbFz/AhEVoW/JgGTxmUQKvGVGKBaraFlzrF4cplu2dl5Q7eFKRMaBI
         hwQ0GCKkFbtyRslb0vTfjzlJLp4V539SSpyeRPLV2gHCDqfz/O9Xi2ZNBvxgieLWTWSU
         BW1TC/2cSGLrBml5hrQNKEbJLBCVDZ9OH8Bo8/s7x1XbGbBzN4AIDv+Rv6st+8TUYpdx
         eMLdkpiaNx1riZnJVJBTR57xsHDxZNZq+UrCR9UgB0TlUu0ZBDnQdTihDLV+gYzAA0+1
         rkZRUKZqHVHTY8j4c3CisyPN2SNzEVJt6KCoDKqldT3ks7Q6Sftp3KpvpWAc4YypaR0Y
         fHZg==
X-Gm-Message-State: AGi0PubTbjqHHOReejSM/UTNnVAIAUclyKx2srDTekUIlwo0GmoOzxB0
        U7YmIY3tLvo4DSZ8+i0d8TEr5u6BlPI=
X-Google-Smtp-Source: APiQypImDRFIw23OphRLSr2tLCe254h14d2kawUwf8XYH2kgtFJDmngnS+J14nygZmJuDqj2G3hy3A==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr41899992wmb.166.1589407350423;
        Wed, 13 May 2020 15:02:30 -0700 (PDT)
Received: from [192.168.0.105] ([84.33.166.154])
        by smtp.gmail.com with ESMTPSA id 128sm32340068wme.39.2020.05.13.15.02.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 15:02:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] blktrace: Report pid with note messages
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20200513160223.7855-1-jack@suse.cz>
Date:   Thu, 14 May 2020 00:04:12 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E45FC662-D4FB-4927-8DE3-22E22687B643@linaro.org>
References: <20200513160223.7855-1-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 13 mag 2020, alle ore 18:02, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> Currently informational messages within block trace do not have PID
> information of the process reporting the message included. With BFQ it
> is sometimes useful to have the information and there's no good reason
> to omit the information from the trace. So just fill in pid =
information
> when generating note message.
>=20

Acked-by: Paolo Valente <paolo.valente@linaro.org>

Thank you!
Paolo

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> kernel/trace/blktrace.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index ca39dc3230cb..ea47f2084087 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -170,10 +170,10 @@ void __trace_note_message(struct blk_trace *bt, =
struct blkcg *blkcg,
> 	if (!(blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))
> 		blkcg =3D NULL;
> #ifdef CONFIG_BLK_CGROUP
> -	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n,
> +	trace_note(bt, current->pid, BLK_TN_MESSAGE, buf, n,
> 		   blkcg ? cgroup_id(blkcg->css.cgroup) : 1);
> #else
> -	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n, 0);
> +	trace_note(bt, current->pid, BLK_TN_MESSAGE, buf, n, 0);
> #endif
> 	local_irq_restore(flags);
> }
> --=20
> 2.16.4
>=20


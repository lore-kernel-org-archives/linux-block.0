Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC10C4361A
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 22:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5197D2220F
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 22:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgLCWOQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 17:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLCWOP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 17:14:15 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BC2C061A4F
        for <linux-block@vger.kernel.org>; Thu,  3 Dec 2020 14:13:35 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id x13so1216101uar.4
        for <linux-block@vger.kernel.org>; Thu, 03 Dec 2020 14:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KPxLDK2m3t3rbdEsv04AbgR9S3xVqD3vwyaV/8maCC4=;
        b=jx8h0ibXuK5mC+q5Jz5dvyMzbpp+OA974bweeH+4sROdy8QOX7PK7gAekr0nKthGl4
         cRjmPpEWFaZYPM9q71D1TrwUI3839gPHa40FhqWXd0I+7sLA4+EtsEsLzxoMDDDPBSy7
         IHOZIytaibCqhTL5FWf8ZcmAxR77IRO3CyOFNJo7FaS8KxJm7KiA4PCwNnwA+NrkQVlu
         gtsRyHAbqsi5XGBhThmDh4Wop/LDq7LAHSucmBw3/NAalpeuCAUYeTRnhUApZA8Gito0
         Fkna4gSLw6vC2KY5tCzUb4jbmIqV/rNwLpb+OlrrQh2CI2HQtMzkqPGheZoCMYJyiy+S
         7c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KPxLDK2m3t3rbdEsv04AbgR9S3xVqD3vwyaV/8maCC4=;
        b=OZfoT229T6w8vbqtmaMRsbugFAoNtVKtd/KEUrVFzk6W+epag6jFV/fGgSt2fR2mUN
         tCfcLTueBwARNez4/2dAbG1icUSGF3MV0tBwzgCICDExGTuu+Puk/dwJM1Kk6htUiGg8
         d2SxcEZXyGc1709du3+YKC207Y+44G6agxQwFOmEiwUINH7w3LeWb2M4YKExs61hVdo8
         MIJLeNythC4CE2HbKMfe/eHu0L0+nsBhPCKc63ZgsdfkmylzKfpm+LOVB+3D5P+2/zt0
         IZ9ZuENh1rUiYtZ8LaCjHm7OuXEAFZkvWD22WVRlqBwWxYrWA+UmqhL+17ncnyAcsoTO
         dyDQ==
X-Gm-Message-State: AOAM530QySdlJKtpyZ4wZEo3KbpRqsFF4fM/FbDT5OBtFE/igejbgfnu
        D+wng2LPCQy3XsVOvTE3icGYtG9rh9GPI8I+1odrJg==
X-Google-Smtp-Source: ABdhPJyzSP1fKwgvfT8Xm6ntUvZx+Fw3PJ26xCx+ecjHbcR9thZbQiP7LX27J+zTqg20SfVqUdUJxAo0/qJts8Fm1uk=
X-Received: by 2002:ab0:310:: with SMTP id 16mr1106249uat.33.1607033614516;
 Thu, 03 Dec 2020 14:13:34 -0800 (PST)
MIME-Version: 1.0
References: <000001d6c8d5$b03e7200$10bb5600$@codeaurora.org>
In-Reply-To: <000001d6c8d5$b03e7200$10bb5600$@codeaurora.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 3 Dec 2020 14:13:23 -0800
Message-ID: <CABCJKueYF95fvdJHCuK2JwY1jpTuM4T2ynMvqa8iUp-rvqYhZA@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH] dm verity: correcting logic used with
 corrupted_errs counter
To:     Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
Cc:     linux-block@vger.kernel.org,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 3, 2020 at 8:18 AM Ravi Kumar Siddojigari
<rsiddoji@codeaurora.org> wrote:
>
> Sorry,  Resending the patch for comments with  dm-devel added .
>
> -----Original Message-----
> From: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
> Sent: Friday, November 20, 2020 6:37 PM
> To: 'linux-block@vger.kernel.org' <linux-block@vger.kernel.org>
> Cc: 'dm-devel@redhat.com' <dm-devel@redhat.com>
> Subject: RE: [PATCH] dm verity: correcting logic used with corrupted_errs
> counter
>
> One more question  :
>         Current code has DM_VERITY_MAX_CORRUPTED_ERRS  set to 100  can we
> reduce this ? or is there any  data that made us to keep this 100 ?
> Regards,
> Ravi
>
> -----Original Message-----
> From: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
> Sent: Wednesday, November 18, 2020 6:17 PM
> To: 'linux-block@vger.kernel.org' <linux-block@vger.kernel.org>
> Subject: [PATCH] dm verity: correcting logic used with corrupted_errs
> counter
>
> In verity_handle_err we see that the "corrupted_errs"  is never going to be
> more than one as the code will fall through "out" label and hit
> panic/kernel_restart on the first error  which is not as expected..
> Following patch will make sure that corrupted_errs are incremented and only
> panic/kernel_restart once it reached DM_VERITY_MAX_CORRUPTED_ERRS.
>
> Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
> ---
>  drivers/md/dm-verity-target.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index f74982dcbea0..d86900a2a8d7 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -221,8 +221,10 @@ static int verity_handle_err(struct dm_verity *v, enum
> verity_block_type type,
>         /* Corruption should be visible in device status in all modes */
>         v->hash_failed = 1;
>
> -       if (v->corrupted_errs >= DM_VERITY_MAX_CORRUPTED_ERRS)
> +       if (v->corrupted_errs >= DM_VERITY_MAX_CORRUPTED_ERRS) {
> +               DMERR("%s: reached maximum errors", v->data_dev->name);
>                 goto out;
> +       }
>
>         v->corrupted_errs++;
>
> @@ -240,13 +242,13 @@ static int verity_handle_err(struct dm_verity *v, enum
> verity_block_type type,
>         DMERR_LIMIT("%s: %s block %llu is corrupted", v->data_dev->name,
>                     type_str, block);
>
> -       if (v->corrupted_errs == DM_VERITY_MAX_CORRUPTED_ERRS)
> -               DMERR("%s: reached maximum errors", v->data_dev->name);
>
>         snprintf(verity_env, DM_VERITY_ENV_LENGTH, "%s=%d,%llu",
>                 DM_VERITY_ENV_VAR_NAME, type, block);
>
>         kobject_uevent_env(&disk_to_dev(dm_disk(md))->kobj, KOBJ_CHANGE,
> envp);
> +       /* DM_VERITY_MAX_CORRUPTED_ERRS limit not reached yet */
> +               return 0;

No. This would allow invalid blocks to be returned to userspace when
dm-verity is NOT in logging mode, which is unacceptable.
DM_VERITY_MAX_CORRUPTED_ERRS is only used to limit the number of error
messages printed out, we cannot let the first N corrupt blocks to just
slip through.

Sami

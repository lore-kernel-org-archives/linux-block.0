Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128D3C19F2D
	for <linux-block@archiver.kernel.org>; Sat, 13 Aug 2022 10:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiHMKYf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Aug 2022 06:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMKYd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Aug 2022 06:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7C6C13F00
        for <linux-block@vger.kernel.org>; Sat, 13 Aug 2022 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660386271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=heBqhuSUvVQ3TQrvRJ1Ob4V7EQd/ob9YSqetyGF3pHU=;
        b=Qgr7C5VKreRhVRdMM28ohBC8BQ4mkB4AtdubgnCZbZpMShDMt42Pub6q8tLUuwMRKDLt3Q
        fz+Pmo6U0I5k9mqUw7u1lpP9P68tNTEahECFtZbw5oKAU7GjzVdGpN/pG6mTkObqLiRJ5i
        2VhfUJDzLbQPZec3Mu06v17OHKpeU8c=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-HAYU8hEuM1SQMT_r9M9gmQ-1; Sat, 13 Aug 2022 06:24:27 -0400
X-MC-Unique: HAYU8hEuM1SQMT_r9M9gmQ-1
Received: by mail-yb1-f199.google.com with SMTP id j144-20020a25d296000000b0067ba828624fso2553672ybg.16
        for <linux-block@vger.kernel.org>; Sat, 13 Aug 2022 03:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=heBqhuSUvVQ3TQrvRJ1Ob4V7EQd/ob9YSqetyGF3pHU=;
        b=07eDsSToXusQgyEFQ4sskWmCKfr0+NfO/dhiKmiER30cgJjXpdbigKXocv2+f2BMQW
         G9LJzupKu1guVKp8Rdwdxwm2452y9eKq/+iR+Tm/O+9ohpwmIww9dO0Og69yyYd92wJ9
         Qn9b8iNpFjZaRAS8d/zuSnue6RHN6/nXCyBFsFAayT03bs6f5oyehbo1HynhSpTc42Kk
         8celsT0vmiitSORsqDz6vAbvnLywhZ2hT+n10/VzHuV2v1ksxi8EIULwlWpZeicOlsEJ
         I9srzwk7GsjnV9RudnNea7TeuhZKafcw2xpd9Na3UUXl6aGEf67fpN/42Jj7y5HFNNXc
         +kIw==
X-Gm-Message-State: ACgBeo1FLxQWN+PivWqMekaf3cd4ctULRKrAX8pwSRn7NTy2+n9eAsdN
        sfO9DCxEdTZ9embqi+YU3ZU01NFv5FM5c6cSQypr8RPPRRDymfOeq6AddCd87MYQBdLWIHWkQyY
        BkvaX5oL7VXM1vWYRNMiC9G0oPY6krRjK5oe5eOA=
X-Received: by 2002:a81:9302:0:b0:324:ec5a:1f17 with SMTP id k2-20020a819302000000b00324ec5a1f17mr7018292ywg.226.1660386267060;
        Sat, 13 Aug 2022 03:24:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7FbPxLmo8443x3qZlFs9PgllVE0ldgl5bvMQMulS8vdH6b+0nvi3IVIATGPNbqa4Cf5lfFi2RRfW067bSMS74=
X-Received: by 2002:a81:9302:0:b0:324:ec5a:1f17 with SMTP id
 k2-20020a819302000000b00324ec5a1f17mr7018285ywg.226.1660386266878; Sat, 13
 Aug 2022 03:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220809091629.104682-1-ZiyangZhang@linux.alibaba.com> <20220809091629.104682-3-ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220809091629.104682-3-ZiyangZhang@linux.alibaba.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Sat, 13 Aug 2022 18:24:16 +0800
Message-ID: <CAFj5m9K9pqNKvbvLKZmZx3u+TBB0TDGO2QSniNTe2BxqPByhGQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ublk_drv: update comment for __ublk_fail_req()
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 9, 2022 at 5:18 PM ZiyangZhang
<ZiyangZhang@linux.alibaba.com> wrote:
>
> Since __ublk_rq_task_work always fails requests immediately during
> exiting, __ublk_fail_req() is only called from abort context during
> exiting. So lock is unnecessary.
>
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3797bd64c3c3..bedef46f6abf 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -605,11 +605,9 @@ static void ublk_complete_rq(struct request *req)
>  }
>
>  /*
> - * __ublk_fail_req() may be called from abort context or ->ubq_daemon
> - * context during exiting, so lock is required.
> - *
> - * Also aborting may not be started yet, keep in mind that one failed
> - * request may be issued by block layer again.

I'd suggest to keep the above two lines, since that is the exact issue
in patch 3.

Thanks,


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD97FC001E0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 14:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjHJO1L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 10:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjHJO1L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 10:27:11 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3741125
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 07:27:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-523643207dbso1216415a12.3
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1691677629; x=1692282429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5xcFRJZ9iTBgAb+ZGptIB8k23d8fMFMHg19sXQmehs=;
        b=bWtUmVyMYDN253szWDkw3W5J4L2OkSDfNJPp3KptVh4yjZPB9bybVxJ3p4IMqaqbMu
         pQDqOEzedv6/ShhOkc8g8BLfgiEki/7735QQALVuajZdbLIkj/GarPi52YIDzt28E4WG
         ppP9X7+oupNlaYNoLqCr5uu9//9ZoHz/mTjysJz/nCSZl02iTrf7Oph+gN5E8QY5Xe1h
         Oq2JQzsbnaQhfD13VEd41uw1iPkT/Lv5naUFowHWhWhFePFWaPd42QbZ8/4kW1Xk4fkG
         J9KEpLEdZPAQTg01DnDdQV1WySF5sCivNsvl5+BlTWrdEdsidRR84c3Nglxs72BWd/5z
         DcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691677629; x=1692282429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5xcFRJZ9iTBgAb+ZGptIB8k23d8fMFMHg19sXQmehs=;
        b=cLN1+DFOiybbeDybuSMwXoJ3huOpYLMEujcyE/Ft/8TrJ1YTwOx9HRzdpAQj9NysfO
         KjZx3olRHKKh9e/TGA9TdxlkkPgoxV1KZw7Eq+vzCSH1jKAl7wYB1lu54e3Jus72j3rW
         u8L39flDLHwfCk56r/GV2nx7PXTb4IED7BDVUbz3h3uGCpO6ZaU7zfk0awlVIJ+4lumr
         j54F5gBYPPHLIePCUaCGSCbJU/u56KZ35MRQTc2WfL5YJwFKr5ztdKpaEiFxdNM8hwsx
         tbDhi9Dqh1oyxtr6udreW1YYYHMSFvYkyT8w+9/wBfEPcFTTHhUi1KlOgluFfMZIecrA
         JnPw==
X-Gm-Message-State: AOJu0Yzkx/H4PzPkzYczMJjM3Om5aGqQ4RuVKJ3QKJf2SghIe0Yfo2B9
        OZoMZNlCnEHgIzkW6iBloINaClDPKnzuUQiJjrtmtA==
X-Google-Smtp-Source: AGHT+IEMxNnZsCvYmRpACWEFVlmp6HtkpiGZh9pKQzzwbAMbJkxtMXj6BSqsrqTWtFTyR+5sVpwD4NdQtaNUqCHeCnM=
X-Received: by 2002:a05:6402:88e:b0:522:36f0:f1a3 with SMTP id
 e14-20020a056402088e00b0052236f0f1a3mr2289742edy.10.1691677629247; Thu, 10
 Aug 2023 07:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230810141947.1236730-1-arnd@kernel.org> <20230810141947.1236730-6-arnd@kernel.org>
In-Reply-To: <20230810141947.1236730-6-arnd@kernel.org>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 10 Aug 2023 16:26:58 +0200
Message-ID: <CAMGffEkM4XKn4MRNR332wENzWzjX=ujWu1HH_zdeGqGB+D79tQ@mail.gmail.com>
Subject: Re: [PATCH 05/17] swim3: mark swim3_init() static
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 10, 2023 at 4:21=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This is the module init function, which by definition is used only
> locally, so mark it static to avoid a warning:
>
> drivers/block/swim3.c:1280:5: error: no previous prototype for 'swim3_ini=
t' [-Werror=3Dmissing-prototypes]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
lgtm
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/swim3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
> index dc43a63b34694..c2bc85826358e 100644
> --- a/drivers/block/swim3.c
> +++ b/drivers/block/swim3.c
> @@ -1277,7 +1277,7 @@ static struct macio_driver swim3_driver =3D
>  };
>
>
> -int swim3_init(void)
> +static int swim3_init(void)
>  {
>         macio_register_driver(&swim3_driver);
>         return 0;
> --
> 2.39.2
>

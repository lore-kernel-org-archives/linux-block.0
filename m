Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C193C7EE23
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 09:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbjEWJS7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 05:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjEWJSt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 05:18:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509FAE50
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:18:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso1172297a12.0
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1684833521; x=1687425521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6aGE1yXLCGqom2dgm1RZWqB3IOHPMmMD3ocBmhdTnU=;
        b=FKzA5pvXQrgkaWHcqzLpVLyiiVG957WM+bB+T/o67YGblCaSeXb8CvOiAUS87qO6C7
         ugiRUkd/TEsHdaA8om8OOL5CWcQBlO9ms17b7nnKZAv9njRcCf88H+R4NHIb8e3M/P9k
         EdZx3Viw4eydVDbjB7GaccQmmjOQSRtQ6Y5PT19S6071PNAXRKTUIVyqw5ePnUoc6N5E
         gj6xFRlM9p2tnmFyWmR091olZ2oTCZgewlaz9ltYe4i/2ek2QBQNa8Qgi+OPZ+BCV0+M
         WJ7PJwD+ylhVDQglLw64dFhNLTFS5gJj+cavAe0vELo8Ojk1U64XKPI6e+eExFn69r7O
         Qdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684833521; x=1687425521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6aGE1yXLCGqom2dgm1RZWqB3IOHPMmMD3ocBmhdTnU=;
        b=DzeE4A3YOAgWzIZIzjwDdYvkuNHpQmpP7V1r3/JBO/MsiED6VO+c/9+njfzHoyizhb
         M/JYQMIzaQKpLIamlv4xXgNSN/OeExt+dcixWnWF9JW+s6Afjmqg7DHpcHeBS3OqGEI8
         e/FTf25stxqyq5vDIpe5eN/xcRigRDg2KpIRlxlA74ELy+pJtIl2Jz3V/8Gf0rwIics0
         GgHfYk6lRKKBm5+X6gFfXWfYKzlSxA9sQ7f8YToBuHudlwJjOuep+NPFdu5ZIRKD0p0w
         BSMwqfpj9NumkVpudDec8ttee9fyy6uN1lPcgolswCSQHCCny/9TcU5yh/V5/rxkYuAn
         b45A==
X-Gm-Message-State: AC+VfDxbzQjwbzNJlLRcz7TZrbEiWZSb90XBInR3Jpp2No+cDU9fRgDU
        zc2QplsFygQfN8QOye6gXqyz5kK6ljDOXSPGjN8O2Q==
X-Google-Smtp-Source: ACHHUZ47NJbWy7IE7Ucb61T0GxLpYyH95uVqfarCOMagvMXiF7YD37+k10OglUt/by4cU+eW4wQsAlf8vO71fxV85OU=
X-Received: by 2002:aa7:d582:0:b0:4fa:b302:84d4 with SMTP id
 r2-20020aa7d582000000b004fab30284d4mr10109917edq.13.1684833520632; Tue, 23
 May 2023 02:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230523075331.32250-1-guoqing.jiang@linux.dev> <20230523075331.32250-11-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-11-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 23 May 2023 11:18:29 +0200
Message-ID: <CAMGffEnUrM+FndkGL5GznbmGjkf=uMm7LHBq0qdaWL68zeV1Cw@mail.gmail.com>
Subject: Re: [PATCH 10/10] block/rnbd: change device's name
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 9:53=E2=80=AFAM Guoqing Jiang <guoqing.jiang@linux.=
dev> wrote:
>
> Both rnbd-srv and rnbd-clt set it with 'clt', which is not
> clear, let's change them to 'clt' and 'srv' accordingly.
The "ctl" means "control" here, it contains some writable knobs..

And this change will break user space tools, so NAK for this one,
others looks good, will reply separately.

> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
NAK, please drop it.
Thx!
> ---
>  drivers/block/rnbd/rnbd-clt-sysfs.c | 2 +-
>  drivers/block/rnbd/rnbd-srv-sysfs.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnb=
d-clt-sysfs.c
> index a0b49a0c0bdd..f6e2b075d2d5 100644
> --- a/drivers/block/rnbd/rnbd-clt-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
> @@ -652,7 +652,7 @@ int rnbd_clt_create_sysfs_files(void)
>
>         rnbd_dev =3D device_create_with_groups(rnbd_dev_class, NULL,
>                                               MKDEV(0, 0), NULL,
> -                                             default_attr_groups, "ctl")=
;
> +                                             default_attr_groups, "clt")=
;
>         if (IS_ERR(rnbd_dev)) {
>                 err =3D PTR_ERR(rnbd_dev);
>                 goto cls_destroy;
> diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnb=
d-srv-sysfs.c
> index 4962826e9639..f17a4085dfbb 100644
> --- a/drivers/block/rnbd/rnbd-srv-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
> @@ -219,7 +219,7 @@ int rnbd_srv_create_sysfs_files(void)
>                 return PTR_ERR(rnbd_dev_class);
>
>         rnbd_dev =3D device_create(rnbd_dev_class, NULL,
> -                                 MKDEV(0, 0), NULL, "ctl");
> +                                 MKDEV(0, 0), NULL, "srv");
>         if (IS_ERR(rnbd_dev)) {
>                 err =3D PTR_ERR(rnbd_dev);
>                 goto cls_destroy;
> --
> 2.35.3
>

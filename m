Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC49C7EE23
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 09:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbjEWJUZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 05:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbjEWJUX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 05:20:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10DF119
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:20:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-513fd8cc029so1128309a12.3
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1684833621; x=1687425621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bK4TElReJ3YKJ3ZdWw6wZ85r+hNjfaIPn3ExnrZXFA=;
        b=HcrEs5N9VzR3QYHKqiEHuv6poBMT9BltdU3QGGTSBeIm9lSDVOuGHMuZBrf0NSd2xk
         ApRRo1bkbUU+hHgnaQBKzaFtoGDepm9uJlQBYC8tceaVDYGODSvz1BB8Stab1DrC9ogh
         5dBw0MKs30+mqUP+4CeiIjZaE/o79IQub0etxIrDs9dabjBIjtlm05v2nsY+QtLYsPMc
         VpsiQsjfgEdCqM6FfZ4UQ+V0gBPmlOHrj7IsC4GggfKoR9JhHomyG2pLYp2paC16pw0B
         PyJ7BeCkh4TdpopOMgYhSi9WfgXuqdRbMUs8k5ieiI91HI0gIjCoj6sOUCfcswJuPJDh
         pkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684833621; x=1687425621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bK4TElReJ3YKJ3ZdWw6wZ85r+hNjfaIPn3ExnrZXFA=;
        b=VpDLOhf9Sb1UoHiSEGQsna89ZU2udy6NcADHFiX2FTdXgnUnwTnL0RRBcaDWmYuYe3
         /wPqtE9JNDg0qzxUvmDWa6Zv0ws8JakAKGgWtxV9lxSP+kSc0lXuj70SzTH3xNg4XgPn
         gMEMsCvvm2pL9cYWrDc2NsuOxoJ5ebnXbZk70J56eU9rGLd0Tz1BuxhqY7cV9DyD5F+r
         Vkgn4jTIvme6080uHN0XAVfLfg+JWMmbXvTXml2ZpDi8/1du9W/TPa3l+drNl5JtciOh
         AwucHQ4sffKZZvS00Saa8kiUU52b7+OkyS8sjx3ohT4aLt3nqcMN+jOrXVjQHXJ70lHy
         CE1Q==
X-Gm-Message-State: AC+VfDzINIFiJLS/QQmuVfFXbD1zBXNlChKr+cQpCpgC/dTdTUtktu5l
        ekvIhPsCKSaNUqtAaVBwnCHNMQfRUpVIaz2+m0ayDjX3E+jscPBs
X-Google-Smtp-Source: ACHHUZ6Rh0dfN05WJ55ibORHDPJxuFa1c41q79Xg/sJTIsULf5nyHdwGaApCxNKZPEyYUVpGdcpdTGEIKwKKwHIZCbc=
X-Received: by 2002:aa7:dcd4:0:b0:50d:9f1b:db7c with SMTP id
 w20-20020aa7dcd4000000b0050d9f1bdb7cmr11155660edu.0.1684833621299; Tue, 23
 May 2023 02:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230523075331.32250-1-guoqing.jiang@linux.dev> <20230523075331.32250-3-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-3-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 23 May 2023 11:20:10 +0200
Message-ID: <CAMGffEk4s4aY8pPaOMKYv3O6T=wixtuFBbvrvHh98H6XW23kng@mail.gmail.com>
Subject: Re: [PATCH 02/10] block/rnbd-srv: remove unused header
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
> No need to include it since none of macros in limits.h are
> used by rnbd-srv.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv-sysfs.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnb=
d-srv-sysfs.c
> index d5d9267e1fa5..9fe7d9e0ab63 100644
> --- a/drivers/block/rnbd/rnbd-srv-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
> @@ -9,7 +9,6 @@
>  #undef pr_fmt
>  #define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
>
> -#include <uapi/linux/limits.h>
>  #include <linux/kobject.h>
>  #include <linux/sysfs.h>
>  #include <linux/stat.h>
> --
> 2.35.3
>

Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F47C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 10:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BADF2070D
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 10:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="lshe6y+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfCRK3D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:29:03 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44612 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfCRK3D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 06:29:03 -0400
Received: by mail-vk1-f193.google.com with SMTP id q189so3638620vkq.11
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 03:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqzN75yxkXN+vD/S75J6kX2i0s5KP4wFxhIBL//QHDY=;
        b=lshe6y+8P7xkAXXiSEEh/bZEF/qEPfWisu1ysOWO5IgGsCa3qOJv7TaHAwEflmGvKB
         UGt3beouJZAZpG93799QLjVsqT7CXYbQe4DILj2irstJSSHoA1/i87+Qvq/4hGJgiZ37
         mRy5NF1hsQ+Q9oA01vmp+u8iSwOZqyMTjn66WZzP6ht/eZ6jGZB6gZjn+4x9tXNmk8/r
         cMc4vZ7iytckWqPGFPC27lfvAwqv6iDrYc0OnL0UjfX3RR3ahDGxsJT89GRei9QOZSUe
         eLoLPlQwbpA7upU3Eu2vItdZL39YiWGhSG9KdaicPLwpXWe8eM8PoWt467F53IlzfDVZ
         Mv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqzN75yxkXN+vD/S75J6kX2i0s5KP4wFxhIBL//QHDY=;
        b=scROnS35hoACRo7dEgEnPkgNXUBlr5Ctlx4Q1q1Cf6QHz1CjLieyH4ouAo9lB3g5qI
         RmPU2Dbcj4ptlb0X6JSekahAB41Zt+Rdyn69m5e5Hxe0xH83nkneTPMUOYkmzEDc0EvJ
         oS7hCP3l94qPskvtZGqkmxQm0/XLbRRfck1k6Il2kNpg7lwPbVVOOJ3ooCFTPF/tmWeN
         E9fkvMX8+twC0EVzEYWKXmL6k15GteLvcGutq1Pg+T5KsHgfXygcDMLvTOCxXK7f98G/
         yKKWw0Mm52k0TIy5LUvqRnfUMOvYnMhXbCk3MxDqY8dNi0BMLvurfB1tbErUV2stvphO
         FFRw==
X-Gm-Message-State: APjAAAWrdQsY6MUnX2JYmGCOLonrVVk4SMJU/i5+2nN+8UbAbtNLJ3Xp
        ZaMnQ1wXFTCp/0LBgfY5P/10rz1pvNEU8c0Xnug3t7htJWN1DA==
X-Google-Smtp-Source: APXvYqyG5rc40ObL6caAoTjU63u/FFmu2QSiy/Nn+10+b4VfARhKLxJOxPaudN4KL0hTIroPvEGj6dx1UeSP3SZNGHQ=
X-Received: by 2002:a1f:b483:: with SMTP id d125mr8601756vkf.51.1552904942575;
 Mon, 18 Mar 2019 03:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190314160428.3559-1-igor.j.konopko@intel.com> <20190314160428.3559-18-igor.j.konopko@intel.com>
In-Reply-To: <20190314160428.3559-18-igor.j.konopko@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 18 Mar 2019 11:28:51 +0100
Message-ID: <CANr-nt3poAp1NQmK35=X=mrKgvEJnUHVN_ROxMWB1hrGoZpHdQ@mail.gmail.com>
Subject: Re: [PATCH 17/18] lightnvm: allow to use full device path
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 14, 2019 at 5:11 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>
> This patch adds the possibility to provide full device path (like
> /dev/nvme0n1) when specifying device on top of which pblk instance
> should be created/removed.
>
> This makes creation of targets from nvme-cli (or other ioctl based
> tools) more unified with other commands in comparison with current
> situation where almost all commands uses full device path with except
> of lightnvm creation/removal parameter which uses just 'nvme0n1'
> naming convention. After this changes both approach will be valid.
>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>  drivers/lightnvm/core.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index c01f83b..838c3d8 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -1195,6 +1195,21 @@ void nvm_unregister(struct nvm_dev *dev)
>  }
>  EXPORT_SYMBOL(nvm_unregister);
>
> +#define PREFIX_STR "/dev/"
> +static void nvm_normalize_path(char *path)
> +{
> +       path[DISK_NAME_LEN - 1] = '\0';
> +       if (!memcmp(PREFIX_STR, path,
> +                               sizeof(char) * strlen(PREFIX_STR))) {
> +               /*
> +                * User provide name in '/dev/nvme0n1' format,
> +                * so we need to skip '/dev/' for comparison
> +                */
> +               memmove(path, path + sizeof(char) * strlen(PREFIX_STR),
> +                       (DISK_NAME_LEN - strlen(PREFIX_STR)) * sizeof(char));
> +       }
> +}
> +

I don't like this. Why add string parsing to the kernel? Can't this
feature be added to the nvme tool?

>  static int __nvm_configure_create(struct nvm_ioctl_create *create)
>  {
>         struct nvm_dev *dev;
> @@ -1304,9 +1319,9 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
>                 return -EINVAL;
>         }
>
> -       create.dev[DISK_NAME_LEN - 1] = '\0';
> +       nvm_normalize_path(create.dev);
> +       nvm_normalize_path(create.tgtname);
>         create.tgttype[NVM_TTYPE_NAME_MAX - 1] = '\0';
> -       create.tgtname[DISK_NAME_LEN - 1] = '\0';
>
>         if (create.flags != 0) {
>                 __u32 flags = create.flags;
> @@ -1333,7 +1348,7 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
>         if (copy_from_user(&remove, arg, sizeof(struct nvm_ioctl_remove)))
>                 return -EFAULT;
>
> -       remove.tgtname[DISK_NAME_LEN - 1] = '\0';
> +       nvm_normalize_path(remove.tgtname);
>
>         if (remove.flags != 0) {
>                 pr_err("nvm: no flags supported\n");
> @@ -1373,8 +1388,6 @@ static long nvm_ioctl_dev_factory(struct file *file, void __user *arg)
>         if (copy_from_user(&fact, arg, sizeof(struct nvm_ioctl_dev_factory)))
>                 return -EFAULT;
>
> -       fact.dev[DISK_NAME_LEN - 1] = '\0';
> -
>         if (fact.flags & ~(NVM_FACTORY_NR_BITS - 1))
>                 return -EINVAL;
>
> --
> 2.9.5
>

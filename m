Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6539C10F03
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 10:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8A32087E
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 10:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="f9NOEv2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfCYKLf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:11:35 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33404 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbfCYKLe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 06:11:34 -0400
Received: by mail-vk1-f195.google.com with SMTP id r189so1819336vkb.0
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 03:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TkyX3H4sRCAuTklGm9e8k2SqWn2S3WfqYbuUjQl5hio=;
        b=f9NOEv2MzGmIVeHvoTa21NPH+w2cmBiovFQjuTAiiGpQjQPF87YlqQ02nVTyLv1J1O
         w13SRmmJW3bn3oNAG7WWaeU1dg4MzdYhNaHaqVDNRMugTQvsRn7Cx8wpUobgOgj2sPIW
         o0ZkweC6QdBVuchpO64Ju5JDjroq2Ca/p8Aak7paFDQ9KMyY+t4MGVN6sE+yv+oC7HHp
         FpPQ+C3l5vrbU1O2E5D7fmGe7XEZDccfRTo9Apyh50Y+VlumoajgOARbjABr6JpHZHHD
         gvcss4dOh/Iu6bG81ILgu8PcHDyP29IVhiApFR8jOt+W7WbYuPRp9oPafmoQ0ukRU32P
         5U2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TkyX3H4sRCAuTklGm9e8k2SqWn2S3WfqYbuUjQl5hio=;
        b=RzApxiDzxMn21JQSMjcCPX8eDFYkeUzz+n9yDPt+ZzISZMyaxeMpY8ouZLLAW6pZd6
         cJ2a/+Eob3HAUK+8NnUyOQ23LxSQyK8gvll0DXZsa4kFUP2WXYzgrWSiS+nJGO9yswG7
         EL0F9YXiwgWqq+wyM0cUKl1XeaeEUPySF8eU2GZ7mI3hDQXwEL0bsYxYS5q7WNVIgvfg
         eK4VZcJ63r7jPftTluXEyjHIdB3ntSTIpi/7Ar8fY+yLpVywSZSQFbWBnL60hXaHOZ9G
         pIfhIpoBHncuAFw6GOoUtfmdDNIYi24PVTKVEXFf36VhSiQpHbL1Q0a3z8lYde+JTeOR
         b93A==
X-Gm-Message-State: APjAAAVw6tcyQUxGF2oy+e3cRINVfisNuJPFpgqPzyiWU74B3M99Q7Ts
        Ivh9XJJsnL+nVv30hxv7YVxdnVwowV+ChWxpQ+YVZeQfMBg=
X-Google-Smtp-Source: APXvYqxFq7KjHOeaPEVVpYDCPUL3SGWDoymXwf2x/ghoks7R5EXoqG+Q3u7W8GPoK+azsGSC1X8GL2fS4JpjaFz6ots=
X-Received: by 2002:a1f:b483:: with SMTP id d125mr13731184vkf.51.1553508692964;
 Mon, 25 Mar 2019 03:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <1553278047-13115-1-git-send-email-marcin.dziegielewski@intel.com>
In-Reply-To: <1553278047-13115-1-git-send-email-marcin.dziegielewski@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 25 Mar 2019 11:11:21 +0100
Message-ID: <CANr-nt2jvcbtxMC8LLqkKikKEUkdiZE1jT-oEw-sghY5-VGnOA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] lightnvm: add mechanism to trigger pblk close on reboot
To:     Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 7:07 PM Marcin Dziegielewski
<marcin.dziegielewski@intel.com> wrote:
>
> Currently if we issue reboot to the system pblk will close
> ungracefully and in consequence it will need recovery on load.
>
> This patch propose utilize of reboot notifier feature to trigger
> gracefull pblk shutdown on reboot.


To put in my two-penny worth, this seems unmotivated.

If user-land chooses to reboot, why should we delay the reboot in the
order of second(s)?
Recovering should be faster than padding anyway, so why not take the hit there?

Also, It's nice to be able to test OOB recovery by just rebooting the
system, and I have not found this sort of thing being done anywhere
else in the block layer.

/ Hans
>
> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> ---
>  drivers/lightnvm/core.c | 65 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 51 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 5f82036..4a421f5 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -27,6 +27,7 @@
>  #include <linux/miscdevice.h>
>  #include <linux/lightnvm.h>
>  #include <linux/sched/sysctl.h>
> +#include <linux/reboot.h>
>
>  static LIST_HEAD(nvm_tgt_types);
>  static DECLARE_RWSEM(nvm_tgtt_lock);
> @@ -1138,9 +1139,52 @@ struct nvm_dev *nvm_alloc_dev(int node)
>  }
>  EXPORT_SYMBOL(nvm_alloc_dev);
>
> +static void _nvm_unregister(struct nvm_dev *dev, bool graceful)
> +{
> +       struct nvm_target *t, *tmp;
> +
> +       mutex_lock(&dev->mlock);
> +       list_for_each_entry_safe(t, tmp, &dev->targets, list) {
> +               if (t->dev->parent != dev)
> +                       continue;
> +               __nvm_remove_target(t, graceful);
> +       }
> +       mutex_unlock(&dev->mlock);
> +
> +       list_del(&dev->devices);
> +
> +       nvm_free(dev);
> +}
> +
> +static int nvm_notify_reboot(struct notifier_block *this,
> +                           unsigned long code, void *x)
> +{
> +       struct nvm_dev *dev, *t;
> +
> +       down_write(&nvm_lock);
> +       if (list_empty(&nvm_devices)) {
> +               up_write(&nvm_lock);
> +               return NOTIFY_DONE;
> +       }
> +
> +       list_for_each_entry_safe(dev, t, &nvm_devices, devices)
> +               _nvm_unregister(dev, true);
> +
> +       up_write(&nvm_lock);
> +
> +       return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block nvm_notifier = {
> +       .notifier_call  = nvm_notify_reboot,
> +       .next           = NULL,
> +       .priority       = INT_MAX, /* before any real devices */
> +};
> +
>  int nvm_register(struct nvm_dev *dev)
>  {
>         int ret, exp_pool_size;
> +       bool is_first;
>
>         if (!dev->q || !dev->ops)
>                 return -EINVAL;
> @@ -1161,32 +1205,25 @@ int nvm_register(struct nvm_dev *dev)
>                 return -ENOMEM;
>         }
>
> -       /* register device with a supported media manager */
>         down_write(&nvm_lock);
> +       is_first = list_empty(&nvm_devices);
> +
> +       /* register device with a supported media manager */
>         list_add(&dev->devices, &nvm_devices);
>         up_write(&nvm_lock);
>
> +       if (is_first)
> +               register_reboot_notifier(&nvm_notifier);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL(nvm_register);
>
>  void nvm_unregister(struct nvm_dev *dev)
>  {
> -       struct nvm_target *t, *tmp;
> -
> -       mutex_lock(&dev->mlock);
> -       list_for_each_entry_safe(t, tmp, &dev->targets, list) {
> -               if (t->dev->parent != dev)
> -                       continue;
> -               __nvm_remove_target(t, false);
> -       }
> -       mutex_unlock(&dev->mlock);
> -
>         down_write(&nvm_lock);
> -       list_del(&dev->devices);
> +       _nvm_unregister(dev, false);
>         up_write(&nvm_lock);
> -
> -       nvm_free(dev);
>  }
>  EXPORT_SYMBOL(nvm_unregister);
>
> --
> 1.8.3.1
>

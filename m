Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DAFC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7119C20835
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 14:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="vQttkTwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfCROmJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:42:09 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33902 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfCROmI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 10:42:08 -0400
Received: by mail-vs1-f67.google.com with SMTP id e126so9387406vse.1
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 07:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCEl0jwuRXeHcXGt5jr1WKq+Le+IwTPkUQjnam44pj0=;
        b=vQttkTwrks1B/b1CVztKTfJvAB6ROUEvthxVOMZ8yPXmKKNtJ6F4IT/XhNURN5gOz9
         SnHuYXbXRBOT8P6uzXME4pEeaIgaZzbjDZfdLV0TBqgt5SWrJD1jObYMfRBtRVMeJBbi
         b1/6Oh8eaeTgDF52vFl+oXV51zVK+r+wQP9Su5CgkBedQv+T8TnUBdleODM6aYXpvYxe
         4btS21cTq6OLsWy7S1hzvO1yAuDohAxRkdxTuOFTywlyv5YWccGL3Tp8pAjLDU6S8g8z
         kWUwBbyc7K8qxOisyfXn8RcWvnoi8B8rAwXT1ns0Xe3SS8TeVdW4HzGVFoTHNoJ51R7S
         OFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCEl0jwuRXeHcXGt5jr1WKq+Le+IwTPkUQjnam44pj0=;
        b=cvyuNrMvFf0W653QVdpRtn+AeTAL+GLY5lmPh9mXnGqmFL/lvW5n+gcnXnwN8uZABh
         vbbYpBjPLbZe4Y33+z9v32Kjth5bJpNGL31PHEBwjPX58t9U1CQ1K1BAqO8HNXl44ntd
         6wBaLE2iCqki+ndrvWedoUFEtUSfSY1d+NcyJMe7RZPTBb27RdQ0DzZpihemuBxmqd/U
         M8EdMg46vNwUM8qzdONRHfGtQg9QCuAYCNtSpALbcF7Zz+wOihsKZc2ZOpNgeWkYpDey
         QFsSV0tUknYp75f2j65RKWJ7c/J+y3KCnMkEOQrA/LTkIlB5TEZ3OPoeiHlxnJiVYWw2
         JBCA==
X-Gm-Message-State: APjAAAXbj0WaYEntGG+xo2WMU7gb7tzuW7RPzrIf3iOr41RzOdAnQKih
        ABpKukBjoyJj5/oGvkp2PqiwRjPm6icNjSoqsRXbWg==
X-Google-Smtp-Source: APXvYqxjhcebrCFqkJ+Lo0oYtCrIPBvMkPL2VonLZ9wFs239zRcaLtFrK/9abWb+SBEzW/PPmIcooIq6BGgIJTF/CDc=
X-Received: by 2002:a67:b106:: with SMTP id w6mr1816321vsl.16.1552920126531;
 Mon, 18 Mar 2019 07:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-18-igor.j.konopko@intel.com> <CANr-nt3poAp1NQmK35=X=mrKgvEJnUHVN_ROxMWB1hrGoZpHdQ@mail.gmail.com>
 <2683438c-2d8d-c450-8b6f-639d0d757185@intel.com>
In-Reply-To: <2683438c-2d8d-c450-8b6f-639d0d757185@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 18 Mar 2019 15:41:55 +0100
Message-ID: <CANr-nt1HbjfxQLvmUrsA9shLmn4_VNOF42JoMV7afvjAtwftFg@mail.gmail.com>
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

On Mon, Mar 18, 2019 at 2:18 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>
>
>
> On 18.03.2019 11:28, Hans Holmberg wrote:
> > On Thu, Mar 14, 2019 at 5:11 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
> >>
> >> This patch adds the possibility to provide full device path (like
> >> /dev/nvme0n1) when specifying device on top of which pblk instance
> >> should be created/removed.
> >>
> >> This makes creation of targets from nvme-cli (or other ioctl based
> >> tools) more unified with other commands in comparison with current
> >> situation where almost all commands uses full device path with except
> >> of lightnvm creation/removal parameter which uses just 'nvme0n1'
> >> naming convention. After this changes both approach will be valid.
> >>
> >> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >> ---
> >>   drivers/lightnvm/core.c | 23 ++++++++++++++++++-----
> >>   1 file changed, 18 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> >> index c01f83b..838c3d8 100644
> >> --- a/drivers/lightnvm/core.c
> >> +++ b/drivers/lightnvm/core.c
> >> @@ -1195,6 +1195,21 @@ void nvm_unregister(struct nvm_dev *dev)
> >>   }
> >>   EXPORT_SYMBOL(nvm_unregister);
> >>
> >> +#define PREFIX_STR "/dev/"
> >> +static void nvm_normalize_path(char *path)
> >> +{
> >> +       path[DISK_NAME_LEN - 1] = '\0';
> >> +       if (!memcmp(PREFIX_STR, path,
> >> +                               sizeof(char) * strlen(PREFIX_STR))) {
> >> +               /*
> >> +                * User provide name in '/dev/nvme0n1' format,
> >> +                * so we need to skip '/dev/' for comparison
> >> +                */
> >> +               memmove(path, path + sizeof(char) * strlen(PREFIX_STR),
> >> +                       (DISK_NAME_LEN - strlen(PREFIX_STR)) * sizeof(char));
> >> +       }
> >> +}
> >> +
> >
> > I don't like this. Why add string parsing to the kernel? Can't this
> > feature be added to the nvme tool?
>
> Since during target creation/removal in kernel, we already operate on
> strings multiple times (strcmp calls for target types, nvme device,
> target names) my idea was to keep this in the same layer too.

Oh, pardon the terse and rather grumpy review. Let me elaborate:

String parsing is best avoided when possible, and i don't think it's
worth increasing the kernel code size and changing the behavior of the
IOCTL when its fully doable to do this in userspace.

Thanks,
Hans

>
> >
> >>   static int __nvm_configure_create(struct nvm_ioctl_create *create)
> >>   {
> >>          struct nvm_dev *dev;
> >> @@ -1304,9 +1319,9 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
> >>                  return -EINVAL;
> >>          }
> >>
> >> -       create.dev[DISK_NAME_LEN - 1] = '\0';
> >> +       nvm_normalize_path(create.dev);
> >> +       nvm_normalize_path(create.tgtname);
> >>          create.tgttype[NVM_TTYPE_NAME_MAX - 1] = '\0';
> >> -       create.tgtname[DISK_NAME_LEN - 1] = '\0';
> >>
> >>          if (create.flags != 0) {
> >>                  __u32 flags = create.flags;
> >> @@ -1333,7 +1348,7 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
> >>          if (copy_from_user(&remove, arg, sizeof(struct nvm_ioctl_remove)))
> >>                  return -EFAULT;
> >>
> >> -       remove.tgtname[DISK_NAME_LEN - 1] = '\0';
> >> +       nvm_normalize_path(remove.tgtname);
> >>
> >>          if (remove.flags != 0) {
> >>                  pr_err("nvm: no flags supported\n");
> >> @@ -1373,8 +1388,6 @@ static long nvm_ioctl_dev_factory(struct file *file, void __user *arg)
> >>          if (copy_from_user(&fact, arg, sizeof(struct nvm_ioctl_dev_factory)))
> >>                  return -EFAULT;
> >>
> >> -       fact.dev[DISK_NAME_LEN - 1] = '\0';
> >> -
> >>          if (fact.flags & ~(NVM_FACTORY_NR_BITS - 1))
> >>                  return -EINVAL;
> >>
> >> --
> >> 2.9.5
> >>

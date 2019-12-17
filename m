Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519BFC43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 21:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C59E2082E
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 21:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLQVjS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:39:18 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:36295 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfLQVjS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 16:39:18 -0500
Received: from mail-qv1-f45.google.com ([209.85.219.45]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Ma1HG-1iDcVb3Zzw-00W0BJ; Tue, 17 Dec 2019 22:39:16 +0100
Received: by mail-qv1-f45.google.com with SMTP id f16so2612778qvi.4;
        Tue, 17 Dec 2019 13:39:15 -0800 (PST)
X-Gm-Message-State: APjAAAVvUpkNX47bVY7y7BA/xiOxNSKSS5O5IGPIs3A9SzgbGtpy4xua
        /DbJIJnN03/RHY+/Gu49dbRDQCeT7mLCLi42a08=
X-Google-Smtp-Source: APXvYqwLgTq/5K3B2a0Kv5JqoIJuNjoXwcTS39ZAj3UFgfd+yZoCWCBdOxFZcsSuuLqlG8YzlR2R9O/gYJsSc823Fwo=
X-Received: by 2002:ad4:4021:: with SMTP id q1mr6532445qvp.211.1576618754626;
 Tue, 17 Dec 2019 13:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20191211204306.1207817-1-arnd@arndb.de> <20191211204306.1207817-11-arnd@arndb.de>
 <f0e7384f3eb6203eb72b36433b0666150cf560ff.camel@codethink.co.uk>
In-Reply-To: <f0e7384f3eb6203eb72b36433b0666150cf560ff.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 Dec 2019 22:38:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0evGt++XO5dCx5u_0oyyoYGRVVPi4vo9FUdDS68G-4+g@mail.gmail.com>
Message-ID: <CAK8P3a0evGt++XO5dCx5u_0oyyoYGRVVPi4vo9FUdDS68G-4+g@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 10/24] compat_ioctl: cdrom: handle CDROM_LAST_WRITTEN
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block <linux-block@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.com>,
        Hannes Reinecke <hare@suse.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Martin Wilck <mwilck@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:oQkrP4ALT6kCEbxBi5aycouamEEcuDaXShQq86/XRr34366WmAl
 +DW2uaAOthFXbkEcpxuI/QOIRgD77+iMZL/EA06p4h382KSE8IGCju8xX6DHTfd3yT+L5m2
 kTgVQc83W5eKgHt+Re0YZ0oZf192kXKv0i8NtN77bnOPS3MASWKtapRiOcIfJi9/lljyVO4
 7rGeSgtf+yyOeFZ4+Thqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nx6byoREsV4=:RAU+LI+4bt7lUL72KS/rFh
 qiOCyFU9GwISJ+5srjJpSMjiSIh6d6ebpQA/3G1N3aklya9dU+hlu18nX8PP7bCTHcPWjzG0u
 UAMTZQr/BzK+rLwg5e5cYkpz/DHn0fxRTi7qaRR7zL1wrUsWVU6PsE4+8jQzog7rHBVZULKWY
 1FDdyFlBOUb/nZixVzK+2UN7mtEy+/eofM+T23bV7ZwZuHXxuyfGOrMiQRTtR8hqtt/eVTAgX
 +pgV3uOLuNnCcWkAPrNNpbTiKtE2cM+hMzFEjyI6JJA6YWmee2zJGIKWz97Xd1dZiQJ3wU9K9
 X2cmvABgK3T0qgyMWyIGuoaq7c9fyyjO/rSzbhY7ywmS3xwrZxoKB7y7XJ/TaRyW7ffH1Ok55
 HQroNEat7CRxQN62V22pYwq04uoQQpNkwveI5FfU7dJLDSA7N70RFV0NBiaOIz1V17Nqx4buV
 lgPhKW3ED5DXc4biumpRPwXUsBX08o1ZfqGjKY72YwD8rONj01CiHxGJj7qORaxBELShli7xX
 JasNwsMY+JQJCwn/F4ki4xmLQCR/alcqdYwn0ZnuriHz52ic+M/VvqHwGMtyFtA66dabrefAH
 cZVQELEzslDJCzaVAw3JvSxg3A1WD29EKBxxnXjWMljE5NAnlXRiC/omLggTc/Ad+C4GQOd6T
 5ufq3VstTLtq3d99zdeKZLibs6ukCqznuFrLgKrllZJFJHPpWGr1xiK5cYomzjmJ4+7/h++zY
 hV0gzpa4E0+98gVwjtDwzKo7raW9o13ZYoPP+QwON29RVkayNtcL9qZarDKuoLGqvwTKws3ST
 0zc+ZctmGhQlUetxy0kQDdldDndacx8QWMK7wlaVs4hAnzRxEHjMHnpDh7S/+B2TKAHyw87Mp
 7+dSKSH3xwL2vn6Zr38g==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 17, 2019 at 4:20 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Wed, 2019-12-11 at 21:42 +0100, Arnd Bergmann wrote:
> > This is the only ioctl command that does not have a proper
> > compat handler. Making the normal implementation do the
> > right thing is actually very simply, so just do that by
> > using an in_compat_syscall() check to avoid the special
> > case in the pkcdvd driver.
> [...]
>
> Since this uses blkdev_compat_ptr_ioctl() it needs to be moved after
> the following patch.
>

Ah right, I obviously reshuffled my patches too much to end up
with the most reasonable order and avoid introducing something
that would be removed again later.

I'll split out the addition of blkdev_compat_ptr_ioctl() into a separate
patch and move that all in front, as I'm no longer sure if there
was another dependency in the other way.

Thanks!

        Arnd

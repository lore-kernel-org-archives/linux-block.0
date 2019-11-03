Return-Path: <SRS0=L9ug=Y3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1ECCA9EB0
	for <linux-block@archiver.kernel.org>; Sun,  3 Nov 2019 23:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBEB2086D
	for <linux-block@archiver.kernel.org>; Sun,  3 Nov 2019 23:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKpit5u5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfKCX6k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Nov 2019 18:58:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32879 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbfKCX6k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Nov 2019 18:58:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id s1so15107999wro.0
        for <linux-block@vger.kernel.org>; Sun, 03 Nov 2019 15:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QLyfSUHOCyias85dXZx9+8Hr6bxV1S9a14shr+4ccQw=;
        b=jKpit5u5cDZEs9adq/rGkTitvZSsEgwJR5bIOlhyRPtuv70LdYHnybA6DoDfKaUW/b
         2g5xa4M57qhMCFZDllUzMYJ/m8/97C87Q1l4xpU+mibm+xZ70MzIf+kBvJnEGBGCIGfJ
         oexB+TZCtNwezRhfILkMWUW5PQR4JJ3zkupIvZv1LYKh0SxxvlyG7NO2tTn56SCp+EW1
         2bV06wdiOlu47fTHjtQjmyjTgVgnYDHiYFVWiNRZrzs6TcOdzR7UF3NDqdLNbVTCW93g
         rkx9VE1yyyh80Hfb4/RAXujwIAo+XMFfct1iI2M19d9X3KrPF9RVYJQ1QBrYUKcuu42u
         WLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLyfSUHOCyias85dXZx9+8Hr6bxV1S9a14shr+4ccQw=;
        b=S1ee2lcdCqaARLK4xZ4hmZVHm5QkfXAFo43rHJTBCIP+o8edeOd2llFk6WBN9tG+ev
         eIdLNoUst/aOYAeIIH9zKmo3xKiZXrIcz3aYX/Fhh9TsmZhCexABuRX0wt+8nWEZKEG8
         E9T1JJiVRRHmuLHsRECcqqCSH+curO7pyCxiff66uxujHSaptxQLqyk0RabALA8eYTHD
         Yh/c09Zu5eKl0xQeo7rhUJzBSGac/CTHnXEltswhWTHcCH13FSDHHYEAwd6gQ6JNmQiL
         XJT0GaocZP3Ry4D6VqIoy3tysbkaOp9yCye7Z0TRGFpLUgbesDOg4FbXT5iSEbwaKM2o
         hQgw==
X-Gm-Message-State: APjAAAXBOL0Uaehq1FAX8dJ00MHDI9Ap0bEKksoRcBsvgzB+gGMtv1Ow
        oLKh/emGhHLenKtDf7TjBhPoBfMDEtv7hAwStcc=
X-Google-Smtp-Source: APXvYqxUQ8QIri+44s51s5Eu3yjf6UxuRcBtRmrXGhnlWgG/Hs5NLMEmwOCYa/QR9looDLirUPk00O/EXQuR2OKOYQA=
X-Received: by 2002:a5d:4ecd:: with SMTP id s13mr21522654wrv.216.1572825517910;
 Sun, 03 Nov 2019 15:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20191102080215.20223-1-ming.lei@redhat.com> <BYAPR04MB574951ACBF23CBDA280282A0867C0@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB574951ACBF23CBDA280282A0867C0@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 4 Nov 2019 07:57:18 +0800
Message-ID: <CACVXFVO3MafpBcufM+eYZM5A-Yip5JGSqiC4kOgejVNnTNjYOA@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: avoid sysfs buffer overflow by too many CPU cores
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Nov 3, 2019 at 8:28 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> Ming,
>
> On 11/02/2019 01:02 AM, Ming Lei wrote:
> > It is reported that sysfs buffer overflow can be triggered in case
> > of too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs of
> > hctx via/sys/block/$DEV/mq/$N/cpu_list.
> >
> > So use snprintf for avoiding the potential buffer overflow.
> >
> > This version doesn't change the attribute format, and simply stop
> > to show CPU number if the buffer is to be overflow.
>
> Does it make sense to also add a print or WARN_ON in case of overflow ?

Yes, it does, could you cook a patch for that?

Thanks,
Ming Lei

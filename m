Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701B1C282DD
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 16:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C3320720
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 16:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="MnKZjVac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgAHQvl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:51:41 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45133 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbgAHQvl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 11:51:41 -0500
Received: by mail-il1-f194.google.com with SMTP id p8so3180332iln.12
        for <linux-block@vger.kernel.org>; Wed, 08 Jan 2020 08:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=co7/buqnJ+QAQFW/aPPMtw9NyE3ymeGSAXf7J8t8yZg=;
        b=MnKZjVacH0zMQk7STp7Vj/S3ld9XtAL8X25Ad/RB6AF374jBqQNA3OsVh5ceb9VnRv
         M3V0K39I6Xt4YPmohA0nu03BkOW/WjgcG8ZxnaGiChs4oFKpQqba2nLBEQfJEWzuPUUG
         JJPFWdhH1jMHRhrz+/sHRrWXFEZMEr2eWyWtWL4vfFLjP1OXVi7FRgX8qq8r7gwURcEI
         hFpd4mOtYnh58haYR97vIOO8u00fHRj8UfDwFJZOw+MR98ciSf1G7imETXA0Mrv2KZHX
         ZeWDMA57GPXiV8BqLZg7HEi6E1ZAxSgQh8ZV1X7rYzj9RPSBrgXHdT+7n9v9qx4gIxTS
         qFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=co7/buqnJ+QAQFW/aPPMtw9NyE3ymeGSAXf7J8t8yZg=;
        b=rfa2RhIVDNS29TYi/cLNspAMCucX6FlTZoGR0J74yqA5mlPDsftP7nMdb2+KPl8WRX
         cJZDHUeQ2W+Zwk9dUdTvngE/d5tcQg+xg6LEkyoSV1WpsFWOfaOvV72CZDuvcEdYEK8t
         rFgcTDUTmz620cayW8gFEKdmSZv8Gj2MdZucI7Gd1mPJqkoaN1pa11gWo83UnrSVAAvi
         0hOPLBM1Jbw98iQJ4hhft6fpNkNbK3+iEY0wHpsxyiiilj/M0Au25Xw3ErKOZ8xf9Tqc
         E+RM0geDWlLVjrsYtcVUkpBfbNc9lnzuFnrspSp+G2IQhhnCjLEsF9m5tAHDMjibFcrU
         u9kg==
X-Gm-Message-State: APjAAAUrTuOlpgc1SMV/9ksqDYnXFT43EKJ3SrnstngUc3oo5dIHVKDi
        ypWMaFd/dgC5zibWBeneJMti5T65T1FW3Bi14swYuA==
X-Google-Smtp-Source: APXvYqzDNtn52z8BtswfS55RdLo1Ou4FfHpSAEHRnHXIJdAKCjg9h7lXV7dcihgcpxR6QupYLI91uvnSuhC76rN/5hU=
X-Received: by 2002:a92:1090:: with SMTP id 16mr4531190ilq.298.1578502300812;
 Wed, 08 Jan 2020 08:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-19-jinpuwang@gmail.com>
 <e0816733-89c0-87a5-bc86-6013a6c96df2@acm.org> <CAMGffEmRF+2SZ5Nf3at9SohZXTT3siakBYoZpErN=Tr_PCA9uw@mail.gmail.com>
 <a2748915-b88e-cc91-2ab8-1a95f678e444@acm.org>
In-Reply-To: <a2748915-b88e-cc91-2ab8-1a95f678e444@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 8 Jan 2020 17:51:30 +0100
Message-ID: <CAMGffE=XKHnKSE9orD=TMhq5j0rikfpoOx5mEwRO4oLxEfHMPA@mail.gmail.com>
Subject: Re: [PATCH v6 18/25] rnbd: client: sysfs interface functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 8, 2020 at 5:39 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 1/8/20 5:06 AM, Jinpu Wang wrote:
> > On Fri, Jan 3, 2020 at 1:03 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >> On 12/30/19 2:29 AM, Jack Wang wrote:
> >>> +/* remove new line from string */
> >>> +static void strip(char *s)
> >>> +{
> >>> +     char *p = s;
> >>> +
> >>> +     while (*s != '\0') {
> >>> +             if (*s != '\n')
> >>> +                     *p++ = *s++;
> >>> +             else
> >>> +                     ++s;
> >>> +     }
> >>> +     *p = '\0';
> >>> +}
> >>
> >> Does this function change a multiline string into a single line? I'm not
> >> sure that is how sysfs input should be processed ... Is this perhaps
> >> what you want?
> >>
> >> static inline void kill_final_newline(char *str)
> >> {
> >>          char *newline = strrchr(str, '\n');
> >>
> >>          if (newline && !newline[1])
> >>                  *newline = 0;
> > probably you meant "*newline = '\0'"
> >
> > Your version only removes the last newline, our version removes all
> > the newlines in the string.
>
> Removing all newlines seems dubious to me. I am not aware of any other
> sysfs code that does that.
>
> Thanks,
>
> Bart.
I agree writing a string with many newlines is not common. We can
require the user to write a single line.
I will drop it after verify with our regression tests.

Thanks Bart

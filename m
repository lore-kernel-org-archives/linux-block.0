Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78535C61DA4
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 21:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjBPVbP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 16:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjBPVbL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 16:31:11 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762BA46B0
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 13:31:08 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id s17so1409730qvq.12
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 13:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gO6r7SGbt4F/ovnWsWl2cTXvsSI+IcObCRtChS/zGts=;
        b=SXAT5sdO5txHxyEYx+B0e8z5wYZ4j/x5InfGVGHklSDzeX28Hm2DSBhTWTPD2/hzkJ
         2bGbrLGlnJb13U8DaibRQ1ZAmUbeXnKgioIHAIEEopGlA5PBa5UikxzXdTYm0VGK9oyE
         y9dxR7RURlIlJe5TwBBBbxXrtNjBl3FeEFoCawSD3s+Zbdq5nDcTIsRy3Xjej4UAbQoB
         ZtjMjiGZx4BtFsxGfkZySEf/HawsYzLQyi4NuyzrG5gQ84p0TFAc8BeEICJ6d/IiFCD3
         rP2Pg80K8w7BEnTS9fuHTnO908mh+mP0cuI1C4UbXhpeFfcFBCw3rXxbU4syZhFS+cQg
         dKdA==
X-Gm-Message-State: AO0yUKXNmRSitSffvBlCXTFauNNTM7sVR76ewJpkqF/vtJYc8P6zaCY4
        4SUIwUI5WFsr2OP3rYLJAOXdcyCKSzvdMA==
X-Google-Smtp-Source: AK7set9tKOQnEOqTuYdb+74O6KxDxDemDjHU2ofjS9cMPz5jSwG1i3RW6R5IuK4tKiXe/zp7eRpfHw==
X-Received: by 2002:ad4:5d43:0:b0:537:9e59:3997 with SMTP id jk3-20020ad45d43000000b005379e593997mr16040314qvb.51.1676583067337;
        Thu, 16 Feb 2023 13:31:07 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id b83-20020ae9eb56000000b0073ba44fd6a2sm743911qkg.1.2023.02.16.13.31.06
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 13:31:06 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id s203so3783655ybc.11
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 13:31:06 -0800 (PST)
X-Received: by 2002:a5b:f4d:0:b0:8e6:2e51:57ff with SMTP id
 y13-20020a5b0f4d000000b008e62e5157ffmr733316ybr.349.1676583066500; Thu, 16
 Feb 2023 13:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20230210010612.28729-1-luca.boccassi@gmail.com> <CAMw=ZnQUOLXiQf195tufdMo-8UCw=QgqFwewkSTDzSaKidYF2w@mail.gmail.com>
In-Reply-To: <CAMw=ZnQUOLXiQf195tufdMo-8UCw=QgqFwewkSTDzSaKidYF2w@mail.gmail.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Thu, 16 Feb 2023 21:30:55 +0000
X-Gmail-Original-Message-ID: <CAMw=ZnTd+LfDcC=Z9tQUQJdVOukv0wVU+mj8jH1L8_5dhM+8yg@mail.gmail.com>
Message-ID: <CAMw=ZnTd+LfDcC=Z9tQUQJdVOukv0wVU+mj8jH1L8_5dhM+8yg@mail.gmail.com>
Subject: Re: [PATCH] sed-opal: add support flag for SUM in status ioctl
To:     linux-block@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 16 Feb 2023 at 20:57, Luca Boccassi <bluca@debian.org> wrote:
>
> On Fri, 10 Feb 2023 at 01:06, <luca.boccassi@gmail.com> wrote:
> >
> > From: Luca Boccassi <bluca@debian.org>
> >
> > Not every OPAL drive supports SUM (Single User Mode), so report this
> > information to userspace via the get-status ioctl so that we can adjust
> > the formatting options accordingly.
> > Tested on a kingston drive (which supports it) and a samsung one
> > (which does not).
> >
> > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > ---
> >  block/sed-opal.c              | 2 ++
> >  include/uapi/linux/sed-opal.h | 1 +
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/block/sed-opal.c b/block/sed-opal.c
> > index 463873f61e01..c320093c14f1 100644
> > --- a/block/sed-opal.c
> > +++ b/block/sed-opal.c
> > @@ -487,6 +487,8 @@ static int opal_discovery0_end(struct opal_dev *dev)
> >                         break;
> >                 case FC_SINGLEUSER:
> >                         single_user = check_sum(body->features);
> > +                       if (single_user)
> > +                               dev->flags |= OPAL_FL_SUM_SUPPORTED;
> >                         break;
> >                 case FC_GEOMETRY:
> >                         check_geometry(dev, body);
> > diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
> > index 1fed3c9294fc..d7a1524023db 100644
> > --- a/include/uapi/linux/sed-opal.h
> > +++ b/include/uapi/linux/sed-opal.h
> > @@ -144,6 +144,7 @@ struct opal_read_write_table {
> >  #define OPAL_FL_LOCKED                 0x00000008
> >  #define OPAL_FL_MBR_ENABLED            0x00000010
> >  #define OPAL_FL_MBR_DONE               0x00000020
> > +#define OPAL_FL_SUM_SUPPORTED          0x00000040
> >
> >  struct opal_status {
> >         __u32 flags;
>
> Hi,
>
> Any chance for a quick review, please? Would have loved to have this
> for the 6.3 merge window, it's a super simple change.
> Thanks!

CC'ed couple more reviewers as suggested by Christian

Kind regards,
Luca Boccassi

Return-Path: <SRS0=Rcc/=XO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B91C49ED7
	for <linux-block@archiver.kernel.org>; Thu, 19 Sep 2019 10:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C71C21907
	for <linux-block@archiver.kernel.org>; Thu, 19 Sep 2019 10:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="KOGoe+X+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfISKaa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:30:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54459 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731993AbfISKa3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Sep 2019 06:30:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so3804080wmp.4
        for <linux-block@vger.kernel.org>; Thu, 19 Sep 2019 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/3e+y/i+U/e7E0tP6HdpGIig2OZ6uJrDHlIZd5LDyU=;
        b=KOGoe+X+GWq+RgbjP85n85JO2Cj3fgftxUQgMGhjylhj1zIB/zN3tfqgTz+r8DUUIQ
         VzqiWowNqv13F+qAB35G3KZ/MiaPrnHoMj75KeUOUINRGa4WvUhMFdt7tu7mfDyaKNey
         /hW8LC8p7Mb5Y1cLCfEoyfDFIWMcB8MIm4sl45QiSGaaawOX9ag8i/1JKCMXlq5qbl+r
         B1GdkxWKnFATffum5RqVRzuy4QhJ1zzo5XbJIovJgeRu4M6WQJdS0YKffeguTJchoZSI
         EtIkj2e+mQXCAIZ62tTdSMJOr/lGg9FAEl+YD/E1Qbt1ohcOy9PSFHk0TPq5c+oB8wwu
         h25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/3e+y/i+U/e7E0tP6HdpGIig2OZ6uJrDHlIZd5LDyU=;
        b=XuFxW2BVECAj0dhMfpOWU+Y+6kie18eyV6GBq+cgKQZsiDySjICqxZAXFFiALTu8Ux
         6jWLLkX68gDX5VHgPqqiA8StHQDoon0jFRRL63NsayPnPjjL1qdpvDvvhYvNJ4RmItFa
         qsiw2F4F6bSjMjsgD8OoXuRXZ5ayG78mdwiLD+kfzRasstyUxmbBs2f5HYX7XBZ6W+2C
         U/eZ9UmhoNEXsNwsoEywd8qRofnHtrZCs6ZVYQQEpBoAwoMwtgXQZAxfP+yNkxdo5NX6
         6WlR7C6g8G4Y+b/OD1/lTpeiDXxO5jZdpC3Q3I2Ilsr3jchrHcRAQ2mF3ouuJOuGDd1/
         RErA==
X-Gm-Message-State: APjAAAU0ujKCzjRx0TI/61unFk/PSk234zI2h8UnGOFGeEkAdgblELr5
        KV8xdbLFEA7e8LAmNTGE6Lhmj91fCCnozH72rkUNjQ==
X-Google-Smtp-Source: APXvYqyc8sbmSsHU8ly1hAIFrdu76M1WYCZD3LiHgVu2Ru2ZxaBI4ECe50q7rK6RNa01pvPQBqyNswrf7cegY3GgLRU=
X-Received: by 2002:a05:600c:c2:: with SMTP id u2mr2018042wmm.37.1568889027653;
 Thu, 19 Sep 2019 03:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-26-jinpuwang@gmail.com>
 <79f11a21-3d4f-96de-113c-1b77734ac428@acm.org>
In-Reply-To: <79f11a21-3d4f-96de-113c-1b77734ac428@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 19 Sep 2019 12:30:16 +0200
Message-ID: <CAMGffE==yJ7gjreTMxMTnMhLKQKQO9R1YKvsfJzHfYOMfr2_tQ@mail.gmail.com>
Subject: Re: [PATCH v4 25/25] MAINTAINERS: Add maintainer for IBNBD/IBTRS modules
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Sep 14, 2019 at 1:56 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > From: Roman Pen <roman.penyaev@profitbricks.com>
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >   MAINTAINERS | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a6954776a37e..0b7fd93f738d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7590,6 +7590,20 @@ IBM ServeRAID RAID DRIVER
> >   S:  Orphan
> >   F:  drivers/scsi/ips.*
> >
> > +IBNBD BLOCK DRIVERS
> > +M:   IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>
> > +L:   linux-block@vger.kernel.org
> > +S:   Maintained
> > +T:   git git://github.com/profitbricks/ibnbd.git
> > +F:   drivers/block/ibnbd/
> > +
> > +IBTRS TRANSPORT DRIVERS
> > +M:   IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>
> > +L:   linux-rdma@vger.kernel.org
> > +S:   Maintained
> > +T:   git git://github.com/profitbricks/ibnbd.git
> > +F:   drivers/infiniband/ulp/ibtrs/
> > +
> >   ICH LPC AND GPIO DRIVER
> >   M:  Peter Tyser <ptyser@xes-inc.com>
> >   S:  Maintained
>
> I think the T: entry is for kernel trees against which developers should
> prepare their patches. Since the ibnbd repository on github is an
> out-of-tree kernel driver I don't think that it should appear in the
> MAINTAINERS file.
>
> Bart.
>
>
Ok, we will remove the link to github.

Thanks,
Jinpu

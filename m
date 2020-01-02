Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC10DC3276D
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 08:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D11E21835
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 08:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="HGY3m+0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgABIlr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 03:41:47 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40272 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgABIlr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 03:41:47 -0500
Received: by mail-io1-f68.google.com with SMTP id x1so37624143iop.7
        for <linux-block@vger.kernel.org>; Thu, 02 Jan 2020 00:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMoljWmBgb5e6B5p/9++As4qYGIq9XMmMz9ABHQzHXU=;
        b=HGY3m+0NRW9HUeN3XL2N9TBj6a4c17qA0Qe1cje/ALXFtOJMwjXIAzpoqiGjb/RgTV
         kYu6TOXl+asz5ElIuJL21BoOyKpU2wSYZI05tQjVVHo0k/wkd3ECEZRg++i4uxk2nZEQ
         Bj86ZwocYdzzfe33oAwfv8wIPRSRP8HlTSWBlRwJKAqOKCMYdHp4G5iMmFVwy2d0Q3QY
         D4h+gpRGhMfWQwdraSN8vxIE6ADidyQC3Ywt4qThMsxrZbZgdsuQN+LtZ+3HU4Fjqhyh
         pNFn4FeJinFNZ4KdRQw7yS/9AvDtjkaMuQ++jFeA4ZL6AFBtSuoC7MnHI1HYwMte5rga
         Q5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMoljWmBgb5e6B5p/9++As4qYGIq9XMmMz9ABHQzHXU=;
        b=iTeVj7zPbiE1QlkF4+d9aJO3rhedDw28aM/zSEMv9r083RCKPvXnBq1PJiOCnvWPoc
         2AwNwaZ5LuvSugOLp0xMSpIkuP00aZsFPdRtIBP6hnZ/bYJnAyj2V52SOc1IgFy9aLpP
         GnwhP75UZIkW6NWqPdBwSx8j4L0vc9oyUFUQYfcJyt/dq+i9qkzJ1T0d+63pB/VtXrlq
         n6ECUia+9WBNwqgpSYLyOnnSova5j7PjZeY377WtTL5gBBwk9iq9QQcJXf+spSPRIgi0
         8LNyhPjUdNqy3lDNjYFIOggly6SSrhl0frSd2AQWrZlolaSRB7lA2DejCHk0d7eQ42Yc
         GEwQ==
X-Gm-Message-State: APjAAAWSONdHelResh7nanRptaFnvg7pi6kWnZiTz9TJ5Ghuo5AJUm4X
        XYo+N0Qs2OWMWvmcbKdgMsLDTo4yaEtRVst9hu49Qg==
X-Google-Smtp-Source: APXvYqwaxIL7M07TJd4WJ7JyuI+xHxVhjujGM7vRjcaNBpGV5I6Iu04IdmP7/ZUuX0Kbg+oFLjEzwyYODkX08XoCEEc=
X-Received: by 2002:a6b:6e02:: with SMTP id d2mr55508729ioh.22.1577954506696;
 Thu, 02 Jan 2020 00:41:46 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-26-jinpuwang@gmail.com>
 <9b923988-acb3-9a44-255f-47da7609d225@amazon.com>
In-Reply-To: <9b923988-acb3-9a44-255f-47da7609d225@amazon.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 2 Jan 2020 09:41:37 +0100
Message-ID: <CAMGffEnzS_JGhtY9fbd_krku+XsUqzYBCxH+OmmkkXYST6g_hQ@mail.gmail.com>
Subject: Re: [PATCH v6 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS modules
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 30, 2019 at 1:22 PM Gal Pressman <galpress@amazon.com> wrote:
>
> On 30/12/2019 12:29, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > Danil and me will maintain RNBD/RTRS modules.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  MAINTAINERS | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e09bd92a1e44..2ba370d8145d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14125,6 +14125,13 @@ F:   arch/riscv/
> >  K:   riscv
> >  N:   riscv
> >
> > +RNBD BLOCK DRIVERS
> > +M:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > +M:   Jack Wang <jinpu.wang@cloud.ionos.com>
> > +L:   linux-block@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/block/rnbd/
> > +
> >  ROCCAT DRIVERS
> >  M:   Stefan Achatz <erazor_de@users.sourceforge.net>
> >  W:   http://sourceforge.net/projects/roccat/
> > @@ -14192,6 +14199,13 @@ F:   include/net/rose.h
> >  F:   include/uapi/linux/rose.h
> >  F:   net/rose/
> >
> > +RTRS TRANSPORT DRIVERS
> > +M:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > +M:   Jack Wang <jinpu.wang@cloud.ionos.com>
> > +L:   linux-rdma@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/infiniband/ulp/rtrs/
> > +
> >  RTL2830 MEDIA DRIVER
> >  M:   Antti Palosaari <crope@iki.fi>
> >  L:   linux-media@vger.kernel.org
>
> RTRS should be after RTL, right :)?
Yes, that's right. -.-
Thanks for double-checking, will be fixed.

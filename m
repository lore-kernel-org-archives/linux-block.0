Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3164C74A23
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 14:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D012064B
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 14:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOkgQTfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfGJOUo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:20:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35307 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfGJOUn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 10:20:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so2478216wmg.0
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bZKPVzLfGMPRTUT4p8/bnTDMgIbx3MafroMWGt5fKDA=;
        b=dOkgQTfNx/4nWmpyTmtMTGCATQwlvrU/n8ezVy4TbxzNl6S2NoHDcVJmyNy3QfpBQD
         4DvIPV1vn+d9WhLuk0CdJWEN3YUHP4Nu1OYA7oSq1WsdMu4UZXVL4L7NSXT9FjtBLRKc
         qHscrb0hRJf9ErP3KIB3YWR+JoTH3TOVaKINPBvOpTJlYZPt32or9OS+bPirNxozrRjm
         BkMWI4qtnZzDCbaAxojGQ266feTHb5uvg4oqRPqZfNlWKkDQOnLCQuBOYX9vVWnHEA6t
         LZebWar2yYAf7/WHiQCtHli/I0J5+zRkyf1WYf6RcOt9y/CkZxAtzQqKlAigaMUU47jh
         0biA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bZKPVzLfGMPRTUT4p8/bnTDMgIbx3MafroMWGt5fKDA=;
        b=j0UNI2Aq9dwlaIASTQM7EzmlUNvt1HNdNLzX6qW6K43CAZH4qvC/R6yvqet+xkwg8w
         XdxGrCdsj9TglpgsFanzzcJ6AgBtIKcwowglfjBZabofOCpfJxMPIbNFRqIsN/tozPMC
         spYsmN458DoRJd7RbCQzzf27A6BCjVtfvfUAjHA+21UgSjs+jpgwyJIkcB5Em5C5vAtl
         uYIYahjrRjSJqgR+B4FS46z4lXDln8qMaJhlN1g92c76T/P3iEfZy+a3ezA7qTVKr465
         X+q7NDqwoLtdREaQgGxociM8U5IMmYRBCOK/23/v3HGg/ShpmPa33lBkbxh/HTnu7w8+
         wp9Q==
X-Gm-Message-State: APjAAAUZ7ygVJG6s5Rgq0U03okZiBHjPyIEat3x6aNgRBILJAKgPLBnv
        QyIvCzgsSCTZa/tMasDU/+zzRVdlVNPuQ7Gy1xg=
X-Google-Smtp-Source: APXvYqwrU0QFp19fXd7eOjSX/s5C7ayWL4rJyb3/DBjg8l5cX7XnZnMzEYPDAYyu+Faz+tw6vuinMMxapJsyPGLcLe0=
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr5318834wmk.147.1562768441982;
 Wed, 10 Jul 2019 07:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <6e3b0f511a291dd0ce570a6cc5393e10d4509d0e.1561385989.git.zhangweiping@didiglobal.com>
 <20190627103719.GC4421@minwooim-desktop> <20190627110342.GA13612@lst.de> <CAA70yB5uve6x-t56u7RcM8=JNSXh644uErC5z4m5h2C1rkSuvA@mail.gmail.com>
In-Reply-To: <CAA70yB5uve6x-t56u7RcM8=JNSXh644uErC5z4m5h2C1rkSuvA@mail.gmail.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 10 Jul 2019 22:20:34 +0800
Message-ID: <CAA70yB7-mLguBM=RxHeGzpDrrvnvdOaK3A32k4bdFc3uOvKaiQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] nvme: add support weighted round robin queue
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minwoo Im <minwoo.im.dev@gmail.com>, keith.busch@intel.com,
        sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Weiping Zhang <zwp10758@gmail.com> =E4=BA=8E2019=E5=B9=B46=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:57=E5=86=99=E9=81=93=EF=BC=9A
>
> Christoph Hellwig <hch@lst.de> =E4=BA=8E2019=E5=B9=B46=E6=9C=8827=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:06=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Jun 27, 2019 at 07:37:19PM +0900, Minwoo Im wrote:
> > > Hi, Maintainers
> > >
> > > Would you guys please give some thoughts about this patch?  I like th=
is
> > > feature WRR addition to the driver so I really want to hear something
> > > from you guys.
> >
> > We are at the end of the merge window with tons of things to sort out.
> > A giant feature series with a lot of impact is not at the top of the
> > priority list right now.
>
> Hi Christoph,
>
> There are some feedback in V3, I really want to get some more feedback fr=
om you
> and other people, at that time I post V4.
>
> So please give some comments for V3 at your convenience after this merge =
window.
>
Hi Christoph,

Ping

Return-Path: <SRS0=MX1A=5N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EEEC43331
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 08:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B055A2072F
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 08:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwYyNz+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgC1I3F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:29:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33898 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgC1I3E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Mar 2020 04:29:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id 65so14557503wrl.1
        for <linux-block@vger.kernel.org>; Sat, 28 Mar 2020 01:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwI/7GI2lKUQPn0sFyYZ2SRu3RwIG5d0OprhmdWW6P0=;
        b=HwYyNz+mZuQKoW0ZNbufhYbwnOtshk/omKd95cax8VI+WwJbpDE38nz+j/EoqSfnLU
         JtE+0Lx/gE0XlhU9+BIB5k/jqpXXfov4sbAto76Iw78qOGarijCA81CkghMw4HeMzhZb
         eNhVor5XeL9kUEsURT2DvWFgZjyUGha7dbok5rgjEmQOrpBw1S8R9VsP5TwOEB77tx1C
         aeuSf2kEWj4Rs4Tdi+tSexB9+He01d8aBfdmToKOCYGVNFLRg/qj4RH0CsWQBJKEApR8
         EJlqTX6fkWoTAA5NvTD5TgoTgx4/TwgV6ZDoTlX3zRzJLyhu2x9ZeDlsENu6MNcBsBEi
         R8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwI/7GI2lKUQPn0sFyYZ2SRu3RwIG5d0OprhmdWW6P0=;
        b=YuVmqj6TvGOCk/zyAFK2GrlKMW0hOiWO9JPFpFs4qlbP1UbHNhDwJJL/UoELKI5IAi
         tGPiFIqc171DkGwrBOequZ2bR097ptXUnUb2D5u7l1ikcAxMuI5lPfFLSu500NjE6ym5
         4qOBqgcTvc69rRMhQeLUc17ATelCIfwEWMAI5W81F8yEbMbPWTRk43Wis230w/pRzEIa
         lWjatq0q8+In3EfLVXRIbGLGByZfQwFIGsM+Mau3bCs7dJe1uc5BFMjUTcJv79DnTN2w
         omNQbpa+bKQweT5B/cXxkJAynAfPuj3j0O0ZzPjjrLz3v+HeRLVuoKhicBTBkrzu+upq
         2TgA==
X-Gm-Message-State: ANhLgQ0mWQcZBwvWHjJ/oZlx1zM6sXDCEV0vGeSa6lLBaLnTPXoF6Kxc
        MIufj5841HNXxH/PUATwGudpExwjuJi2IsWgC9k=
X-Google-Smtp-Source: ADFU+vvcbrj0nGIpQ7ZdReABnLDzJXDdsiYijzqL80JlhfgeKYp4k2b7RxmxdTrFqMg2VmfKtK2nQu4voQHf2tob07M=
X-Received: by 2002:a5d:6992:: with SMTP id g18mr3868816wru.426.1585384142649;
 Sat, 28 Mar 2020 01:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200323182324.3243-1-ikegami.t@gmail.com> <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com> <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com> <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com> <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
 <20200328031334.GA18429@keith-busch>
In-Reply-To: <20200328031334.GA18429@keith-busch>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sat, 28 Mar 2020 16:28:51 +0800
Message-ID: <CACVXFVNY++56icyHB4+-aGjRXWZ5B7WdK4z-N336u0+v6sDhbQ@mail.gmail.com>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
To:     Keith Busch <kbusch@kernel.org>
Cc:     Tokunori Ikegami <ikegami.t@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 11:13 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Sat, Mar 28, 2020 at 10:11:57AM +0800, Ming Lei wrote:
> > On Sat, Mar 28, 2020 at 2:18 AM Keith Busch <kbusch@kernel.org> wrote:
> > >
> > > This is actually even more confusing. We do not support 256MB transfers
> > > within a single command in the pci nvme driver anymore. The max is 4MB,
> > > so I don't see how increasing the max segments will help: you should be
> > > hitting the 'max_sectors' limit if you don't hit the segment limit first.
> >
> > That looks a bug for passthrough req, because 'max_sectors' limit is only
> > checked in bio_add_pc_page(), not done in blk_rq_append_bio(), something
> > like the following seems required:
>
> Shouldn't bio_map_user_iov() or bio_copy_user_iov() have caught the
> length limit before proceeding to blk_rq_append_bio()?

Actually the limit should be caught earlier in bio_add_pc_page(), that requires
to pass 'rq' in, then one perfect passthrough bio can be made before
appending to rq.

Not only max sector limit, max segments & virt_boundary should be checked
in request wide too.

So far, only lightnvm calls bio_add_pc_page() before allocating
request, and that is
the 1st bio, so NULL rq can be passed.

thanks,
Ming Lei

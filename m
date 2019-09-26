Return-Path: <SRS0=S7xR=XV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BDCC432C2
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 10:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09823217F4
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 10:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="PuaUgNVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfIZKAx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:00:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40398 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfIZKAx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Sep 2019 06:00:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so1879248wmj.5
        for <linux-block@vger.kernel.org>; Thu, 26 Sep 2019 03:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROnvgo4/nAkCzFnrK5SIJSu529RBPGmkqL+uQqHEUMo=;
        b=PuaUgNVHIVBuzW7CazDD5YSXZ47LIMRVT0LuhBHydMkL+Nd/4ALuCEadZa5huqFFOT
         89hFZdAd8Hp8MQPaAxFtWHssbThHRCBxJUIqt4yKSlVIxEab08seSVTBCe35OR75g8u7
         SGH2P7KZ3b1J9NzpiKK7IMTmMQHxDlynol1xoN9064QZTiJ2Meffpaeaq2veyboRAuAK
         92grBr9pH7R8LD1EtKFtfHGFlnVEvFuKWZTp6G8S2Mi/whFCejINu2WOcGLD6zrTQj24
         p/gQkg99LLpBeIfo2I4o/KRuuHt/JI7xbNEfkFhswW0Eg7Tj3CBby8pmDwF16aneyqVy
         K87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROnvgo4/nAkCzFnrK5SIJSu529RBPGmkqL+uQqHEUMo=;
        b=W8SXYSBwjstkDZd9AHR9ekhGG6674Gy3CYY2MUnDzovRlr4A5rYYY9+fkJkscQceE+
         F3Pw14vE66mTVXBpA7CS/Qz2ThqtQj+Y+5SArchTAB71CHu6eK9PWD99YU0//iyTCgec
         /5UYoDQXCLOgoChiTyFCHY+/F7gO/4nLy5nq+rKpdw3ioirdLSa1VdpiKISVPT7nfKDI
         FdkX1Xz9UA5MsALWDNjXXM2fticsodWY7rsyEtkkJuomkLf9z4gtTMuzEhb1DBrQDvi9
         sqLQ3FBIhUy+1JvljJD1elUZ2PSIduZDmxXItML039HmcQ8wTu99pl0bGIXMf0TQL6Gd
         tlBQ==
X-Gm-Message-State: APjAAAXRDhiscYXxuE8FikUFWN6Ti6JSASCmIbFQPmhpbiXHLu9zKyP5
        hMrC5uHlDM8dORMQ8S4YtgLri2y0kT8N2HQXOwpTpA==
X-Google-Smtp-Source: APXvYqysXTvpf5h9BVMWCnPdx4cfKVcwJHWZ7bm/B461J7LDJWR7z6FxBTIsHXBS1ZilwuRiugympCx0y+aumA5hMp4=
X-Received: by 2002:a05:600c:c2:: with SMTP id u2mr2107404wmm.37.1569492049693;
 Thu, 26 Sep 2019 03:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-17-jinpuwang@gmail.com>
 <7d11d903-7826-8c1a-bef8-74ea4cf5f340@acm.org> <CAMGffEmZdqJ2Nw1KX=DirMp4e89i-G4ut24qNSVYRy0eG=v8sg@mail.gmail.com>
 <CAHg0Huyuf_rVCb3gugYWu1jaFT4gyrex+SpC1vsuUtWRk-UOFQ@mail.gmail.com>
In-Reply-To: <CAHg0Huyuf_rVCb3gugYWu1jaFT4gyrex+SpC1vsuUtWRk-UOFQ@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 26 Sep 2019 12:00:38 +0200
Message-ID: <CAMGffEkKyx1dB2ipwi++U4B2he7A+E16Pbzt-FqGQeZGuXvUDQ@mail.gmail.com>
Subject: Re: [PATCH v4 16/25] ibnbd: client: private header with client
 structs and functions
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 26, 2019 at 1:43 AM Danil Kipnis
<danil.kipnis@cloud.ionos.com> wrote:
>
> On Tue, Sep 17, 2019 at 6:36 PM Jinpu Wang <jinpu.wang@cloud.ionos.com> wrote:
> >
> > On Sat, Sep 14, 2019 at 12:25 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > >
> > > On 6/20/19 8:03 AM, Jack Wang wrote:
> > > > +     char                    pathname[NAME_MAX];
> > > [ ... ]
> > >  > +    char                    blk_symlink_name[NAME_MAX];
> > >
> > > Please allocate path names dynamically instead of hard-coding the upper
> > > length for a path.
> Those strings are used to name directories and files under sysfs,
> which I think makes NAME_MAX a natural limitation for them. Client and
> server only exchange those strings on connection establishment, not in
> the IO path. We do not really need to safe 256K on a server with 1000
> devices mapped in parallel. A patch to allocate those strings makes
> the code longer, introduces new error paths and in my opinion doesn't
> bring any benefits.
Hi Bart,

We have a draft patch, but it looks ugly, after discussing in house,
due to the reason
Danil mentioned.

we dropped the patch.

Thanks,
Jinpu

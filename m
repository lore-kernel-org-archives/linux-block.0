Return-Path: <SRS0=vQdV=2N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AA1C2D0C0
	for <linux-block@archiver.kernel.org>; Mon, 23 Dec 2019 07:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCCA206CB
	for <linux-block@archiver.kernel.org>; Mon, 23 Dec 2019 07:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="asbgCvJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfLWHjE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Dec 2019 02:39:04 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:32827 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfLWHjE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Dec 2019 02:39:04 -0500
Received: by mail-io1-f68.google.com with SMTP id z8so15303778ioh.0
        for <linux-block@vger.kernel.org>; Sun, 22 Dec 2019 23:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zeye+q53rZmux/Iau8xNLxQp7lO05n5+p3pMzBVRFf8=;
        b=asbgCvJsJwZ0p1J1IYLFjlmcXtT1c+RjctZqZh/gsHJe16G98SpIq9tjPn/oKINtKE
         P8GGt+Ygb7UPsZR61EgA7JsHXQap7Rua3dzlxGm4kcSR3ylR073c2YdfjdSOnHyxTXye
         G2fzMdt+RR7FuNTevjk+metyZxVEziyQTINNbsSTqp47J6grnx9CMiTXCYMtd8GQypYP
         RWJ/b0NA77oH3Mnym7d64982prg0YPF1c7nq1wgZwbMh9xxOnHuihs7ehgza8Fod0xyS
         CB6qjAyElA+LDTpwl+BHGU0mGKsVlWg4s1D3w3KUn0KJPd2hjYcnHzMJXCeIsz/PUbOo
         yn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zeye+q53rZmux/Iau8xNLxQp7lO05n5+p3pMzBVRFf8=;
        b=kCpoSDmDJxq6JoVnhbaY52MmygNPCrknXeYvpsz1utf99vsPY6zg6HoUVPfRWNhRZ/
         qPcTAmxVX1bIv9HlhPmbcM27wFrIz7JoQhDNLzHRoGq4l6WsHmgQL7xbkwlguW4Yw3xf
         dfxcvNDlE2+flmNt+hf8OeV6ODxDHOXvJjjjPuLCfPnRlZ4MLvLk8yA3QJHKgZnOKTfj
         8MkzndXWIl8FFUc5wsgyD7oaiHoz9dEcD5RVn7TgACT0XHQF9E0W/jWOxTCZr6BipeQS
         eFznjMDYfZ6lBx4/bQnYdHCUdyoZ7I4+cNbrnRzMou77OMbZiS2a47NezfyJM9QugC+h
         R5xQ==
X-Gm-Message-State: APjAAAUicNDc/J3hNMQhIZtGHSlD7wHD5nzb2B0C+pxOQIKor5zExQMN
        f9JSvXSk4sV3d5tvGjsJfjtzGbTVwGIeUun+ip63Hw==
X-Google-Smtp-Source: APXvYqyK4sCYJ4o+bv9/rJOZOgkU9PG4Z7cuTPQR3TcJUT5pn/w74AAt1MCMgekgDxCujUR7u3lgpgoU3szvt6tBsoU=
X-Received: by 2002:a02:ca10:: with SMTP id i16mr8015353jak.10.1577086743442;
 Sun, 22 Dec 2019 23:39:03 -0800 (PST)
MIME-Version: 1.0
References: <20191220155109.8959-1-jinpuwang@gmail.com> <20191220155109.8959-3-jinpuwang@gmail.com>
 <20191221101530.GC13335@unreal> <CAHg0HuxC9b+E9CRKuw4qDeEfz7=rwUceG+fFGfNHK5=H2aQMGw@mail.gmail.com>
 <20191222073629.GE13335@unreal>
In-Reply-To: <20191222073629.GE13335@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 23 Dec 2019 08:38:54 +0100
Message-ID: <CAMGffEn9xcBO0661AXCfv0KDnZBX6meCaT07ZutHykSxM4aGaQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/25] rtrs: public interface header to establish RDMA connections
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 22, 2019 at 8:36 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Sat, Dec 21, 2019 at 03:27:55PM +0100, Danil Kipnis wrote:
> > Hi Leon,
> >
> > On Sat, Dec 21, 2019 at 11:15 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > Perhaps it is normal practice to write half a company as authors,
> > > and I'm wrong in the following, but code authorship is determined by
> > > multiple tags in the commit messages.
> >
> > Different developers contributed to the driver over the last several
> > years. Currently they are not working any more on this code. What tags
> > in the commit message do you think would be appropriate to give those
> > people credit for their work?
>
> Signed-of-by/Co-developed-../e.t.c
>
> But honestly without looking in your company contract, I'm pretty sure
> that those people are not eligible for special authorship rights and
> credits beyond already payed by the employer.
>
Hi, Leon,

Thanks for the suggestion, how about only remove the authors for the
new entry, only keep the company copyright?
> +/* Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
> + * Authors: Jack Wang <jinpu.wang@cloud.ionos.com>
> + *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
> + *          Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> + *          Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
> + */

The older entries were there, I think it's not polite to remove them.

Regards,
Jack

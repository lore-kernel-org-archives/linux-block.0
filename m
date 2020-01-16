Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC02C33CB1
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD582073A
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 15:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B0xCPtFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgAPPxF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:53:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42481 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPPxE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jan 2020 10:53:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so19208543qtq.9
        for <linux-block@vger.kernel.org>; Thu, 16 Jan 2020 07:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i7NTAXzB1w6OZi8wh7MAxhZ8SUZX2K16pqrakSHjTlY=;
        b=B0xCPtFkmozoeMJuWIrPg29xNBiRYvxx2MFQp/T8Iz5yO/XRPSFzRiHjYsQ0uzELXd
         06avWwsMbilXdNArYAtbry06RDtA6XOKKX3Urzg4PpzYYOl1VKN5qsStgvt8IMIj6d9G
         D7hN49JOSCSZJKx3GbX2xt1vJXVS3dUbRpmF6zZ0EiiqpiXwyAFFPcAys4amG86eJjxR
         GlKVLZkMNhqz7nHril/QyFSqtI6X6Zws9OCJ+tZJXeJmZ8OjDFEtmKKjKD3HZxgAoCe6
         bdBqRS4QKF/iaFnKgrNuWyvLnJUbecDatWU9uBETQbIdyiA2OFW059AlKZvP44Y+BEnG
         coqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i7NTAXzB1w6OZi8wh7MAxhZ8SUZX2K16pqrakSHjTlY=;
        b=dwMJso1VAFpjO/itMFUQJG6QrgjTkfBgL7q00yyTVH74/jcYQVX6JWVguOBY4r1OSp
         NRfYgk2nhGf3ObCd7lbfGMggeqV2xgVC3QZPfIxmmniQoIIpTmWQYrnr17KN7mlPMO/L
         hCU4qlo5WtvO9PCtAMW3CYT14bcqQ0yNAEI3P55jU0Xk6RnUL5e3g6sJXqc5zdqq/sdd
         UK81lYibaiXypGWXk11g4R6gdbl8KGw9xHJ35TDifd8vtAxgJePVEJ4md6oVzGQ63sfT
         m+tgCX8wlJT5hiShVcFdwXYZkwKmDoCp7avlO/TB6r8Qh85DaOOGeV6ZYZQWcIcwGMGV
         3d1w==
X-Gm-Message-State: APjAAAUai6D/65/AgaNpq4gfs7m5lLTQF7FXZz2S/x+F+/SdQ/86nZMJ
        Qw4kcKPKZhAY7bJ1sYepQQFnRw==
X-Google-Smtp-Source: APXvYqyx4lxthDx8vBkWHLxM4URs/uWRwPfgqChXoksGLx97cT2Uje2lMGgFGNulOk2sEmv7KWsBAw==
X-Received: by 2002:ac8:1c23:: with SMTP id a32mr2966994qtk.119.1579189983893;
        Thu, 16 Jan 2020 07:53:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c8sm11250513qtv.61.2020.01.16.07.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 07:53:02 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1is7S9-0006D9-84; Thu, 16 Jan 2020 11:53:01 -0400
Date:   Thu, 16 Jan 2020 11:53:01 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Jack Wang <jinpuwang@gmail.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCH v7 06/25] RDMA/rtrs: client: main functionality
Message-ID: <20200116155301.GC10759@ziepe.ca>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
 <20200116125915.14815-7-jinpuwang@gmail.com>
 <20200116145300.GC12433@unreal>
 <CAMGffE=pym8iz4OVxx7s6i37AU+KPFN3AeVrCTOpLx+N8A9dEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=pym8iz4OVxx7s6i37AU+KPFN3AeVrCTOpLx+N8A9dEQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 16, 2020 at 04:43:41PM +0100, Jinpu Wang wrote:
> > > +             wake_up(&clt->permits_wait);
> > > +}
> > > +EXPORT_SYMBOL(rtrs_clt_put_permit);
> > > +
> > > +struct rtrs_permit *rtrs_permit_from_pdu(void *pdu)
> > > +{
> > > +     return pdu - sizeof(struct rtrs_permit);
> >
> > C standard doesn't allow pointer arithmetic on void*.
> gcc never complains,  searched aournd:
> https://stackoverflow.com/questions/3523145/pointer-arithmetic-for-void-pointer-in-c
> 
> You're right, will fix.

The kernel extensively uses a gcc extension treating arithmatic on a
void * as the same as a u8, you can leave it for kernel code.

But is generally a big question why code is written like that, always
better to use a struct and container_of

Jason

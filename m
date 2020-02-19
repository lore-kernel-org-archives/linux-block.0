Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C02C34055
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A037320578
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="b7HJsPgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgBSQng (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:43:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39021 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgBSQng (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 11:43:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id j15so365814pgm.6
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 08:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CSi48COg7O+zi2K9/ck2d1xU7vAVOC+iAJju5Ur3V0o=;
        b=b7HJsPgNeKbBv9+A8TG0o1/TRxU+ISF8hI4w5ytwopFEZmuolUmVpZotDd2JWlAWax
         xo61mx55cKtmeqHiCfN8OTSOS8duITjAQIFwEJgo1IRTLTEHxFb4I1urWQVDy4b2k8VI
         TXVh5piKH5spZ/4RFxPDS4TtvNQeTzouZDqWu7zOvanpicLnPdAlCL5C5RbRJr1Nz8oz
         Bd4lqDeEI1YSTFH/1DrlJpw/zb5tL+dDSC3uUu9q92ZBxj8xet8oWUhHbnOtNLwsW/f/
         WjXfUNp7clzRKZd1kDcC/VGLdjqSS0AtM/ivQeD6tuYjjzvEEvLmR3s6RFZy05pEZWcq
         QDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CSi48COg7O+zi2K9/ck2d1xU7vAVOC+iAJju5Ur3V0o=;
        b=foDPWjcsyFWZ0X6E8gD11DG5femCE/bqbBMJNnCAw5AoVp6JeNwMbWPzrFeuu1evbk
         Oa9Yk9hA4TJfoPR0e9rn4fwhlRvyn2EeIN4iF8w9ctqpje9t/RIsf7/oNp3mu7V9Jum3
         597h9Uq61oTZthi0wDewv0ggCL5v3ZO0/vAvxXz1nhkZFdZeW9s/1DKroP0RLiOmiwqz
         mUhDYVEJz4fhGd7O0b0SEOp8RTt7YjAaf5k+rtjZ45SXwdkWHaE6zoWtUtvbcvCRjUna
         vih8P2Xl+qN8qbXxzITHBJN0OR+XmX6sGWp4X5/d1sK4/vio0dFQh8YbSXPwhc2EiXTo
         wRMQ==
X-Gm-Message-State: APjAAAVZDb2skGStNd0dZLvXmDXc/NlRVb9jD4rrRMGW25wwnJVf2sG9
        +SqprPGDn82Ds/TEOESWFiE8LA==
X-Google-Smtp-Source: APXvYqwkwvCm9Kp71y3MrnjzoDfDxZEAFsr7tdGwNYzqLSkQ1xCDQSS9SWKiHNHCiMxp3TrtM6V5Mw==
X-Received: by 2002:a63:5f17:: with SMTP id t23mr29042208pgb.91.1582130615265;
        Wed, 19 Feb 2020 08:43:35 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s7sm215492pgp.44.2020.02.19.08.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 08:43:34 -0800 (PST)
Date:   Wed, 19 Feb 2020 08:43:30 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     "sunke (E)" <sunke32@huawei.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com
Subject: Re: [PATCH blktests v4] nbd/003:add mount and clear_sock test for nbd
Message-ID: <20200219164330.GB353282@vader>
References: <1577071109-68332-1-git-send-email-sunke32@huawei.com>
 <8ece15f7-addf-44b2-0b54-4e1a450037f2@huawei.com>
 <20200211222345.GI100751@vader>
 <c374674b-f884-3d2e-14ca-bae2982e3fbd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c374674b-f884-3d2e-14ca-bae2982e3fbd@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 12, 2020 at 04:13:02PM +0800, sunke (E) wrote:
> 
> 
> 在 2020/2/12 6:23, Omar Sandoval 写道:
> > On Mon, Dec 23, 2019 at 11:15:35AM +0800, sunke (E) wrote:
> > > Hi Omar,
> > > 
> > > The nbd/003 you simplified does the same I want to do and I made some small
> > > changes. I ran the simplified nbd/003 with linux kernel at the commit
> > > 7e0165b2f1a, it could pass.Then, I rollbacked the linux kernel to commit
> > > 090bb803708, it indeed triggered the BUGON.
> > > 
> > > However, there is one difference. NBD has ioctl and netlink interfaces. I
> > > use the netlink interface and the simplified nbd/003 use the ioctl
> > > interface. The nbd/003 with the netlink interface indeed seem to trigger
> > > some other issue. So, can it be nbd/004?
> > 
> > Sure, how about we add a flag to mount_clear_sock that specifies to use
> > the netlink interface instead of the ioctl interface, and make nbd/004
> > which is the same as nbd/003 expect it runs it with the netlink flag?
> > 
> Hi Omar
> 
> I can not understand adding a flag to mount_clear_sock.

Sorry, I thought you were saying that there is a netlink interface
equivalent to ioctl(NBD_CLEAR_SOCK).

> How about add
> _start_nbd_server_netlink and _stop_nbd_server_netlink in tests/nbd/rc,
> others can also reuse the code?

Sure, that works.

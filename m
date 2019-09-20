Return-Path: <SRS0=iom0=XP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8DEC3A5A2
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 16:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C643207FC
	for <linux-block@archiver.kernel.org>; Fri, 20 Sep 2019 16:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="lRDI8pnb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fl/pFOth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391345AbfITQxw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:53:52 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43259 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391341AbfITQxv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Sep 2019 12:53:51 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7FB4821FF3;
        Fri, 20 Sep 2019 12:53:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 20 Sep 2019 12:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=FTd0MjyQOamupYznMP3YQLd0NxQ
        xaRMULdNa/344S3w=; b=lRDI8pnbIDWfciHpPwFjFq45ln5DXNtWefzKYiwztV+
        HBZMP/zHlhvGihum05VWt+5eALgd0Dd3grUmveDSriopgzVIHv5UyyAujhGvxXD5
        InQmokUvLqtj35EQeRkfjPfed4cXckV50bvDZvBviAasO+2tNiGW/sqTnVDakO1s
        3sTGIcf7q2gHE3Q4bhUUbCbE9Yk3NxNTJXEpv2AjAqfP6bl4ckV1sTY1VHDM5SCG
        6vT3mFlQd0jDm8S29ejuUJNKa7jiapogfRw/0cMLvem/g6F4aAyCExRmL0nZWiyh
        CUHYo63HTMjaVFbqhVYwIUxPIy+xSEnYagQbwHftDyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FTd0Mj
        yQOamupYznMP3YQLd0NxQxaRMULdNa/344S3w=; b=fl/pFOthiqaFEREBiWxfZZ
        vwOWr/x1PeA5HiDKCuGELytwtTPsReXLnxvqRt1m3rZ6C22sFoEpNSK6FGixBfTA
        JRQznQlVr/MYJbsd0wMMuXLLCv/3YvzUnbjrOwTmul2zlzDrITdu0lm3FqZo7ab0
        GZianKatOpQe3T3c6id/Vr/oQhOAYefLQbaUgWjlWm80FyWD4U3SNZ0c/pyHVBDx
        Z3UaxAT+Mn16Y/c+17W5dgvNp9hUZa1ZY+qEvSKmC5MkpwHAma5EH3TUJddqKsmP
        ao9LEFTtdYfY9tn8qpUnG0/sTT6+egLgXeidMH4QqOGG/PtoxfTmguPv96tT8hGw
        ==
X-ME-Sender: <xms:HQSFXUFznBscUnxCHURvfHBBDeWz6Sj1MIhfPzXHzvNR2kLyBLQl2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddvgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgurhgv
    shcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucfkphepie
    ejrdduiedtrddvudekrddvfeejnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgv
    shesrghnrghrrgiivghlrdguvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:HQSFXULeNZPsSIFlvWQdeaGxyzcIpzDuWgaHCormmS5R8WcS_h7pPA>
    <xmx:HQSFXXGEBBL2yklmiIH1-XvLcLDHsHMGfheF3FkTqtG7UlmZCz4V9Q>
    <xmx:HQSFXY61F-lDsmFpVYEu7bx-kX53pcwUgWJNnJBQdChktc3gj08xGg>
    <xmx:HgSFXc179_zBPFUFM378ua4QdWJcEeM4teW-SCCBLZxpuJWbh5_-Ww>
Received: from intern.anarazel.de (c-67-160-218-237.hsd1.ca.comcast.net [67.160.218.237])
        by mail.messagingengine.com (Postfix) with ESMTPA id AFC1880059;
        Fri, 20 Sep 2019 12:53:49 -0400 (EDT)
Date:   Fri, 20 Sep 2019 09:53:48 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] io_uring: IORING_OP_TIMEOUT support
Message-ID: <20190920165348.pjmdnm3mozna3ous@alap3.anarazel.de>
References: <f0488dd6-c32b-be96-9bdc-67099f1f56f8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0488dd6-c32b-be96-9bdc-67099f1f56f8@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2019-09-17 10:03:58 -0600, Jens Axboe wrote:
> There's been a few requests for functionality similar to io_getevents()
> and epoll_wait(), where the user can specify a timeout for waiting on
> events. I deliberately did not add support for this through the system
> call initially to avoid overloading the args, but I can see that the use
> cases for this are valid.

> This adds support for IORING_OP_TIMEOUT. If a user wants to get woken
> when waiting for events, simply submit one of these timeout commands
> with your wait call. This ensures that the application sleeping on the
> CQ ring waiting for events will get woken. The timeout command is passed
> in a pointer to a struct timespec. Timeouts are relative.

Hm. This interface wouldn't allow to to reliably use a timeout waiting for
io_uring_enter(..., min_complete > 1, ING_ENTER_GETEVENTS, ...)
right?

I can easily imagine usecases where I'd want to submit a bunch of ios
and wait for all of their completion to minimize unnecessary context
switches, as all IOs are required to continue. But with a relatively
small timeout, to allow switching to do other work etc.

- Andres

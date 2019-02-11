Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B12EC282D7
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 15:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5447021B18
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 15:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbfBKPzh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:55:37 -0500
Received: from ms.lwn.net ([45.79.88.28]:46286 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730236AbfBKPzg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 10:55:36 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 494EF9AE;
        Mon, 11 Feb 2019 15:55:35 +0000 (UTC)
Date:   Mon, 11 Feb 2019 08:55:33 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, avi@scylladb.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/18] io_uring: add file set registration
Message-ID: <20190211085533.35190404@lwn.net>
In-Reply-To: <73e23146-2138-5a46-46ed-9c7f1f912a04@kernel.dk>
References: <20190129192702.3605-1-axboe@kernel.dk>
        <20190129192702.3605-14-axboe@kernel.dk>
        <CAG48ez2kLWUEambWesQQaeVn_u=PtjuMeDUc49yamhYspfd7Sg@mail.gmail.com>
        <20190204025612.GR2217@ZenIV.linux.org.uk>
        <785c6db4-095e-65b0-ded5-72b41af5174e@kernel.dk>
        <2b2137ed-8107-f7b6-f0ca-202dcfb87c97@kernel.dk>
        <40b27e78-9ee8-1395-feb3-a73aac87c9a7@kernel.dk>
        <20190206005638.GU2217@ZenIV.linux.org.uk>
        <8f124de2-d6da-d656-25e4-b4d9e58f880e@kernel.dk>
        <20190207040058.GW2217@ZenIV.linux.org.uk>
        <73e23146-2138-5a46-46ed-9c7f1f912a04@kernel.dk>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 7 Feb 2019 11:45:40 -0700
Jens Axboe <axboe@kernel.dk> wrote:

> > OK, braindump time:  
> 
> [snip]
> 
> This is great info, and I think it belongs in Documentation/ somewhere.
> Not sure I've ever seen such a good and detailed dump of this before.

I suspect I might be able to make something like that happen :)  Stay
tuned.

Thanks,

jon

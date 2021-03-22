Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E787C433C1
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 15:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F4A61972
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 15:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhCVPgo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 11:36:44 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:52274 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhCVPgf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 11:36:35 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOMZO-008CS3-Es; Mon, 22 Mar 2021 15:34:18 +0000
Date:   Mon, 22 Mar 2021 15:34:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] buffer: a small optimization in grow_buffers
Message-ID: <YFi4+ojoqo4+n1EV@zeniv-ca.linux.org.uk>
References: <alpine.LRH.2.02.2103221002360.19948@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2103221002360.19948@file01.intranet.prod.int.rdu2.redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 22, 2021 at 10:05:05AM -0400, Mikulas Patocka wrote:
> This patch replaces a loop with a "tzcnt" instruction.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> Index: linux-2.6/fs/buffer.c
> ===================================================================
> --- linux-2.6.orig/fs/buffer.c
> +++ linux-2.6/fs/buffer.c
> @@ -1020,11 +1020,7 @@ grow_buffers(struct block_device *bdev,
>  	pgoff_t index;
>  	int sizebits;
>  
> -	sizebits = -1;
> -	do {
> -		sizebits++;
> -	} while ((size << sizebits) < PAGE_SIZE);
> -
> +	sizebits = PAGE_SHIFT - __ffs(size);
>  	index = block >> sizebits;
>  
>  	/*

Applied.

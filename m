Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796F3C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 12:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhLWMha (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 07:37:30 -0500
Received: from verein.lst.de ([213.95.11.211]:53782 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233015AbhLWMha (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 07:37:30 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id ECB6D68AA6; Thu, 23 Dec 2021 13:37:24 +0100 (CET)
Date:   Thu, 23 Dec 2021 13:37:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: drop needless assignment in set_task_ioprio()
Message-ID: <20211223123724.GA23339@lst.de>
References: <20211223123003.6947-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223123003.6947-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  		if (task->io_context) {
>  			kmem_cache_free(iocontext_cachep, ioc);
> -			ioc = task->io_context;
>  		} else {
>  			task->io_context = ioc;
>  		}

Please also drop the now superflous braces.

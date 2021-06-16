Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5EDC48BE5
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 03:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9039613B6
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 03:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFPDxT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 23:53:19 -0400
Received: from verein.lst.de ([213.95.11.211]:52219 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhFPDxS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 23:53:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2CDD268AFE; Wed, 16 Jun 2021 05:51:10 +0200 (CEST)
Date:   Wed, 16 Jun 2021 05:51:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, gmpy.liaowx@gmail.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] pstore/blk: Improve failure reporting
Message-ID: <20210616035109.GA25873@lst.de>
References: <20210615212121.1200820-1-keescook@chromium.org> <20210615212121.1200820-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615212121.1200820-2-keescook@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 15, 2021 at 02:21:18PM -0700, Kees Cook wrote:
> -	if (!dev || !dev->total_size || !dev->read || !dev->write)
> +	if (!dev || !dev->total_size || !dev->read || !dev->write) {
> +		if (!dev)
> +			pr_err("NULL device info\n");
> +		else {
> +			if (!dev->total_size)
> +				pr_err("zero sized device\n");
> +			if (!dev->read)
> +				pr_err("no read handler for device\n");
> +			if (!dev->write)
> +				pr_err("no write handler for device\n");
> +		}
>  		return -EINVAL;
> +	}

I still find this style of checks pretty strange..

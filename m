Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5972C49361
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 07:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF43613D5
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 07:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFQH6d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 03:58:33 -0400
Received: from verein.lst.de ([213.95.11.211]:57648 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230118AbhFQH6c (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 03:58:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9AC7C68C4E; Thu, 17 Jun 2021 09:56:22 +0200 (CEST)
Date:   Thu, 17 Jun 2021 09:56:22 +0200
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
Subject: Re: [PATCH v3 2/5] pstore/blk: Move verify_size() macro out of
 function
Message-ID: <20210617075622.GB899@lst.de>
References: <20210616164043.1221861-1-keescook@chromium.org> <20210616164043.1221861-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616164043.1221861-3-keescook@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +#define verify_size(name, alignsize, enabled) {			\

Our normal macro style would be to move the opening brace onto a separate
line, just like we do for functions.

With that fixed:

Signed-off-by: Christoph Hellwig <hch@lst.de>

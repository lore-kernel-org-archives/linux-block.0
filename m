Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4922DC28CBC
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 06:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6DB20735
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 06:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgEFGHn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 02:07:43 -0400
Received: from verein.lst.de ([213.95.11.211]:39059 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgEFGHn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 02:07:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9879368C4E; Wed,  6 May 2020 08:07:41 +0200 (CEST)
Date:   Wed, 6 May 2020 08:07:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/10] loop: Rework lo_ioctl() __user argument
 casting
Message-ID: <20200506060741.GE10771@lst.de>
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-9-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429140341.13294-9-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 04:03:39PM +0200, Martijn Coenen wrote:
> In preparation for a new ioctl that needs to copy_from_user(); makes the
> code easier to read as well.
> 
> Signed-off-by: Martijn Coenen <maco@android.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, it seems like you have dropped all the reviews from the previous
versions, even if nothing substantial changed.  Please keep them unless
a patch actually is reworked.

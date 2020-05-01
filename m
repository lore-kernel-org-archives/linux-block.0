Return-Path: <SRS0=jnOf=6P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BA2C47257
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 17:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4F12063A
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 17:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgEAR0z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 May 2020 13:26:55 -0400
Received: from verein.lst.de ([213.95.11.211]:47959 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbgEAR0z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 May 2020 13:26:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FA7B68C65; Fri,  1 May 2020 19:26:53 +0200 (CEST)
Date:   Fri, 1 May 2020 19:26:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] loop: Factor out setting loop device size
Message-ID: <20200501172653.GB22792@lst.de>
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-3-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429140341.13294-3-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 04:03:33PM +0200, Martijn Coenen wrote:
> This code is used repeatedly.
> 
> Signed-off-by: Martijn Coenen <maco@android.com>
> ---
>  drivers/block/loop.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

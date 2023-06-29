Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A92DEB64DC
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 07:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjF2Hd5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 03:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjF2Hd1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 03:33:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F741FD8;
        Thu, 29 Jun 2023 00:33:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D5CBE6732D; Thu, 29 Jun 2023 09:33:22 +0200 (CEST)
Date:   Thu, 29 Jun 2023 09:33:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Min Li <min15.li@samsung.com>
Cc:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v5] block: add check that partition length needs to be
 aligned with block size
Message-ID: <20230629073322.GB19464@lst.de>
References: <CGME20230629062728epcas5p2bb48fea42a380039c0eb06c19a44aad1@epcas5p2.samsung.com> <20230629142517.121241-1-min15.li@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629142517.121241-1-min15.li@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

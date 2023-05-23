Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CDDC7EE26
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 11:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjEWLfg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 07:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjEWLfg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 07:35:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E11EFA;
        Tue, 23 May 2023 04:35:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C508B6732D; Tue, 23 May 2023 13:35:31 +0200 (CEST)
Date:   Tue, 23 May 2023 13:35:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anuj Gupta <anuj20.g@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        gost.dev@samsung.com, anuj1072538@gmail.com, joshiiitr@gmail.com,
        stable@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH] block: fix bio-cache for passthru IO
Message-ID: <20230523113531.GA28790@lst.de>
References: <CGME20230523112014epcas5p267f30562f3f2e3c6d58fbb76c0084e5b@epcas5p2.samsung.com> <20230523111709.145676-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523111709.145676-1-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 04:47:09PM +0530, Anuj Gupta wrote:
> +	if (rq->cmd_flags & REQ_ALLOC_CACHE && (nr_vecs <= BIO_INLINE_VECS)) {

The inner braces are superflous.

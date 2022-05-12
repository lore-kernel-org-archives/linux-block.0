Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2307C433EF
	for <linux-block@archiver.kernel.org>; Thu, 12 May 2022 06:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350147AbiELGLz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 May 2022 02:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347360AbiELGLy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 May 2022 02:11:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3219170913
        for <linux-block@vger.kernel.org>; Wed, 11 May 2022 23:11:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1A87568BFE; Thu, 12 May 2022 08:11:49 +0200 (CEST)
Date:   Thu, 12 May 2022 08:11:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] block: Fix the bio.bi_opf comment
Message-ID: <20220512061148.GA20285@lst.de>
References: <20220511235152.1082246-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511235152.1082246-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

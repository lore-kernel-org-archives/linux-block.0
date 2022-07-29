Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938C4C00144
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 14:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbiG2OT1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 10:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbiG2OT0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 10:19:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC3D79ECC
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 07:19:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B514668AA6; Fri, 29 Jul 2022 16:19:22 +0200 (CEST)
Date:   Fri, 29 Jul 2022 16:19:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/5] ublk_drv: cancel device even though disk isn't
 up
Message-ID: <20220729141922.GA32321@lst.de>
References: <20220729072954.1070514-1-ming.lei@redhat.com> <20220729072954.1070514-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729072954.1070514-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

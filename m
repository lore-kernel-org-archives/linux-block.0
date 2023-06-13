Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8814AC77B7A
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 04:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbjFMEdB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 00:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbjFMEci (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 00:32:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3D5173E;
        Mon, 12 Jun 2023 21:30:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B978468B05; Tue, 13 Jun 2023 06:30:38 +0200 (CEST)
Date:   Tue, 13 Jun 2023 06:30:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
        sagi@grimberg.me, joshi.k@samsung.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 2/2] nvme: improved uring polling
Message-ID: <20230613043038.GA13343@lst.de>
References: <20230612190343.2087040-1-kbusch@meta.com> <20230612190343.2087040-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612190343.2087040-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

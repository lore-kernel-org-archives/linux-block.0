Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780A9C7EE29
	for <linux-block@archiver.kernel.org>; Sat, 10 Jun 2023 06:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjFJGtM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 10 Jun 2023 02:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjFJGtL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Jun 2023 02:49:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8123A89;
        Fri,  9 Jun 2023 23:49:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2026468C4E; Sat, 10 Jun 2023 08:49:06 +0200 (CEST)
Date:   Sat, 10 Jun 2023 08:49:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
        sagi@grimberg.me, joshi.k@samsung.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] block: add request polling helper
Message-ID: <20230610064905.GA2131@lst.de>
References: <20230609204517.493889-1-kbusch@meta.com> <20230609204517.493889-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609204517.493889-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

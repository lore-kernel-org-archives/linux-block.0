Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B3FCDB482
	for <linux-block@archiver.kernel.org>; Thu, 19 Oct 2023 05:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjJSFeY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Oct 2023 01:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSFeX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Oct 2023 01:34:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F4D11B;
        Wed, 18 Oct 2023 22:34:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BBA6667373; Thu, 19 Oct 2023 07:34:17 +0200 (CEST)
Date:   Thu, 19 Oct 2023 07:34:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        joshi.k@samsung.com, martin.petersen@oracle.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/4] block integrity: direclty map user space addresses
Message-ID: <20231019053417.GB14346@lst.de>
References: <20231018151843.3542335-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018151843.3542335-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

s/direclty/directly/

in the subject.


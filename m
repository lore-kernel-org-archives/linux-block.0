Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AE8C77B78
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 13:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjEDN4C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 May 2023 09:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEDN4B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 09:56:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C587EC4;
        Thu,  4 May 2023 06:56:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 260E768B05; Thu,  4 May 2023 15:55:57 +0200 (CEST)
Date:   Thu, 4 May 2023 15:55:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Breno Leitao <leitao@debian.org>
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        asml.silence@gmail.com, hch@lst.de, axboe@kernel.dk,
        ming.lei@redhat.com, leit@fb.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, sagi@grimberg.me, joshi.k@samsung.com,
        kbusch@kernel.org
Subject: Re: [PATCH v4 2/3] io_uring: Pass whole sqe to commands
Message-ID: <20230504135556.GB17048@lst.de>
References: <20230504121856.904491-1-leitao@debian.org> <20230504121856.904491-3-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504121856.904491-3-leitao@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

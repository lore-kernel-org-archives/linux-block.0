Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0817CE8181D
	for <linux-block@archiver.kernel.org>; Tue, 26 Sep 2023 06:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjIZGEt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Sep 2023 02:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjIZGEs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Sep 2023 02:04:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67238DE;
        Mon, 25 Sep 2023 23:04:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C922E68D0A; Tue, 26 Sep 2023 08:04:34 +0200 (CEST)
Date:   Tue, 26 Sep 2023 08:04:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix kernel-doc for disk_force_media_change()
Message-ID: <20230926060433.GA4512@lst.de>
References: <20230926005232.23666-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926005232.23666-1-rdunlap@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

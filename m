Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82449C53210
	for <linux-block@archiver.kernel.org>; Sun,  8 Jan 2023 17:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjAHRNm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Jan 2023 12:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbjAHRNi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Jan 2023 12:13:38 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71686BC03
        for <linux-block@vger.kernel.org>; Sun,  8 Jan 2023 09:13:38 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D6DDF68AA6; Sun,  8 Jan 2023 18:13:35 +0100 (CET)
Date:   Sun, 8 Jan 2023 18:13:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 1/2] block: make BLK_DEF_MAX_SECTORS unsigned
Message-ID: <20230108171335.GA20522@lst.de>
References: <20230105205146.3610282-1-kbusch@meta.com> <20230105205146.3610282-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105205146.3610282-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

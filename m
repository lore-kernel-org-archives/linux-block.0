Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFC2C433FE
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 14:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiEPOLv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 10:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244454AbiEPOLt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 10:11:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F7E117A
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 07:11:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F28EA68AA6; Mon, 16 May 2022 16:11:41 +0200 (CEST)
Date:   Mon, 16 May 2022 16:11:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: cleanup the VM accounting in submit_bio
Message-ID: <20220516141141.GA11736@lst.de>
References: <20220516063654.2782792-1-hch@lst.de> <43ae0d52-9ed7-757c-4a01-4b4ca71a00ba@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ae0d52-9ed7-757c-4a01-4b4ca71a00ba@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 16, 2022 at 03:45:08PM +0200, Damien Le Moal wrote:
> I know it is the same value, but for consistency, wouldn't it be better to use
> REQ_OP_WRITE here ?

Yes, it absolutely would.  The use of WRITE wasn't even initentional.

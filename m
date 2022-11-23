Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B9EC4332F
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 07:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiKWHh0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 02:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbiKWHhY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 02:37:24 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E20F885B;
        Tue, 22 Nov 2022 23:37:21 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3B32768AFE; Wed, 23 Nov 2022 08:37:19 +0100 (CET)
Date:   Wed, 23 Nov 2022 08:37:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] elevator: printk a warning if switching to a new
 io scheduler fails
Message-ID: <20221123073719.GB8328@lst.de>
References: <cover.1669126766.git.nickyc975@zju.edu.cn> <d51ed0fb457db7a4f9cbb0dbce36d534e22be457.1669126766.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51ed0fb457db7a4f9cbb0dbce36d534e22be457.1669126766.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

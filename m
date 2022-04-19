Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618CFC4332F
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 05:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiDSFVy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 01:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiDSFVy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 01:21:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74432496B;
        Mon, 18 Apr 2022 22:19:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E100A68AFE; Tue, 19 Apr 2022 07:19:08 +0200 (CEST)
Date:   Tue, 19 Apr 2022 07:19:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, patches@lists.linux.dev,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] Drop Documentation/ide/
Message-ID: <20220419051908.GA31471@lst.de>
References: <20220419011021.15527-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419011021.15527-1-rdunlap@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 18, 2022 at 06:10:21PM -0700, Randy Dunlap wrote:
> Drop all Documentation/ide/ since IDE support was deleted by
> Christoph Hellwig <hch@lst.de>, Jun 16 2021.

Thanks, looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

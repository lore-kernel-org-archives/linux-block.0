Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8136C67871
	for <linux-block@archiver.kernel.org>; Wed, 11 Jan 2023 04:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjAKE3Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 23:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbjAKE2g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 23:28:36 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA1B13CE7;
        Tue, 10 Jan 2023 20:28:09 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C43C368BEB; Wed, 11 Jan 2023 05:27:50 +0100 (CET)
Date:   Wed, 11 Jan 2023 05:27:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 1/6] block: add a sanity check for non-write
 flush/fua bios
Message-ID: <20230111042750.GA15234@lst.de>
References: <20230110132710.252015-1-damien.lemoal@opensource.wdc.com> <20230110132710.252015-2-damien.lemoal@opensource.wdc.com> <4a278c42-1f7b-f4c2-13c1-06d6fe52997f@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a278c42-1f7b-f4c2-13c1-06d6fe52997f@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yes, I'm ok with the updates to it.

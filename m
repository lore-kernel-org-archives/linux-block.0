Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C57C54EAA
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 06:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjA3GtR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 01:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbjA3GtF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 01:49:05 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8E629E2A;
        Sun, 29 Jan 2023 22:48:19 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B7C868C4E; Mon, 30 Jan 2023 07:48:15 +0100 (CET)
Date:   Mon, 30 Jan 2023 07:48:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ondrej Zary <linux@zary.sk>, Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pata_parport: add driver (PARIDE replacement)
Message-ID: <20230130064815.GA31925@lst.de>
References: <425b5646-23e2-e271-5ca6-0f3783d39a3b@opensource.wdc.com> <20230123190954.5085-1-linux@zary.sk> <d4f7ebd5-d90d-fb96-0fad-bd129ac162dc@opensource.wdc.com> <e843fde8-7295-dd30-6d98-a62f63d7753c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e843fde8-7295-dd30-6d98-a62f63d7753c@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jan 29, 2023 at 08:44:06PM -0700, Jens Axboe wrote:
> I would prefer if we just delete it after merging this one, in the same
> release. I don't think there's any point in delaying, as we're not
> removing any functionality.
> 
> You could just queue that up too when adding this patch.

I'd prefer to just deprecate.  But most importantly I want this patch
in ASAP in some form.

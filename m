Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F1C433EF
	for <linux-block@archiver.kernel.org>; Sun,  6 Mar 2022 10:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiCFKhd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Mar 2022 05:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiCFKhc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Mar 2022 05:37:32 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4A5142486;
        Sun,  6 Mar 2022 02:36:39 -0800 (PST)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 131427A01D4;
        Sun,  6 Mar 2022 11:36:39 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] pata_parport: paride replacement
Date:   Sun, 6 Mar 2022 11:36:36 +0100
User-Agent: KMail/1.9.10
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220305201411.501-1-linux@zary.sk> <20220306085825.GA22425@lst.de>
In-Reply-To: <20220306085825.GA22425@lst.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202203061136.36700.linux@zary.sk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sunday 06 March 2022 09:58:25 Christoph Hellwig wrote:
> Hi Ondrej,
> 
> I just took a quick glance and it seems like the actual protocol
> modules still are basically almost exactly the same ones as the
> paride ones.  Is there a way to just keep the existing modules?
> 
> The only big thing I noticed is the host template, but at least
> for the transitional periode we could probably allocate that
> dynamically in the core.  I think would reduce the amount of code
> churn nicely and make review much easier.

Yes, only small changes in the protocol modules regarding (un)registration.

Getting the original modules work with pata_parport (like in 1st preview) required some hacks that break paride (disabling EXPORT_SYMBOLs in paride).

Maybe the protocol modules can be moved (git mv) from paride and then patched? A copy would be better but there's no "git cp".

-- 
Ondrej Zary

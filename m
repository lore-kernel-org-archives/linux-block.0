Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D51C433FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 07:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiKWHi2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 02:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbiKWHi0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 02:38:26 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE181C923;
        Tue, 22 Nov 2022 23:38:25 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 209F968AFE; Wed, 23 Nov 2022 08:38:23 +0100 (CET)
Date:   Wed, 23 Nov 2022 08:38:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] elevator: remove an outdated comment in
 elevator_change
Message-ID: <20221123073822.GD8328@lst.de>
References: <cover.1669126766.git.nickyc975@zju.edu.cn> <cbf47824fc726440371e74c867bf635ae1b671a3.1669126766.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf47824fc726440371e74c867bf635ae1b671a3.1669126766.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 22, 2022 at 10:21:26PM +0800, Jinlong Chen wrote:
> mq is no longer a special case.

But switching to none still is a special case.  Then again this should
be very obvious from the code, so I'm fine the comment removal:

Reviewed-by: Christoph Hellwig <hch@lst.de>

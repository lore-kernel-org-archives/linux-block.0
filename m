Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F4BC433FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 07:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiKWHhF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 02:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbiKWHhE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 02:37:04 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9714F802A;
        Tue, 22 Nov 2022 23:37:03 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 78F3268AFE; Wed, 23 Nov 2022 08:37:00 +0100 (CET)
Date:   Wed, 23 Nov 2022 08:37:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] elevator: update the document of elevator_switch
Message-ID: <20221123073700.GA8328@lst.de>
References: <cover.1669126766.git.nickyc975@zju.edu.cn> <94250961689ba7d2e67a7d9e7995a11166fedb31.1669126766.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94250961689ba7d2e67a7d9e7995a11166fedb31.1669126766.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

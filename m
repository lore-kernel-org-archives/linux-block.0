Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0326EC38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 07:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJ3Hh2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 03:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJ3Hh1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 03:37:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7065960C9;
        Sun, 30 Oct 2022 00:37:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 355B068AA6; Sun, 30 Oct 2022 08:37:24 +0100 (CET)
Date:   Sun, 30 Oct 2022 08:37:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [RESEND PATCH v2 1/3] blk-mq: remove redundant call to
 blk_freeze_queue_start in blk_mq_destroy_queue
Message-ID: <20221030073724.GB4131@lst.de>
References: <cover.1667107410.git.nickyc975@zju.edu.cn> <3a6d54a5adc8bd09aab28abfbe5f5b02bb863a8d.1667107410.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a6d54a5adc8bd09aab28abfbe5f5b02bb863a8d.1667107410.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -	blk_freeze_queue(q);
> +
> +	/*
> +	 * blk_freeze_queue_start has been called in blk_queue_start_drain, we just
> +	 * need to wait.
> +	 */


This commit is not only pointless, but also exceeds the 80 character
limit.

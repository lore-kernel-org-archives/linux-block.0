Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956FCC4332F
	for <linux-block@archiver.kernel.org>; Fri, 16 Dec 2022 15:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiLPPPV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Dec 2022 10:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiLPPPU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Dec 2022 10:15:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA3A26A9C;
        Fri, 16 Dec 2022 07:15:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4A566212A;
        Fri, 16 Dec 2022 15:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0D8C433EF;
        Fri, 16 Dec 2022 15:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671203718;
        bh=hVmaV8eHCGnDwSv6a5ZKwe06WOILzDouZM8P5zM5OFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6znUTtwqFg4NpDKlwVfpK5BPgC7FYTjMC4aXzX+13Xd5MgiAee20AVVNVaTBYE5z
         KJbW1dIHq2g1GfeWDnOJU6jpYx8ztqR4jJDj+0G5LNIOAprDbROaXA0JXQt5oSwU1h
         tfE8RjUNrsBcaWKd3n/TXnVyJI//0GKrYTBBIxs1okGN1lDkE4fRnlPI61zTTK/W2c
         k//WqpF/oYW+4raxiELhcgWQESiiin35CbWHmBO+H36jGIKbZzYN9rR6nLvpmQqW5P
         lTd7LVVCECDtP80/oYJoPAvunr3l3QwhBB9edmYyJRTDDoz3HLBTA33UdD8412KgQo
         oPRD6OnHheYCg==
Date:   Fri, 16 Dec 2022 08:15:15 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     huteng19901016@gmail.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "huteng.ht" <huteng.ht@bytedance.com>
Subject: Re: [PATCH] blk-mq: fix possible NULL pointer access in classic
 polling
Message-ID: <Y5yLgydd0dk/I7wT@kbusch-mbp.dhcp.thefacebook.com>
References: <20221216150636.18111-1-huteng.ht@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216150636.18111-1-huteng.ht@bytedance.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 16, 2022 at 11:06:36PM +0800, huteng19901016@gmail.com wrote:
> From: "huteng.ht" <huteng.ht@bytedance.com>
> 
> Since poll method in blk_mq_ops may not be implemented by driver,
> add a judgement to avoid NULL pointer access.

Have you actually observed this NULL pointer access occur? Because the
poll attempt should have been abandoned much earlier due to the queue
not having QUEUE_FLAG_POLL set. If a driver has that flag set without
actually implementing ->poll(), though, that'd be a different bug.

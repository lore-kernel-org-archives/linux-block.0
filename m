Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B3FC001B2
	for <linux-block@archiver.kernel.org>; Fri, 16 Dec 2022 16:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiLPQE6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Dec 2022 11:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiLPQE2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Dec 2022 11:04:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6932B275F9
        for <linux-block@vger.kernel.org>; Fri, 16 Dec 2022 08:02:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05A3E62157
        for <linux-block@vger.kernel.org>; Fri, 16 Dec 2022 16:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FE6C433F1;
        Fri, 16 Dec 2022 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671206520;
        bh=axhqR2Sxv4zseMVdzZfXLs/mZ80xRPUTrRIGPcKkSVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=do/IrapbAwT18o17iDkGcbhtYUrpeCgSYCaKHB1/e14Y4ml9/PWKK0QQ9qNqB0wsa
         DOsMFMR9x8PBZr9cUKTdnhhCmCVftDni+z+b0Q6CYL6m4m+M7k/82GBNK8RoxQNjKJ
         8ksSTC8426QuXoZRMjlcpIH/LRe504YCw1aoKpnCWbpB7WWC5ChG8C4FpGdfOX637x
         ZoZvHQydqOpMJeTuKG/B4XmQkUCYYpxRNK3ofjbq3Smk19vUcR986D/sSP/LZ7X33R
         PEZ8U2ilUiQygbfUegJrw9hdoqtDVtMi3PibehEqnrU/ksZkSpt+xxEq2Dv0eadmtu
         w0vwd9wShQrUg==
Date:   Fri, 16 Dec 2022 09:01:57 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH] block: don't clear REQ_ALLOC_CACHE for non-polled
 requests
Message-ID: <Y5yWdc1Bwk1U4JCJ@kbusch-mbp.dhcp.thefacebook.com>
References: <ca1e0bf6-b7fa-5505-3682-2cd122b984be@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1e0bf6-b7fa-5505-3682-2cd122b984be@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 16, 2022 at 08:22:09AM -0700, Jens Axboe wrote:
> Since commit:
> 
> b99182c501c3 ("bio: add pcpu caching for non-polling bio_put")
> 
> we support bio caching for IRQ based IO as well, hence there's no need
> to manually clear REQ_ALLOC_CACHE if we disable polling on a request.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Keith Busch <kbusch@kernel.org>

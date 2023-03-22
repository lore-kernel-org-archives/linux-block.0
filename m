Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0340C6FD1F
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 08:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjCVIdp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 04:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCVId1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 04:33:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62B02E0D2
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 01:33:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F801338BC;
        Wed, 22 Mar 2023 08:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679474005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/hlUx4WQADfM9GBc0qYa0b1Y8Vi/rBflGXQ5fwe8og=;
        b=NNvocjYQ4LDGBfIr+tMtloqdzT0xotmTnpI/AL7P56HtB/IaJn0Kf34TKTcii9vmXEXzh+
        xR/uQMWQEcw3fNf6IDksUbnfBW/C5JLmyAflHg5qaNELflJn5F7Gna6yGW/61d1dW82fkL
        bO7Z6SybcdbZw0tZy7Op34g1XiR9PfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679474005;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/hlUx4WQADfM9GBc0qYa0b1Y8Vi/rBflGXQ5fwe8og=;
        b=NKIcoaVmK7YYFz/B8qH4CQMggyfNQM18IZZ2B9A3buQvnacF+TnC9325Na+c+XH4y0rr5N
        4G8/JT5RZGtFkfCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01BA2138E9;
        Wed, 22 Mar 2023 08:33:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YnVgAFW9GmSwQQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 22 Mar 2023 08:33:25 +0000
Date:   Wed, 22 Mar 2023 09:33:24 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] blk-mq: fix forward declaration for rdma mapping
Message-ID: <20230322083324.sa35d7kotkydoefx@carbon.lan>
References: <20230321215001.2655451-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321215001.2655451-1-kbusch@meta.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 21, 2023 at 02:50:01PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> blk_mq_rdma_map_queues() used to take a 'blk_mq_tag_set *' parameter,
> but was changed to 'blk_mq_queue_map *'. The forward declaration needs
> to be updated so .c files won't have to include headers in a specific
> order.
> 
> Fixes: e42b3867de4bd5e ("blk-mq-rdma: pass in queue map to blk_mq_rdma_map_queues")
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

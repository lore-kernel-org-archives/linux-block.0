Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10892C6FD1C
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 08:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjCVIh4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 04:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCVIhz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 04:37:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710483B228
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 01:37:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DC6FC20B60;
        Wed, 22 Mar 2023 08:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679474267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mWrJnqj4p/7ZROVw3PX58fqmiFYRhPVkQIFcn9g3idg=;
        b=iN7ZwnGPXR8E23tjegIc6MGObr+U7X0OCc4wHBC3HwZSc7Q70weXnFpeELVKx35W3EmB4a
        kJ37AJ4+ta3hboJM4SX4s4TASM7D5Hh/tO7TrQNeuIA4O8n6N6x5mdSW8/83rnlmR+AO+P
        Xn5Lmy1K46+JCcgDVqlLMIpB8OFevh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679474267;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mWrJnqj4p/7ZROVw3PX58fqmiFYRhPVkQIFcn9g3idg=;
        b=+P+Foo7QMzEgC25X5uqPYf52DCms1lCautGD8QR3ZB31nue+gkYk1o77N3zUw9Ib6Ocru/
        plGCzaHy3LYLrPDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE04E138E9;
        Wed, 22 Mar 2023 08:37:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lVhJMlu+GmQfRAAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 22 Mar 2023 08:37:47 +0000
Date:   Wed, 22 Mar 2023 09:37:47 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        Keith Busch <kbusch@kernel.org>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH 3/3] blk-mq: directly poll requests
Message-ID: <20230322083747.ljos4iqkklworudl@carbon.lan>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322002350.4038048-4-kbusch@meta.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 21, 2023 at 05:23:50PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Polling needs a bio with a valid bi_bdev, but neither of those are
> guaranteed for polled driver requests. Make request based polling use
> directly use blk-mq's polling function.
> 
> When executing a request from a polled hctx, we know the request's
> cookie, and that it's from a live multi-queue that supports polling, so
> we can safely skip everything that bio_poll provides.
> 
> Link: http://lists.infradead.org/pipermail/linux-nvme/2023-March/038340.html
> Reported-by: Martin Belanger <Martin.Belanger@dell.com>
> Reported-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

I've tested the whole series and this patch alone with rdma and tcp.

Tested-by: Daniel Wagner <dwagner@suse.de>
Revieded-by: Daniel Wagner <dwagner@suse.de>

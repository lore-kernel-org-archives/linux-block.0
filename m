Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4C1CCA47B
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 11:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiF3Lmf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 07:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiF3Lmd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 07:42:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6162B58FD7
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 04:42:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 109401FABB;
        Thu, 30 Jun 2022 11:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656589351;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QmKWgIw063b5fTYfPAdvZOYvSYVD4qaTzTs73psoTqs=;
        b=N7n/xIzb68Y8pBmG7BEYg2X9gMXFGudFJcJ4HASakca0FqqrgGLYrZYK467gDClRpy/QQw
        VEbpRlpTPcmA2WE3IaZXFTtQQ6tf4xTI1El8my0M9pHiJCYp8pnkUdsrAagxsfxKd1r0m0
        xiQnwM/WbHVV5ahgmI+Bdbwws+g49iI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656589351;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QmKWgIw063b5fTYfPAdvZOYvSYVD4qaTzTs73psoTqs=;
        b=TFd2PnAdf4rLngqdH6SgDTBw1BevI2vyXuex2DlTXZe+4fWQM3nYbXjJ2hbnuBxYsD2cAF
        ESmJ/W7ywmoBf7CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7F23139E9;
        Thu, 30 Jun 2022 11:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id chW/MyaMvWLhHwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 30 Jun 2022 11:42:30 +0000
Date:   Thu, 30 Jun 2022 13:37:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 50/63] fs/btrfs: Use the enum req_op and blk_opf_t
 types
Message-ID: <20220630113748.GA15169@suse.cz>
Reply-To: dsterba@suse.cz
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-51-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629233145.2779494-51-bvanassche@acm.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 29, 2022 at 04:31:32PM -0700, Bart Van Assche wrote:
> Improve static type checking by using the enum req_op type for variables
> that represent a request operation and the new blk_opf_t type for
> variables that represent request flags.
> 
> Cc: David Sterba <dsterba@suse.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: David Sterba <dsterba@suse.com>

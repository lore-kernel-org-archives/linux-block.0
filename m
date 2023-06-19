Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A83EB64D9
	for <linux-block@archiver.kernel.org>; Mon, 19 Jun 2023 07:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjFSHzS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jun 2023 03:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSHzR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2023 03:55:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19560FA;
        Mon, 19 Jun 2023 00:55:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B877B2188E;
        Mon, 19 Jun 2023 07:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687161314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzodxslVWR34FWKTezh8R+HCLqkf9hKJ6nwhZ2cYyW0=;
        b=eNlw2lEdFwRO24qHwcZk6RTiyPfPkFK/qnznneFVO8rBVp3e+AZ/aqo7cxuiWUi7UZx3/u
        vkV2Xoh4sMJjXcH5IJeusAnX5mWTuVn8oi5gpUC4jlQYE+YlD/QdEUarmKV36IYMkRGmVb
        scGcJ9MfBs7nhXYSgMCL6L2HxVXQ96Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687161314;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzodxslVWR34FWKTezh8R+HCLqkf9hKJ6nwhZ2cYyW0=;
        b=5dGQ0ErR9rr16jt9qdW7WZcepprWjTCTT6S4BuS9s9Siz9XZJXBmmJ4JbJ68RjM0Wj1Dsm
        qnkil/Q7ipU84tCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A99C3139C2;
        Mon, 19 Jun 2023 07:55:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3PtfKeIJkGRQBgAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 19 Jun 2023 07:55:14 +0000
Date:   Mon, 19 Jun 2023 09:55:14 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH v1 0/2] nvme-fc: Fix blktests hangers
Message-ID: <iek6a3eegnjirapsuw2jtptxttgor2e4bvoljlr2swqwzagso5@b7k5kq6j2ab2>
References: <20230615094356.14878-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615094356.14878-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 15, 2023 at 11:43:54AM +0200, Daniel Wagner wrote:
> A couple more fixes to enable blktests for the fc transport.

I let run blktests in a loop and eventually the unloading of the fs module
blocked again with

      nvme_fcloop: fcloop_exit: Failed deleting remote port
      nvme_fcloop: fcloop_exit: Failed deleting target port

So the reordering of the module unloades in blktets just made it a bit harder to
hit but it's still possible to hit this. So we should also consider

https://lore.kernel.org/linux-nvme/20230418130159.11075-2-dwagner@suse.de/

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A605C25B5C
	for <linux-block@archiver.kernel.org>; Thu,  6 Jul 2023 00:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjGFASZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 20:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjGFASW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 20:18:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935A619B7;
        Wed,  5 Jul 2023 17:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12863617ED;
        Thu,  6 Jul 2023 00:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 123E5C433B7;
        Thu,  6 Jul 2023 00:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688602695;
        bh=n19H1bNzyKgXIdlxXeVLq/pVMrGObknKs8lwRwrUP90=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=L0+ViUP6R7pGw/hqVLlqlhVenRrVaizDIJiQDp1b5Nqfi/6MgrNNXgX5VOirFTZr7
         7G2hYmfDpiRL3WvTUeFd59G3OFJRltfq5vjRmdiVeXUDS5iHVk94kuNxgIJvLWauzz
         mOXsaxvGRndBuMlcYOA8xzWMF3/drk2LGQqLXrTBzoBBoUMHRSS+fdSjOaMH2sFyQ7
         P1CSil5dqpGkX8VsubftoxF+dV2Wq47plE0wRTG6SzKcnFMWZkgMxW8aXW/6GWn+fb
         YyXFEztb5MEZ+ZIIluSVdTxp0rAQnRWpkjk3UZcTo8t6giHCCuMHOnirYJ77EyxIf9
         LhoISi3RR/cJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA85AC691F0;
        Thu,  6 Jul 2023 00:18:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v22 19/31] f2fs: Provide a splice-read wrapper
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168860269488.29151.5197726531516627453.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Jul 2023 00:18:14 +0000
References: <20230522135018.2742245-20-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-20-dhowells@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, hch@infradead.org,
        linux-block@vger.kernel.org, hdanton@sina.com, jack@suse.cz,
        david@redhat.com, torvalds@linux-foundation.org,
        jlayton@kernel.org, brauner@kernel.org, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgg@nvidia.com,
        linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, logang@deltatee.com,
        hch@lst.de
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jens Axboe <axboe@kernel.dk>:

On Mon, 22 May 2023 14:50:06 +0100 you wrote:
> Provide a splice_read wrapper for f2fs.  This does some checks and tracing
> before calling filemap_splice_read() and will update the iostats
> afterwards.  Direct I/O is handled by the caller.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Jaegeuk Kim <jaegeuk@kernel.org>
> cc: Chao Yu <chao@kernel.org>
> cc: linux-f2fs-devel@lists.sourceforge.net
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-mm@kvack.org
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v22,19/31] f2fs: Provide a splice-read wrapper
    https://git.kernel.org/jaegeuk/f2fs/c/ceb11d0e2da2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



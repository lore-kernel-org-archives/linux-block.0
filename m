Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C92C3DA66
	for <linux-block@archiver.kernel.org>; Fri, 25 Aug 2023 12:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjHYMcB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Aug 2023 08:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244875AbjHYMbh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2023 08:31:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C4126AF;
        Fri, 25 Aug 2023 05:31:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76B0B67B95;
        Fri, 25 Aug 2023 12:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8004C433C9;
        Fri, 25 Aug 2023 12:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692966625;
        bh=YllMQsUv14IXcAV5eXi5Bkkkb4eHZRqaRVsvNBAoLlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGsV9oyBhqmEqmboUScP7GRsXXfMR9TqANIi5mr5dUFcT65MSCDGKtuxy2CS54cH1
         cqRJ29ZmcwRtuClxZx1FFk2vGFa8ZmPDLwkwpzl8Dp9LixE/E3bzwfi2a7jw4f7SO6
         Jhhg9hNJ+pf+Aln4mJxUMvAkp7V7PVNmieW+z0J91Hbjv6CStPv2g74s+XzJGxwGW2
         GUOeS2AzXpgWXl7CYpZxWDdTtkYCRnaMhGP1KxD3oEhJ9cRdo+pYnkZ4XBJG1Q4XxV
         bnjbLCNqqmsfHvBB6WDXzmEmdtXpYV2Zfl1XnqC4Rqx1plNlqUjOUFEq4sGYqWftex
         slovSrrs/SCCg==
Date:   Fri, 25 Aug 2023 14:30:21 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 23/29] f2fs: Convert to bdev_open_by_dev/path()
Message-ID: <20230825-kaschieren-gespreizt-7d246803ae8f@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-23-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-23-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:34PM +0200, Jan Kara wrote:
> Convert f2fs to use bdev_open_by_dev/path() and pass the handle around.
> 
> CC: Jaegeuk Kim <jaegeuk@kernel.org>
> CC: Chao Yu <chao@kernel.org>
> CC: linux-f2fs-devel@lists.sourceforge.net
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

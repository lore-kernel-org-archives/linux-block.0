Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D3FC7EE2C
	for <linux-block@archiver.kernel.org>; Fri, 25 Aug 2023 12:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243402AbjHYMcc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Aug 2023 08:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbjHYMcB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2023 08:32:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6545C2117;
        Fri, 25 Aug 2023 05:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 449B967B1C;
        Fri, 25 Aug 2023 12:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4995C433C8;
        Fri, 25 Aug 2023 12:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692966692;
        bh=xeeE9OL56szUlQkfE3YZ9y93xazUihAuaZdpblcR+s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rYxUt/BNCSb8buvXjaAcup2J1SslDw1TyEcVw0oiLcLcsLdknXXkP8H2XqQgoScPa
         1lmK2CmQ2xFjJxsG4hLP6xL0Xmkr8o8Sj/APOKnOq9h9+Rcz9ClQn9PYhms1g07+8X
         xy8GRvz45I+NOyAIUG0dL3a7fT9YvAWMajZd1FIYzSJH/xg8wy3ZXjkDansQY6jvSM
         0LdryvUEWBthmCJ1VEX/OPc6HQzuaRc1gLY7qtH61GajBIXvJ7YpdHiESh0V1ev8yl
         InZHsBWQnm3Ph138e17lvinJpfHew3I4JudLlcv5C8PhY1kz5b+2ZNneMZG3ImGsul
         ACFN3zmFmGZXg==
Date:   Fri, 25 Aug 2023 14:31:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH 24/29] jfs: Convert to bdev_open_by_dev()
Message-ID: <20230825-autark-irrgarten-2e76ee966762@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-24-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-24-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:35PM +0200, Jan Kara wrote:
> Convert jfs to use bdev_open_by_dev() and pass the handle around.
> 
> CC: Dave Kleikamp <shaggy@kernel.org>
> CC: jfs-discussion@lists.sourceforge.net
> Acked-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

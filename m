Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C900C3DA6F
	for <linux-block@archiver.kernel.org>; Fri, 25 Aug 2023 11:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244121AbjHYL45 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Aug 2023 07:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244484AbjHYL4t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2023 07:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0BF10FF;
        Fri, 25 Aug 2023 04:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A037E6146C;
        Fri, 25 Aug 2023 11:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690DCC433C8;
        Fri, 25 Aug 2023 11:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692964607;
        bh=YCgx9U87vcM/sPt5nfivx+zm1TRjhU2OgXFV2oyUhfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YANaZq+Nab+4jPdlv9xZhGF68npY0UWCfbof63kV9MggkKvzsoBNQxKCZCrG9L1Bn
         CAdn3RzlduIuIrAnNU8IxZdD2fFjPxNqNLI/1fGYuBe1wRSV6sZ6p8kdbvchE4dCWA
         62yFhvG6u8WPXSdW0oQPAIsXOqBK+MPtWDMHAORo4MuXtZeVC8gOaxSyeNqJxNNZXF
         TbH88JMcZ7cONOUtJ+qxK+1nRoT0t7JCgMQHZd14VZbtO6lyJNpH44CsPJ/OCFWwH6
         bCJZbMf26MAuMr0oB6qUIyRcBXWxkoU0xmqGmIeoTZES+EvYdzXfaflTKlanU2y4uE
         7vCUlKsUilz7Q==
Date:   Fri, 25 Aug 2023 13:56:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        xen-devel@lists.xenproject.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 07/29] xen/blkback: Convert to bdev_open_by_dev()
Message-ID: <20230825-flatterhaft-zugluft-557515f1b2e7@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-7-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-7-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:18PM +0200, Jan Kara wrote:
> Convert xen/blkback to use bdev_open_by_dev() and pass the
> handle around.
> 
> CC: xen-devel@lists.xenproject.org
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

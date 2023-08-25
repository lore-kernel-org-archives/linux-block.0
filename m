Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFCDC3DA66
	for <linux-block@archiver.kernel.org>; Fri, 25 Aug 2023 12:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244872AbjHYMgR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Aug 2023 08:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244976AbjHYMgL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2023 08:36:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2D22123;
        Fri, 25 Aug 2023 05:35:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0C9261381;
        Fri, 25 Aug 2023 12:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC29C433C8;
        Fri, 25 Aug 2023 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692966958;
        bh=WZhoQI4SQ1PkbMB0aQ3u5RKKO+ivrApvlEQUhSgI2bU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fb4oA3BIKH0w6JdT8obpdFYBfAKO79ukbitfPKI8nSPsDvooi3n+NuOedn+xWwZxO
         ZLxAv88KK12XJeUexGBxB5y5/9YxYdrtV2Kv9Vc0Ybs+W4AAGuxtMJOy+r0vb9dDsu
         lPcZzngxZtx2dffbxrVHbbLJSv4Ux+nNpZg6GViwVJxGGHV7yneA08Uyxkl4pOEPYt
         45fOoqFJRnaE35hC5muBwEjbJwEy0UVeDD/5fvAXewJWdmaKA4Ywa8nnTKSLk52A1i
         vtLymw/+8tV9nfn1STihYzk1GSY6DNbGKFBYvpa//x/za9HHgOCkdY283bCYa+mPwY
         YgB6SNPb/S+gQ==
Date:   Fri, 25 Aug 2023 14:35:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        reiserfs-devel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 27/29] reiserfs: Convert to bdev_open_by_dev/path()
Message-ID: <20230825-umjubelt-denkmal-692a41dcd900@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-27-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-27-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:38PM +0200, Jan Kara wrote:
> Convert reiserfs to use bdev_open_by_dev/path() and pass the handle
> around.
> 
> CC: reiserfs-devel@vger.kernel.org
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

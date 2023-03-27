Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDF2C77B61
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 15:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjC0PaA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 11:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjC0P37 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 11:29:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D225DC2
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 08:29:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D4166130B
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 15:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A85BC433D2;
        Mon, 27 Mar 2023 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679930996;
        bh=Xgtuhef4jyW2cgWrSnfZWnXDNN/zG9DkTw9F06RZcJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAyJJC5zXCo43xGgrJmkH+9sAYCguC/EtXKclwU0CerLyucQYI37wM37/HlRVV0/B
         mvSwjsBWrsC0HKY6XePoaIjUOREhY3BCO0uBKVtqFmSsYkJXdrxYF6oUstRc/COKqB
         ODux3ROTJHXhF16lWj51qMbL7tTXi/ZfpKiBBixu+wJBIgVcD5auDU2fmx8p0gHsei
         w5Mhl5/XgoubdIYEoDU6aFQzBJzF7Htd2R8Iljkw75hRuzS19MvqZghhWQwRK26ASX
         HlXoJBipwTP1D6o77rDydfDBHQ3Zjha+sd/qnMf7HGgV4lCek3jE9mH8XWMISyNMyj
         ogPfS0BwqLdmA==
Date:   Mon, 27 Mar 2023 09:29:51 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
Message-ID: <ZCG2b85hN+pTm/VZ@kbusch-mbp.dhcp.thefacebook.com>
References: <20230324212803.1837554-1-kbusch@meta.com>
 <20230324212803.1837554-2-kbusch@meta.com>
 <55f9c095-32c2-648d-7ac9-84c1d9224abb@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55f9c095-32c2-648d-7ac9-84c1d9224abb@grimberg.me>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 26, 2023 at 04:01:46PM +0300, Sagi Grimberg wrote:
> On 3/25/23 00:28, Keith Busch wrote:
> > +	if (blk_rq_is_poll(req))
> > +		WRITE_ONCE(ioucmd->cookie, req);
> 
> Why aren't we always setting the cookie to point at the req?

As in unconditionally set the cookie even for non-polled requests? We need to
see that the cookie is NULL to prevent polling interrupt queues when an
io_uring polled command is dispatched to a device without polled hctx's.

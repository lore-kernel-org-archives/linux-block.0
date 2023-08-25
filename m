Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5230DC3DA6F
	for <linux-block@archiver.kernel.org>; Fri, 25 Aug 2023 11:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbjHYLsR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Aug 2023 07:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244362AbjHYLrx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2023 07:47:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1A12115;
        Fri, 25 Aug 2023 04:47:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5443967A8D;
        Fri, 25 Aug 2023 11:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2880DC433C7;
        Fri, 25 Aug 2023 11:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692964068;
        bh=Q12a5jCz9Y05UL3JyEMUoFRHg2W/veTXXFw53T4To0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdqC2q3MBCTgc/LCSWxDLqKCnlnMJwSZMWopIfxVw8QRhexqNvrhMokF9/aF2T2sV
         aLvff3AaOYfUQ2kixfYl4Q+xFzOHQWqsN6mhEVAhDBUJ3AB2zNdylPFJw81co46/eJ
         ubCZvGOHTyj7yBsG4woSipWDT9fVuOhKhO2sgW97DPSe4zlTMloFO06S70bffktE6q
         TresDfl9aKiRAB+i0ODQxH6D4Hua4Y108CE4XUjEi6T3MQXSGCSxeRVQEOPricPCKR
         Okyu9WQUeuV72ZWK7NFp6rGTXiCNBjMxbze9gBrkF480B6nD/PCKIPsAamy87RgDTr
         oWLvv+23o6COA==
Date:   Fri, 25 Aug 2023 13:47:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        drbd-dev@lists.linbit.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/29] drdb: Convert to use bdev_open_by_path()
Message-ID: <20230825-neubeginn-kannst-cdb8a45263f7@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-4-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:15PM +0200, Jan Kara wrote:
> Convert drdb to use bdev_open_by_path().
> 
> CC: drbd-dev@lists.linbit.com
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828C4C3DA6F
	for <linux-block@archiver.kernel.org>; Fri, 25 Aug 2023 12:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjHYMMd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Aug 2023 08:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244564AbjHYMM0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2023 08:12:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A352199E;
        Fri, 25 Aug 2023 05:12:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCD8665279;
        Fri, 25 Aug 2023 12:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35F5C433C8;
        Fri, 25 Aug 2023 12:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692965543;
        bh=M3cpTHOb+iXz0DwXB5N8EGyNvTPaJrfg/BGZSnD8hzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fvspKuGVkdo0pbXROBUOk3J6Ql0juVzHlQErFSucYWbLrpR4NQFpQfaL+z07nPHPG
         dZDIFr8dAHPMt36SX+bDOeU1Yx5789p/E4PFcCV8TsY0Xq6bs5NX94a9V+IYGwFa1p
         1aJfyy0A6ClZRNwsJXR8sgFui1QhfJ5XzZf8PTDg/MnJJ4jVF1G4FD9HWAQ2gyOjPh
         6qbNF0n5pweHIl6KVKiR3VZ7f/TzIiHi9S7F0o2nnx2kS1DQMbNso96zZsW7yJ/Jcv
         uMHobIaE9uOsjsAN5fkRi7tGp1Tml1hmAxU0S75odNjtGcKdkFDlyfV9DkLJmhWyGl
         fTxg5DOTG3RPQ==
Date:   Fri, 25 Aug 2023 14:12:18 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 13/29] nvmet: Convert to bdev_open_by_path()
Message-ID: <20230825-argwohn-befallen-9485f981c8c9@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-13-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-13-jack@suse.cz>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:24PM +0200, Jan Kara wrote:
> Convert nvmet to use bdev_open_by_path() and pass the handle around.
> 
> CC: linux-nvme@lists.infradead.org
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

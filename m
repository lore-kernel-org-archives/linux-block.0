Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235ADC3DA66
	for <linux-block@archiver.kernel.org>; Fri, 25 Aug 2023 13:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjHYN3j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Aug 2023 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245125AbjHYN3U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2023 09:29:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E08A2133;
        Fri, 25 Aug 2023 06:29:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9A6564C8A;
        Fri, 25 Aug 2023 13:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0DEC433C7;
        Fri, 25 Aug 2023 13:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692970155;
        bh=Kbv8RLcnybXhh3ttzFimO6pE4mxcaj6dzrHQVawJyzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=grIN7LIZkkYNWjyPZ9wdNShrKsqLEIxiD5DA3+05miHUlznDEQvH6Ktel0RIvZJgB
         CztgbPtF7RajFgnZTBM6aCApgzPh4WjpTkn9RI/WaL6nfENdcFY+VvwcBEvrU8REcI
         jU7kswT1Y5isPklQedJ4jvAZk4WPCYblBejr0UeaEZQdZVZxUyGhb9ATeoPLrxs6TY
         c9mfg9z/yGL4GkSfw4Jym2O1Wi3molOOvrFenW6NQoAOxxGQt7RBoo2/qoP9KWE8G/
         LZsjTP4epY1sOategbyVfag4i58nTNWlrlKS73KCdis+EFvhVLNymbILXjvlTBseGS
         kqrFlqYtNShmg==
Date:   Fri, 25 Aug 2023 15:29:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/29] block: Use bdev_open_by_dev() in blkdev_open()
Message-ID: <20230825-attribut-sympathisch-6dfddfe25f45@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-2-jack@suse.cz>
 <20230825022826.GC95084@ZenIV>
 <20230825094509.yarnl4jpayqqjk4c@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230825094509.yarnl4jpayqqjk4c@quack3>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> file->f_flags. Attached is a version of the patch that I'm currently
> testing.

Appended patch looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

The patch also has another fix for O_EXCL. In earlier versions of this
patch series it relied of f_flags. Thanks for that comment you added in
there about this now. This really helps given that O_EXCL has special
meaning for block devices. Ideally we'd have kernel doc for
file_to_blk_mode().

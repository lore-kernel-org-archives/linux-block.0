Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C78EB64D8
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 10:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344895AbjFPKyJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 06:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345308AbjFPKxy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 06:53:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901E36EA7;
        Fri, 16 Jun 2023 03:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE19461A32;
        Fri, 16 Jun 2023 10:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5081C433C0;
        Fri, 16 Jun 2023 10:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686912344;
        bh=lWIOpJRwWlscUy/iaU7h7f9Lc9Cypdj9DNjGiQ3mPMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDvhcUMxz/8szRKlzAJxt7NuaeKZyT5bo3D9EkEtzke2KQnZGRxJjqn9oXVIyenig
         KjV8hUESbTOAFHdcaOakZYG9aKaZhPe0HSB08IDlJ8aSOO2WVs2O0gAl2PKsdvcYD4
         0+kH/bYbz4BX0aYliPHk7GhRjXwY0JRcSaGKif9w5qKNrYUS27zF4jTvOf2cSZBFPV
         tCs3DA0mViXHnY/aFdA4ZvDkk7LtnsMq9h6e21+pNF1KUkIUIUvHKdNelfWatH/1gP
         fhAEru5COjK6zMaJhgYN9eRvgv9wG3tuxSnXIGhnrc7OMfC7jivERSnGe/vXeJkKbE
         IwgO2H+FesHrg==
Date:   Fri, 16 Jun 2023 12:45:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] splice: don't call file_accessed in copy_splice_read
Message-ID: <20230616-vielfach-seehund-f7ba6a05c603@brauner>
References: <20230614140341.521331-1-hch@lst.de>
 <20230614140341.521331-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230614140341.521331-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 14, 2023 at 04:03:38PM +0200, Christoph Hellwig wrote:
> copy_splice_read calls into ->read_iter to read the data, which already
> calls file_accessed.
> 
> Fixes: 33b3b041543e ("splice: Add a func to do a splice from an O_DIRECT file without ITER_PIPE")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

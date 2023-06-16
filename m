Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA17EB64DA
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 10:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345555AbjFPK5D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 06:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345522AbjFPK4p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 06:56:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDE93C2D;
        Fri, 16 Jun 2023 03:48:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA9B762134;
        Fri, 16 Jun 2023 10:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84F6C433C9;
        Fri, 16 Jun 2023 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686912529;
        bh=zJoq3wQX3ovbhIc5OKGVYEKFikOCP2u1EuDaSV+Qb1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oyZU4KcbEAIIansQQ/f5Vg9gIBjh4BlE2oc0Vyw0NLqdoQuvEwaxNtqI++c8hWuAD
         vhBrC1+2ZAkH5D0PMJYXA4K4fhwfM5Tvs8RSvAituAqtULxZ/+UJVXqfr7VJFQNOd6
         ytW0blcdu3uFDaTtaZTOudfEJd17VE1y167CZhyCRcdfeqPSJstyXpjcRojtV6X7BJ
         +6OSEPMpMa0vDQKNDmPGUhbk3kTf9uZK9WD7C1eQ0W+28MKZQ8b11Iit4Nqjsee6hF
         Dsd1HpkcktzHVnLKRGPjWUgwjG6l2k0NSBmTS0zWzxtxtI3210QklAzCVx/32f4YyF
         xL+yeqR8sO1Ig==
Date:   Fri, 16 Jun 2023 12:48:45 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] iov_iter: remove iov_iter_get_pages and
 iov_iter_get_pages_alloc
Message-ID: <20230616-ladung-fundort-262df0f58fb4@brauner>
References: <20230614140341.521331-1-hch@lst.de>
 <20230614140341.521331-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230614140341.521331-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 14, 2023 at 04:03:41PM +0200, Christoph Hellwig wrote:
> Now that the direct I/O helpers have switched to use
> iov_iter_extract_pages, these helpers are unused.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

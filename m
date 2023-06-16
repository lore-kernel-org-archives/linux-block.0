Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43054EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 10:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345527AbjFPK4C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 06:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjFPKzt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 06:55:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C43768D;
        Fri, 16 Jun 2023 03:47:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E962363861;
        Fri, 16 Jun 2023 10:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFE7C433C9;
        Fri, 16 Jun 2023 10:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686912453;
        bh=1OsNVW6dmfZVZ5/KisSfPWg/TytGKk/p9FQ33yPckTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PuJqlQaDE/LWEAS3//0SJwYS5ollfei1PsPdfQmiIHH0OnNvrVEIurkQDzQNI2Vsh
         jGqlkg73z3tTkdH9lPlT9szYJhbcCnySVuf6zEXu+xTg9vitQ8LmVF5HdtEeB36qlv
         0ArZNixzaJvnsqZXSIlozgozKLo225Q0TYUpUqDuNi1y8m5KP+cS7yjxVl8IDMbXIV
         FKQgWvTunLrQjEsskxQHyx5Dm12xu+/iT6WXd0MnY0XdjI17hv55f/rzex2Ni2CPI6
         h/Y7hecnSpSBU0hSMYN5LuA2HdE45aApRIBfn2vN/9R+jlgKBjo+NtkOxZz6VgKfgh
         VyQTCMxbGa4Wg==
Date:   Fri, 16 Jun 2023 12:47:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] block: remove BIO_PAGE_REFFED
Message-ID: <20230616-beackern-allesamt-e391d3c800b1@brauner>
References: <20230614140341.521331-1-hch@lst.de>
 <20230614140341.521331-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230614140341.521331-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 14, 2023 at 04:03:40PM +0200, Christoph Hellwig wrote:
> Now that all block direct I/O helpers use page pinning, this flag is
> unused.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47609C74A5B
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 15:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjC2Pb3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 11:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjC2Pb2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 11:31:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB9135A2
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 08:31:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 562FB61D34
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 15:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D580CC433D2;
        Wed, 29 Mar 2023 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680103886;
        bh=CS6yDeQEWMi5IlVwuFbuJoT81F27QT5zA6drWZ1wHY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehcYc4knP++X6jzs2E2yVfpu24J2CsTpygaM5jij8xFeue3i9RLA/1bd5os6giwoe
         qVeeHwqsJQYD6blseCY7jNzUFSJMj0sfc7wqG4nO04p1GG893wsBBpGUz6h2tE8ZBM
         F+2mlmgdVxAbYFUbDsIXzNPxjatGdPIFEEAjgyi/gxwKAg3Xp2fCJRHRgdLtfXxcNZ
         0L8zMdfTYlYuueFcdNliJCEXTKsXmJSbif3VwPysw5VmdX1ycLzOYs8fv8NYAqTBnO
         huTMLqf8VAHiSfpEdO6j2YElvk4DEVsvnmL0+3FW2OoxEVZA7rgXcje5uNiWC+Otqi
         P0qg/bbOTDn9w==
Date:   Wed, 29 Mar 2023 17:31:21 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ondrej Kozina <okozina@redhat.com>
Cc:     linux-block@vger.kernel.org, bluca@debian.org, gmazyland@gmail.com,
        axboe@kernel.dk, hch@infradead.org, rafael.antognolli@intel.com
Subject: Re: [PATCH 3/5] sed-opal: allow user authority to get locking range
 attributes.
Message-ID: <20230329-line-flogging-093cc9133cda@brauner>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230322151604.401680-4-okozina@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322151604.401680-4-okozina@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 04:16:02PM +0100, Ondrej Kozina wrote:
> Extend ACE set of locking range attributes accessible to user
> authority. This patch allows user authority to get following
> locking range attribues when user get added to locking range via
> IOC_OPAL_ADD_USR_TO_LR:
> 
> locking range start
> locking range end
> read lock enabled
> write lock enabled
> read locked
> write locked
> lock on reset
> active key
> 
> Note: Admin1 authority always remains in the ACE. Otherwise
> it breaks current userspace expecting Admin1 in the ACE (sedutils).
> 
> See TCG OPAL2 s.4.3.1.7 "ACE_Locking_RangeNNNN_Get_RangeStartToActiveKey".
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> Tested-by: Luca Boccassi <bluca@debian.org>
> Tested-by: Milan Broz <gmazyland@gmail.com>
> ---

Seems fine,
Acked-by: Christian Brauner <brauner@kernel.org>

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFF3C77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 22:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbjEWWOw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 18:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjEWWOs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 18:14:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2349BF
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 15:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DCF762865
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 22:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEDDC433D2;
        Tue, 23 May 2023 22:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684880086;
        bh=9a68yYtMPcirKceLGMSE5Hy6UeDQXTstorCorrv5SAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htpelhHzUeD0o5bLiqjrs6Ap+9cOvQHQ8thenSbpuy6XTy0RCccgCDcMjFD6sZqyw
         Am0ArWfNu8hXy5A8lGOy/id7+4aPlR+HwffwmyARGa7ZeRk20PDSaUNpUjeXatqEST
         o5BTWgrwkUNAyuSHhlKrb6LKqVMn+v+hnZbT7JU6+HtfDQrPUw21lTDNSWUYFsPUw4
         U2Q+UTLkFc9Q7pXdahUFaYlWZjh8vJbBK2T6TJ9k8e6qf/pgiSxEDIPKRmSRCngVuE
         jF7HJ5mrFP7VptahCY2nYP0HKD+QKp8q6pv0Gw9R9652jrihQ1jvCSVe7ErWG44EuY
         DnRg6wGh49uqA==
Date:   Tue, 23 May 2023 22:14:45 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "J. corwin Coburn" <corwin@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        vdo-devel@redhat.com
Subject: Re: [dm-devel] [PATCH v2 03/39] Add memory allocation utilities.
Message-ID: <20230523221445.GC888341@google.com>
References: <20230523214539.226387-1-corwin@redhat.com>
 <20230523214539.226387-4-corwin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523214539.226387-4-corwin@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 05:45:03PM -0400, J. corwin Coburn wrote:
> diff --git a/drivers/md/dm-vdo/memory-alloc.c b/drivers/md/dm-vdo/memory-alloc.c
> new file mode 100644
> index 00000000000..00b992e96bd
> --- /dev/null
> +++ b/drivers/md/dm-vdo/memory-alloc.c
> @@ -0,0 +1,447 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright Red Hat
> + */

Copyright statements need to include a year.

- Eric

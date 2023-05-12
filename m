Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4E8C7EE23
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 14:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbjELObX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 10:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241216AbjELObT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 10:31:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C1F14352
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l/fNiN/iPqi0pRfMs7BY4vSy+wD6QuWHuuRxGVgNQmY=; b=eMO7okyX4GMeO3Z59tlFZq9ecx
        bpwSZFL0gxO1rXLHt6gvmjbIah9mXDIfGis5hq3gDIj7s/Tzb4O6NwVK1c61QKPWpjO8sfxogcKow
        WJTaUehYIShW7IS9dINdye9nq/RZaa2pnGwk9DTmKAVJa8WShHx50lfOK7hHjUAoqSHn3W/b3E2li
        dyKhTIOOosGXUD5IXHskqgLU4YpG8o0WrKynkFy27PDwBcgJ292PnX6OAD0m07xxt4Gknin9FVXXF
        oeiQxjw6A5al0rn7sqbWEyQ4SKiFn1OZMR7ytE6gfO6oxiCeGTqrKCxsvCD4n4wLSbI2rbBrIRD4m
        0c0/dHNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pxTne-00CBPW-2U;
        Fri, 12 May 2023 14:31:14 +0000
Date:   Fri, 12 May 2023 07:31:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] zram: allow user to set QUEUE_FLAG_NOWAIT
Message-ID: <ZF5NssjIVNUU9oIA@infradead.org>
References: <20230512082958.6550-1-kch@nvidia.com>
 <20230512082958.6550-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512082958.6550-2-kch@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 12, 2023 at 01:29:56AM -0700, Chaitanya Kulkarni wrote:
> Allow user to set the QUEUE_FLAG_NOWAIT optionally using module
> parameter to retain the default behaviour. Also, update respective
> allocation flags in the write path. Following are the performance
> numbers with io_uring fio engine for random read, note that device has
> been populated fully with randwrite workload before taking these
> numbers :-

Why would you add a module option, except to make everyones life hell?

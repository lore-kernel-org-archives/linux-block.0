Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD61C43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 06:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbiFOGSu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 02:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiFOGSu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 02:18:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92665220C5;
        Tue, 14 Jun 2022 23:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rQwWDOk1Ek8zy1OBl1F+0AXgLUzVzQYKZPN8/Z82aqU=; b=F4AyYAO+fhSl4fozyxP+wCmf4A
        +rmuTeJrUzZGAs5q5Tidvwg3Hef342hpE/2CVW2L/1j29EcTiwCXIlDs728azaQN8/wpjbIl0Yzmh
        w1cmDGx0oF9llw/EhoKmiO36sNNXUbpo+MhgQV4nsOxK/s7JzwueFONQbiZVwMYnQY4xp9pAzY+3+
        ocEeifSDHo9wf00a2ZON2dmp7RI7xieBwgzInXNoZeVUg7Si1I5vXS/J7MlqRC2jET/ShAnIdqcdV
        3j1cQm0IlrqNouYrRp747W3jrkoAFm6Ft6720efZ4+aY51HmpG+eEkVbot1pK4pGpbURWd9x3GFi1
        GrTxf3dg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1MMU-00Cq6h-22; Wed, 15 Jun 2022 06:18:42 +0000
Date:   Tue, 14 Jun 2022 23:18:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: update comment for blkcg_init_queue
Message-ID: <Yql5wrthJvZDwWjq@infradead.org>
References: <20220614100556.20899-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614100556.20899-1-guoqing.jiang@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 06:05:56PM +0800, Guoqing Jiang wrote:
> It was called from __alloc_disk_node since commit 1059699f87eb ("block:
> move blkcg initialization/destroy into disk allocation/release handler).
> Let's change the comment accordingly.

Well, the right things is to simply drop this comment.  I do have
a large series toucing it and removing it, so maybe we can wait
until that?

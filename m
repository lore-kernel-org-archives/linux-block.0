Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99B4C4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 18:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiJRSRt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJRSRs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 14:17:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040587D1FF
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AqJ0v0hhWU7bzKshJrvn579bKb31i80AclR/mDSMXJo=; b=SGDjpWATMVzh/pbCUrefeFdPR3
        Jo2+g5toaGqCPCKiA/4iJzwggRpKDJnBLXuOtQPH10gThWpbWYVKQIo57mZQZEvQSoVbyFogJUC3w
        8ifeTiMaNLzkY4M2z61hXIlTYfQtECUbzK/WTh68RFL53hDmiRBvDYta4t0fWD7DoTBXC/YCJveto
        bfBhqYttUsoTM6tU2hMR2ox0Oh7xEDOqoHz7vDt9bIsfmUF9Cf1g2ANPFaBmNra+/xBBgumc8Ty6D
        5tOHdPxsUSEsswU1hvlGM+9UQTK1/xbNay/LQ9y0j4uzB6uzs544LcfCWVFlaFnGTTU4WSbUmVXUS
        qogy+R8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okr9l-009r0R-62; Tue, 18 Oct 2022 18:17:37 +0000
Date:   Tue, 18 Oct 2022 11:17:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: Re: [git pull] device mapper changes for 6.1
Message-ID: <Y07twbDIVgEnPsFn@infradead.org>
References: <Y07SYs98z5VNxdZq@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07SYs98z5VNxdZq@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18, 2022 at 12:20:50PM -0400, Mike Snitzer wrote:
> 
> - Enhance DM ioctl interface to allow returning an error string to
>   userspace. Depends on exporting is_vmalloc_or_module_addr() to allow
>   DM core to conditionally free memory allocated with kasprintf().

That really does not sound like a good idea at all.  And it does not
seem to have any MM or core maintainer signoffs.


Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA44C25B0F
	for <linux-block@archiver.kernel.org>; Sat, 13 Aug 2022 07:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbiHMHPu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Aug 2022 03:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMHPm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Aug 2022 03:15:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D5D4B4BF;
        Sat, 13 Aug 2022 00:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vYYon2uzzpmLpiYSbuG/TOWLg7+Nuk3SA0Hqh/kQ1zI=; b=Bod9/1VIzvLLwlBHl5Qblw6+qZ
        Fvz//Xng5Sz65C9TbnWlLiHopKBfL4BQShqd/zc1jsSF1GIKWvkJrVn7VLzPwOPIpD7lE0gSChDOM
        kLscXAPwN1193FjAGTWHYQU47ZcgQv2qEdNpm+mtlNdjhMOwuhq8MkFs8nzRMu3DofKSvT8gYm52P
        SiAHnLKOLC0FWU/+3eExWeCas+qnKh87lNhk/HZkrhDc5m/FGzwWvTlPLnLDpPv+dtieasGnzVL8W
        CgfEqdES2vXxbTa/CeS7EO3vKrqFv687jFPCZSeWVtSIzXW1uPgxh/3X4NlAi6pSAsOe3vYXN26cB
        IW699G/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMlMq-009Dgs-HE; Sat, 13 Aug 2022 07:15:32 +0000
Date:   Sat, 13 Aug 2022 00:15:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] fs: fix possible inconsistent mount device
Message-ID: <YvdPlDPX82NsC6/d@infradead.org>
References: <20220813060848.1457301-1-yukuai1@huaweicloud.com>
 <YvdJMj5hNem2PMVh@infradead.org>
 <230cf303-b241-957d-f5aa-5d367eddeb3f@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230cf303-b241-957d-f5aa-5d367eddeb3f@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Aug 13, 2022 at 03:09:58PM +0800, Yu Kuai wrote:
> Thanks for your reply. Do you think it's better to remove the rename
> support from dm? Or it's better to add such limit?

It will probably be hard to entirely remove it.  But documentation
and a rate limited warning discouraging it seems like a good idea.

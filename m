Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BCDC433EF
	for <linux-block@archiver.kernel.org>; Mon, 11 Apr 2022 15:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbiDKP7o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbiDKP7o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Apr 2022 11:59:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42B21D320;
        Mon, 11 Apr 2022 08:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GBHXr14ylwPw0Lr+8W24NLBOrvOV2rbcZxI9Qhlznt4=; b=OIsbWCt4m8lIi7nMztvFrdioGy
        6r/4lLaSjyLiheoe5dO2W+YKCn1NL4px7rrp8z4z+Isu9Z4kjCIB686zkaPvE3+suPaJybMqHr6hB
        zChOSYvASsCtK2qiV8dUJP4aPKqVpWdkwJR8IkPhKL3tki86yv23PSXAKHW9g5sMvotFHdzuVWeNg
        uYNshd9znN3NDaAWsDL8dcAfNKvRUYqmDX2PIQmMnKIU0SeDYlIRCWuXrXwypZ2vdqmh+QBOET+qw
        fu8+Dk7U4UJgPxPA+rLWo+NDdepFdvTTPp5FiA8XwOYutSaK5uSoY71eRhaNGh8kiFNuWx6BGosY/
        l3W8U9Gg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndwPu-009gx2-92; Mon, 11 Apr 2022 15:57:26 +0000
Date:   Mon, 11 Apr 2022 08:57:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] block: print correct sectors in
 printk_all_partitions()
Message-ID: <YlRP5rlp+eNXhFzf@infradead.org>
References: <1649475581-12139-1-git-send-email-yangtiezhu@loongson.cn>
 <1649475581-12139-4-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649475581-12139-4-git-send-email-yangtiezhu@loongson.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 09, 2022 at 11:39:41AM +0800, Tiezhu Yang wrote:
> In the above log, the sectors are not consistent with the output
> of fdisk command, fix it.

It is however consistent with the output of /proc/partitions.

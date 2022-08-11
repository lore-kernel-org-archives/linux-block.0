Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05303C19F2A
	for <linux-block@archiver.kernel.org>; Thu, 11 Aug 2022 14:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbiHKOJW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Aug 2022 10:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiHKOJW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Aug 2022 10:09:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0B48E0F8;
        Thu, 11 Aug 2022 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xIw5J8JiW9EWdbkmaTRIkgvuE5eWmxbyOxxWHb1qODM=; b=IQQP/nmNwdcKQmc1MyI1YA+Fmj
        /punLxww0BQwWjRhe01y/fBF+fTCLhxtJRdmeIk6maNBwLtdpRcsLcxrIrTfA3kIpEBjM7JljqC/Z
        rCLRpkzau8DfX3v25mgaYfTQZx4rnuQ5KTGajocpP4T5YVWtnOu+Bi+ZL7Eo4tKiiva+P2bXSVMqp
        ZQV7eNdklwO3RWd7XN26k9rCLTzkoRpVqHFA+dded2/hw/RFVp2dw99X/w8auy/N0CitoGM/6tfXa
        /GfU3VZpCDk6Clrx6x2NjVCfP46TwlkG+0eDGD1b9p1aHzNrSMutppm252V/p5TdWuKkS1l6ltsmp
        TKXK4MJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oM8sB-00D58V-9T; Thu, 11 Aug 2022 14:09:19 +0000
Date:   Thu, 11 Aug 2022 07:09:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-wbt: do not throttle swap write on processes other
 than kswapd
Message-ID: <YvUNj9cTFhvHKsF4@infradead.org>
References: <1660217545-10697-1-git-send-email-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660217545-10697-1-git-send-email-zhanghongchen@loongson.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 11, 2022 at 07:32:25PM +0800, Hongchen Zhang wrote:
> +		if (current_is_kswapd() ||
> +		    (bio->bi_end_io != end_swap_bio_write))
> +			flags |= WBT_TRACKED;

Why can't this just use REQ_SWAP instead of doing strange poking into
deep kernel internals?

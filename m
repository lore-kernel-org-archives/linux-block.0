Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE56FECE58E
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 07:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52162089C
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 07:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qqL5aeST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfJOH5i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:57:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfJOH5i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 03:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ithh4fNVODCNLQRajtvbqlzKafq/KU+0DA/zmN+wqWE=; b=qqL5aeSTIWDgNtp/HJwA9ZMMT
        h6+KRvOiY4pSov/nKY8VqOC06c+kPQhxJBnm7nY1siqW84NYOnVx8zsyOJDLXR9dfPkROAFN14C4s
        Bbo8/C+IyFdigIzD8emUm814SZCWsHufo0ufltGfahj0Eh+2N+KzAeSFYfxd+CYuWqM7PRjQTO8i2
        I6d09ZKQZNbJoQSYDHrFlwcMrp3Vp69s59+15/XZYTw63O8UAgA4HJ7W+3jaa92wO6Fq+R6q7/ZG3
        9+7mSEoNEU3QXsYwcBtZIY+mUSJoxUy8f5LTGNXQ+KoFtlhtKshTptfWuq1A04jzWN6jLciBMSfQR
        93TJzegyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKHi4-0000mz-81; Tue, 15 Oct 2019 07:57:36 +0000
Date:   Tue, 15 Oct 2019 00:57:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm, swap: disallow swapon() on zoned block devices
Message-ID: <20191015075736.GC32307@infradead.org>
References: <20191015043827.160444-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015043827.160444-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 15, 2019 at 01:38:27PM +0900, Naohiro Aota wrote:
> +		if (blk_queue_is_zoned(p->bdev->bd_queue))
> +			return -EINVAL;

Please add a comment here (based on your changelog).

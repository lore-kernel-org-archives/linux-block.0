Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1146DC433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 06:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346111AbiBKGs4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 01:48:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbiBKGsy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 01:48:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7801120
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 22:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wpIHtVENMH+coDRnZitI63bv4jrEKLUn0SHpH9v7VWI=; b=wSEoR9aphj7QiVEOLtp5AmlAOS
        MkGpjJEzpaun7EPJCJrVk28u9WHnizUiJ7fAYdBfcd71G6/Vf+XTzNSkN3ZgRBP4NKtvJwJ/eq/ZN
        /uOqlqczJheWkZOqFuvHlKOSBkLxtDzwYNnLul+eM8sP+Gf/zT2H/r3AHsz7s4tXsNgs9cKGscxnX
        ZcV8/SVQtQhW5h+U744KMz22ecftDY28PPEkK5NyhzUHX35pVNFnj7+4xRsIzJJqbGkC9n0p4Xs3K
        3DkFi2BOqVUdDhJ8iySSpMD4qZaF6FbfLMuQOGhTX3U4k7IUFauWv17DCz5HsfS3F6R1oDap9yTWX
        euuRlRZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIPjh-0060XY-Kl; Fri, 11 Feb 2022 06:48:53 +0000
Date:   Thu, 10 Feb 2022 22:48:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 02/14] dm: fold __clone_and_map_data_bio into
 __split_and_process_bio
Message-ID: <YgYG1ZcfqL6iJvaa@infradead.org>
References: <20220210223832.99412-1-snitzer@redhat.com>
 <20220210223832.99412-3-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210223832.99412-3-snitzer@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 10, 2022 at 05:38:20PM -0500, Mike Snitzer wrote:
> Fold __clone_and_map_data_bio into its only caller.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1920AC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 14:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiFWOBU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 10:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiFWOBT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 10:01:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4503DA4C
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 07:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m9BROHYYMou1C2lDyaMQPBtg5slG1hoxgupCGV4L5s4=; b=yq76+Ow7rGVr3SSQiYwZ+V+DeU
        RaYncUB/zrNX3c2LoqmptD63eM4RPl+ge6s3SmXZs57EyPrJ99K3nhGIizM/ITlbw0l3YTA8P28nm
        qTld5lQA5EQiixDA7d3vHOQUGs1glUC+WAAXz+/V+WhialwyZ9wVCFrmL28gb+Sq42i2+1ZcnGUDH
        a07YWc1EQlWImho7hHhKxJ8kFcWEncsZoYcioc2eZfAiTm29bs5Zw5jh6lGnc/OxrSrU1Sj4IAbTt
        EBMGpKwEJ5NF0afTlsPrVG+Yv4GvBTh388ETcBfaqGhjg/afHD8ZGqSTk/tO4FPy+59IBZeOyRpE0
        05FZ6g8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4NOW-00FSTL-GT; Thu, 23 Jun 2022 14:01:16 +0000
Date:   Thu, 23 Jun 2022 07:01:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 7/9] blk-ioprio: Convert from rqos policy to direct call
Message-ID: <YrRyLGQVJJ+pK7dY@infradead.org>
References: <20220623074450.30550-1-jack@suse.cz>
 <20220623074840.5960-7-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623074840.5960-7-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nice!  The rqos calling conventions always seem like a bit of
obsfucation anyway..

Reviewed-by: Christoph Hellwig <hch@lst.de>

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1D7C433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 09:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiCBKAe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 05:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236632AbiCBKAd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 05:00:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996D55DA4E
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 01:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gJvStZ0YiVfrbX5MOoemk0fi9i4bJfemXE5CSiLv3+k=; b=2TFVFlsCyxWOGF78+aavjnqfD2
        Tu07CKxAn7eCT+2QMZOlxr9jXoYAOY9NGPtD1/+ySQg7KYzv/+M3+znzKpWqVf7pf+dvqUqrtReT9
        uJ1B0bfYcDh6bXKFMbbX6cBaw0uOW9+rHUCfcItATxPOp6sOE2AWUpVtz+IpUCGHpOqAWpE7uCTQt
        1Hr/sjGPX4VQ1slJEGQ8V+nLnTePsLdo3uDl+QTXv7F62KLIIbKoeMTZoViRKYDX96r/+7/7/f1gY
        WLDfyv+c1Llu31XgSba+7tUElg+8n4Ckcu6cGN5uol8IoJaxt9J1XHIRYEqkgm9e6U/ryKbW5BI/Y
        ZtcNOIsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPLlt-002Brr-Cw; Wed, 02 Mar 2022 09:59:49 +0000
Date:   Wed, 2 Mar 2022 01:59:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 6/6] blk-mq: manage hctx map via xarray
Message-ID: <Yh9AFYuvK7ZGH/uP@infradead.org>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
 <20220228090430.1064267-7-ming.lei@redhat.com>
 <Yh4hjS0S3vXfLWlH@infradead.org>
 <Yh7RDCaqiqMmKj1s@T590>
 <Yh8pwiR5DWC9ELDD@infradead.org>
 <Yh8+qA4p6EWGFbtG@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh8+qA4p6EWGFbtG@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 02, 2022 at 05:53:44PM +0800, Ming Lei wrote:
> Another point is that 'unsigned long *' is passed to xa_find() as index.
> However, almost all users of queue_for_each_hw_ctx() defines hctx index
> as 'unsigned int'.
> 
> If we switch to xa_for_each(), the type of hctx index needs to be changed
> to 'unsigned long' for every queue_for_each_hw_ctx(). But xa_load()
> needn't such change.
> 
> Also from user viewpoint, looks 'unsigned long' change for hctx index is
> still a bit confusing, IMO.

If you use xarray you need to fit the convention it expects, that should
not be in any way a surprise.

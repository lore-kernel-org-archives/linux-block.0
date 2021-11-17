Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C654CC433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 06:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E2961B66
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 06:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhKQGU0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 01:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhKQGU0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 01:20:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2C5C061570
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 22:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RyuZVDoKkJj8V4G+JXVCRgBdrL8dhYkZ7EpjLVgetQk=; b=2mc4EwuAs8F4Of7UUGNc6G+eY+
        NFX6IWHeILxCXXJqwbpkttT8cOTZI0T1cV/9+pQsrGi8XLamqK1AG9Q1Db0XyyYAHZj1ZffltpB8K
        z/9VWJ0W/r9Mj+FQQPUWRKnIRCgktmjxRuB1YBdTDfppABR7VcOdPHWT/B4UuF//T0UjYRsrweWIe
        AimjhbSFZJ087yGu1FsULmCPyBGbvlAcrtODrzmw3DDHWQPhkFI4IfSQonLU7hDBuv5o3NzQLXAMo
        9wEN7MkGskW56c88939lbVHWuzP0+moEp1EAUvfPcRGOsGR/X3+sqcPKGqlMPhmxmQgqS4fh/TNgp
        7qOBZ3cA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnEG7-003R6G-Ry; Wed, 17 Nov 2021 06:17:27 +0000
Date:   Tue, 16 Nov 2021 22:17:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 3/4] nvme: separate command prep and issue
Message-ID: <YZSedy1bGe30XEHW@infradead.org>
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117033807.185715-4-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 16, 2021 at 08:38:06PM -0700, Jens Axboe wrote:
> +	ret = nvme_prep_rq(dev, ns, req, &iod->cmd);
> +	if (ret == BLK_STS_OK) {
> +		nvme_submit_cmd(nvmeq, &iod->cmd, bd->last);
> +		return BLK_STS_OK;
> +	}
> +	return ret;

I'd prefer the traditional handle errors outside the straight path
order here:

	ret = nvme_prep_rq(dev, ns, req, &iod->cmd);
	if (ret)
		return ret;
	nvme_submit_cmd(nvmeq, &iod->cmd, bd->last);
	return BLK_STS_OK;


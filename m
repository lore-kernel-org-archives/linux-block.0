Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0095DC3F2CD
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C239A20719
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hzD/smrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgCWQw4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:52:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgCWQw4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 12:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=leF0VeJHSFRi2mE3OjOLPl0/3j8Sf6w03dhOHv6bRtY=; b=hzD/smrLJMMlexyiVa82vFhSUL
        PvlSN6o74aVmQRqtTEz1gk6pttHi6/2DgVtHitMsTPSNhLRNYwxD/2JOKP+oM7Z+FdmKcmXvB05pn
        dGUz00/wsvkup/yAPHxYW/aT4P6zD6WSjDRtmu3EJs1yQ1vnDGzLOA5mYB9fTKC6Sfra4Zba22n0X
        JDtf/Dm2lZ+aq7yFTqaBWnPjeAIR+Ns8P8xgFQuppPSbFU1m2s6i9ICDncbUgMGcb2qc+mVsiUkFh
        rnCB078jc8k3r+lSCUkX2PcMXGkazzmR2r4qK1wNFcQcHokMY1mkceTkwyFbYyQg5KVB097H/RNis
        6yWSJQjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGQJq-0001Nc-Tf; Mon, 23 Mar 2020 16:52:54 +0000
Date:   Mon, 23 Mar 2020 09:52:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
        jack@suse.cz, bvanassche@acm.org, tytso@mit.edu,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 1/4] bdi: use bdi_dev_name() to get device name
Message-ID: <20200323165254.GB4982@infradead.org>
References: <20200323132254.47157-1-yuyufen@huawei.com>
 <20200323132254.47157-2-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323132254.47157-2-yuyufen@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 23, 2020 at 09:22:51PM +0800, Yufen Yu wrote:
> Use the common interface bdi_dev_name() to get device name.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

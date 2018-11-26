Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB1BC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 17:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3414C20672
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 17:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FUF4xUsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3414C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeK0D5N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:57:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeK0D5N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EJMxz0oJNE/IcBr6aMJ2kzHHQn9Ugz301HWmWHD9qwI=; b=FUF4xUsiW+FrinnhqaH+IcpP5
        PumFI2fZFK2ktufXD0OkVPL05PdGASoMT8MHDUeaxWW1c/9OWrvvO5hyGaQaR7FuyNB8jcLZc7rcy
        o/5k+pWUURXCKPegnA5Di7VEB5iNJCkCtSea7IyohOofXbda40/xRYrr2J7j1C2+3bWq7kaGsOF/6
        DtDhISl8xQnGL/YuyJDiUudGkhRQ3Jh6W40+/bvZHGzQK5q2PWVMAMx1H5XxHy1ZjIB8YuoNW0+C8
        Xc5Z+TNY1DkcRQvvX/ZgOU2w6UzETDs5PIlUzqu7G1t2i3xEST0Z0U7K2tsBeiit2bB5d5ycf5OxB
        hcafnP4Fw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRKHG-0001x7-S5; Mon, 26 Nov 2018 17:02:30 +0000
Date:   Mon, 26 Nov 2018 09:02:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/8] block: sum requests in the plug structure
Message-ID: <20181126170230.GA5816@infradead.org>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126163556.5181-2-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 09:35:49AM -0700, Jens Axboe wrote:
> This isn't exactly the same as the previous count, as it includes
> requests for all devices. But that really doesn't matter, if we have
> more than the threshold (16) queued up, flush it. It's not worth it
> to have an expensive list loop for this.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

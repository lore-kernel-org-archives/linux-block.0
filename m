Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8028C77B72
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 05:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjDPFvu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 01:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDPFvt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 01:51:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152432D7F
        for <linux-block@vger.kernel.org>; Sat, 15 Apr 2023 22:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZeWB+OyzqPMFslonYwMPg9QDtjDd8f/kfCyotOebeqw=; b=swnOwyVFdsyhPdOXDfFc3U0Dac
        cZQra6PDh2HNjNBqy0EqqCSD04bCXoUoljw4Oj/SonkTVG4NOWzA4x66AV/vv1t4++QBxknXZDtTw
        o/tFK4e/QZVi1gm/VWV0OoH7L7LjAmRT8dFqW5rlrSGZEXbVcclsIbDixZyliAnGbqbc+prVStTDO
        MlQZUlkrkLKbNKgpk4gCiBTWT0DL2z82jn3NltV0jC/6F7O2esOP1f9jpsre6uP8G67UQ525Woy6K
        2XxYbyXcfxuKxcXTT6Kuxdm7Iu8gSCCgPUx9/hNGmAh0vVpOFLszZICZyJ4NnObJtrys6JhNpOJXL
        YMnqXgWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnvIh-00DBmB-2A;
        Sun, 16 Apr 2023 05:51:47 +0000
Date:   Sat, 15 Apr 2023 22:51:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: re-arrange the struct block_device fields for
 better layout
Message-ID: <ZDuM8+1VuBbxXiJN@infradead.org>
References: <20230414134848.91563-1-axboe@kernel.dk>
 <20230414134848.91563-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414134848.91563-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 14, 2023 at 07:48:47AM -0600, Jens Axboe wrote:
> This moves struct device out-of-line as it's just used at open/close
> time, so we can keep some of the commonly used fields closer together.
> On a standard setup, it also reduces the size from 864 bytes to 848
> bytes. Yes, struct device is a pig...

Maybe add a comment about keeping struct device last and why?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

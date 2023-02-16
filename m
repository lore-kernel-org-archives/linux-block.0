Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C3BC6379F
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 16:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjBPQGs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 11:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBPQGk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 11:06:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD916EB9;
        Thu, 16 Feb 2023 08:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=SN7hxZuJ2JzBBAiVNcZp2OVCnF
        WfLRzX2c2LJrRHM7MWZUf1mRMONWmURqXN/M1nnjtEbklGW+CqX0cwbSp4Xyl4LAeC/Vt5bTeknkh
        4zvYX3NX3HIwMOwgRlhm6org/TKAdp9zjznFW6EMytVo3X5O06FWaOPB+5Y3Frd4ChFxqeZvvz9Fc
        z3X5GjrledWFypD65TscHb7fwq3bfIWw6+s+mZPjO5eZOx5LTR52M3k8aA1iA37pHGYj1Xh4juC7Q
        vQw8ZIuyC76uuoOFy/J9xiZlrqjLkiFe+LfGLGTA1xZGpQhKH8YRYeI2353I5kSB1195LRPoPEoTn
        rSyhjeBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSgmK-00B3lf-S2; Thu, 16 Feb 2023 16:06:36 +0000
Date:   Thu, 16 Feb 2023 08:06:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/4] brd: check for REQ_NOWAIT and set correct page
 allocation mask
Message-ID: <Y+5UjCoATwaM5BND@infradead.org>
References: <20230216151918.319585-1-axboe@kernel.dk>
 <20230216151918.319585-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216151918.319585-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

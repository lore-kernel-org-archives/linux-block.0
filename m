Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1DEC282DD
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 13:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E588D20692
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 13:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jFDR3fS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgAHNlU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:41:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgAHNlU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 08:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bk7BjMxuwK5gNfwAh4AA8EKzYBWdZUl3azQMOlk7jS8=; b=jFDR3fS+91GXUQJdlUKI5Mt24
        8Q2424dNSM24FncH+5YjrVVrCzA5UGA9aUy2XlGV6dC9UmyV+TSm4HukW/4z/sKlyvrWArHO8Ue0F
        lvV3OXq2ZxFPUA4XYGvqnA1YqxzzhNFj59PqOw0NbUXaIfkbvwipg/oiCHzNK+BhsUfXL2BSb2pI3
        KUcIKKOQGa3c2Wm64zBYaERjk1YHOJfZfX4rZvGrDhi005s2MUdwd3b9RuSbbVZXc93HQBRRc3Dml
        0tLZ7KNHTRyq54ud1vIiiqz8YPWrrKZ4r2iu9pIETLU53v/4vrJKkNuXZ4WZmKb8mOWWONEMeFaNm
        wVhAlVq5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipBaK-0005rk-0k; Wed, 08 Jan 2020 13:41:20 +0000
Date:   Wed, 8 Jan 2020 05:41:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH] block: streamline merge possibility checks
Message-ID: <20200108134119.GE4455@infradead.org>
References: <20191218194156.29430-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218194156.29430-1-dmitry.fomichev@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 18, 2019 at 02:41:56PM -0500, Dmitry Fomichev wrote:
> Checks for data direction in attempt_merge() and blk_rq_merge_ok()
> are redundant and will always succeed when the both I/O request
> operations are equal. Therefore, remove them.
> 
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

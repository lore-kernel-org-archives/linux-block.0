Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D64C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E0C20818
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nrsuV2xJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E0C20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbeKOBo2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:44:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbeKOBo2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3DCsVju+2+mGI5DhN1EdZdO+y+4edCTM62e+YZcFmO4=; b=nrsuV2xJ7CxI2l6nWo+rWW0FR
        CKalviEShtke5tELgVO/Qr8bVBRP+cESVtR64sWMNtkFeJ9qVmARxY5BeZvXXaQ0cImMUyI9YrOtM
        PvVqAkQ3Lo6zn+G5qBg3xUluTCMsQiTRjX0RfyhV6p/jDYCwF2Z1Y8JNhqjfQHyjuE/xOxX+cy8Th
        Id5RHREej/8ax8Ite0/29a69J5nRVmBN1ga3RhoYcE0oOdR/+8Qi3IGe/jz8TnCNGBFBocVi4pzV8
        vtfqekWLhnGYZa/QZr/m3wsFSz27xY39joGKyyG/sls1RjnoBVRWa5WvtWu4FUmGU/0LN3JkDUQSa
        z2HmlemzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxHY-0007Du-0x; Wed, 14 Nov 2018 15:40:44 +0000
Date:   Wed, 14 Nov 2018 07:40:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 5/6] blk-rq-qos: inline check for q->rq_qos functions
Message-ID: <20181114154043.GB22811@infradead.org>
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-6-axboe@kernel.dk>
 <20181114152132.GB22186@infradead.org>
 <e81bc8be-cbb6-6f78-c358-32c7eae4e454@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e81bc8be-cbb6-6f78-c358-32c7eae4e454@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 08:33:33AM -0700, Jens Axboe wrote:
> > The inlining sounds fine, but please do it without the obsfucating
> > macros.
> 
> Why? It's a lot of code duplication.

Just source code, not binary code.  And remember that humans want
to understand this code by grepping it, finding it in source browsers,
etc.  And all that macro obsfucation makes it much harder.

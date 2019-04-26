Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D813C43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 14:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A60206E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 14:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NIaEAsWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfDZO5O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:57:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43474 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfDZO5O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 10:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9DFYhnDq1zIOCLh5g9RhbnIb3Fs2bo7/ZB1f6Qh9gjU=; b=NIaEAsWhuiCNQFSUULmyxBCJH
        MCGPur6mfZBP72WbRqdS/q+SNpYY9pfNdEEk6sGasGMgXdkjEymMV0Q8FxEotPgKcJx/U4ipWZS9y
        mharyHSvnb56T7nDncxpsf3YaS8+uNcNoM+nKhj25cf9Tf97nBv7j27OXWozdgaOlHdyZAbS9SKWl
        mGzPRsoQPINK0bijyBU3pRuweN9wGT7GADOsZEL+xIVJjuYb63XrfdSlYcRlO58mAKUxR2Uevst/j
        bZ3MZF45OBLd04r9A0bs3Dyu+UD0dv0lf68UnV+o2S06xOSfeJYE9XXAOhNIMhdrxG0nIWvw7Z8Fq
        3ey24sf/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK2Hn-0004b9-Pa; Fri, 26 Apr 2019 14:57:11 +0000
Date:   Fri, 26 Apr 2019 07:57:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block/028: check if T10 verification fails
Message-ID: <20190426145711.GA12338@infradead.org>
References: <20190426023937.19584-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426023937.19584-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 10:39:37AM +0800, Ming Lei wrote:
> When T10 verification fails, the error code of BLK_STS_PROTECTION
> may not be propagated to user space, see mpage_end_io().

Well, we should probably fix that instead of papering over it..

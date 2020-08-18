Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533C4C433E3
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 19:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286D4206B5
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 19:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GR+UBqRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHRTn0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHRTnZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 15:43:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EB0C061342
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 12:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5uX3Y7zqB7UK605UCIJYb3gCg2x89imxtZLrqC0yOIs=; b=GR+UBqRVoSkNhJrZ4fI54nCJUi
        hFSMxYgyGhbvfaxNkGLP/vbREgldbl22C5SDNPLWhpgb2f+i1Xtaq4FJ3sars9JlUh5nKbqJenZnY
        ydMSUXMzisk5D5pSJB7VzzJSSVgik/UkDFJh+0HSF1H2IXwfuJTXJNZYaNvmPSjJT3rA91kWcVt+l
        pIckthTfQNiQearM84DxCAil0eCebrMaiYPdSjCh2/ap8TMrAmj4VxuOtG2nRcew9mOJMGop1eL0Y
        fY05QNePrDPdUdtiQngs4ksNXBW02BKS1SrscF0xp7E1CZ8W0+avu+JvV4WMNhx1DrBeaXVFpaiLP
        TimnBm3A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k87Vx-0000ta-Vc; Tue, 18 Aug 2020 19:43:22 +0000
Date:   Tue, 18 Aug 2020 20:43:21 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritika Srivastava <ritika.srivastava@oracle.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, hch@infradead.org
Subject: Re: [PATCH v4 2/2] block: better deal with the delayed not supported
 case in blk_cloned_rq_check_limits
Message-ID: <20200818194321.GA3271@infradead.org>
References: <1597772380-3034-1-git-send-email-ritika.srivastava@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597772380-3034-1-git-send-email-ritika.srivastava@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 18, 2020 at 10:39:40AM -0700, Ritika Srivastava wrote:
> If WRITE_ZERO/WRITE_SAME operation is not supported by the storage,
> blk_cloned_rq_check_limits() will return IO error which will cause
> device-mapper to fail the paths.
> 
> Instead, if the queue limit is set to 0, return BLK_STS_NOTSUPP.
> BLK_STS_NOTSUPP will be ignored by device-mapper and will not fail the
> paths.
> 
> Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Ritika Srivastava <ritika.srivastava@oracle.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

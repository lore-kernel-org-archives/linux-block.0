Return-Path: <SRS0=9ghM=BF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A867FC433E3
	for <linux-block@archiver.kernel.org>; Sun, 26 Jul 2020 15:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81004206E3
	for <linux-block@archiver.kernel.org>; Sun, 26 Jul 2020 15:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="twHLcHZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgGZPKG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jul 2020 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgGZPKF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jul 2020 11:10:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F568C0619D2
        for <linux-block@vger.kernel.org>; Sun, 26 Jul 2020 08:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ILBd0GE65OM50TCueNdMDvwPfHVIqdRT42CM7OWkiuk=; b=twHLcHZdOk5r0eJ3SgzW+2eCvY
        fdKKSphyDm4RBNfbuQNOcIUbh2rV7kh+9xtpnyYWhACoLXr3H47tZ5LfnzCtHRj2mAsmfUHZhIeDB
        iTtxj+CU/ohNCxC9zJ9AoNXca0DdoG1FB1E5ThoGR//SOn03VBq4CENAM1jrB16IGIFBiB6qQnimX
        fx/V/ZeSwNXb9JjgR2/DGZtAQWJeuK2m552G6mKv+S8og4cZADm6JH9G5y1i+8nbiUPaoUacct4MN
        RXEPEny14voddt1TOgcd8BnS46ozwOGd3YjkEAgkTCbxYsNeRngutcx9f2v3wfCwNf0pcmsTz3F0p
        lyt+MkDQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jziHr-0006Gh-Lq; Sun, 26 Jul 2020 15:10:03 +0000
Date:   Sun, 26 Jul 2020 16:10:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritika Srivastava <ritika.srivastava@oracle.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH 1/1] block: return BLK_STS_NOTSUPP if operation is not
 supported
Message-ID: <20200726151003.GB20628@infradead.org>
References: <1595608402-16457-1-git-send-email-ritika.srivastava@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595608402-16457-1-git-send-email-ritika.srivastava@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 24, 2020 at 09:33:22AM -0700, Ritika Srivastava wrote:
> If WRITE_ZERO/WRITE_SAME operation is not supported by the storage,
> blk_cloned_rq_check_limits() will return -EIO which will cause
> device-mapper to fail the paths.
> 
> Instead, if the queue limit is set to 0, return BLK_STS_NOTSUPP.
> BLK_STS_NOTSUPP will be ignored by device-mapper and will not fail the
> paths.

How do we end up calling blk_cloned_rq_check_limits when the operations
aren't actually supported?  The upper layers should make sure this never
happens, so you're just fixing symptoms here and not the root cause.

Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23294C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 08:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BB320855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 08:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XXpf5wLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BB320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeKZTLH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:11:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeKZTLG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 14:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kFYmEUxJDA2mOlJcm/r7bIh8MQRtJegN3RnCIprEHMM=; b=XXpf5wLDWXuf1ytPTM5MR/8GJ
        BMeEdd3FVvfyxO0B8C38jR/C8gVTg6+AobC7eMoaN/aq616gXpTGwaghW6DVMEqB1JtqIShkvpyl6
        0z2td1HAeedsEKm6a4bpcugRxtlRwBePibYT2RvY/h9agX76y2jxq+Z3u7/GIkFqKDEJLqI/sFjxv
        9q8rXBDHRLi7NokGPfB6xQ85DDC/bD0Surybr66Nv1ay4/HzQvc9c0jun2ffb6qR6C255O9IRvaZ5
        trmmlQDxUODTdgoNC9ZjO2siw0Sm+bdR25HRFhEjsVOYtPt6mnK1hZOAGOTvJ8LuDmC2zTCyoXJD5
        3j9NXkG6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRC5S-0001zA-Mn; Mon, 26 Nov 2018 08:17:46 +0000
Date:   Mon, 26 Nov 2018 00:17:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 3/6] nvme: remove opportunistic polling from bdev target
Message-ID: <20181126081746.GB362@infradead.org>
References: <20181123183411.8708-1-axboe@kernel.dk>
 <20181123183411.8708-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123183411.8708-4-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 23, 2018 at 11:34:08AM -0700, Jens Axboe wrote:
> It doesn't set HIPRI on the bio, so polling for it is pretty silly.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Well, I know who forgot to mark it hipri :)

But for now this looks good, we need to revisit fabrics polling entirely
once everything has settled.

Reviewed-by: Christoph Hellwig <hch@lst.de>

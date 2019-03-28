Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504A0C4360F
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE822173C
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OHK6Fi+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfC1RFN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:05:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1RFN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 13:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1umyAol6qJ52sj688B0QitsfoTQEqbkW4R/EnVJiSfk=; b=OHK6Fi+NAxVE34gT4tqGmSxkx
        mFoPTwrw+cDjrxRZSW2/fJN8UzQZh64YlByOGemm5KEIFjdieuGx3/siy8Rex61ARUy73IhkGDZxf
        ksGFY/Yh7BSsB1EAzXI5oHK3V/8chMcIIflP6C1bsF9mg/vv3Z2vrfB5HBzfU1JOzFVGhoWVqqz29
        Zreq3k7escMET1Bpwtah6buL88tTgehfaPln3yNXi4Z14+xM0MC/BQbFEass7BBujFgWmQ3j/sxC+
        RO4eFPTNf9BJt1Z/KANS+Ly/1SAFAvqhISXIhmKQ1Xj27IAvP5fVzK8Ge+jvhKr9mf0WuRTVoPKYW
        kUJfxXNBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9YST-0007aa-Uk; Thu, 28 Mar 2019 17:04:53 +0000
Date:   Thu, 28 Mar 2019 10:04:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 01/16] block: sed-opal: fix IOC_OPAL_ENABLE_DISABLE_MBR
Message-ID: <20190328170453.GA27845@infradead.org>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1550103368-4605-2-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550103368-4605-2-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Christoph Hellwig <hch@lst.de>

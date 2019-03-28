Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659A5C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B7E21773
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lw6xQPDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfC1RJ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:09:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1RJ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 13:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=lw6xQPDfFHwfGWFfjwauUtewu
        FM5fLeSl8n4rlUm4Cd7eFZ2jQzv+0RNuJHjL32CFuNpk7wx9mk0Krt9qhdXuRx9Vhhhhg0AZej9+i
        4xchcer29iOhzJjMsrbSOUmxLzFxTE9wBLT0gKad+MKU24IgHMArdgGxArCiNUHkCpio4f2TBAwOS
        ZaNQPzYz5hlL1BD2LZfObt0s5sg6DgGnyvprjg0d3R3n2LPC2TiUbBT+cW6cT4eM0gB0qeZXrLzRz
        m3xgkYaf2y9MYc5wPfLbrYv4u9qreS+eD6rgezSrfd33pW97amfDXQJNAZ3Hs5MR6ZjELRvrMw0FD
        JmL0NnhOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9YWs-0003Uq-0i; Thu, 28 Mar 2019 17:09:26 +0000
Date:   Thu, 28 Mar 2019 10:09:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 15/16] block: sed-opal: don't repeat opal_discovery0 in
 each steps array
Message-ID: <20190328170925.GG27845@infradead.org>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1550103368-4605-16-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550103368-4605-16-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

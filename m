Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472A9C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 08:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C41920855
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 08:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CzGzbMTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfAQI5e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:57:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfAQI5e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 03:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T8UtIB+T3zr1IacjNUJbhbpN4vCjaQRrKMJruhvE+/M=; b=CzGzbMTPR7mdPm6HHjmPn6dBd
        KKtJ0nEA+JlUHOvPP4ttu0BiG4uXMH9Aok8DDWG/nasNi+6iLj6VkLp0RDJFhFEF47gEREQ33lCbt
        2UYcH4se6rb39F+GVDRnZ9L3CY6YaEEXySJwYL/8cZZcg7TPVYFG7FTJByY8wOegGXLEA+r745lQH
        KZTC0c9LYIFYl7/C1nKm+WxOn+JVJOGpFaeIIwTEBYfQHBD79jKNCylgZ999/qNlvSHJZqVQPm7vN
        9OqWjNIdmFGFOvG15agvm4XiT82qj7VI0nj+tpJkeKQbh4yrH2tbrdDNXn6ERxSrVPRocWDN0IB5m
        gEUjoc5Gw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gk3UN-0005PJ-MY; Thu, 17 Jan 2019 08:57:27 +0000
Date:   Thu, 17 Jan 2019 00:57:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 00/16] block: sed-opal: support shadow MBR done flag and
 write
Message-ID: <20190117085727.GA14092@infradead.org>
References: <20190116225533.BD1396004E@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116225533.BD1396004E@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi David,

the way the series appear looks odd, because it wasn't threaded or
even ordered, and the patches from Jonas seem to have been sent out
by you under his name.  Can you resend them carefully threaded, all
mails from you with the additional from header for resends?

git-send-email will do it all for you, but it can also be done manually.

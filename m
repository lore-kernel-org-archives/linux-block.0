Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17D5C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 13:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB9120866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 13:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hzclDxb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfEANrE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 09:47:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfEANrE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 09:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=hzclDxb5EBcv1GyYB5FBae4H9
        5I4PSmO2tOGCBhJzQzJoWNpG1bJY3ZoDpt8X799OLnZe8tOMMHHpgkVaxaEv8CGHcgyOizQKy3qaO
        RS7fJRzMu9b5XmeBdkRoSUo3xrG7WQ+B1N/zo1uWuy692jIhMvRUC+y7z5nyixuM5ifVbsgrWgyly
        N1D2Av7G+DdvbKQi+vPnnRxYXItpvAQ5jsgXlxuV4/pS4GsVTObPV8ar6m9ZvOweqsrNOnEEoxy/p
        PJEUFqcHuq4dO/8YU0EI1bQQSN7lC8PeWeQx1D2iZRHgV5E9DKWQYrXkI0JFb8nyMbkvg+VDiI37+
        bVnRHc8Iw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLpZU-0006Hp-A2; Wed, 01 May 2019 13:46:52 +0000
Date:   Wed, 1 May 2019 06:46:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 1/3] block: sed-opal: add ioctl for done-mark of shadow
 mbr
Message-ID: <20190501134652.GA24132@infradead.org>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1556666459-17948-2-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556666459-17948-2-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

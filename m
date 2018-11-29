Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ECAC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 16:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AA5213A2
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 16:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZqRynE9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AA5213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeK3DHK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:07:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbeK3DHK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 22:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zq76zl+WXkKrKXTJhP6mDa95qyjqZvbdF5Jqxo9+5ew=; b=ZqRynE9k4OV8LfcNkzW4GDs76
        3kBhbWLvMJIyyDj4GkowhMYEO1B5DVe+t14EVXXfYaYRWaC1D6RwSKwprOlB7MhqMdkxM1VK48gIZ
        wWgT6ThfG/eTXNPs26bhObLbnCv5i6Z3x62SFgtgYlOQZ3AuKKKsLF7I5/UMzxcrCH4MnD9JIKHb0
        CWnjNld3ST2WjzzKyTOgN+u86SkQnRgOUIPtnzxLqKoTUl6wAK5qC/0ch03BOCs7TJCGRj8Uq0DD6
        6qlI289O5/Ktm0Wtmf+qGsBYdf0vH+ojIrpHOAPb8Fa1sYOWB7WfpKrNocIxFUvaYo1tFiWPsZ4lF
        Kf8kQ2T3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSOkh-0001wG-QN; Thu, 29 Nov 2018 16:01:19 +0000
Date:   Thu, 29 Nov 2018 08:01:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH v3] block: add io timeout to sysfs
Message-ID: <20181129160119.GA7364@infradead.org>
References: <20181128160433.GA35371@192.168.3.9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128160433.GA35371@192.168.3.9>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I think we need a check for the presence of a timeout method and
only show this attribute if the driver actually supports block level
timeouts.

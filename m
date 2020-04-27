Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04505C54FD0
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 05:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2722084D
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 05:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DqQbbRjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD0Fuf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 01:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726527AbgD0Fuf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 01:50:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E880EC061A0F;
        Sun, 26 Apr 2020 22:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=DqQbbRjN48qdiyxsw8aeuawdwp
        FT1K4puKCLqD5Zw0D4JNaDdTf8MxvlTTR2PrGt6f0hLPsFK2YEul5L6i5+wAgYR6XvgLg5yv5r0fI
        tdNis3LtVmsFwNhuJC0UIFtua1SSiI4dcHgWPsJoKqeBEMZSt+IR35LQoZNc5nCCW5JU80fp9Wvt5
        9MBube3J8cZZYnnmlig46fBn6RGIBy5mbhmnT7QWkKwMaS4gKZylTklVr1nMsI4WRgPxYbSohJYTp
        oQZFWIczkLjgmIgxE75O3Se4M47wZNVnJAC3w+akQpo+RNTU4ftljjpfbYTO/+J7IAUt/hrEPyeJU
        +ybaO01Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSwf4-0004Ji-QP; Mon, 27 Apr 2020 05:50:34 +0000
Date:   Sun, 26 Apr 2020 22:50:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-block@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] floppy: suppress UBSAN warning in
 setup_rw_floppy()
Message-ID: <20200427055034.GC4159@infradead.org>
References: <20200426130728.63399-1-efremov@linux.com>
 <20200426130728.63399-4-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426130728.63399-4-efremov@linux.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72845C54FD0
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 05:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 454192075B
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 05:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tEJxhwdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgD0FuM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 01:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726243AbgD0FuM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 01:50:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6514FC061A0F;
        Sun, 26 Apr 2020 22:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KowqKjfssS2ozf3NiNblFlHmPeXSo4s+5OxCquaWHNc=; b=tEJxhwdbNGeXD+sv3esFhqnnyK
        aRCt6ul/9L25ZJVrAHPhfyDE2ul3c/u9Yc/XxMhKlxeKzoMmT1WcTzFl109RaMJTh69guHwtg4WDs
        U109QvtobvFuUn6Hnfw5/AOU60V7khCA5LL0WNaWkgRoz0q+2edLF8K6qFTGp2V6Q5MLTmc48N0vB
        r05/yQJ2J9/HHlMRnPkx3vc8PsfEGYVR9rlPfdSuigRzZ8K9Q8gyEmSS1VzN082N+E9ZWpR0oCLVH
        18XmvSMHIrdRsIIBmzfaaqU2tvf9NCF6K1H8hOreLsjCgZVUR8W8JKKbx5FkNiKIDKgxCfSCPhNPe
        vA0KpNKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSwei-0004FC-58; Mon, 27 Apr 2020 05:50:12 +0000
Date:   Sun, 26 Apr 2020 22:50:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-block@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] floppy: add defines for sizes of cmd & reply
 buffers of floppy_raw_cmd
Message-ID: <20200427055012.GB4159@infradead.org>
References: <20200426130728.63399-1-efremov@linux.com>
 <20200426130728.63399-3-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426130728.63399-3-efremov@linux.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good modulo the hexdump nitpick:

Reviewed-by: Christoph Hellwig <hch@lst.de>

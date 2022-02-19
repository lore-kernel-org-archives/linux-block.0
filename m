Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C4CC433F5
	for <linux-block@archiver.kernel.org>; Sat, 19 Feb 2022 07:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiBSHfa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Feb 2022 02:35:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiBSHf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Feb 2022 02:35:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67CC9D041;
        Fri, 18 Feb 2022 23:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wN/R54DdjG51GJ6FLBWX7by9g1NK4X9Fp+pJwqXBiSY=; b=XLm5fOZoTSqUQcc/6HfBfv5Jjp
        EC24wDq9QL7o0YZmGY/Dl6Un+zXHUBXWLx0CdmzayahZKrW4JfCWCpvy3FeqTaTeoo2IXfxsuWJd7
        Xunzz414UatDBr1UrShziKs6rEwVJ1Pn042Kwa6xzmMsR8PIDnKidUQ3AYMuAsXcM5qAENM4MMjg+
        pE6sDmJXZVLbvXumLRbcsbYPzSY9prTsSLKXsbu9tlR2zePoCVVWHoBB3VIHSS2RrfqY4DjJLjLdH
        sti2tdv5TRjapsWueb5KPUbyV1JG889JbvQaZLbauSGzphyPg9laNXHhNy42JPGSuaWwVjAfXTvDc
        55PDxGdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLKGs-00GNIY-8z; Sat, 19 Feb 2022 07:35:10 +0000
Date:   Fri, 18 Feb 2022 23:35:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefan Roesch <shr@fb.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 04/13] fs: split off __alloc_page_buffers function
Message-ID: <YhCdruAyTmLyVp8z@infradead.org>
References: <20220218195739.585044-1-shr@fb.com>
 <20220218195739.585044-5-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218195739.585044-5-shr@fb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Err, hell no.  Please do not add any new functionality to the legacy
buffer head code.  If you want new features do that on the
non-bufferhead iomap code path only please.

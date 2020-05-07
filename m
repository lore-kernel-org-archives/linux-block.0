Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EE7C38A2A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 13:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015A42075E
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 13:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J5xepBZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgEGNnQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 09:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725969AbgEGNnQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 09:43:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FFBC05BD43
        for <linux-block@vger.kernel.org>; Thu,  7 May 2020 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IkTIfnCuUdfzkCQIu83TZMurI22TqEIsThsv/B2BQHU=; b=J5xepBZEN6H3HIaVu6WlHffHUE
        CrEBGGQwR5c7aMqT9BQAFYA9bsFb2PZ4hnU+aYqbSz388tpk3gERlgCGXsILAL+ArY5B20gX6sRpQ
        mef+0CHSa7AA52yzuChdhvrBMb+xHxDmJRcqDP4FJs88HuZndgjkmtOCfhyROJTRWcECFOsy0Rib5
        43Ydct+56WaYHuBxBqyOCJA69js82vAy9g4gosnjvnIHEEJPAlmaXgnyYRjrvX0na/HvSp+Yhekvf
        XKmJVX4m+9OdqQMmU+EP9QdrGVUPmZ+QyVlNCn4AQpzt9qdaknOkGcwykGuNU1+sv9awYgoVIlic0
        QhGO9xsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWgns-0006o0-2r; Thu, 07 May 2020 13:43:08 +0000
Date:   Thu, 7 May 2020 06:43:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk, tom.leiming@gmail.com, bvanassche@acm.org,
        hch@infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Fix potential kernel panic when increase hardware
 queue
Message-ID: <20200507134308.GA26100@infradead.org>
References: <cover.1588856361.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588856361.git.zhangweiping@didiglobal.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The whole series looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

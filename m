Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C476BC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EF52086B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KiGsqSpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EF52086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeK1SiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:38:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbeK1SiE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 13:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wVHUGmwz57MgvKdCu4SZmJZ1Rwp/OvXIPNgTJwkHfxQ=; b=KiGsqSpGhPgbm2OU35gWVQ6QP
        4/u1WT9QPhi5sk7EyNPD686RS049MDQtVVZA7TuoBUtWYtwSe/1E99se5I44MKEy3Hs64AU99+r4I
        npGNB9/pjmaoWha3js/tIYJKsP0cmkI83kKQI1XMJ06Fl3XaulH8pN0BXhs+9ojAKP2WHStZNHTG9
        oqR8IErGKUahXKbsnTh9c85jPw/yhaODl4ov8ApVBd3+mTbnLLMDWFnWZsvcmxYw9Y44l8kJTpPq+
        q/lfcxYQuN7g8qX5S7MVASFRV7fpYnnf+09vzyRi2cL5lSNlsyTTZ0nTKZ5czks1UqAW0+2tAwHuM
        hW2QHfv7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRuPS-0003O4-S9; Wed, 28 Nov 2018 07:37:22 +0000
Date:   Tue, 27 Nov 2018 23:37:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Allison Henderson <allison.henderson@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com
Subject: Re: [RFC PATCH v1 0/7] Block/XFS: Support alternative mirror device
 retry
Message-ID: <20181128073722.GB7084@infradead.org>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <20181128053303.GL6311@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128053303.GL6311@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 04:33:03PM +1100, Dave Chinner wrote:
> One thing that is going to make this more complex at the XFS layer
> is discontiguous buffers. They require multiple IOs (and therefore
> bios) and so we are going to need to ensure that all the bios use
> the same bi_rw_hint.

Well, in case of raid 1 the load balancing code might actually
map different bios to different initial legs.   What we really need
is to keep the 'index' or each bio.  One good way to archive that
is to just reuse the bio for the retry instead of allocating a new one.

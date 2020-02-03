Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BC7C3524D
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 08:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0268420658
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 08:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b5WCKpMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgBCIga (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:36:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgBCIga (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 03:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G2pDsW29Nx79ibmycfMTPTv+ChirvYgSU5iRViYofm4=; b=b5WCKpMM24O6CPxEP7SZ4ApZP
        aABNRwlt6K/4mqfZC/oLtj1KXFt8hGQnWg2mPkwBzppibtbBCTzdW4B1PdcTlb/Ek9hhwyVtdNK3L
        c4j+39Y25HCxGZez10pwRkIPh7UBB6Dwa7m9M4dCeY+0Wyey1mh5MNzplw86pSAB/3s9eD/pK+H3d
        eEVcUtKdDV2UTQonY9Qt8C62PfVs/01GuZR8jIQ+5U+sOZuOY/8/jhpazhoLOp798XpP8d7gsKfw2
        8Cp9OVc76gZK/7oTpkb6PL5e/qVIDDHMvijRNupyBam94Ac7/reMDR1iDqJEW/DsD7pIO+YJEt0sq
        E0DrxmmmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyXDS-0003Ni-O0; Mon, 03 Feb 2020 08:36:22 +0000
Date:   Mon, 3 Feb 2020 00:36:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>,
        Daniel Disseldorp <ddiss@suse.com>,
        Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 15/15] rbd: switch to blk-mq
Message-ID: <20200203083622.GA5005@infradead.org>
References: <20200131103739.136098-1-hare@suse.de>
 <20200131103739.136098-16-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131103739.136098-16-hare@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 31, 2020 at 11:37:39AM +0100, Hannes Reinecke wrote:
> Allocate one queue per CPU and get a performance boost from
> higher parallelism.

Well, the driver already is using blk-mq so your subject is incorrect.
I think you want to say something like "rbd: support multiple queues"

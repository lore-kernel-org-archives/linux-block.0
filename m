Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CFAC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7471E214DA
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qRVoKy6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfA2Iwb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:52:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfA2Iwa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 03:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c7s23OeCHThHVmOpUwWYk6Apu7riiEPKDKIim565hKI=; b=qRVoKy6tSkqVlg9C4Ic1UlsrH
        +nuvMGG//ZmQcUHd/YmH6Ns8gxs8vtWBzblpTjRBn8jHCA9wMx4ujdzyXYpdm5MIZ3MIGjqFo6PYN
        bXf7hQ5/fonUv8EbrVRNtNjz9tgcEE4VQ50mHSZkEbixvwzslrGgj69bA9c55ft5VbT7x1cv0QOzj
        UFkBLuRx+tNXCyhx7HqT7KUIT/nWkFbWRSY+kmX5Em8OAfX8d4bRZWDRtMgsr0slAEx9ZrwqPyv+K
        eVaMK2UuCluVD13DUFNfMPjnOJcUIKBCHLO7AAv/3E7RlOVnkjk4P4FbV9yvU0nwoeA53/DZ9dg3c
        rNQgwDeJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goP86-0008JP-Mx; Tue, 29 Jan 2019 08:52:26 +0000
Date:   Tue, 29 Jan 2019 00:52:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        John Dorminy <jdorminy@redhat.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Alasdair G Kergon <agk@redhat.com>
Subject: Re: block: Fix a WRITE SAME BUG_ON
Message-ID: <20190129085226.GA25610@infradead.org>
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
 <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
 <20190128221441.GA24102@redhat.com>
 <yq1lg34f4i7.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1lg34f4i7.fsf@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 11:54:08PM -0500, Martin K. Petersen wrote:
> That said, now that we have REQ_OP_WRITE_ZEROES (where the LBS is
> irrelevant due to the payload being the ZERO_PAGE), it may be worthwhile
> to remove REQ_OP_WRITE_SAME. I think drbd is the only user relying on a
> non-zero payload. The target code ends up manually iterating, if I
> remember correctly...

I had a series to remove it a while ago, but you wanted to keep it at
that point.  I can resurrect it.

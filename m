Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58624C4321A
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 14:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA192084F
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 14:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sbavI2MS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfDZOrH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:47:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOrH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 10:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VFpwf0uER1KnB426+X7UPhdTtG2qivWWYDz6u/XxK1g=; b=sbavI2MSRVslbfYNWMJ8CH2gV
        qZXWW6P6OIWyK/t8anm9RmHQ+1qaj2s+x9TIXR5Tg/WFBSXfLhZvjWyAoCEGYJ2XORzognBfR5Wqs
        UYxNndXra6db+ftv2kBVYNZBfmnSlRK04528quRuNTrr3X9HZWontxJVP5ufGGrzy0I8cy1+cAbpi
        zs81GKmnYPKzI6FAn7x7k3F6tWxErEYig2Vc2PUrshvWyns8EouqYdNPcFv588BZAvfYwgUlEZji3
        USy3Em0jkxc3Msas3qswjEBn12UycKskY1tFmidxo3Hu+bNexQsNe/JOpCSj8fdrjH3l+Kv2V+EKF
        xGvbNY8uQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK27y-00011k-L8; Fri, 26 Apr 2019 14:47:02 +0000
Date:   Fri, 26 Apr 2019 07:47:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jerome Glisse <jglisse@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Direct block mapping through fs for device
Message-ID: <20190426144702.GA31264@infradead.org>
References: <20190426013814.GB3350@redhat.com>
 <20190426062816.GG1454@dread.disaster.area>
 <20190426124553.GB12339@infradead.org>
 <20190426144507.GB178347@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426144507.GB178347@magnolia>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 07:45:07AM -0700, Darrick J. Wong wrote:
> Hmmm, this lease interface still doesn't support COW, right?
> 
> (Right, xfs_pnfs.c bails out with -ENXIO for reflink files)

Yes, but that is because no one bothered to do the work.
pNFS/block and pNFS/scsi explicitly support a compatbile COW
scheme, it is just that no implemented it yet (at all I think,
not just for Linux..).

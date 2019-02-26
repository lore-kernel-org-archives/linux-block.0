Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B67C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 03:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF98217F4
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 03:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VyTTc7Uq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfBZD1p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Feb 2019 22:27:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZD1p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Feb 2019 22:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LwVmVyEBq/Y4O6foRX8QuspzDe+zpg/qVDA0EFY9KAY=; b=VyTTc7Uq89bXk8Jir4e01nfQY
        LK2zucJH/iBcxt9hsmKkM9A+JVp7eXSr8IPxwlV0QHPhtLyIfzPaO0Cx1jpX/07sclASxhwQ9zIfu
        rkWxGFNNifdtwY3IGIRVCYXO3gQkrc0Qqa+ryGMpeDIK1l1jre/rCCBHnfOGODiBMkCj5GRC1RVpk
        qR+pLRccGOKg5jfzMz2VrdkyqSlnyQIYtPkVlpYutGjbwLeLIsSQrT4B/gmTWh3jVVGVx11AcHcCc
        +9L7JBR3XkSNx+HdDJpU86Ywbk3O8z+h+XDBEXwtBlFZtfq5xA380f0M2cUxTmKUoZ2CxJUquKFRP
        4bcFH5q1w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyTP7-0006Px-6b; Tue, 26 Feb 2019 03:27:37 +0000
Date:   Mon, 25 Feb 2019 19:27:37 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Christopher Lameter <cl@linux.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] xfs: allocate sector sized IO buffer via page_frag_alloc
Message-ID: <20190226032737.GA11592@bombadil.infradead.org>
References: <20190225040904.5557-1-ming.lei@redhat.com>
 <20190225043648.GE23020@dastard>
 <5ad2ef83-8b3a-0a15-d72e-72652b807aad@suse.cz>
 <20190225202630.GG23020@dastard>
 <20190226022249.GA17747@ming.t460p>
 <20190226030214.GI23020@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226030214.GI23020@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 26, 2019 at 02:02:14PM +1100, Dave Chinner wrote:
> > Or what is the exact size of sub-page IO in xfs most of time? For
> 
> Determined by mkfs parameters. Any power of 2 between 512 bytes and
> 64kB needs to be supported. e.g:
> 
> # mkfs.xfs -s size=512 -b size=1k -i size=2k -n size=8k ....
> 
> will have metadata that is sector sized (512 bytes), filesystem
> block sized (1k), directory block sized (8k) and inode cluster sized
> (32k), and will use all of them in large quantities.

If XFS is going to use each of these in large quantities, then it doesn't
seem unreasonable for XFS to create a slab for each type of metadata?


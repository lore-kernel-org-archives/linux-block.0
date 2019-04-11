Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F5CC10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEE92083E
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BgdtZopq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDKPeU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:34:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50058 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDKPeU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 11:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T28W5zwe2deBjNrmDnAVx0OMglLxvM9TAIaZxWl3Nms=; b=BgdtZopqpJgrRkBc5gzuTGY//
        vgnGIBjhN76K065UdNZZLTerLFKF6XcK60Ts7hn5DEG4LXY1Z4+fuFSmVUsgjqfBT6I5uA0dOYa//
        ZYmZQiSez6LXeL9EPfoQYmmaTrU9BsPLZFLce88FB0zdh2VNYhmuIZvyu4Ke357MTUyJOOCIFQVtC
        cDmOED04jjuXTbav0An2bZ3HrQka26biArlyJhg9xpX2sIXpf95CTEAYD/L3Ie3jDgEazquaLtKq/
        Y1O8Xnb2kiu9iIlBVXTcY9mRXzEtLGs7LRdWTCmpcE1W95E22QSvo7VvcqxQKQItFIzYPvbRVZPnP
        vOvIU0vJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEbiN-0004na-G3; Thu, 11 Apr 2019 15:34:11 +0000
Date:   Thu, 11 Apr 2019 08:34:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        Jens Axboe <axboe@kernel.dk>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Some new bio merging behaviors in __bio_try_merge_page
Message-ID: <20190411153411.GA16987@infradead.org>
References: <85c5fa1a-a506-e26f-c354-1554d47d8b2b@huawei.com>
 <20190411070807.GA421@ming.t460p>
 <cb392476-a00e-09ce-fa6b-9e088242ecc6@huawei.com>
 <20190411080953.GE421@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411080953.GE421@ming.t460p>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 11, 2019 at 04:09:54PM +0800, Ming Lei wrote:
> I don't think it is a good behaviour to use bio->bi_max_vecs to limit
> max allowed page, you may see the idea from the naming simply...
> 
> If there were other such drivers, we may fix it easily, and the following
> patch should fix your issue:

Yep.  Consumers of the block layer really have no business at all
looking at bi_vcnt.

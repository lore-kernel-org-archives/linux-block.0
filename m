Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7147C47247
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 06:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9859A20735
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 06:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qdZfG6pT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEHGli (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 02:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbgEHGlh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 02:41:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCCDC05BD43
        for <linux-block@vger.kernel.org>; Thu,  7 May 2020 23:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VwnDrt8gGtelhrnEVhSpwe1Zh7jMcXYAaqFwp47eXLM=; b=qdZfG6pTG68S24OHZ8NqOPT/EK
        f9UDMJbe4IzpiEkeDCFDL9JrqSSkbvX/SVJMcHSK7Gvx6+wLOOk2lrvhXJADQ5O+lk6OCzPU9fsYX
        GmModBz6tHOlUZgTY8qk2+YhYqtn5UE6+hSsVFZ2jTj3q0TpHHuQyJGIua3n9LH7rSHXee8ANa3Ni
        hNM5A6Cj3HsysaqP4kfqwlMoM9xzN5GrO/QRqLNj0RSMQQPy+b30ebddyFwYYkTJa9tlFVS54PP0w
        j2l9ZkH/Xanx9ny7vhUk6bx5avdVbUZk4nBY2sgLW9/B64GYXOvqLauD5hHGrRg2O7649PJUgTfvO
        7vfM1w8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWwhR-0000xU-N8; Fri, 08 May 2020 06:41:33 +0000
Date:   Thu, 7 May 2020 23:41:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH V2 4/4] block: don't hold part0's refcount in IO path
Message-ID: <20200508064133.GA11136@infradead.org>
References: <20200508044407.1371907-1-ming.lei@redhat.com>
 <20200508044407.1371907-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508044407.1371907-5-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 08, 2020 at 12:44:07PM +0800, Ming Lei wrote:
> gendisk can't be gone when there is IO activity, so not hold
> part0's refcount in IO path.
> 
> Cc: Yufen Yu <yuyufen@huawei.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

This looks correct, although I'd still prefer to centralize the
partno checks in the helpers.  Also hd_struct_get is unused with
this patch isn't it?

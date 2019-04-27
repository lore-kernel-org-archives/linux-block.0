Return-Path: <SRS0=GE/Q=S5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509DBC43218
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 06:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D24208CA
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 06:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f5HcEYOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfD0GCD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:02:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47856 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfD0GCD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Apr 2019 02:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SE78iVl+047QJWCEuViLdiRDhBqJWiVE3iO9qltRaeQ=; b=f5HcEYOmnP1zsDVi8CYbfyxVh
        DzFJ35JdEuYUt5VD5bPd4jVEaDyBgZbgmKFNQnlcQKpOf63K/iKrDEIV6Jou9Ent3dm6t6lVNfemI
        ZV3qR5j6p2iU5B4CUiJsch+8E3eQ50D0Vcm0bcwHn4yHP8aDrZ9KKzzID4bQ3lcT1+CiZkVKT5dwF
        SyIV+jMKyLYMEhbcQ49FRqaVk7bN1XC2PQgdbcoYBTMNHtQmlgqNA1Cewke+mbYMs1HO9aanQyYRs
        bo8evjKmmYPAyPO9zRgcWt7at7l7Y0CXQfiXrbOSAseItKID0Y0aEeH8hIWqapd22rIoSuUNC0yQn
        cE/cz9/6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKGPR-0005Fw-05; Sat, 27 Apr 2019 06:02:01 +0000
Date:   Fri, 26 Apr 2019 23:02:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] iov_iter: fix iov_iter_type
Message-ID: <20190427060200.GA15185@infradead.org>
References: <20190426104521.30602-1-ming.lei@redhat.com>
 <20190426104521.30602-3-ming.lei@redhat.com>
 <20190426124435.GA12339@infradead.org>
 <20190426221322.GA31470@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426221322.GA31470@ming.t460p>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 27, 2019 at 06:13:23AM +0800, Ming Lei wrote:
> I agree we need a cleanup, which might be a bit bigger change. It should
> be clean to convert them into bit fields.
> 
> This issue is quite serious, system ram can easily be leaked completely,
> so could we fix the issue by the easy way first?

I'm fine with this as a quick band-aid for 5.2:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But we really need to fix this properly ASAP.

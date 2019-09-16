Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6066EC49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 09:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D89620890
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 09:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q1BYRnzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbfIPJGM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:06:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfIPJGM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 05:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Oaf329R4b+DuYUW6Zsch6ey/owKab5e8+jm4KdXYlS8=; b=q1BYRnzPwLaXuMfSE+Y4+0p2u
        173ANMu921LFWAUcW33FlvQ9CLG2bCOz0OSZe0Ksa3HTkigUQEtDEGuFlYooOzHxmb88dTepngm/0
        drukBDd44MbsGKFHHvmjvRu2x6JcZa1C8MK6lWm32hVMSnh5mCtOwlVH73HzoVEngdCC1y0lNBpq+
        YX9Nw9cfn2WY+Cyyb3KW+LyqhZtZDYhAVO2G9XDnm9H3Iv8QSY9rcCpTvFQYaXGqAsebIj7Rlik8D
        XnHlaC92PR/i26NI5+fdWMSezxL6mPHvI8WCiJwqkI3kyGqIaVbcZSusr5efjN71fhQ8VjXCwEalI
        JAmqwAz9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9mxS-0004i0-M1; Mon, 16 Sep 2019 09:06:06 +0000
Date:   Mon, 16 Sep 2019 02:06:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     xiubli@redhat.com
Cc:     josef@toxicpanda.com, axboe@kernel.dk, mchristi@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCHv2 0/2] blk-mq: Avoid memory reclaim when allocating
 request map
Message-ID: <20190916090606.GA13266@infradead.org>
References: <20190916021631.4327-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916021631.4327-1-xiubli@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 16, 2019 at 07:46:29AM +0530, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> To make the patch more readable and cleaner I just split them into 2
> small ones to address the issue from @Ming Lei, thanks very much.

I'd be much happier to just see memalloc_noio_save +
memalloc_noio_restore calls in the right places over sprinkling even
more magic GFP_NOIO arguments.

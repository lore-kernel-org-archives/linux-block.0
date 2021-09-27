Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD940C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 11:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AB860FD7
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 11:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhI0L4X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 07:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbhI0L4W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 07:56:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF893C061575;
        Mon, 27 Sep 2021 04:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=jza0qAL9zRP7+LInvLg6T+h/t7
        Xa3DrOAZDwYACz0zIScQEHCAVbrMYg/GxLuu/p+FOMIi8FKKrRrZlOb8Ft7g/2iAr552DMtZ0USTi
        e+j7/6jzKkQ9u1UZKGUP/LrBx3d9IYAkwYa4kJ3kU9mHCnkPUOpMu9fXh6J+mLLDKtrXfdKlXVFw8
        q6Sy4rtvy3ulz1D8v5sS15HHqhcuHFpyW2GOdVQmURlhb/1Hh0kfV/ln+evoimYmkTus4XvdM0GLn
        JD2OtXb6IzWPGLc+xgokNPOIkxmr6tMkVEfUHM6K03gHw+Nm/725WpqmRKI184e0/NaArqfgtdl2L
        ISvQBHMQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUpC6-009iHx-9F; Mon, 27 Sep 2021 11:53:21 +0000
Date:   Mon, 27 Sep 2021 12:53:14 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     hch@infradead.org, mst@redhat.com,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        stefanha@redhat.com, israelr@nvidia.com, nitzanc@nvidia.com,
        oren@nvidia.com, linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH 1/1] virtio-blk: avoid preallocating big SGL for data
Message-ID: <YVGwqlOTY9GWQfwQ@infradead.org>
References: <20210830233500.51395-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830233500.51395-1-mgurtovoy@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

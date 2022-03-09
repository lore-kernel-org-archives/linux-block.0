Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299D0C433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 06:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiCIGbw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Mar 2022 01:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiCIGbv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Mar 2022 01:31:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB4A1617E3;
        Tue,  8 Mar 2022 22:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ntm/dJs2/y5fqeYM6uRy7ia5gvFf9GhnZESlJpBE9Dc=; b=0pp44e+5cwbPdRDOvm7CrZ6jDS
        FVVNFQAn+lXJwDREDzhbriG/Yd3e+WxM6Rzaq/h7jzjWrQd9PHz3W0V2RsbeSiqaSOTC24rP9Ikj9
        LqenOdnZ9OkyI0dHMHl/o+jD9v2+y5osvLsCh0QPqjkHjleSRlg+wFRowpEHP5oWZfNkmPwsLdIVT
        YGVJvI859Hkhd5GyqklErCo3qLHgXC7O5JCQVg9OSoeSARnA5AbUUx9+Fw/sr/hWCtM9tIqIayZEs
        hFt31t+EkByNSoHRLt4cMS3wqPO0NxusxCEtfPD61Ou9AJBmDT3OXVMT9HhbZSQRCPJOvuSpoNwES
        NsGobxtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRpqV-007WTb-Sn; Wed, 09 Mar 2022 06:30:51 +0000
Date:   Tue, 8 Mar 2022 22:30:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] block: sx8: Invalid wait context in carm_queue_rq()
Message-ID: <YihJm4xuJEDXbcJx@infradead.org>
References: <CAMhUBj=i4MJ6KH_UU5dy8e+DmviRg4EFA-D5zyD=XfRi9Ma=pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhUBj=i4MJ6KH_UU5dy8e+DmviRg4EFA-D5zyD=XfRi9Ma=pg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I guess you don't actually have the hardware and just built it into the
kernel?

Because I've been pretty sure that this driver is pretty much dead,
so maybe we need to go ahead and just remove it.

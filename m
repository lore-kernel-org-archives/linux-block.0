Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D21C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 13:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiFWNsg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 09:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiFWNsf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 09:48:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61CA33353
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SrTiIqlvg00+skM4kgBJYNVwj7IOV4m/U4xoNC+evE0=; b=yfj3sG/vQrGpFnEIKXmtS8CF5H
        fAJGfKvreTchKGPUYGeZhjBy7RBALSTOqmiRR8h8XANW9D46p1ELx8qzpzndgdtdaVu2YusHS0Tq5
        zZszELY54YQJlNYs41Uk6ebqLhUoWL5vWj2tYIS1TVVG4kXIfNI5JXq660y/eJ09NjCJ/OTC/WuiH
        BGsPf5nHTcZhC87V1U0yIuuLC3GOmJBSBJS1JDzbF8wTK6t70xW20K83VFJTVsGZfapUQGiLE1iw3
        PFsMoAAxHeexFXanoKLJ9/7wuwRhONsGjUPoV0vF+VUdxxKwRsTk7S8W9qogjYxVYa75X7QkdiW2O
        Q5KFaylg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4NCD-00FPu2-CM; Thu, 23 Jun 2022 13:48:33 +0000
Date:   Thu, 23 Jun 2022 06:48:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <YrRvMdRIWC84FcAe@infradead.org>
References: <YrRpb4LlxotvjCML@infradead.org>
 <49f60048-1307-6860-794a-82020c9f2ffd@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49f60048-1307-6860-794a-82020c9f2ffd@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 23, 2022 at 07:44:08AM -0600, Jens Axboe wrote:
> On 6/23/22 7:23 AM, Christoph Hellwig wrote:
> > The following changes since commit 2645672ffe21f0a1c139bfbc05ad30fd4e4f2583:
> > 
> >   block: pop cached rq before potentially blocking rq_qos_throttle() (2022-06-21 10:59:58 -0600)
> > 
> > are available in the Git repository at:
> > 
> >   ssh://git.infradead.org/var/lib/git/nvme.git nvme-5.19
> 
> Usually I'd just turn that into the right git://, but it seems it's
> missing the signed tag this time too. Can you generate one?

Will do.

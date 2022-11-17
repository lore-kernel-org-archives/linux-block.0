Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E539DC4332F
	for <linux-block@archiver.kernel.org>; Thu, 17 Nov 2022 06:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiKQG7z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Nov 2022 01:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiKQG7w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2022 01:59:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1A06EB48;
        Wed, 16 Nov 2022 22:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0D+NUr6m8qnDg7Lo00WOCHfY1jMSWPh16a0XI9PEktQ=; b=xraDXSZxxVomTDMpWD0CQRGdEZ
        jw6P4pa+QZsCNsV6Zddp3TUtLmQjTthzLlvjTllJY6NDRq6RC6zhaKRR/PTw4V1P7t+ZjadJaiin/
        NYFFrNogiAMWw21+ha2XKtgks1c8jeq9MWwsAF5ZG3x7DPYT9WLnyU5Bamtxfcp3vthRn+nO59c+U
        PvnqUk8cChoj50Zx9C9phnmvwjgszcpyRXA8P1ZkF6nL/x08qfLxGm2YOUSdU1BZ7p0dw3copfzeQ
        F4TWM2Q/5hkfaW7a9tAnilhjLdKyHdT5mnMJnKv1nbqsITFmZp1TrSNoF+RvueKQllJCdvaH1ZneL
        fCTQZ5Sg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovYs5-00B1Yn-PD; Thu, 17 Nov 2022 06:59:37 +0000
Date:   Wed, 16 Nov 2022 22:59:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v5 3/4] partitions/efi: add support for uImage.FIT
 sub-partitions
Message-ID: <Y3Xb2YbBP1jr9Q1j@infradead.org>
References: <cover.1668548123.git.daniel@makrotopia.org>
 <7526fc5a461a0d68eb1dab575f9c1950638fc21a.1668548123.git.daniel@makrotopia.org>
 <Y3R8oQXRQ8uq8p4P@infradead.org>
 <Y3V9/pmHs7ypE7lb@makrotopia.org>
 <Y3XN+fDTjHz09qEE@infradead.org>
 <271114315.250800.1668667808308.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <271114315.250800.1668667808308.JavaMail.zimbra@nod.at>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 17, 2022 at 07:50:08AM +0100, Richard Weinberger wrote:
> I think supporting these images in Linux is a worthwhile goal.

I never argued against that.  But it is not a fit for partitions.
So write a proper stacked block driver or dm driver for it if you
care enough.  The format is a complete mess and should be isolated
to not affect the rest of the kernel.

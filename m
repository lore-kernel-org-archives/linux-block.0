Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD94C001DF
	for <linux-block@archiver.kernel.org>; Tue,  1 Aug 2023 09:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjHAJ7U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Aug 2023 05:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjHAJ7O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Aug 2023 05:59:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096F492;
        Tue,  1 Aug 2023 02:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e/cM7pOb8V89NpAzMZKFrg3KLMzh7PzjRGacn60nwMo=; b=qMSX/esFTnAxyNgoPrP7jADKIJ
        9wYBblso7ibaqsO4XPGhMXQl/u8gSIsx8I/5u6dg/GaVIIrLMqfefa84XJ0heq2jUXxRhBvjXFLGi
        Y/rblK29yQR3cUoMbWfzUO60DbS17t2UtdJKcmKeyWjjGdQ9oBxMnq/Ze3+OCkpbh8QYF4sPLVEOE
        vveGaxTDW+ZWK+Wpe7x0ZYCgCXogjrVnJJ5rKZj8gNhLocGXvNHPH2JIO1ywOmgp2Ya54Go+nNX+/
        kV4RSB9CZZTzDfRQbZSfnOhA4i1IDHD6PSy+upS4BiftCsv21OKxuaAaTUvrmr/js+hxTR8BoEhzx
        MncecfbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQm9i-001i00-28;
        Tue, 01 Aug 2023 09:59:06 +0000
Date:   Tue, 1 Aug 2023 02:59:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jinyoung Choi <j-young.choi@samsung.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 2/4] bio-integrity: Sets the payload size in
 bio_integrity_add_page()
Message-ID: <ZMjXarxCV8f/SC5+@infradead.org>
References: <20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p5>
 <CGME20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p7>
 <20230731125224epcms2p7e3c5bbe1fd544c0fd586520b2d155872@epcms2p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731125224epcms2p7e3c5bbe1fd544c0fd586520b2d155872@epcms2p7>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

s/Sets/update/ in the subject line.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

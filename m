Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AED9C636CD
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 09:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjAaJF0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 04:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjAaJEx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 04:04:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AC82D50;
        Tue, 31 Jan 2023 01:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=zzLsGiLpg3sDlIcnH/4TM1gEfT
        PMYpVh8i/2J+j/LHb2QYDgTjfdHNP/fs2mMHiuKTDjnToOQ+uIBEIEjkWT9j66QII2E6xvAu796es
        kKAUZdM4SSKR6EpcxHRLD7L01+BpwFsgd2BN5ud/lqK62XlZanc7W56N0gfjrjdCi05O1ileoXYwz
        lXz9OSn8NSmAK8Sh3NvWrFTOpoCWqtFrwW2YhdqpnNzpIDaRv7DKhbfic6c2xSaKYFDO+MSyPTEdo
        XdKE4PHUBC9iToIeFdY59TiFOdxM3irWvzDPTz5guk+XqaqznxfgKMLxTeDHXIZSKmdc6FQj8HzjG
        xEtREtPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMmW5-006t3v-Uw; Tue, 31 Jan 2023 09:01:25 +0000
Date:   Tue, 31 Jan 2023 01:01:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] memstick: core: Imply IOSCHED_BFQ
Message-ID: <Y9jY5dJFcqIJbbmE@infradead.org>
References: <20230131085220.1038241-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131085220.1038241-1-linus.walleij@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


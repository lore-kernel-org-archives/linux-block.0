Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473B7C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 07:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiITH0H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 03:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiITH0G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 03:26:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231E951A35;
        Tue, 20 Sep 2022 00:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qteLBBo7gVyIzY+cqTBV2I+NHOr6YHBw0FIcyQI9tp8=; b=U3km51K/9URRR722eOD617czlB
        kqYZuclNDxR6GAVHQG3rJZMaxuqea8tUvU/koafALedar/8WuJg+KJyLEcsxoXQJByN3xPoakhMPJ
        McLagTM5reMYyM+mDumkJtDVs5/+tUkMbn5vLgLPvsygRLLzh8gJuUluxOZOtOZyrR1raZN8lIQor
        0Msm8hPNHjhhNr4I5brlzrtuOyyRV2Xh/TkvUNtjgyfONhZ7B7LC3xcst135iXYeUB9hKvkX5Ej78
        EomQxwVHT7hkQvUVfVUSIxO126iYx9NuGH/aSRN7sRx8oyBpXjRNwF6SuleSfBnyNEktiOCW7eQdy
        yKds+8xA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaXdh-001LTm-Vw; Tue, 20 Sep 2022 07:25:53 +0000
Date:   Tue, 20 Sep 2022 00:25:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v2 3/3] blk-wbt: don't enable throttling if default
 elevator is bfq
Message-ID: <YylrAbQ75wCAj5va@infradead.org>
References: <20220919070916.2738443-1-yukuai1@huaweicloud.com>
 <20220919070916.2738443-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919070916.2738443-4-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Matching names is always is a bad idea.

Just ad a flags field to elevator_mq_ops, add a DISABLE_WBT flag
to it, and check for that and everything should become much, much
simpler.


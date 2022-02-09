Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403ACC433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 15:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiBIPOC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 10:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiBIPOB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 10:14:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98CFC0613C9
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 07:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KCtvxzmJwQb6I1Zq4WHfbvy6JT/CSDdM70yrjB72gCw=; b=QyYTPR3UnsJuccXr8DrRRau8TU
        lHTcsfno8eNi8WnZvVkqci80R1+V8Bgjz026u8J1t9QkLwjHbbalNLbdjSCaI4J0Jq07I8YD1c9mJ
        3a7Z7igzdCDtkJVDI8ZP5UL/OOgxyHzkT4zh5J2bVGWvO/FQDm2vXjWzBmSgWc1MOxlylnNUtz64L
        XxnHa3ZQ31tPfeXZ8fxz+P8n7XTfngyX+j1MemnyETGg86AeclyV3oICEpMxEV/q63snai0Q+zxWA
        CTz+g3gemWlaicBhfkUYKSYRgVeIhRbeSoEkqlnIrHizZ50nNX5swmZYQqDw94zpO+mARRpoG6uDL
        5Eb639Lw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHofT-000Wt9-3Q; Wed, 09 Feb 2022 15:14:03 +0000
Date:   Wed, 9 Feb 2022 07:14:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     shy828301@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH V7 1/2] block: create event class for rq completion
Message-ID: <YgPaO0OtJ+NhpNwX@infradead.org>
References: <20220205091150.6105-1-chaitanyak@nvidia.com>
 <20220205091150.6105-2-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205091150.6105-2-chaitanyak@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It seems a bit silly to add the even class without the second user.

But I'm fine with this if we'd just merge them together.

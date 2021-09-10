Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54D9C433EF
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 10:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1B06103D
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 10:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhIJKNi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Sep 2021 06:13:38 -0400
Received: from verein.lst.de ([213.95.11.211]:47656 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232094AbhIJKNh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Sep 2021 06:13:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8DE3767357; Fri, 10 Sep 2021 12:12:24 +0200 (CEST)
Date:   Fri, 10 Sep 2021 12:12:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lihong Kou <koulihong@huawei.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: nvme: fix the NULL ptr bug in
 bio_integrity_verify_fn
Message-ID: <20210910101224.GA12941@lst.de>
References: <20210910085412.747800-1-koulihong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910085412.747800-1-koulihong@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Please just add the call to blk_flush_integrity to
blk_integrity_unregister itself.

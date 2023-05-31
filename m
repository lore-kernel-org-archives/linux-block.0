Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BE3C77B73
	for <linux-block@archiver.kernel.org>; Wed, 31 May 2023 12:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjEaMtg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 May 2023 08:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbjEaMtQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2023 08:49:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE3E6C;
        Wed, 31 May 2023 05:48:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 995C768B05; Wed, 31 May 2023 14:47:52 +0200 (CEST)
Date:   Wed, 31 May 2023 14:47:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, dlemoal@kernel.org, quic_pragalla@quicinc.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] blk-ioc: protect ioc_destroy_icq() by 'queue_lock'
Message-ID: <20230531124752.GA27468@lst.de>
References: <20230531073435.2923422-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531073435.2923422-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

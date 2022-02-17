Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067AFC433FE
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 08:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238092AbiBQIu1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Feb 2022 03:50:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbiBQIu0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Feb 2022 03:50:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A62A2297;
        Thu, 17 Feb 2022 00:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ddEn12nVNSTNC1o3mC2tsISdHyE4ufX5A0JgBRGn6Hc=; b=hTb/MVzaSsIzpKCz7EwezCtdcb
        yt8/5ZxpZ4kq3WzSUN0fKPVq+Uy4b2I8TKMWa++lo+WavCts960AhW9H8LCWKBM6FIE5FbBj/IIMl
        CAlRQAZAxX/P0155VRt0eSkG+cFycGlIIj8/yNLbedQOyEpqEcJoVSSQHYMrwLcJ8+4LrqpEmHYVa
        yVlANlkasJ+yTaiVZPMEd9crcdo1tsPKNjBpsPDxuEVoDlq8SLe11NU4VhYqs/0ZsS3OK5BGjQrpY
        cLBTjOy9127vkODf7FqqZyUGpULD7Y1CivCi9gHPuHqwza3PPd4UzF4vRObQmWgyHvlaSDaWO/Htq
        wwYgCaig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKcUL-009ah5-Hn; Thu, 17 Feb 2022 08:50:09 +0000
Date:   Thu, 17 Feb 2022 00:50:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V4 2/6] blk-wbt: make wbt pluggable
Message-ID: <Yg4MQSUZZu9D+qJu@infradead.org>
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-3-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217031349.98561-3-jianchao.wan9@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +struct rq_qos *wbt_rq_qos(struct request_queue *q);
>  int wbt_init(struct request_queue *);


Please move the wb_lat sysfs attribute into blk-wbt.c as well, which
removes the need to expose these two functions.


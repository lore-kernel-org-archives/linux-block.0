Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9166C636CC
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 06:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBPGJK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 01:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBPGJI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 01:09:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23832193F8;
        Wed, 15 Feb 2023 22:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Fs3zdBc1VKjApf/pkUDbn9eZgt
        9QsFE4gKglz6HKki1XjNSOpjKKZ7Iz5zZvZcgXKcirOxbCzqWEkfH+LLxINU86fersO8fZPuR4KId
        VduM1v46L97buQFSfVnENOlO3TTpiKcsoqDyTfR3/RO2zrL35vfH5mQjMYmGTKa1tC766+daol8Yj
        SLUGKejT/uNwYYwpC6iZuNAe8oA8594ebPAvtWoMP7WuBy0VEKbNx38YU9yLtDuKdCS2gzp9b7aAS
        fUVIq7rpFc+CVeUiPs/td9okNgXhvuJ7o3WHqPRvGVVZQu9h6uHO0dcEJBlX9gam/MtThVbiyrbet
        +lMKurfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSXRy-008eRw-VF; Thu, 16 Feb 2023 06:08:58 +0000
Date:   Wed, 15 Feb 2023 22:08:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev
Subject: Re: [PATCH] block: Fix io statistics for cgroup in throttle path
Message-ID: <Y+3IepgVkmbc5gor@infradead.org>
References: <20230216032250.74230-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216032250.74230-1-hanjinke.666@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

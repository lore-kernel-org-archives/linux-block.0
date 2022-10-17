Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9542EC4332F
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 11:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJQLg5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 07:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJQLg4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 07:36:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C6757BC3;
        Mon, 17 Oct 2022 04:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ILWUUnJmtGV7aeHMCXZZLwmGVJlhgsvZnptaQfncfUE=; b=buma+6IvaMsiAqrbzCR92v9ktz
        qEQVyYhJieOyZhb8YSwweyJDN3OaIif/yt+gFwbSZ+E9rkSKaDVtrk2QHfhtERBjUDe/z+mNA+TkF
        SRp21SgtIvUSTP/PpbjEAxliUKVRVl9vnD1vfJzkab9FiGjtkuIpw52XMunVds5mXVtY/odkY7hd7
        bM7A76PT5BN9y5zrivKiU++JNvjBjn3M5pD4xpcniY6vXb4XyCAKmfQ7TQxMCK36dVbkr8v47OgRT
        1b8aushYhNjxSWLiMTfrRmCDI85Lv1pDj56a1dXDNJVdx7t+HBqQM49E/HqmvPh6q7Udl13Qm52Ww
        sG49e0SA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okOQE-00ArzE-KL; Mon, 17 Oct 2022 11:36:42 +0000
Date:   Mon, 17 Oct 2022 04:36:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        gregkh@linuxfoundation.org, willy@infradead.org, kch@nvidia.com,
        martin.petersen@oracle.com, johannes.thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC] block: fix use after free for bd_holder_dir/slave_dir
Message-ID: <Y00+SsxI7IJ56im8@infradead.org>
References: <20221012125838.1608619-1-yukuai1@huaweicloud.com>
 <Y00LTH0yk3obS22m@infradead.org>
 <dadef634-9ec3-aa7b-f1c0-65a98a0fafb1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dadef634-9ec3-aa7b-f1c0-65a98a0fafb1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 17, 2022 at 05:24:20PM +0800, Yu Kuai wrote:
> I agree that this patch do make sense, however, it seems to me this
> patch should fix the problem that kobject is leaked, not uaf... And I
> verified that the problem can still be reporduced with this patch.

Can you share your reproducer?

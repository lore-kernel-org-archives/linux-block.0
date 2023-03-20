Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E56C7618A
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 06:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCTGPg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 02:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCTGPf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 02:15:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82171E1CF;
        Sun, 19 Mar 2023 23:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=xWrRXf5X271LIN8PGtDG/a4axv
        ub9tzrkNW8tP/n/4bcDdQHwOINqNtiGX5nYj8rSzA7TuYVUxiB0QQtdBDA4OqxPfGtdsy5yykmBPU
        d2Oavnhi6UhjMAT8TsAgg2BUswMNueArlbP8V6Pf0iDS/pLJJFJqgpe815OvqlhacxklLCxW7d9o+
        ie+I+lvIvTpaybHJz2KoCWLmSfis2Hu5MQCSFrV6+DTZYePk2ipXI94Pswj7nRpVpwuHF3lZIg4TO
        q5yfmqYMfgvaOKbWLidOLVAdjFeEWu2nV+A8PVtUwIKJnxWLSPXCdpXbj/kasGTEvRY1NXxV1gjtg
        WRGAvHug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe8nu-008DYG-0m;
        Mon, 20 Mar 2023 06:15:34 +0000
Date:   Sun, 19 Mar 2023 23:15:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 3/3] blk-integrity: register sysfs attributes on
 struct device
Message-ID: <ZBf6Bh76w8y7KZH1@infradead.org>
References: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
 <20230309-kobj_release-gendisk_integrity-v3-3-ceccb4493c46@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v3-3-ceccb4493c46@weissschuh.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

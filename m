Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A212C47090
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 08:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiLFI3o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 03:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiLFI3l (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 03:29:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D761113F93;
        Tue,  6 Dec 2022 00:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=RfQ2CvwYdw3Vp1qoRTFcDqBjiW
        EKFzZcdQaUazje9kzcWOOrbkywyTNbrxgmBULhx8nQz+XwQgAazevKM4UYNjpkEtYQiimi9azD1xm
        RRUFLz5+HsPwRVTaBqj17O3hbZom69F8PYnM5iyPXTKnCNBMQ8wTaflCcrNrjVqmYQCw4p/zCxuYK
        5Bk0ydz/8ysN7M9PUFBI4MNSOWwe6O0gfTmPyelyIstc0HVcict+ipS6U1rhrHgMB7vZd/vQww7MD
        2ZGg3pk9nKFpiSJVajRaYqDyfhKfeiqBKkhbD2+Qy/YhtENOoGvaNqIpo4aftYNuNnzmT9kX6/JP0
        AxScauDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2TKZ-004qdQ-7K; Tue, 06 Dec 2022 08:29:35 +0000
Date:   Tue, 6 Dec 2022 00:29:35 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] block: sed-opal: Don't include <linux/kernel.h>
Message-ID: <Y479b0KiXjWzXFRR@infradead.org>
References: <c1d479b39e30fe70c4579a1af035d4db49421f56.1670069909.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1d479b39e30fe70c4579a1af035d4db49421f56.1670069909.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

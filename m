Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB8CC433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 15:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiBKPwz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 10:52:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349434AbiBKPwy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 10:52:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA0E196
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=uJ30gXsqpZ2AiW/If6WWs+/Q+T
        MQ05BTuxkitJy+y2IYiPgFAfISw4uZCuR+TtNyUV4CDzjicSfFaQBxfywVURW9n6j6u5laRmx3s05
        6rYYCgFDKat/abLKSMrRVmKmqIq9zeOSFZxFurhA1y/6JOA8rAUKIm9jEjD0y/NHQbydnAjDg5I51
        laROm51h5x5xL+ZqpVGBhtjs7yImCq2Kk5/KSvenRoWj2l9IkvBp34TpJXOBtFOh62LIKBL1eWGq9
        JfZZ+CbuXE7lNiJE5BoMp1lJL/KXbo5niQkUjgHnjlIspzs6FzqAeHwXgZ0OQp+45Eb6mbyJyF3us
        0PhJ4mmw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIYE6-007sAN-1N; Fri, 11 Feb 2022 15:52:50 +0000
Date:   Fri, 11 Feb 2022 07:52:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, Pankaj Raghav <pankydev8@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v1 1/1] block: Add handling for zone append command in
 blk_complete_request
Message-ID: <YgaGUtMwq2qjo+9+@infradead.org>
References: <20220211093425.43262-1-p.raghav@samsung.com>
 <CGME20220211093602eucas1p1fe39e931232162a686b2feb06ea1f314@eucas1p1.samsung.com>
 <20220211093425.43262-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211093425.43262-2-p.raghav@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E58EEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 13:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjFUNPp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjFUNPo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 09:15:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BC51996
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 06:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7KtYi3eep9XbX588SNTMn5wloXG6pscuzpNL2Pfc/eI=; b=NpVRqyd25XnP+LIMi0RBCfaMb1
        C979QWJcaCpZ9oWDTPhnKiGBGmXmF80gnUoRdljpTV8/TiFMlIG/oCiDKnRc9ylgniKn1TocD54UV
        Wa7Tsq+j99vPRMp2Cpymkun14uEMRTUyR9m5oRV8TYopVNzdwjke0kXM/0FEZRsK4wrkhNKEmw+fh
        Wfhqrx1rgIiieFhpa+rqJkCqifgpvAyWMjPFvAMv3U0MOQaXAJJs6SABcM8lJXIMViHkXKyZetFXS
        tjxIlwBNGdlbJAGIoAOPWHsteifabiK47EeBRM1I1nHsLnCbHQ1WpHp6pF7hL6kBNIIoV+MV6sp7M
        MfcL0fnw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qBxgO-00EeS1-3C;
        Wed, 21 Jun 2023 13:15:36 +0000
Date:   Wed, 21 Jun 2023 06:15:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        virtualization@lists.linux-foundation.org,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>, houtao1@huawei.com
Subject: Re: [PATCH v2] virtio_pmem: add the missing REQ_OP_WRITE for flush
 bio
Message-ID: <ZJL3+E5P+Yw5jDKy@infradead.org>
References: <ZJLpYMC8FgtZ0k2k@infradead.org>
 <20230621134340.878461-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621134340.878461-1-houtao@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Please avoid the overly long line.  With that fixe this looks good
to me.


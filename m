Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC0AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 15:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiGVPHY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 11:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiGVPHW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 11:07:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7253884EE1
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 08:07:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C0A6768AFE; Fri, 22 Jul 2022 17:07:19 +0200 (CEST)
Date:   Fri, 22 Jul 2022 17:07:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 2/2] ublk_drv: make sure that correct
 flags(features) returned to userspace
Message-ID: <20220722150719.GA7475@lst.de>
References: <20220722103817.631258-1-ming.lei@redhat.com> <20220722103817.631258-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722103817.631258-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F3CC43334
	for <linux-block@archiver.kernel.org>; Mon, 25 Jul 2022 06:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiGYGpc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 02:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiGYGp3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 02:45:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA72EB7FF
        for <linux-block@vger.kernel.org>; Sun, 24 Jul 2022 23:45:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D162F68AA6; Mon, 25 Jul 2022 08:45:23 +0200 (CEST)
Date:   Mon, 25 Jul 2022 08:45:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] ublk_drv: add SET_PARA/GET_PARA control command
Message-ID: <20220725064523.GB20796@lst.de>
References: <20220723150713.750369-1-ming.lei@redhat.com> <20220723150713.750369-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723150713.750369-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Can you spell out PARAM?  PARA sounds rather strange.

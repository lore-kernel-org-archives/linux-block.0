Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC14C77B7D
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 06:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjEQGqs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 02:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjEQGqr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 02:46:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49767F9
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 23:46:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4EE3B6732A; Wed, 17 May 2023 08:46:43 +0200 (CEST)
Date:   Wed, 17 May 2023 08:46:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v5 08/11] block: mq-deadline: Reduce lock contention
Message-ID: <20230517064643.GB24536@lst.de>
References: <20230516223323.1383342-1-bvanassche@acm.org> <20230516223323.1383342-9-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516223323.1383342-9-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72A0C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A831A218A5
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfCVOCl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:02:41 -0400
Received: from verein.lst.de ([213.95.11.211]:43248 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbfCVOCl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:02:41 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B2E5468C4E; Fri, 22 Mar 2019 15:02:33 +0100 (CET)
Date:   Fri, 22 Mar 2019 15:02:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] block: bio: introduce BIO_ALLOCED flag and
 check it in bio_free
Message-ID: <20190322140233.GC17767@lst.de>
References: <20190322131346.20169-1-jthumshirn@suse.de> <20190322131346.20169-4-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322131346.20169-4-jthumshirn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>

But how do you manage to get the tiny on-stack bios split?  What kind
of setup is this?

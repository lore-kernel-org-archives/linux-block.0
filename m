Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FE2C0650E
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 14:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F4F21871
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 14:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfGCOkI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:40:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:54696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbfGCOkI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jul 2019 10:40:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6155B6A9;
        Wed,  3 Jul 2019 14:40:06 +0000 (UTC)
Date:   Wed, 3 Jul 2019 16:40:06 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] block: create bio_try_merge_pc_page helper
 __bio_add_pc_page
Message-ID: <20190703144005.GF4026@x250.microfocus.com>
References: <20190703130036.4105-1-hch@lst.de>
 <20190703130036.4105-3-hch@lst.de>
 <20190703133446.GE4026@x250.microfocus.com>
 <20190703143459.GA10149@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190703143459.GA10149@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 03, 2019 at 04:34:59PM +0200, Christoph Hellwig wrote:
> Really just an empty line going away outside the directly touched code.
> I think it is more effective to boundle that here rather than having
> an extra patch for that..

I'm not a fan of stuff glued together, but admittedly that's pure bikeshedding
here.

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

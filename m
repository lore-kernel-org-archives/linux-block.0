Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364EDC282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 10:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE7C21872
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 10:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfBGKyC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:54:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:51550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbfBGKyC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Feb 2019 05:54:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF56FACD4;
        Thu,  7 Feb 2019 10:54:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 47CF01E3DB5; Thu,  7 Feb 2019 11:54:00 +0100 (CET)
Date:   Thu, 7 Feb 2019 11:54:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH] blktrace: Show requests without sector
Message-ID: <20190207105400.GC3597@quack2.suse.cz>
References: <20190206120440.26557-1-jack@suse.cz>
 <04f7afa6-a137-823c-75be-a09422a63998@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04f7afa6-a137-823c-75be-a09422a63998@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 06-02-19 12:49:46, Jens Axboe wrote:
> On 2/6/19 5:04 AM, Jan Kara wrote:
> > Currently, blktrace will not show requests that don't have any data as
> > rq->__sector is initialized to -1 which is out of device range and thus
> > discarded by act_log_check(). This is most notably the case for cache
> > flush requests sent to the device. Fix the problem by making
> > blk_rq_trace_sector() return 0 for requests without initialized sector.
> 
> Concept is fine, but man, that's not very readable. How about:
> 
> if (blk_rq_passthrough(rq) || blk_rq_pos(rq) == (sector_t) -1)
> 	return 0;
> 
> return blk_rq_pos(rq);
> 
> instead? Preferably with a comment on why blk_rq_pos() will be -1.

Good points. Will send v2 shortly. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E9EC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 01:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B7F2080C
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 01:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B7F2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeKSMVZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 07:21:25 -0500
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:23717 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727033AbeKSMVZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 07:21:25 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 19 Nov 2018 12:29:22 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gOYqP-0007jC-E4; Mon, 19 Nov 2018 12:59:21 +1100
Date:   Mon, 19 Nov 2018 12:59:21 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] aio: add iocb->ki_blk_qc field
Message-ID: <20181119015921.GQ6311@dastard>
References: <20181117235317.7366-1-axboe@kernel.dk>
 <20181117235317.7366-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117235317.7366-4-axboe@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 17, 2018 at 04:53:15PM -0700, Jens Axboe wrote:
> Add the field and have the blockdev direct_IO() helpers set it.
> This is in preparation for being able to poll for iocb completion.

What purpose does this field serve?

And why add it to just blockdev direct_IO and not the other direct
IO paths, too?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

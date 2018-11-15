Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4A3C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 01:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8084222360
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 01:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8084222360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeKOLMq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:12:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeKOLMq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 06:12:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A9B63154860;
        Thu, 15 Nov 2018 01:07:08 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1B70600D6;
        Thu, 15 Nov 2018 01:06:56 +0000 (UTC)
Date:   Thu, 15 Nov 2018 09:06:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix 32 bit overflow in __blkdev_issue_discard()
Message-ID: <20181115010651.GD32603@ming.t460p>
References: <20181113214337.20581-1-david@fromorbit.com>
 <10a8dd78-7c00-8593-9f4e-b20eb1161b92@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10a8dd78-7c00-8593-9f4e-b20eb1161b92@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 15 Nov 2018 01:07:08 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 08:18:24AM -0700, Jens Axboe wrote:
> On 11/13/18 2:43 PM, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > A discard cleanup merged into 4.20-rc2 causes fstests xfs/259 to
> > fall into an endless loop in the discard code. The test is creating
> > a device that is exactly 2^32 sectors in size to test mkfs boundary
> > conditions around the 32 bit sector overflow region.
> > 
> > mkfs issues a discard for the entire device size by default, and
> > hence this throws a sector count of 2^32 into
> > blkdev_issue_discard(). It takes the number of sectors to discard as
> > a sector_t - a 64 bit value.
> > 
> > The commit ba5d73851e71 ("block: cleanup __blkdev_issue_discard")
> > takes this sector count and casts it to a 32 bit value before
> > comapring it against the maximum allowed discard size the device
> > has. This truncates away the upper 32 bits, and so if the lower 32
> > bits of the sector count is zero, it starts issuing discards of
> > length 0. This causes the code to fall into an endless loop, issuing
> > a zero length discards over and over again on the same sector.
> 
> Applied, thanks. Ming, can you please add a blktests test for
> this case? This is the 2nd time it's been broken.

OK, I will add zram discard test in blktests, which should cover the
1st report. For the xfs/259, I need to investigate if it is easy to
do in blktests.

Thanks,
Ming

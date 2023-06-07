Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C4DC7EE23
	for <linux-block@archiver.kernel.org>; Wed,  7 Jun 2023 07:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbjFGHr2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jun 2023 03:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbjFGHrF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 03:47:05 -0400
Received: from h2.cmg2.smtp.forpsi.com (h2.cmg2.smtp.forpsi.com [81.2.195.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4904510D5
        for <linux-block@vger.kernel.org>; Wed,  7 Jun 2023 00:45:37 -0700 (PDT)
Received: from lenoch ([80.95.121.122])
        by cmgsmtp with ESMTPSA
        id 6nrKqOBdTv5uI6nrLqCwQ6; Wed, 07 Jun 2023 09:45:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
        t=1686123935; bh=6Da3kD3R2MTkcuUr4S40ZXt/uYdS4+Mx3J6oHgc4Et8=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=Cg8kZ0g9qtzpCFa4LW7X4XmyLv3qrbcgkHvQy0hSdjm7dw/aoPUtf5LhbkC2XhaP/
         IQ4JxhGIr9c6jip0XShv8XseIpU+wRQ17rPSXFWDIwlblv5YNnYEZJzRa+am8UODf/
         lRMS8PelkVStFYYPbSfxAsUw4d0d8O2B0WPo/B/1Rm/nLotol5qoYaNjq5rA/Wd5eG
         X+XygWzV0QCUv6xGE/e4ZroZnnIVUF+BMZzqdQlt6kaQolB4ZIpIl4wws2Nm7t4vd4
         2nwQNhd7USb+ALmMN9/BN2jKKklROBYXiMZQ1POs8ta4bjS+zXkC8sY3WAw3/Ma0Jy
         YkvpAqqffNvyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
        t=1686123935; bh=6Da3kD3R2MTkcuUr4S40ZXt/uYdS4+Mx3J6oHgc4Et8=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=Cg8kZ0g9qtzpCFa4LW7X4XmyLv3qrbcgkHvQy0hSdjm7dw/aoPUtf5LhbkC2XhaP/
         IQ4JxhGIr9c6jip0XShv8XseIpU+wRQ17rPSXFWDIwlblv5YNnYEZJzRa+am8UODf/
         lRMS8PelkVStFYYPbSfxAsUw4d0d8O2B0WPo/B/1Rm/nLotol5qoYaNjq5rA/Wd5eG
         X+XygWzV0QCUv6xGE/e4ZroZnnIVUF+BMZzqdQlt6kaQolB4ZIpIl4wws2Nm7t4vd4
         2nwQNhd7USb+ALmMN9/BN2jKKklROBYXiMZQ1POs8ta4bjS+zXkC8sY3WAw3/Ma0Jy
         YkvpAqqffNvyA==
Date:   Wed, 7 Jun 2023 09:45:34 +0200
From:   Ladislav Michl <oss-lists@triops.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: ratelimit warning in bio_check_ro
Message-ID: <ZIA1nsJzEj/dAOYG@lenoch>
References: <ZIAjht591AEza3c4@lenoch>
 <20230607063002.GA21239@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607063002.GA21239@lst.de>
X-CMAE-Envelope: MS4wfG2P4CAxB7az0PiADDZMTTwQP41YZ4A37X9/aHyOV6V72ImOqUK/OsN+WfXmug4IoevfKwCIoKWZhXqbK3MI9I1o67ciWD/WuQL23+0sRNiQqxD3LXyk
 7aFoHgHBmPPh+maWUGOdSf/bu4JKqHNdBNduSFHvb8r3g7xlHnDKbjJ3OpEc6T3U4zJHcnyrC3yopPbvOoI4gkloSwHRMu6EaLA=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On Wed, Jun 07, 2023 at 08:30:02AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 07, 2023 at 08:28:22AM +0200, Ladislav Michl wrote:
> > From: Ladislav Michl <ladis@linux-mips.org>
> > 
> > Until 57e95e4670d1 ("block: fix and cleanup bio_check_ro")
> > a WARN_ONCE was used to print a warning. Current pr_warn causes
> > log flood, so use pr_warn_ratelimited instead.
> > Once there adjust message to match the one used in bio_check_eod.
> 
> Do you have a case that hits this?  Beause we'd really need to fix it.

I hit that while working on customer's embedded board. There's eMMC
where boot partitions are locked after upgrade by writing 1 into
force_ro sysfs file. Pending writes are triggering this warnign.
Of course update scripts was fixed meanwhile and knowing what
process triggered warning was quite helpful. So there's nothing
to fix, it is just improved diagnostic and returning to (almost)
old behaviour.

> Otherwise this looks ok to me.

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF30C433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 20:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2DF61052
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 20:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhJVULd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 16:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234042AbhJVULc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 16:11:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EBD361052;
        Fri, 22 Oct 2021 20:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634933354;
        bh=gFrxBFEi0YoEDCSVf09DO+BAeqo+xpHQwFHgOvwLxmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eeV7LxLCx4ALpIAtkWHJaUVbKHYJ80FnHzwOP61DNrZI4bU8Qmxy31E4054stw9Cy
         RuRaDtVrSuEzmmv2cgcbjVBQcTcNMGzc3la2smEOM9x8kcyJgX58Yhl1aCgp9tewK3
         kXz4ZPAhMCokUg/LTkIWZTSgLgG/74wvVrVhIL7jsMJnGxn9byZn3cMVGPH+FrIb8a
         /sw73oV1GecAPxqxypGe2zc+6ivZhhWIATqnbhy/4Nhi8uCcM+kswNsc72HL3weF2Y
         ldNyq7f8qgYVj337Qv+vZLfapmvofp2qIfX343eDNHl1z78M10CttBfeu2DPFWNXuJ
         zxlDkh6OZFMxA==
Date:   Fri, 22 Oct 2021 13:09:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] block: cleanup the flush plug helpers
Message-ID: <YXMaZoQJiR5WFZTw@archlinux-ax161>
References: <20211020144119.142582-1-hch@lst.de>
 <20211020144119.142582-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211020144119.142582-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 04:41:19PM +0200, Christoph Hellwig wrote:
> Consolidate the various helpers into a single blk_flush_plug helper that
> takes a plk_plug and the from_scheduler bool and switch all callsites to
> call it directly.  Checks that the plug is non-NULL must be performed by
> the caller, something that most already do anyway.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This patch as commit 008f75a20e70 ("block: cleanup the flush plug
helpers") in -next causes the following errors with CONFIG_BLOCK=n
(tinyconfig):

kernel/sched/core.c: In function ‘sched_submit_work’:
kernel/sched/core.c:6346:35: error: ‘struct task_struct’ has no member named ‘plug’
 6346 |                 blk_flush_plug(tsk->plug, true);
      |                                   ^~
kernel/sched/core.c: In function ‘io_schedule_prepare’:
kernel/sched/core.c:8357:20: error: ‘struct task_struct’ has no member named ‘plug’
 8357 |         if (current->plug)
      |                    ^~
kernel/sched/core.c:8358:39: error: ‘struct task_struct’ has no member named ‘plug’
 8358 |                 blk_flush_plug(current->plug, true);
      |                                       ^~

I tested the latest block tree and did not see it fixed nor did I see it
reported or fixed elsewhere.

Cheers,
Nathan

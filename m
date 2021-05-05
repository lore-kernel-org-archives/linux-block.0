Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BC3C433ED
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 16:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3658E6121F
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 16:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhEEQVy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 May 2021 12:21:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:43618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233954AbhEEQVx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 May 2021 12:21:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50D96B2F4;
        Wed,  5 May 2021 16:20:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 79B551F2B59; Wed,  5 May 2021 18:20:50 +0200 (CEST)
Date:   Wed, 5 May 2021 18:20:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org
Subject: False waker detection in BFQ
Message-ID: <20210505162050.GA9615@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Paolo!

I have two processes doing direct IO writes like:

dd if=/dev/zero of=/mnt/file$i bs=128k oflag=direct count=4000M

Now each of these processes belongs to a different cgroup and it has
different bfq.weight. I was looking into why these processes do not split
bandwidth according to BFQ weights. Or actually the bandwidth is split
accordingly initially but eventually degrades into 50/50 split. After some
debugging I've found out that due to luck, one of the processes is decided
to be a waker of the other process and at that point we loose isolation
between the two cgroups. This pretty reliably happens sometime during the
run of these two processes on my test VM. So can we tweak the waker logic
to reduce the chances for false positives? Essentially when there are only
two processes doing heavy IO against the device, the logic in
bfq_check_waker() is such that they are very likely to eventually become
wakers of one another. AFAICT the only condition that needs to get
fulfilled is that they need to submit IO within 4 ms of the completion of
IO of the other process 3 times.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

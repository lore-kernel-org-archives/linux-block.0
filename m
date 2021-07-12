Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7543C07E9C
	for <linux-block@archiver.kernel.org>; Mon, 12 Jul 2021 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9174161222
	for <linux-block@archiver.kernel.org>; Mon, 12 Jul 2021 17:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhGLRap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:30:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38010 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhGLRao (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jul 2021 13:30:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8DCB422085;
        Mon, 12 Jul 2021 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626110875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=i8OOw3EC98mxR4MVF5Hjz1UV/zK7FKDb3M+lQc8YgU8=;
        b=zpiHTfmpnHrfo4ipn4HP0RaKaQRXrctQqt3jTAESXjOaEkHH6dXvIbM9WOYQzOJndm6SZ1
        pzVfj8JlzF0ezIWZGq9d2+UK5iTo07Nobc+DwvU7wynhCDSV+G9x5HyGw//mh4FlLmZOcA
        +q5QxWeADf6KdWdeeTVJQHTXiZsT7n0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626110875;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=i8OOw3EC98mxR4MVF5Hjz1UV/zK7FKDb3M+lQc8YgU8=;
        b=lm22nrTBW0PJ73HtcdzhlfhbWKhP6SDR6BTOf4E1qg8CecV8QKZu4n1vndr0qo0j3zruK+
        wf2Jble8RtK0BJDg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 81302A3B81;
        Mon, 12 Jul 2021 17:27:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 60AD41F2AA9; Mon, 12 Jul 2021 19:27:55 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, mkoutny@suse.cz,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] bfq: Limit number of allocated scheduler tags per cgroup
Date:   Mon, 12 Jul 2021 19:27:36 +0200
Message-Id: <20210712171146.12231-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050; h=from:subject:message-id; bh=DkzcLqVVCYNpH5fpkH1eNEWHcrr8DddaQVV7CRopHi4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7HuIvQZpLYbbhzWof9A6rFY7wPVbCNLkFpLsAB6v mT41TSmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOx7iAAKCRCcnaoHP2RA2U8pB/ 9dfU/MLBeCYqN+CBU6QiVzOC431fKBnimWlZigQOGZEFOh+5sf+BG1SF/SazUt4Bb7p0eEJI7Bbn82 Rzm1WyPUgCD/YlE1vlH8GVCAktV+46PNkC6IDH5tjvm5DhGvG+d5TtdxJErVZqMQyOvKWMBVoxuh1R v8zeYjypm98P5Sruia2Ae4+0KUSFSZs5ETiktEk/ewavqQJwR3SqxwrsNEyWEW9ueaj8eW3q5r0rJE nCwCe7EpI1Pfh19Y4GZbYgMPEGj/W8N0Ev1lvNiVIoXCVcUq5XTrwiO4kkrF+ZQ4PJ3LD8YKf9b3zs UVOl/d8eBtjQQm6eZ6WCIFDLp9Pfkt
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

I was looking into why cgroup weights do not have any measurable impact on
writeback throughput from different cgroups. This actually a regression from
CFQ where things work more or less OK and weights have roughly the impact they
should. The problem can be reproduced e.g. by running the following easy fio
job in two cgroups with different weight:

[writer]
directory=/mnt/repro/
numjobs=1
rw=write
size=8g
time_based
runtime=30
ramp_time=10
blocksize=1m
direct=0
ioengine=sync

I can observe there's no significat difference in the amount of data written
from different cgroups despite their weights are in say 1:3 ratio.

After some debugging I've understood the dynamics of the system. There are two
issues:

1) The amount of scheduler tags needs to be significantly larger than the
amount of device tags. Otherwise there are not enough requests waiting in BFQ
to be dispatched to the device and thus there's nothing to schedule on.

2) Even with enough scheduler tags, writers from two cgroups eventually start
contending on scheduler tag allocation. These are served on first come first
served basis so writers from both cgroups feed requests into bfq with
approximately the same speed. Since bfq prefers IO from heavier cgroup, that is
submitted and completed faster and eventually we end up in a situation when
there's no IO from the heavier cgroup in bfq and all scheduler tags are
consumed by requests from the lighter cgroup. At that point bfq just dispatches
lots of the IO from the lighter cgroup since there's no contender for disk
throughput. As a result observed throughput for both cgroups are the same.

This series fixes this problem by accounting how many scheduler tags are
allocated for each cgroup and if a cgroup has more tags allocated than its
fair share (based on weights) in its service tree, we heavily limit scheduler
tag bitmap depth for it so that it is not be able to starve other cgroups from
scheduler tags.

What do people think about this?

								Honza

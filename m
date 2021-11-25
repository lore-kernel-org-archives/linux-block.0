Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DA5C433EF
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 13:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355058AbhKYNmC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 08:42:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41358 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355093AbhKYNkB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 08:40:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2653B1FD34;
        Thu, 25 Nov 2021 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637847409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=b94eRtSLJycZ0x6ubVAAdmUuYlryxqDVFPZy7GvB3Qw=;
        b=nXssUNqjnkKZiNrKeMh4BEYdZHFudQxqnD8W8xI0BGeWWfandJCdPq246rihEfq5xk7eCR
        9BqZ4CdbmG6jYgVk9qOMMRNNpRycZdSyNH+YkoRcr1zfybuBkZDwIYISrutpJx5wo0q0ne
        Xm0WCA9tjc2mbVXv+1jSUXNSZdQLPrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637847409;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=b94eRtSLJycZ0x6ubVAAdmUuYlryxqDVFPZy7GvB3Qw=;
        b=4cd25tCspMMzkd/zbNY/lADVf9nthx6jxI3iXefW0NX1eXM8695VyWKVpJ+DG1IwC2YMCq
        iEeT6OAyKbOYToAg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 1A0F3A3B8C;
        Thu, 25 Nov 2021 13:36:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DEF5A1E0BFB; Thu, 25 Nov 2021 14:36:45 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/8 v5] bfq: Limit number of allocated scheduler tags per cgroup
Date:   Thu, 25 Nov 2021 14:36:33 +0100
Message-Id: <20211125133131.14018-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3544; h=from:subject:message-id; bh=2trK6ybV80986aHhSHkYVa1rlXOkLc/a8I2MP7ZFLPs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhn5FcHzC5yKao8olefzJhFbf7Pyn+JmwGd1EmlwQ2 jfvWJSKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYZ+RXAAKCRCcnaoHP2RA2chSB/ 4v9w3v2rvqqg+F+JdObcxSj46jmIB5zvZOocW36Q1cvKNrai1fOXtXL9wc30NfDg1R0EnFghVrdazj HLn5seGGZIgfM4oZgJyNU5zg6Vx9byRYDFwjkkErp0yGToy8A5Xs44lWlEw4p40zmPvMEs6h+uCtsx 8ykA1HDVvo9NizfaEu37KSFljLOeQjkp0G8pAdzcJQUiX/Kru4ufJU7ZMPwyBYV4UhzETejwBtUSNv qvAZsWTQMYcodosoGlBRblRlgGReCMlGOrBqxHHBfiCUYMOVAhjW7NRsx1gjrNnVcCn7Po8NPr/Spo 374IAjcM09fasWbWMz+1r+BFDGfJkP
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

Here is the fifth revision of my patches to fix how bfq weights apply on
cgroup throughput and on throughput of processes with different IO priorities.
The only change since the previous version is that I've rebased the series
on top of Jens' linux-block.git for-5.17/block branch which required a bit of
reshuffling of IOC passing.

Jens, can you please merge the series?

Changes since v4:
* Rebased on top of linux-block.git for-5.17/block

Changes since v3:
* Rebased on top of 5.16-rc2
* Added Reviewed-by and Acked-by tags

Changes since v2:
* Rebased on top of current Linus' tree
* Updated computation of scheduler tag proportions to work correctly even
  for processes within the same cgroup but with different IO priorities
* Added comment roughly explaining why we limit tag depth
* Added patch limiting waker / wakee detection in time so avoid at least the
  most obvious false positives
* Added patch to log waker / wakee detections in blktrace for better debugging
* Added patch properly account injected IO

Changes since v1:
* Fixed computation of appropriate proportion of scheduler tags for a cgroup
  to work with deeper cgroup hierarchies.

Original cover letter:

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

								Honza

Previous versions:
Link: http://lore.kernel.org/r/20210712171146.12231-1-jack@suse.cz # v1
Link: http://lore.kernel.org/r/20210715132047.20874-1-jack@suse.cz # v2
Link: http://lore.kernel.org/r/20211006164110.10817-1-jack@suse.cz # v3
Link: http://lore.kernel.org/r/20211123101109.20879-1-jack@suse.cz # v4

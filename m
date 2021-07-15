Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD448C47E48
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 13:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB6061360
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 13:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbhGONdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 09:33:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57252 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhGONdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 09:33:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 637A51FE25;
        Thu, 15 Jul 2021 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626355827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QKH7/xefNqTRCod5UCsWj+PEvi0uBm27A6j8MnKfBn4=;
        b=oNeQI0/R85RmNJYJtzF1gt4AxYd2r2puMM1f2/IloNG26ozpF4lwYjG+37yS8goa1Wt9Xy
        Pz4KH4iLYUOk6ZwEljCN78mMwl3kKrlPb0vADbXpPilpKgpzeKWSIzQxgmn0+e5aV8CNWN
        BA/Bm4bE0JKQC8pbfK9jpHjqhlfqSKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626355827;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QKH7/xefNqTRCod5UCsWj+PEvi0uBm27A6j8MnKfBn4=;
        b=kGYax3nPky6Sncnm7tkTSMoR4C+83I4wuY11RuEaEQTw/L0OIjohiOgf1yIFvjfwVxMUTl
        7bPOEI0bvFtEWlCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 52121A3B8F;
        Thu, 15 Jul 2021 13:30:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2F8C91E0BF2; Thu, 15 Jul 2021 15:30:27 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3 v2] bfq: Limit number of allocated scheduler tags per cgroup
Date:   Thu, 15 Jul 2021 15:30:16 +0200
Message-Id: <20210715132047.20874-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2873; h=from:subject:message-id; bh=I5aXUrFDZe2CAg9UOHFtqtL+0LvC4tU9TslHegcd9NE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg8DhJy2Dd/DNH7sIu9SqRmW6QVkhviwM3gGp7+T+W hz+AybKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYPA4SQAKCRCcnaoHP2RA2RR3B/ 9ARBS+nmIhQRENKx2O5biTXpB4Ra/nvZBJTYmC25xh4FnAAIG6YR6fQ+4ZEhNl1Yz9nBoqkWIq+hNN FwN8ExY4TTqhKf/Xaut7CtIo4iReUnQwsp1YrrM6F8btelEKEwjDzvsLrYFLP9x84k6XveVGht4KfB HMvBGIoxS5uiJ3Nz79tHF14uZBxwCG7vqJAJKHUnq4vFz0BR5TWV/yc5TIy/FqwCI0aAG5uzOY6mZv f/qECMFezaozL2aE9acbY+ovWmSD8OsNKS3XbyHpSXBjvImKs4ZCpT63h33S5VriwoD+jrZ4br7KWF grji/5pAU25K0TYBQDrnupzGccSPbY
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

Here is the second revision of my patches to fix how bfq weights apply on
cgroup throughput. This version has only one change fixing how we compute
number of tags that should be available to a cgroup. Previous version didn't
combine weights at several levels correctly for deeper hierarchies. It is
somewhat unfortunate that for really deep cgroup hierarchies we would now do
memory allocation inside bfq_limit_depth(). I have an idea how we could avoid
that if the rest of the approach proves OK so don't concentrate too much on
that detail please.

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

What do people think about this?

								Honza

Previous versions:
Link: http://lore.kernel.org/r/20210712171146.12231-1-jack@suse.cz # v1

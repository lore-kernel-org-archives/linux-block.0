Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FB2C433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFEC610A0
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbhJFRdy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:33:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50240 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhJFRdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 13:33:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C8B27224DF;
        Wed,  6 Oct 2021 17:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633541517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MxeXr2d1lbvQmDb8MHYavn82BOMN9IAiRL9yXG4pCvI=;
        b=yBkkxhw3ym7xoAGpn+RSblZ0mPVR7E54+FWf5HdqH17fddrV5xTz9E8+5HPZYIVCvIfLpx
        sojpjT68wHDOn+q51LXPfwragvHrQYlHqjFl/bhNNWavqSTxRNJXB0bgWx78gEA0ep+H8h
        GiUQi+5uYqUp5iWFJEvgLSfwprzOWGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633541517;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MxeXr2d1lbvQmDb8MHYavn82BOMN9IAiRL9yXG4pCvI=;
        b=OHSZ30lZe3e/FOnWDqaABIrTNZ2F+H2BnEIYaP3JpLS9csQahkzhDc5A0vAlG+AQJfIENl
        FTHJJ+o3/AiQcECg==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id B1886A3B89;
        Wed,  6 Oct 2021 17:31:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 59EA41F2C8D; Wed,  6 Oct 2021 19:31:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/8 v3] bfq: Limit number of allocated scheduler tags per cgroup
Date:   Wed,  6 Oct 2021 19:31:39 +0200
Message-Id: <20211006164110.10817-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4088; h=from:subject:message-id; bh=yUSAzX82wEpA49FQSo1XRvAj0+1W/b2lkZ0Bh/dJdTU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhXd1e77MKyH/oq6Hrjy/n/rE1x/fjSelvOVjeOXWY 6TZEoPiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYV3dXgAKCRCcnaoHP2RA2VSYB/ 4s1fJZ41QrK2wXsbxu2ObEuPJfiQVCcaZ0G6K9lYAc3HV1mWKRWhXyG0A80xS5FRjWyyNaT4D2GU24 FE5WPOiM5xkzzzqcoPB8TV0sYmZog0ki9fdXj66LtQfe8zHr5ZVFT8/VtaPma2kqZxFK3z+61h114W hd9IIbLRk4ZU+gGao8vGmA6U+skTf18LtTHBv63RndJAF34uDAHSmthVlakdjQ8VdBukkNdvejaFf9 oDigVtKxZUkI8glGebqrjahIsXxpLGVpIPPIg0fUivXGikVxBG/s9yMu8/RJjafbYtjhnSrS8h9tZG sQjbZIE8OE5gi6yjwSTwgz4EzteFKl
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

Here is the third revision of my patches to fix how bfq weights apply on cgroup
throughput and on throughput of processes with different IO priorities. Since
v2 I've added some more patches so that now IO priorities also result in
service differentiation (previously they had no effect on service
differentiation on some workloads similarly to cgroup weights). The last patch
in the series still needs some work as in the current state it causes a
notable regression (~20-30%) with dbench benchmark for large numbers of
clients. I've verified that the last patch is indeed necessary for the service
differentiation with the workload described in its changelog. As we discussed
with Paolo, I have also found out that if I remove the "waker has enough
budget" condition from bfq_select_queue(), dbench performance is restored
and the service differentiation is still good. But we probably need some
justification or cleaner solution than just removing the condition so that
is still up to discussion. But first seven patches already noticeably improve
the situation for lots of workloads so IMO they stand on their own and
can be merged regardless of how we go about the last patch.

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

What do people think about this?

								Honza

Previous versions:
Link: http://lore.kernel.org/r/20210712171146.12231-1-jack@suse.cz # v1
Link: http://lore.kernel.org/r/20210715132047.20874-1-jack@suse.cz # v2

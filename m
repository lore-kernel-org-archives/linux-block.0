Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED96BC433FE
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 10:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbhKWKfH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:35:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57452 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbhKWKfH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 05:35:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8C5F51FD39;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637663518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EWGTsGuD+NEhpdV4IKsm5zJdjWiHMRXQARmGvNl+Yxg=;
        b=NoGcUrK0cJW2qaodeuXOezsBbGvXkt694C7024W1Y3Xb/aw9sh/DYZEV8jblMriUw8H8Vt
        rukQbrMNU9WP6zUimfIpCAC0/8X1/X7KS0lexI7e8bnBWxWDDvXyRyvHx4lzzzmbKd6AIU
        l0AKPRAynwKlPmbTLboPU2GTaKNqRD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637663518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EWGTsGuD+NEhpdV4IKsm5zJdjWiHMRXQARmGvNl+Yxg=;
        b=7R4PLmE182BWKBbO3HNXSkC1RiqMVa33oHUP2xMusuEDPWdU/gUWNRNzd9A/pK4+OWq3tW
        M0GKGYfM5BeDM/AA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 821D1A3B84;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5E0EB1E13AB; Tue, 23 Nov 2021 11:31:58 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/8 v4] bfq: Limit number of allocated scheduler tags per cgroup
Date:   Tue, 23 Nov 2021 11:29:12 +0100
Message-Id: <20211123101109.20879-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3893; h=from:subject:message-id; bh=YvnEdtQXgi5BBcmIHOGt0mk6R3Ly1z7cwBpednPorGc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhnMJzHHSvtLX4PDLlmfZNmJp4kth2XwvQoFbSaxQ1 fsw1BNOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYZzCcwAKCRCcnaoHP2RA2aAwB/ 0aLps0v7gdgl4kvVRI/7d/rn3dTTjNLCDR4t6y9KrDHN/De2t9TazDq8SBfAhwPYL2bN5luvVoewWq UvEqR/EhbmzB64wjKtLYLAWkVwLCZMdfuCZNgnQKxYjtj+8EDT/JBd32sXSnXIMeWlUhnjl+3BSPfe 3lrsb44n179kk1NIZ/GPLhyYxWycFHn49GGt9dMVO6lQxG3cnfFBiLDRq2UuJFI+xH7/gpmWPw3GhK W1b12z8zAUmeswh758XSfzohh7ur5dBvYQ0SkCSiG1XRfqsJNJb9RvgRPwzc/oVe5PXuNXnWEUqe2t 2joAyvSh/6/AQm+3/vvW6xJoVWP3xc
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

Here is the fourth revision of my patches to fix how bfq weights apply on
cgroup throughput and on throughput of processes with different IO priorities.
There are no changes since the previous version, I've just rebased the series
and collected acks.

I was hesitating for some time whether to submit the series including the last
patch which I know regresses dbench benchmark when run with many clients.  In
the end I've decided to submit including that patch since most of testing
happened with it applied, it is conceptually a correct thing to do, dbench with
many clients isn't that much revelant benchmark, and there are workarounds
available for the dbench regression. I still plan to work on that aspect of BFQ
scheduling with Paolo so that we have better answer for dbench-like workloads
with BFQ in the future.

Jens, can you please merge the series?

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

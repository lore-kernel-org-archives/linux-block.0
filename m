Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC31C64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8053B20700
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8053B20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbeLFSAb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:00:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbeLFSAa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 13:00:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9C6230B7B9F;
        Thu,  6 Dec 2018 18:00:29 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CFC7101961E;
        Thu,  6 Dec 2018 18:00:26 +0000 (UTC)
Date:   Thu, 6 Dec 2018 13:00:26 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v4 0/7] per-cpu in_flight counters for bio-based drivers
Message-ID: <20181206180025.GA15514@redhat.com>
References: <20181206164122.2166-1-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206164122.2166-1-snitzer@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 06 Dec 2018 18:00:30 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06 2018 at 11:41am -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> Hey,
> 
> This v4 addresses the compile issues on various archs when CONFIG_SMP
> isn't set (by introducing appropriate wrappers in genhd.h)
> 
> Testing with this v4 I was unable to reproduce the issue you reported
> where iostat always reports 0 for avgqu-sz -- but please let me know
> if you still see problems like that.

I ran blktests and both block/017 and block/018 fail due to this
patchset's changes, I'm still trying to grok what the test result is
_saying_ but I'll hopefully get there soon:

block/017 (do I/O and check the inflight counter)            [failed]
    runtime    ...  77.675s
    --- tests/block/017.out     2018-12-06 12:31:21.457936217 -0500
    +++ /home/git/blktests/results/nodev/block/017.out.bad      2018-12-06 12:36:15.735053586 -0500
    @@ -1,14 +1,14 @@
     Running block/017
    -sysfs inflight reads 1
    +sysfs inflight reads 2
     sysfs inflight writes 0
    -sysfs stat 1
    -diskstats 1
    -sysfs inflight reads 1
    ...
    (Run 'diff -u tests/block/017.out /home/git/blktests/results/nodev/block/017.out.bad' to see the entire diff)

# diff -u tests/block/017.out /home/git/blktests/results/nodev/block/017.out.bad
--- tests/block/017.out 2018-12-06 12:31:21.457936217 -0500
+++ /home/git/blktests/results/nodev/block/017.out.bad  2018-12-06 12:51:36.695542332 -0500
@@ -1,14 +1,14 @@
 Running block/017
-sysfs inflight reads 1
+sysfs inflight reads 2
 sysfs inflight writes 0
-sysfs stat 1
-diskstats 1
-sysfs inflight reads 1
-sysfs inflight writes 1
 sysfs stat 2
 diskstats 2
-sysfs inflight reads 0
+sysfs inflight reads 2
+sysfs inflight writes 1
+sysfs stat 3
+diskstats 3
+sysfs inflight reads 1
 sysfs inflight writes 0
-sysfs stat 0
-diskstats 0
+sysfs stat 1
+diskstats 1
 Test complete

block/018 (do I/O and check iostats times)                   [failed]
    runtime    ...  156.073s
    --- tests/block/018.out     2018-12-06 12:31:21.458936217 -0500
    +++ /home/git/blktests/results/nodev/block/018.out.bad      2018-12-06 12:38:51.831116369 -0500
    @@ -1,10 +1,10 @@
     Running block/018
     read 0 s
     write 0 s
    -read 1 s
    +read 2 s
     write 0 s
    -read 1 s
    ...
    (Run 'diff -u tests/block/018.out /home/git/blktests/results/nodev/block/018.out.bad' to see the entire diff)

# diff -u tests/block/018.out /home/git/blktests/results/nodev/block/018.out.bad
--- tests/block/018.out 2018-12-06 12:31:21.458936217 -0500
+++ /home/git/blktests/results/nodev/block/018.out.bad  2018-12-06 12:38:51.831116369 -0500
@@ -1,10 +1,10 @@
 Running block/018
 read 0 s
 write 0 s
-read 1 s
+read 2 s
 write 0 s
-read 1 s
-write 1 s
 read 2 s
+write 1 s
+read 6 s
 write 3 s
 Test complete

Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAC7C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068F020851
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2hxaN5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068F020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeKSU5t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:57:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42025 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbeKSU5t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 15:57:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id u5-v6so26141372wrn.9
        for <linux-block@vger.kernel.org>; Mon, 19 Nov 2018 02:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iL05uSSIvpNAEkXjPa4LLsPBFMnCpnvcdfAc7Vp2A5U=;
        b=J2hxaN5CgQwX3XH/86Da0A57BLs8NYJ8juPTSrnowTgszBdtNhDye09DYxM78q2BE+
         +ZHxy5iCAg9M4JKk1wT00JAcjorZhunK9l42+pYRJuPsgH6GZFCS5IXb0Hy8SVdgc/Mk
         SD9HgD6PUDRerWtSHLriKPYP1sBOyjQxUVX0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iL05uSSIvpNAEkXjPa4LLsPBFMnCpnvcdfAc7Vp2A5U=;
        b=Pdt+IvX79gdP+ddrPrtyTdcXi3dgfn6jBY4D3CXA2HT6/C7s+egAPTCIGVOz5GurDa
         9F7szy9rCg8tJrM+2i75/sgkFgZHtuKv5f2VeIaCdw7FhDGfVDrOGjRspRnsqNASlhXL
         IAo49rRn4/psS2ivHUheZ3JNT2iB1NTdr3mLkvVBjKtm/KOedIsWI4q4xN2wccxuqIut
         zXaxeSgRgqDdQ2Kum5UeMnvQPrMkOuUV9IjrdmzwaQl3XLYo4haxY8HWRn4zNC7DhyLJ
         4jDlvxd/Rbm3cOAbV6iO4PlLMncCFUVk+/Ixs2tyS9CS2a8cpasVbjD9FvzkdQRxogKh
         AKNQ==
X-Gm-Message-State: AGRZ1gLgfRLx+B76GcdApS9bvh7KSjUVKe7SrFOiXnffXFv46MmOjTJr
        oglT7xZaIAnLgMeH8TYmU1OA2g==
X-Google-Smtp-Source: AJdET5fGybOqVpQ/4Qigr+E46Add4Df19BCn58+A5mX7Y2M3uFblQbDmYkRrettjKRivqQMP6EARfw==
X-Received: by 2002:a5d:4708:: with SMTP id y8-v6mr17550396wrq.16.1542623675257;
        Mon, 19 Nov 2018 02:34:35 -0800 (PST)
Received: from localhost.localdomain ([37.162.18.180])
        by smtp.gmail.com with ESMTPSA id e9sm14973298wro.16.2018.11.19.02.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 02:34:34 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V2 00/10] unify the interface of the proportional-share policy in blkio/io
Date:   Mon, 19 Nov 2018 11:34:14 +0100
Message-Id: <20181119103424.3853-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
here is the V2 of this patch series. Let me rephrase the description
of the series, in view of the fact that CFQ will be gone with legacy
block.

The current implementation of cgroups doesn't allow two or more
entities, e.g., I/O schedulers, to share the same files.  Thus, to
enable people to set group weights with BFQ, I resorted to making BFQ
create its own version of the same interface files used by CFQ (before
going away with legacy block), by prepending a bfq prefix.

Actually, no legacy code uses these different names, or is likely to
do so.  Having these two sets of names is simply a source of
confusion, as pointed out also, e.g., by Lennart Poettering (CCed
here), and acknowledged by Tejun [2].

In [1] we agreed on a solution that solves this problem, by actually
making it possible to share cgroups files.  Both writing to and
reading from a shared file trigger the appropriate operation for each
of the entities that share the file.  In particular, in case of
reading,
- if all entities produce the same output, the this common output is
 shown only once;
- if the outputs differ, then every per-entity output is shown,
 followed by the name of the entity that produced that output.

With this solution, legacy code that, e.g., sets group weights, just
works, regardless of the I/O scheduler actually implementing
proportional share.

But note that this extension is not restricted to only blkio/io.  The
general group interface now enables files to be shared among multiple
entities of any kind.

(I have also added a patch to fix some clerical errors in bfq doc,
which I found while making the latter consistent with the new
interface.)

CHANGES FROM V1:
- Removed patch that introduced a function to only find kernfs nodes,
  without increasing ref counters
- Changed commit messages and BFQ documentation, to comply with the
  fact that there won't be CFQ any longer

Thanks,
Paolo

Angelo Ruocco (5):
  cgroup: link cftypes of the same subsystem with the same name
  cgroup: add owner name to cftypes
  block, bfq: align min and default weights with the old cfq default
  cgroup: make all functions of all cftypes be invoked
  block, throttle: allow sharing cgroup statistic files

Paolo Valente (5):
  cgroup: add hook seq_show_cft with also the owning cftype as parameter
  block, cgroup: pass cftype to functions that need to use it
  block, bfq: use standard file names for the proportional-share policy
  doc, bfq-iosched: fix a few clerical errors
  doc, bfq-iosched: make it consistent with the new cgroup interface

 Documentation/block/bfq-iosched.txt |  34 ++---
 block/bfq-cgroup.c                  | 148 +++++++++++++-------
 block/bfq-iosched.h                 |   4 +-
 block/blk-cgroup.c                  |  22 +--
 block/blk-throttle.c                |  24 ++--
 include/linux/blk-cgroup.h          |  10 +-
 include/linux/cgroup-defs.h         |  14 +-
 include/linux/cgroup.h              |  13 ++
 kernel/cgroup/cgroup.c              | 262 +++++++++++++++++++++++++++++-------
 9 files changed, 390 insertions(+), 141 deletions(-)

--
2.16.1

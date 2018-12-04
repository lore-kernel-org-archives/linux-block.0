Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460B6C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0826E2081B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="nBS7HiAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0826E2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbeLDRri (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:47:38 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:36559 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeLDRri (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 12:47:38 -0500
Received: by mail-yb1-f173.google.com with SMTP id w203so3372465ybg.3
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 09:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=lX1tQ0Dc1R1MudwwlVF3wQYyuWDYlEze9Ia5EB1RdRo=;
        b=nBS7HiAtQm0mIFq3+ePQYDlcV/VqcAILGw9rCUF5pAemJn0HlkYetvIhPq2WuxpsbS
         ytKB3/09yU4+K7gR2r1uqDZoWEgqS0t4vxB8PMRZS4DGEQb4HO3w8cd9TcYB9N9wMnqD
         orVrHE0AFNVDaYWrKKNS1BdYAIOrFq8JADVqVll2mLyjm80RJrNXWaBm9v/s6s6M7nEG
         wqaLuM7EdcpXbBkousbeZX54CQIxMdxgQ1sVqAgisrqHLhahM2l88JkOek1vP7NouIEj
         ZCfuPXGzT/oDjzS7JOeko+rBbPl0EXJP60FDmseEUn1hlNaqoeZ6qswEQlVMSVPOFqQQ
         JxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=lX1tQ0Dc1R1MudwwlVF3wQYyuWDYlEze9Ia5EB1RdRo=;
        b=hDa7tFNALjbSbkyIiiLe0dE3Q4fMhkPYfEGvvQ1NtLSJrWOssPN7ZsHFJcnOw17GdG
         +7Li7U5hdZrmbMef91nUB5jhlu++b7ZPeqMjxB/EXqphVI5imyCpEiHB686kiSIjxpeh
         Q8WQWEWel2Zh9LIML2cUmWJXGryMkuVg414w/wTqH3ZDwAJzGBJdPctuDCS1X+0X2KFG
         CUNZK3j3e9/5gm3yoxI5skXZF+fMy3X5D9EMR1ZhzqbDMM8kmkkyvO643xEHz6UoD9Sk
         zkKGeEcaaLuxOuLDGLM3mQVOJ7CZQTFX0gCesnZabBt88po5rMgNMzKQIoD4zvyPUifY
         mZ2A==
X-Gm-Message-State: AA+aEWZFEnt7645Ft0xUlpg+cpAyTo8sYMvIgpgqchOcDhBmoBgNrta2
        j1a6idbJaOkPnzXzivKPFG92TTzWwac=
X-Google-Smtp-Source: AFSGD/UBNfgBFnOefhE9db0gyKDZymohmLR7RgmHQDtZuXeJ9DNKwXV0BfXcA0ic+v/qoPwsyZMbIw==
X-Received: by 2002:a5b:40a:: with SMTP id m10-v6mr20045709ybp.21.1543945656713;
        Tue, 04 Dec 2018 09:47:36 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w77sm7623872ywa.9.2018.12.04.09.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 09:47:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-block@vger.kernel.org, kernel-team@fb.com, osandov@fb.com
Subject: [PATCH 0/3] io.latency test for blktests
Date:   Tue,  4 Dec 2018 12:47:30 -0500
Message-Id: <20181204174733.7423-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patchset is to add a test to verify io.latency is working properly, and to
add all the supporting code to run that test.

First is the cgroup2 infrastructure which is fairly straightforward.  Just
verifies we have cgroup2, and gives us the helpers to check and make sure we
have the right controllers in place for the test.

The second patch brings over some python scripts I put in xfstests for parsing
the fio json output.  I looked at the existing fio performance stuff in
blktests, but we only capture bw stuff, which is wonky with this particular test
because once the fast group is finished the slow group is allowed to go as fast
as it wants.  So I needed this to pull out actual jobtime spent.  This will give
us flexibility to pull out other fio performance data in the future.

The final patch is the test itself.  It simply runs a job by itself to get a
baseline view of the disk performance.  Then it creates 2 cgroups, one fast and
one slow, and runs the same job simultaneously in both groups.  The result
should be that the fast group takes just slightly longer time than the baseline
(I use a 15% threshold to be safe), and that the slow one takes considerably
longer.  Thanks,

Josef

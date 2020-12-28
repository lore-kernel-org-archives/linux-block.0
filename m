Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3A2C433E9
	for <linux-block@archiver.kernel.org>; Mon, 28 Dec 2020 15:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A93522472
	for <linux-block@archiver.kernel.org>; Mon, 28 Dec 2020 15:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405845AbgL1PpW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Dec 2020 10:45:22 -0500
Received: from m12-18.163.com ([220.181.12.18]:33143 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404685AbgL1PpU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Dec 2020 10:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=mCK3T
        3HIeKSj/rHeq3FOKCdx0pS1aXsThj/p4jnQzPI=; b=Sa3L00uYaG4P5JIN4QmGk
        L+DYUDuVuSPH5ikYzxj9M2pIjPzHJ4cSg7L6FvyGk5zGJ/MCwQX6i6wxAbDwsixD
        UhKrvNsKbo963BCGD7r5q2njgksQ/WsCFwrFRF35b57FYr5ixtIvQchohDTy3mIH
        iNKOJOfQkitk1rReiqco8Y=
Received: from localhost (unknown [101.86.213.121])
        by smtp14 (Coremail) with SMTP id EsCowABXAhED+elfmhLSMA--.24651S2;
        Mon, 28 Dec 2020 23:25:55 +0800 (CST)
Date:   Mon, 28 Dec 2020 23:25:55 +0800
From:   Hui Su <sh_def@163.com>
To:     kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        axboe@kernel.dk, linux-block@vger.kernel.org, sh_def@163.com
Subject: Re: [blokc/blk]  d828aefa7a: xfstests.xfs.372.fail
Message-ID: <20201228152555.GA1185658@ubuntu-A520I-AC>
References: <20201223054317.GA1518010@ubuntu-A520I-AC>
 <20201226113133.GC11697@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201226113133.GC11697@xsang-OptiPlex-9020>
X-CM-TRANSID: EsCowABXAhED+elfmhLSMA--.24651S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4fWF4ktF4UXr1DGF43GFg_yoWkKrgE9F
        W5tr1kKan5JF4ayws3Kr1avasIkayDJrWFqa1rt3yDZFn3JayrAanxCF90qas7G3yrWr9F
        va15A3saq3W2vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRXXo7JUUUUU==
X-Originating-IP: [101.86.213.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbBDgMJX1rbLvbm2gAAs+
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Dec 26, 2020 at 07:31:33PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: d828aefa7a1bdf7fbc5073fdb66da9bfb1264c21 ("[PATCH v2] blokc/blk-merge: remove the next_bvec label in __blk_bios_map_sg()")
> url: https://github.com/0day-ci/linux/commits/Hui-Su/blokc-blk-merge-remove-the-next_bvec-label-in-__blk_bios_map_sg/20201223-202618
> base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
> 
> in testcase: xfstests
> version: xfstests-x86_64-d41dcbd-1_20201218
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: xfs
> 	test: xfs-reflink-18
> 	ucode: 0x21
> 
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>

Thanks, i will take a look at it.


Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDEDC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408AF2087E
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 23:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfA2Xz2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:55:28 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:60703 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726846AbfA2Xz2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 18:55:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TJEZGm1_1548806123;
Received: from US-160370MP2.local(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TJEZGm1_1548806123)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 30 Jan 2019 07:55:25 +0800
Date:   Tue, 29 Jan 2019 15:55:23 -0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/3] blk-iolatency: fix IO hang due to negative
 inflight counter
Message-ID: <20190129235522.36yrlxio2kqlwv3w@US-160370MP2.local>
Reply-To: bo.liu@linux.alibaba.com
References: <20190125001249.72688-1-bo.liu@linux.alibaba.com>
 <20190125001249.72688-2-bo.liu@linux.alibaba.com>
 <eb65005a-572d-1640-3c85-214be541a348@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb65005a-572d-1640-3c85-214be541a348@suse.de>
User-Agent: NeoMutt/20180323
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 25, 2019 at 09:30:49AM +0100, Johannes Thumshirn wrote:
> On 25/01/2019 01:12, Liu Bo wrote:
> > In fact the hang can be easily reproduced by the below script,
> > 
> > H=/sys/fs/cgroup/unified/
> > P=/sys/fs/cgroup/unified/test
> > 
> > echo "+io" > $H/cgroup.subtree_control
> > mkdir -p $P
> > 
> > echo $$ > $P/cgroup.procs
> > 
> > xfs_io -f -d -c "pwrite 0 4k" /dev/sdg
> > 
> > echo "`cat /sys/block/sdg/dev` target=1000000" > $P/io.latency
> > 
> > xfs_io -f -d -c "pwrite 0 4k" /dev/sdg
> 
> Can you please turn this into a testcase for blktests as well?
>

Sure, please check out the patch.
https://patchwork.kernel.org/patch/10787361/

thanks,
-liubo

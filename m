Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BD6C282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 22:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AECB218D2
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 22:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfA3WzH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 17:55:07 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:38915 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727963AbfA3WzG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 17:55:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01406;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TJIA-u0_1548888902;
Received: from US-160370MP2.local(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TJIA-u0_1548888902)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Jan 2019 06:55:03 +0800
Date:   Wed, 30 Jan 2019 14:55:01 -0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] block: add test for io hang due to blk-iolatency
Message-ID: <20190130225500.zqosgi2p4tsm4jg6@US-160370MP2.local>
Reply-To: bo.liu@linux.alibaba.com
References: <20190129235407.64401-1-bo.liu@linux.alibaba.com>
 <BYAPR04MB45022333823441D3A4FEA5B586900@BYAPR04MB4502.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB45022333823441D3A4FEA5B586900@BYAPR04MB4502.namprd04.prod.outlook.com>
User-Agent: NeoMutt/20180323
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 30, 2019 at 03:46:45AM +0000, Chaitanya Kulkarni wrote:
> Thanks for the test Liu, please see my inline comments.
> 
> From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org> on behalf of Liu Bo <bo.liu@linux.alibaba.com>
> Sent: Tuesday, January 29, 2019 3:54 PM
> To: linux-block@vger.kernel.org
> Subject: [PATCH blktests] block: add test for io hang due to blk-iolatency
>  
> Add test for verifying io hang when enabling blk-iolatency after a few
> IOs have been done.
> 
> This is a regression test for
> "blk-iolatency: fix IO hang due to negative inflight counter".
> 
> Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> ---
>  tests/block/022     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/block/022.out |  2 ++
>  2 files changed, 44 insertions(+)
>  create mode 100755 tests/block/022
>  create mode 100644 tests/block/022.out
> 
> diff --git a/tests/block/022 b/tests/block/022
> new file mode 100755
> index 0000000..6e5ab42
> --- /dev/null
> +++ b/tests/block/022
> @@ -0,0 +1,42 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2019 Bo Liu <bo.liu@linux.alibaba.com>
> +#
> +# This test is a regression test for io hang due to blk-iolatency, the patch is
> +# "blk-iolatency: fix IO hang due to negative inflight counter"
> +
> +. tests/block/rc
> +. common/cgroup
> +. common/null_blk
> +DESCRIPTION="This test will demonstrate io hang due to blk-iolatency"
> +
> +requires() {
> +       _have_null_blk && _have_cgroup2_controller_file io io.latency
> need to add _have_program xfs_io here.

OK.

> +}
> +
> +test() {
> +       local CGROUP2_DIR
> +       local dir
> +       echo "Running ${TEST_NAME}"
> +
> +       if ! _init_null_blk queue_mode=2; then
> may be print a error message here and/or skip the test instred of just return  ?

Sure.

> +               return 1
> +       fi
> +
> +       _init_cgroup2
> +       dir=$(_cgroup2_base_dir)
> +
> I'm little bit confused, CGROUP2_DIR is not initialize or its an environment variable ?

It's defined in _init_cgroup2, but I'll add a comment for that.

thanks,
-liubo

> +       echo $$ > ${CGROUP2_DIR}/cgroup.procs
> +       xfs_io -f -d -c "pwrite 0 4k" /dev/nullb0
> +
> +       # target=1s
> +       echo "`cat /sys/block/nullb0/dev` target=1000000" > ${CGROUP2_DIR}/io.latency
> +
> +       xfs_io -f -d -c "pwrite 0 4k" /dev/nullb0
> +
> +       echo $$ > ${dir}/cgroup.procs
> +       _exit_cgroup2
> +       _exit_null_blk
> +
> +       echo "Test complete"
> +}
> diff --git a/tests/block/022.out b/tests/block/022.out
> new file mode 100644
> index 0000000..14d43cb
> --- /dev/null
> +++ b/tests/block/022.out
> @@ -0,0 +1,2 @@
> +Running block/022
> +Test complete
> -- 
> 2.20.1.2.gb21ebb6
> 

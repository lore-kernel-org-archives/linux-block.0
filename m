Return-Path: <SRS0=WD2t=T6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4816AC28CC0
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 08:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A9A25117
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 08:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfE3Idu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 04:33:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbfE3Idu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 04:33:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16F02307D988;
        Thu, 30 May 2019 08:33:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-133.pek2.redhat.com [10.72.12.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ABE025DD74;
        Thu, 30 May 2019 08:33:46 +0000 (UTC)
Subject: Re: [PATCH blktests] block: add queue freeze/unfreeze sequence test
To:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org
Cc:     osandov@fb.com
References: <20190529090027.25224-1-bob.liu@oracle.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <4804a370-c710-7434-ce02-8f5447b7e1f5@redhat.com>
Date:   Thu, 30 May 2019 16:33:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529090027.25224-1-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 30 May 2019 08:33:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

You should add the 022.out file

diff --git a/tests/block/022.out b/tests/block/022.out
new file mode 100644
index 0000000..14d43cb
--- /dev/null
+++ b/tests/block/022.out
@@ -0,0 +1,2 @@
+Running block/022
+Test complete

On 5/29/19 5:00 PM, Bob Liu wrote:
> Reproduce the hang fixed by
> 7996a8b5511a ("blk-mq: fix hang caused by freeze/unfreeze sequence").
>
> Signed-off-by: Bob Liu <bob.liu@oracle.com>
> ---
>   tests/block/022 | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
>   create mode 100755 tests/block/022
>
> diff --git a/tests/block/022 b/tests/block/022
> new file mode 100755
> index 0000000..e3ac197
> --- /dev/null
> +++ b/tests/block/022
> @@ -0,0 +1,59 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2019 Bob Liu <bob.liu@oracle.com>
> +#
> +# Test hang caused by freeze/unfreeze sequence. Regression
> +# test for 7996a8b5511a ("blk-mq: fix hang caused by freeze/unfreeze sequence").
> +
> +. tests/block/rc
> +. common/null_blk
> +
> +DESCRIPTION="Test hang caused by freeze/unfreeze sequence"
> +TIMED=1
> +
> +requires() {
> +	_have_null_blk && _have_module_param null_blk shared_tags
> +}
> +
> +hotplug_test() {
> +	while :
> +	do
> +		echo 1 > /sys/kernel/config/nullb/"$1"/power
> +		echo 0 > /sys/kernel/config/nullb/"$1"/power
> +	done
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +	: "${TIMEOUT:=30}"
> +
> +	if ! _init_null_blk shared_tags=1 nr_devices=0 queue_mode=2; then
> +		return 1
> +	fi
> +
> +	mkdir -p /sys/kernel/config/nullb/0
> +	mkdir -p /sys/kernel/config/nullb/1
> +	hotplug_test 0 &
> +	pid0=$!
> +	hotplug_test 1 &
> +	pid1=$!
> +
> +	#bind process to two different CPU
> +	taskset -p 1 $pid0 >/dev/null
> +	taskset -p 2 $pid1 >/dev/null
> +
> +	sleep "$TIMEOUT"
> +	{
> +		kill -9 $pid0
> +		wait $pid0
> +		kill -9 $pid1
> +		wait $pid1
> +	} 2>/dev/null
> +
> +	rmdir /sys/kernel/config/nullb/1
> +	rmdir /sys/kernel/config/nullb/0
> +
> +	_exit_null_blk
> +	echo "Test complete"
> +}
> +

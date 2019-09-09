Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBADC00307
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 09:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A275321920
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 09:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfIIJ3z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:29:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26459 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbfIIJ3y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Sep 2019 05:29:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34D94C08EC33;
        Mon,  9 Sep 2019 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EFB619C78;
        Mon,  9 Sep 2019 09:29:48 +0000 (UTC)
Subject: Re: [PATCH blktests] nvme: Add new test case about nvme
 rescan/reset/remove during IO
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "osandov@fb.com" <osandov@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20190903081752.463-1-yi.zhang@redhat.com>
 <BYAPR04MB5749BFB675992BCE031582E286B50@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <57353580-1dcf-ee05-7232-1eb12f60b613@redhat.com>
Date:   Mon, 9 Sep 2019 17:29:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5749BFB675992BCE031582E286B50@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 09 Sep 2019 09:29:54 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 9/8/19 2:23 AM, Chaitanya Kulkarni wrote:
> On 09/03/2019 01:18 AM, Yi Zhang wrote:
>> Add one test to cover NVMe SSD rescan/reset/remove operation during
>> IO, the steps found several issues during my previous testing, check
>> them here:
>> http://lists.infradead.org/pipermail/linux-nvme/2017-February/008358.html
>> http://lists.infradead.org/pipermail/linux-nvme/2017-May/010259.html
>>
>> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
>> ---
>>    tests/nvme/031     | 43 +++++++++++++++++++++++++++++++++++++++++++
>>    tests/nvme/031.out |  2 ++
>>    2 files changed, 45 insertions(+)
>>    create mode 100755 tests/nvme/031
>>    create mode 100644 tests/nvme/031.out
>>
>> diff --git a/tests/nvme/031 b/tests/nvme/031
>> new file mode 100755
>> index 0000000..4113d12
>> --- /dev/null
>> +++ b/tests/nvme/031
>> @@ -0,0 +1,43 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2019 Yi Zhang <yi.zhang@redhat.com>
>> +#
>> +# Test nvme pci adapter rescan/reset/remove operation during I/O
>> +#
>> +# Regression test for bellow two commits:
>> +# http://lists.infradead.org/pipermail/linux-nvme/2017-May/010367.html
>> +# 986f75c876db nvme: avoid to use blk_mq_abort_requeue_list()
>> +# 806f026f9b90 nvme: use blk_mq_start_hw_queues() in nvme_kill_queues()
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="test nvme pci adapter rescan/reset/remove during I/O"
>> +TIMED=1
>> +
>> +requires() {
>> +	_have_fio
>> +}
>> +
>> +device_requires() {
>> +	_test_dev_is_nvme
>> +}
>> +
>> +test_device() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	pdev="$(_get_pci_dev_from_blkdev)"
>> +
>> +	# start fio job
>> +	_run_fio_rand_io --filename="$TEST_DEV" --size=1g \
>> +		--ignore_error=EIO,ENXIO,ENODEV --group_reporting  &> /dev/null &
>> +
>> +	# do rescan/reset/remove operation
>> +	echo 1 > /sys/bus/pci/devices/"${pdev}"/rescan
>> +	echo 1 > /sys/bus/pci/devices/"${pdev}"/reset
>> +	echo 1 > /sys/bus/pci/devices/"${pdev}"/remove
> Can you please use a variable for "/sys/bus/pci/devices/"${pdev}"/" ?
OK, will do that
>
> Also we need to validate above files rescan/reset/remove with if [ -f ]
> and report appropriate error if any of that is not preset.
OK, will do for rescan/remove sysfs.
As Omar said, the QEMU env doesn't have the "reset" attribute, I will 
skip the error reporting for "reset".
[root@dhcp-12-153 blktests]# lspci | grep -i nvm
00:01.0 Non-Volatile memory controller: Intel Corporation QEMU NVM 
Express Controller (rev 02)
[root@dhcp-12-153 blktests]# ll /sys/bus/pci/devices/0000\:00\:01.0/re*
--w--w----. 1 root root 4096 Sep  9 05:24 
/sys/bus/pci/devices/0000:00:01.0/remove
--w--w----. 1 root root 4096 Sep  9 05:24 
/sys/bus/pci/devices/0000:00:01.0/rescan
-r--r--r--. 1 root root 4096 Sep  9 05:24 
/sys/bus/pci/devices/0000:00:01.0/resource
-rw-------. 1 root root 8192 Sep  9 05:24 
/sys/bus/pci/devices/0000:00:01.0/resource0
-rw-------. 1 root root 4096 Sep  9 05:24 
/sys/bus/pci/devices/0000:00:01.0/resource4
-r--r--r--. 1 root root 4096 Sep  9 05:24 
/sys/bus/pci/devices/0000:00:01.0/revision


Thanks for the review, will send the V2 later.

>> +	sleep .5
>> +	echo 1 > /sys/bus/pci/rescan
>> +	sleep 5
>> +
>> +	echo "Test complete"
>> +}
>> diff --git a/tests/nvme/031.out b/tests/nvme/031.out
>> new file mode 100644
>> index 0000000..ae902bd
>> --- /dev/null
>> +++ b/tests/nvme/031.out
>> @@ -0,0 +1,2 @@
>> +Running nvme/031
>> +Test complete
>>


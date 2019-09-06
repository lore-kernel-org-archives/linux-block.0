Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ED6C43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 09:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C52620842
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 09:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392878AbfIFJXY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:23:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392864AbfIFJXY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Sep 2019 05:23:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F4D27E427;
        Fri,  6 Sep 2019 09:23:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A4E560A97;
        Fri,  6 Sep 2019 09:23:18 +0000 (UTC)
Subject: Fwd: Re: [PATCH blktests] nvme: Add new test case about nvme
 rescan/reset/remove during IO
References: <f77317f0-401d-614c-f136-d96ee7b9dd34@redhat.com>
From:   Yi Zhang <yi.zhang@redhat.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block <linux-block@vger.kernel.org>, osandov@fb.com,
        Ming Lei <ming.lei@redhat.com>
X-Forwarded-Message-Id: <f77317f0-401d-614c-f136-d96ee7b9dd34@redhat.com>
Message-ID: <27060ac3-dbed-7d38-95d8-378b935adab7@redhat.com>
Date:   Fri, 6 Sep 2019 17:23:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f77317f0-401d-614c-f136-d96ee7b9dd34@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 06 Sep 2019 09:23:24 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar

Thanks for your review, pls check my comments inline

On 9/5/19 2:21 AM, Omar Sandoval wrote:
> On Tue, Sep 03, 2019 at 04:17:52PM +0800, Yi Zhang wrote:
>> Add one test to cover NVMe SSD rescan/reset/remove operation during
>> IO, the steps found several issues during my previous testing, check
>> them here:
>> http://lists.infradead.org/pipermail/linux-nvme/2017-February/008358.html
>> http://lists.infradead.org/pipermail/linux-nvme/2017-May/010259.html
>>
>> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
>> ---
>> tests/nvme/031 | 43 +++++++++++++++++++++++++++++++++++++++++++
>> tests/nvme/031.out | 2 ++
>> 2 files changed, 45 insertions(+)
>> create mode 100755 tests/nvme/031
>> create mode 100644 tests/nvme/031.out
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
>> + _have_fio
>> +}
>> +
>> +device_requires() {
>> + _test_dev_is_nvme
>> +}
>> +
>> +test_device() {
>> + echo "Running ${TEST_NAME}"
>> +
>> + pdev="$(_get_pci_dev_from_blkdev)"
>> +
>> + # start fio job
>> + _run_fio_rand_io --filename="$TEST_DEV" --size=1g \
>> + --ignore_error=EIO,ENXIO,ENODEV --group_reporting &> /dev/null &
>> +
>> + # do rescan/reset/remove operation
>> + echo 1 > /sys/bus/pci/devices/"${pdev}"/rescan
>> + echo 1 > /sys/bus/pci/devices/"${pdev}"/reset
> My QEMU VM doesn't have the "reset" attribute, I'm guessing because of
> this code in pci_create_capabilities_sysfs():
>
> if (dev->reset_fn) {
> retval = device_create_file(&dev->dev, &reset_attr);
> if (retval)
> goto error;
> }
>
> We can skip the reset if the attribute doesn't exist.

OK, will change to bellow to skip it.

   # QEMU VM doesn't have the "reset" attribute, skip it

     if [[ -e /sys/bus/pci/devices/"${pdev}"/reset ]]; then
             echo 1 > /sys/bus/pci/devices/"${pdev}"/reset
     fi

>> + echo 1 > /sys/bus/pci/devices/"${pdev}"/remove
>> + sleep .5
>> + echo 1 > /sys/bus/pci/rescan
>> + sleep 5
> Instead of sleep, we can kill and wait for fio.

OK, will add bellow kill and wait cmd

     { kill $!; wait; } &> /dev/null

After remve/rescan operation, the nvme  need about 3s to be 
reinitialized on my environment, so I added sleep 5 here,

how about add bellow loop to wait for the device node?

     # wait nvme reinitialized
     local m
     for ((m = 0; m < 10; m++)); do
             if [[ -b "${TEST_DEV}" ]]; then
                 break
             fi
             sleep 0.5
     done
     if (( m > 9 )); then
             echo "nvme still not reinitialized after 5 seconds!"
     fi

>
> Thanks!

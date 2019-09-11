Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA33FECDE27
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 08:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A0421D7D
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 08:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfIKIsk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:48:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfIKIsk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 04:48:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99AFAA37196;
        Wed, 11 Sep 2019 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDE541001944;
        Wed, 11 Sep 2019 08:48:29 +0000 (UTC)
Subject: Re: [PATCH V2 blktests] nvme: Add new test case about nvme
 rescan/reset/remove during IO
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@osandov.com" <osandov@osandov.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20190909164537.2729-1-yi.zhang@redhat.com>
 <BYAPR04MB57492918C78F461EDF94D23586B70@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <08e230e1-f4c1-80ef-1432-efbf761f2804@redhat.com>
Date:   Wed, 11 Sep 2019 16:48:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB57492918C78F461EDF94D23586B70@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 11 Sep 2019 08:48:39 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Chaitanya
Thanks for your review.

On 9/10/19 1:03 AM, Chaitanya Kulkarni wrote:
> On 09/09/2019 09:47 AM, Yi Zhang wrote:
>> Add one test to cover NVMe SSD rescan/reset/remove operation during
>> IO, the steps found several issues during my previous testing, check
>> them here:
>> http://lists.infradead.org/pipermail/linux-nvme/2017-February/008358.html
>> http://lists.infradead.org/pipermail/linux-nvme/2017-May/010259.html
>>
>> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
>> ---
>>
>> changes from v1:
>>    - add variable for "/sys/bus/pci/devices/${pdev}"
>>    - add kill $!; wait; for background fio
>>    - add rescan/reset/remove sysfs node check
>>    - add loop checking for nvme reinitialized
>>
>> ---
>> ---
>>    tests/nvme/031     | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>>    tests/nvme/031.out |  2 ++
>>    2 files changed, 73 insertions(+)
>>    create mode 100755 tests/nvme/031
>>    create mode 100644 tests/nvme/031.out
>>
>> diff --git a/tests/nvme/031 b/tests/nvme/031
>> new file mode 100755
>> index 0000000..db163a2
>> --- /dev/null
>> +++ b/tests/nvme/031
>> @@ -0,0 +1,71 @@
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
>> +	local sysfs="/sys/bus/pci/devices/${pdev}"
>> +
>> +	# start fio job
>> +	_run_fio_rand_io --filename="$TEST_DEV" --size=1g \
>> +		--group_reporting  &> /dev/null &
>> +
>> +	sleep 5
>> +
>> +	# do rescan/reset/remove operation
>> +	if [[ -f "${sysfs}"/rescan ]]; then
>> +		echo 1 > "${sysfs}"/rescan
>> +	else
>> +		echo "${sysfs}/rescan doesn't exist!"
>> +	fi
>> +	# QEMU VM doesn't have the "reset" attribute, skip it
>> +	if [[ -f "${sysfs}"/reset ]]; then
>> +		echo 1 > "${sysfs}"/reset
>> +	fi
>> +	if [[ -f "${sysfs}"/remove ]]; then
>> +		echo 1 > "${sysfs}"/remove
>> +	else
>> +		echo "${sysfs}/remove doesn't exist!"
>> +
>> +	fi
> This is a lot of code repetition. You should be creating one helper
> and passing just file names. (No need to check the return value).
> something like this :-
>
> check_sysfs()
> {
> 	local sysfs_attr=$1
>
> 	if [[ -f "${sysfs_attr}" ]]; then
> 		echo 1 > "${sysfs_attr}"
> 	else
> 		#TODO : add a check to not print if sysfs_attr is not
>                   #reset
> 		echo "${sysfs_attr] doesn't exist!"
> 	fi
> }
> and call above function here :-
>
> 	for i in rescan remove reset; do
> 		check_sysfs_attr $i
> 	done
will fix it in next version

>> +
>> +	{ kill $!; wait; } &> /dev/null
>> +
>> +	echo 1 > /sys/bus/pci/rescan
>> +
>> +	# wait nvme reinitialized
>> +	local m
> Please declare all the local variables at the start of the function.
>
> Do we need to call udevadm settle here ?
agree, will add it.

>
>> +	for ((m = 0; m < 10; m++)); do
>> +		if [[ -b "${TEST_DEV}" ]]; then
>> +			break
>> +		fi
>> +		sleep 0.5
>> +	done
>> +        if (( m > 9 )); then
>> +                echo "nvme still not reinitialized after 5 seconds!"
>> +        fi
> Please recheck the alignment in the above if.
Thanks.

>
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


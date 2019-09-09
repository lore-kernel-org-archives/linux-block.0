Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DA6C4740A
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 16:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AB82082C
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 16:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfIIQOA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:14:00 -0400
Received: from ale.deltatee.com ([207.54.116.67]:38098 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfIIQOA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Sep 2019 12:14:00 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1i7MIf-0004wZ-7B; Mon, 09 Sep 2019 10:13:58 -0600
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Omar Sandoval <osandov@fb.com>
References: <20190905174347.30886-1-logang@deltatee.com>
 <BYAPR04MB5749A3E9B06514AF589FE13B86B50@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7ae33b82-88d7-2fa3-2bc3-da0b262d0ee8@deltatee.com>
Date:   Mon, 9 Sep 2019 10:13:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5749A3E9B06514AF589FE13B86B50@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: osandov@fb.com, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests] nvme/031: Add test to check controller deletion
 after setup
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019-09-07 12:19 p.m., Chaitanya Kulkarni wrote:
> On 09/05/2019 10:44 AM, Logan Gunthorpe wrote:
>> A number of bug fixes have been submitted to the kernel to
>> fix bugs when a controller is removed immediately after it is
>> set up. This new test ensures this doesn't regress.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>
>> ---
>>
>> This is reallly just a resend. The patches this tests for are all in
>> 5.3-rc7 or earlier and it passes on said kernel version.
>>
>> I've rebased this patch onto the latest blktests as of today with no
>> changes required.
>>
>> Thanks,
>>
>> Logan
>>
>>   tests/nvme/031     | 55 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nvme/031.out |  2 ++
>>   2 files changed, 57 insertions(+)
>>   create mode 100755 tests/nvme/031
>>   create mode 100644 tests/nvme/031.out
>>
>> diff --git a/tests/nvme/031 b/tests/nvme/031
>> new file mode 100755
>> index 000000000000..16390dcb380e
>> --- /dev/null
>> +++ b/tests/nvme/031
>> @@ -0,0 +1,55 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2019 Logan Gunthorpe
>> +#
>> +# Regression test for the following patches:
>> +#    nvme: fix controller removal race with scan work
>> +#    nvme: fix regression upon hot device removal and insertion
>> +#    nvme-core: Fix extra device_put() call on error path
>> +#    nvmet-loop: Flush nvme_delete_wq when removing the port
>> +#    nvmet: Fix use-after-free bug when a port is removed
>> +#
>> +# All these patches fix issues related to deleting a controller
>> +# immediately after setting it up.
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="test deletion of NVMeOF controllers immediately after setup"
>> +QUICK=1
>> +
>> +requires() {
>> +	_have_program nvme &&
>> +	_have_modules loop nvme-loop nvmet &&
>> +	_have_configfs
>> +}
>> +
>> +test() {
>> +	local subsys="blktests-subsystem-"
>> +	local iterations=10
>> +	local loop_dev
>> +	local port
>> +
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	_setup_nvmet
>> +
>> +	truncate -s 1G "$TMPDIR/img"
>> +
>> +	local loop_dev
> Duplicate declaration of the local variable ?

Oops, yes, nice catch. I'll send an updated patch later this week.

Logan

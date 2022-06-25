Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A6FC43334
	for <linux-block@archiver.kernel.org>; Sat, 25 Jun 2022 07:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiFYHvZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Jun 2022 03:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiFYHvY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jun 2022 03:51:24 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BF5A47AF9
        for <linux-block@vger.kernel.org>; Sat, 25 Jun 2022 00:51:23 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A96o3ga+aosuxaEf95XudDrUDvXyTJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUolhDcEnzcWDWyCbq6PZTDwco0iYIqyoUJU7JbQnYNlQFdlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/vQHOKlULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt9Rw2tVMt525T?=
 =?us-ascii?q?y8nI6/NhP8AFRJfFkmSOIUfouKWeyni7Z37I0ruNiGEL+9VJEU3O5AIv+xzBmp?=
 =?us-ascii?q?N3eIXJSpLbR2Zge+yhrWhRYFEncQiKsjgPIIFvTdjxC7QFv8lQLjcT66M7thdt?=
 =?us-ascii?q?ArcLOgm8e32PpJfMGQwKk+bJUAnB7veM7pm9M/Au5U1W2QwRIqpmJcK?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AVydcIKBfdSSTLoLlHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="125929549"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Jun 2022 15:51:22 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id A918B4D17189;
        Sat, 25 Jun 2022 15:51:18 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sat, 25 Jun 2022 15:51:19 +0800
Received: from [192.168.122.212] (10.167.226.45) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sat, 25 Jun 2022 15:51:18 +0800
Subject: Re: [PATCH blktests] nvmeof-mp/rc: Avoid skipping tests due to the
 expected SKIP_REASON
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
References: <20220624082039.5x2cl26q7v6rnm5n@shindev>
 <3e731962-6bf1-e45d-0b57-04a41c96dd96@fujitsu.com>
 <20220624121737.iqo35ocrtttqjzzr@shindev>
From:   "Li, Zhijian" <lizhijian@fujitsu.com>
Message-ID: <8252f7c4-ad54-3740-f4dc-482136dc7982@fujitsu.com>
Date:   Sat, 25 Jun 2022 15:51:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20220624121737.iqo35ocrtttqjzzr@shindev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-yoursite-MailScanner-ID: A918B4D17189.AC4E1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


on 6/24/2022 8:17 PM, Shinichiro Kawasaki wrote:
> On Jun 24, 2022 / 17:59, Li, Zhijian wrote:
>>> On Jun 24, 2022 / 15:50, Xiao Yang wrote:
>>>> In _have_kernel_option(), SKIP_REASON = "kernel option NVME_MULTIPATH
>>>> has not been enabled" is expected but all nvmeof-mp tests are skipped
>>>> due to the SKIP_REASON. For example: >
>>> ----------------------------------------------------- > ./check
>>> nvmeof-mp/001 > nvmeof-mp/*** [not run] > kernel option NVME_MULTIPATH
>>> has not been enabled >
>>> ----------------------------------------------------- > > Avoid the
>>> issue by unsetting the SKIP_REASON. > > Signed-off-by: Xiao Yang
>>> <yangx.jy@fujitsu.com>
>>> Good catch. Thanks!
>>>
>>> This issue was triggered by the commit 7ae143852f6c ("common/rc: don't unset
>>> previous SKIP_REASON in _have_kernel_option()"). So let's add a "Fixes" tag to
>>> note it.
>>>
>>>> --- > tests/nvmeof-mp/rc | 5 +++++ > 1 file changed, 5 insertions(+) >
>>>> diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc > index
>>> dcb2e3c..9c91f8c 100755 > --- a/tests/nvmeof-mp/rc > +++
>>> b/tests/nvmeof-mp/rc > @@ -24,6 +24,11 @@ and multipathing has been
>>> enabled in the nvme_core kernel module" > return > fi > > + # In
>>> _have_kernel_option(), SKIP_REASON = "kernel option > + # NVME_MULTIPATH
>>> has not been enabled" is expected so > + # avoid skipping tests by
>>> unsetting the SKIP_REASON
>>> Can we have shorter comment? Like:
>>>
>>>           # Avoid test skip due to SKIP_REASON set by _have_kernel_option().
>>>
>>>> +	unset SKIP_REASON
>> Well, IMO it's not always correct to unsetSKIP_REASON, for example, if the
>> OS didn't have kernel config file, we should report the test as 'not run'
> Actually, this group_requires() in tests/nvmeof-mp/rc has another
> _have_kernel_option() call for DM_UEVENT. It will catch and report the "no
> kernel config "case. So, I think it is ok to apply Xiao's solution to fix
> the current issue.
>
> I think Li's point is still valid, but let's take action for it later. One more
> point I want to mention is that "unset SKIP_REASON" is not a good practice. To
> seek for the best shape, I can think of following changes:

below changes sound good :)


>
> 1) Introduce _check_kernel_option(), which checks the specified kernel option
>     is defined, but does not set SKIP_RESAON. Using this, "unset SKIP_REASON" of
>     group_requires() in tests/nvme-of/rc (and tests/nvme/039) can be avoided.
>
> 2) Introduce _have_kernel_config_file() which sets SKIP_REASON when neither
>     /boot/config* nor /proc/config.gz is available. It can be called from the
>     group_requires() in tests/nvme-of/rc before _check_kernel_option() to ensure
>     the kernel option check is valid.
>



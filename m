Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C80C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 20:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356706AbiDSVBM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 17:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355486AbiDSVBM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 17:01:12 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C1341FA5
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650401906; x=1681937906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xjv2fWto2N+kSg1h18b7msqfmFI8VtHQJ2KL2A6ODjA=;
  b=G0Ylwm3MUVTuGXIZwpEayiP5PMIqqs6AzqQ6/ZQJCx4p15rjy48OFDO+
   JMK7ZozKxN8vuabAPg3CPU6BPPb9BKoGNeTaN+yowNUgzslW+OQqg1EtJ
   8e4htdkgfMy9ui674qwr10mnfiMwQg7Cbwdhr7u233DN6pXWDuZLRGPss
   BGRdSTVLzPf1/8IH8NGd1UPIDc0Qj6479u0FB1QqDkvkabUazwuhVep4M
   Vc1Rthu+6WY25Jx6ewlwYF/MSsjfqlOZhh2afQzKF2MGYfXYL5iwl8VEc
   QocXyVM6aBxYFMew/SAmjcGc6WNcA4VVVSndRp3uyfJ2zxg9IIBWql9Vl
   w==;
X-IronPort-AV: E=Sophos;i="5.90,273,1643644800"; 
   d="scan'208";a="203162724"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 04:58:26 +0800
IronPort-SDR: ADCFdvrWZQlk5JE15WFHYXE11nAwJktvQcphuX21DWAlamz8i2iF/nYxxxXBnIai9avkgv2GKp
 CkiH3Jh/+zKISIpJo7mflFKfcJWSe39IQDeL8s8pQUC28drd5DrLWl6mBNm7xNuyLTtJbOhiVw
 vcN1jlj+7VyhVXKC6Lj4p+kKNI71PvoHf/Qgef94mYXktHSuTl3Fm2vKJ613+pAcqcPwKPEHXk
 TGS4ZZDD9s36A4hCZw7slyaU7fSTPi83PpL1KJTVU2mnMU9YpJnptpmlkh8kaR1grU2VZHiZX2
 l8hb6nTywQPrtEhJN7DOqGYo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 13:28:45 -0700
IronPort-SDR: X7OVKA6NNS9/TUwwf5/sitjHZuan/rz3tu34abALHR72EqZdN7azc3bU02zeYy0pbs2jov5lsx
 Ry2bRCSsKdCj8yW5Q5hBkoJ/kU4yKFw2aZMGsypdLSSJAY59JRGz1tMK3u94+35y3VyEgQ5ACd
 owa1Avbd7SsgXUuhl2FyaVda+YYBMd05mfQEgCqGsr/nSvU+WCljhwUhYhbj6cjKNqEkg025Qu
 HwJQLnrR9N7cgHx82X1fFElCeJS5DAlNNz962D+12dwowdWeUFEyEHYAVmTHwaE5xMo6CWnsdo
 82U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 13:58:27 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjbkB5lT5z1SVnx
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 13:58:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650401906; x=1652993907; bh=Xjv2fWto2N+kSg1h18b7msqfmFI8VtHQJ2K
        L2A6ODjA=; b=FJdQm6aRkkTFbd7gCwif6D4XIkVTDVg3riuGRygL2e8dBd5eMF0
        orAfpl60ZOs0Akvfgl1Boh4BKq7OrUD3KU+1ib8KEdfntPLSKepELD2FAQsn2IJB
        8wLDqoiTCsOZqKvw4IKzTWNk029F87Ye5Xg1sEdLEnf1wBiE1PKJIy77LX5/Imo3
        GJazuFHmHvQ5aq2NrmMy33hPJcYq+WePjtlE9VDARSbY6QmCfbgGgkMS2/9ty9xP
        oXkq9gqEzYSoQwG14pq4IIiXotEdm5ipCzS3u/0ywLnPU3LdQHX8B9IiO599HyKz
        yP0jK5C2bl+7qJS/kP3FKnooRypZ7rbwNsA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yb08zuENK35h for <linux-block@vger.kernel.org>;
        Tue, 19 Apr 2022 13:58:26 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kjbk95bn9z1Rvlx;
        Tue, 19 Apr 2022 13:58:25 -0700 (PDT)
Message-ID: <c25455bf-a929-95cb-41f8-c8ee4f6b0d62@opensource.wdc.com>
Date:   Wed, 20 Apr 2022 05:58:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/4] block: null_blk: Improve device creation with
 configfs
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <20220419110038.3728406-1-damien.lemoal@opensource.wdc.com>
 <20220419110038.3728406-5-damien.lemoal@opensource.wdc.com>
 <03583c5a-00fb-a6a0-9021-592f61c17d91@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <03583c5a-00fb-a6a0-9021-592f61c17d91@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/22 20:55, Jens Axboe wrote:
> On 4/19/22 5:00 AM, Damien Le Moal wrote:
>> Currently, the directory name used to create a nullb device through
>> sysfs is not used as the device name, potentially causing headaches for
>> users if devices are already created through the modprobe operation
>> withe the nr_device module parameter not set to 0. E.g. a user can do
>> "mkdir /sys/kernel/config/nullb/nullb0" to create a nullb device while
>> /dev/nullb0 wasalready created from modprobe. In this case, the configfs
>                 ^^^
> 
> space

Re-sending to fix this. Also realized that using "#define pr_fmt" would
simplify patch 3. Updating that.

> 
>> nullb device will be named nullb1, causing confusion for the user.
>>
>> Simplify this by using the configfs directory name as the nullb device
>> name, always, unless another nullb device is already using the same
>> name. E.g. if modprobe created nullb0, then:
>>
>> $ mkdir /sys/kernel/config/nullb/nullb0
>> mkdir: cannot create directory '/sys/kernel/config/nullb/nullb0': File
>> exists
>>
>> will be reported to th user.
>>
>> To implement this, the function null_find_dev_by_name() is added to
>> check for the existence of a nullb device with the name used for a new
>> configfs device directory. nullb_group_make_item() uses this new
>> function to check if the directory name can be used as the disk name.
>> Finally, null_add_dev() is modified to use the device config item name
>> as the disk name for new nullb device, for devices created using
>> configfs. The naming of devices created though modprobe remains
>> unchanged.
>>
>> Of note is that it is possible for a user to create through configfs a
>> nullb device with the same name as an existing device. E.g.
> 
> This is nice, and solves both the confusing part of having
> pre-configured devices, but also using the actual directory name as the
> device name even if they are not ordered.
> 
> Only odd bit is you can create a device name where a special file of
> that name already exists, but I don't think that's solvable in a clean
> way and we just need to ignore that. That's arguably a user error, don't
> pick names that already exist.

Yes. add_disk() will fail if the device name already exist within the
"block" device class, but will not complain about anything if the existing
device belongs to another class.

I could add a "block" class wide check for device name existence in
null_find_dev_by_name() instead of only checking the nullb list ?


-- 
Damien Le Moal
Western Digital Research

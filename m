Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3943DC433FE
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 22:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26C660EB7
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 22:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhIFWcb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 18:32:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35284 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhIFWcb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Sep 2021 18:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630967486; x=1662503486;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=bNi6gtLKsuKCgkluH5I9H1vk3LG8Rrv2qnh74pX3JQ8=;
  b=LvY0aFfFd0GChn7g6Lc9pQ9yVvuk4U3SNGOHrWydnOPA1zW2ktQ0/qJf
   vB8e9sZAfeWOtkolrmOkopsqDh8kpH7eaRSvbQ0FzoXg3FtTaJBCq+I42
   mPMbyzCHIHdqf5QNYLSOyszdInJNIjal5V9nsFO8jhWanMqi6/OeMTLRD
   SoFjt1ygSYkzcwfvNegsDcdMUCjLA20ZyR/Pc57JeudCZphA2FZxziAxw
   p22a3nXacyWG+WZ1SHT9LBEqSSUkxSUA/0HC8xtSpFlU87H02hUqcTsIc
   bgpxAspc/W/9pqeeo2rCYQ5vJZYDHfP+c58uOWdvJbaDUt8MMoNfS77SW
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,273,1624291200"; 
   d="scan'208";a="283114143"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 06:31:24 +0800
IronPort-SDR: QK00tLx0gGipVpHn9q6Qje4IfDrH6CRgarxAxe7Am2JCWEYs2LKtEo4YfDUmpZr14zbolQRUO9
 Cv9O8C3NxvKGlQ9dPeTMO34jltBLauyfrIncDsGnU+3FfeDY/qctiypeexM8Qqlgs/ZAWwujVm
 RkzI8D6wqC1bXuPxD6oKLsfPD6k+yrtavwhLUyFrPFiDF9sUPkOOAPLv1lxT8LcS6QjA0DBIeE
 euwBXKz66Qz1AovgF+iI7dQCJrMw/zvigauuUBr9nZcFY76+zpl16i7Rbauw2R4N5vSxFIgpTR
 vk7k0NGWSvikXtimQVxB0JNg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 15:08:02 -0700
IronPort-SDR: Muyxr2jO3s8BOOOQISkgfo16lW90b1eiFPmDYu53urWtKJTJrl5HrZ+l28n/cIo/MT7rcxxzWv
 BGk9YdqFBwQsiCDfWx3f1rau/EjD3P4Hl1Agj7xbZeUZEYutlPqks/X5ac7ecl3qVghNpl0X+7
 MyI8enV5FgzGycbrV8qPynJtYuT/vxfheMsBRdu0WGzAzAfgb5w8FQBfXO2M5lIZmYrtogm4s+
 6aEKYKi5wuUBUenQpePYI14ghDZaWp1PnTLspNDGQQRooR9JE3DGmqd0OAv0mZy5gzkQkwM7eC
 K8A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 15:31:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4H3NRH5N1pz1RvlV
        for <linux-block@vger.kernel.org>; Mon,  6 Sep 2021 15:31:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-language
        :content-type:in-reply-to:mime-version:user-agent:date
        :message-id:organization:from:references:to:subject; s=dkim; t=
        1630967483; x=1633559484; bh=bNi6gtLKsuKCgkluH5I9H1vk3LG8Rrv2qnh
        74pX3JQ8=; b=F7oRa8szKkJHHFsEP9djyRdkeuBve19yf45+pdQsRXoLkQXNXCL
        jHfEOjrlR4KF430XdWXfdBbvKCHhb8Je1It/Nirw0Q8P8Kl21xuK6Mz3CkINDkCo
        B8CFr+BhtEqLw0fjjnVXBDAylDK6ZAM64rHzIiDudgO9HUEd4tWGZ0GFAZ9Krndl
        C6hTBy7d8+9hjU1Rp1K66Q19oGRFPCsWzubrfaxG7fR8Idi851aI9vGbFTFMMQAH
        DNjiEUad+04KQX6xeY0nfN2goSArEmzFwdFK4g9buksYe1wwfYdA66GKnwPU0Qaj
        0t2m+ZF43Q9CjfbP9vHzPwAunQ4Nre8VIDw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CwSEH7B3R4h3 for <linux-block@vger.kernel.org>;
        Mon,  6 Sep 2021 15:31:23 -0700 (PDT)
Received: from [10.225.48.54] (unknown [10.225.48.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4H3NRG30lHz1RvlP;
        Mon,  6 Sep 2021 15:31:22 -0700 (PDT)
Subject: Re: [PATCH v7 1/5] block: Add independent access ranges support
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20210906015810.732799-1-damien.lemoal@wdc.com>
 <20210906015810.732799-2-damien.lemoal@wdc.com>
 <9a253efe-d924-a8a8-10ac-c2787ce34cb7@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
Message-ID: <4bf7f824-b25e-4488-1907-ef91d7e02359@opensource.wdc.com>
Date:   Tue, 7 Sep 2021 07:31:21 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9a253efe-d924-a8a8-10ac-c2787ce34cb7@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/07 2:38, Jens Axboe wrote:
> On 9/5/21 7:58 PM, Damien Le Moal wrote:
>> struct blk_independent_access_ranges contains kobjects (struct kobject)
>> to expose to the user through sysfs the set of independent access ranges
>> supported by a device. When the device is initialized, sysfs
>> registration of the ranges information is done from blk_register_queue()
>> using the block layer internal function disk_register_iaranges(). If a
>> driver calls disk_set_iaranges() for a registered queue, e.g. when a
>> device is revalidated, disk_set_iaranges() will execute
>> disk_register_iaranges() to update the sysfs attribute files.
> 
> I really detest the iaranges "name", it's horribly illegible. If you
> want to stick with the ia thing, then disk_register_ia_ranges() would be
> a lot better (though still horrible, imho, just less so).

For the function names, similarly with the struct names, I can use the full
spelling, so disk_set_independent_access_ranges() and
disk_alloc_independent_access_ranges(). Same for the internal functions for
sysfs registration. Longer function names, but very clear I think.

> 
> Same goes for blk-iaranges, we really need to come up with something
> more descriptive here.

OK. I can rename the file to block/blk-independent-access-ranges.c. It is a long
but clear. Are you OK with shortened local variable names in that file ? Using
the full spelling make formatting of the code really hard due to the very long
lines.


-- 
Damien Le Moal
Western Digital Research

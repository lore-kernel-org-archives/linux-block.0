Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D01DC4338F
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 06:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B636023E
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 06:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhHHG3a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Aug 2021 02:29:30 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5909 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHHG3a (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Aug 2021 02:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628404151; x=1659940151;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=3GAC1Q1eyioWTbceJCqnnOuPi53DrTVF6wRNqBUDPwU=;
  b=B2NrBKY3RkJAWsW19rqvuRWM+bMI6iiYy9T3b9d4vTRqedULxMxM9JU0
   Le7E/u2WPk/a/sKGrjPhCfJRIJ9uzAHVSvC+HT5RyHxnPcI+h1EOQ3HMl
   zMoCKHRGKV82ol8IVX9pJItuI++kMO6aA5JF5nHj/a+/e3+MjeMwOPaEG
   Uiyt5j0/VwDEC8qAEcRFXgg7Q+YoVP1yq8iBV93UF3Dh0HeXwwrN+fcMN
   AE0kjPEHmcwY6op4C4qtVSKnxeXHXgUCLYWpfDuZAJxlWaJu5uyt3V84r
   +008azbj8iYLhwFaWG4j9t915jWHP0khIuPAxKcVyh9WLYU6tw7HNoIhm
   w==;
X-IronPort-AV: E=Sophos;i="5.84,304,1620662400"; 
   d="scan'208";a="288162594"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2021 14:29:11 +0800
IronPort-SDR: QYnw3fNfGh94rH0tD8lDW+qtgOhaOTQNJZTqATAJZNHIaNjvQ5vPdMdEO5gMkoLksEr0QcBAPP
 4siPL6/zHNXp8zRb+VDX0CbSlJlEFyqR9noce9xlQXvUxskm81mjVuoFz+KtegBL5C57u3H8Pv
 LZKkaM9vO+QuLGug41A1Ks7MN04TP4nPMk04MQK+hQ1sipIcSHglEZ+yAII3zVuF6xaJtKipBc
 +agkvFvMJVZxtHGakT9z7LTrbnWHniuO3pgdC+yliETM5odwlPcF7AvhsEw3SqFrbmr9R7HBnG
 vsHaw+nlrN2vh0KcFOo2knEA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2021 23:06:36 -0700
IronPort-SDR: 2AlAspc+VF+VXfSmvl7XIq5Jnk50wEDJQI09H6+gIzI039pBs5JJiVwV++UC6G9w4d+tglpI/t
 tg+5UWUnXEE+pRZ+vYGzqBCRshbKxXyxW3EHUB2r8mMnJaGu+oid5lCSYxsTp5GNFFwKFzbu8H
 0yIk8TuOUTfrbhqklCCJUjvA74eFbWroWRz8NjrNlPamoDk/PhS+D2dTBuja7Ek/T2/dP+/L0v
 q0iIG6uZCf8suHrDxdlB6Jm+6INvKSgc5bYIXkWAzQ1efjr6tk/Kye7bOfvOuq/5o9w87D6SDD
 yZ4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2021 23:29:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Gj8SR22V5z1RvlK
        for <linux-block@vger.kernel.org>; Sat,  7 Aug 2021 23:29:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-language
        :content-type:in-reply-to:mime-version:user-agent:date
        :message-id:organization:from:references:to:subject; s=dkim; t=
        1628404150; x=1630996151; bh=3GAC1Q1eyioWTbceJCqnnOuPi53DrTVF6wR
        NqBUDPwU=; b=iSMFNrC0RjlpU7HT24FoAgDrjFQm+Qs/a7M1tOiYpyGWMoZYMvc
        qEZCjnEN2NLLPdANrPJ5diihsqPcGmCEE85GJSvg6KQG3knJxzSSmYlAP3eHEF+t
        I/tWDkH/fpctQnOluM7rhPQPd75neJ5vm0R50nmLQMBSICU0UYYa5yVp66zHdDAB
        iU85BPPqc6Elac44IObBuXmUD8uw8UpnXxU+NZM3zeSqFfAto5GXYTzM3QxRjO7A
        w9mFvws0U0PmNnIybErLXIK5colf7YnGSRy4jkD+mjcE0l9JfyfrAowBVb6Wu7vN
        qQ3CGeqbm0DyST/Gm7O1mqNICWVGiO4u6GQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZDJM0XN7kyrF for <linux-block@vger.kernel.org>;
        Sat,  7 Aug 2021 23:29:10 -0700 (PDT)
Received: from [10.225.48.54] (unknown [10.225.48.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Gj8SP5KDrz1RvlC;
        Sat,  7 Aug 2021 23:29:09 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] block: rename IOPRIO_BE_NR
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20210806111857.488705-1-damien.lemoal@wdc.com>
 <20210806111857.488705-4-damien.lemoal@wdc.com>
 <5f2640c5-0712-b822-9ac7-3daa974c0c30@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
Message-ID: <e98cdc46-a58e-2c20-b0ab-5a93c4bf66c0@opensource.wdc.com>
Date:   Sun, 8 Aug 2021 15:29:08 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5f2640c5-0712-b822-9ac7-3daa974c0c30@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/08 1:16, Jens Axboe wrote:
> On 8/6/21 5:18 AM, Damien Le Moal wrote:
>> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
>> index abc40965aa96..99d37d4807b8 100644
>> --- a/include/uapi/linux/ioprio.h
>> +++ b/include/uapi/linux/ioprio.h
>> @@ -31,9 +31,9 @@ enum {
>>  };
>>  
>>  /*
>> - * 8 best effort priority levels are supported
>> + * The RT and BE priority classes both support up to 8 priority levels.
>>   */
>> -#define IOPRIO_BE_NR	8
>> +#define IOPRIO_NR_LEVELS	8
> 
> That might not be a good idea, if an application already uses
> IOPRIO_BE_NR...

Hmmm. include/uapi/linux/ioprio.h is being introduced with kernel 5.15. These
definition are not UAPI level right now.

What about something like this:

#define IOPRIO_NR_LEVELS	8
#define IOPRIO_BE_NR		IOPRIO_NR_LEVELS

To keep IOPRIO_BE_NR ?

OR,

Keep IOPRIO_BE_NR as is in include/uapi/linux/ioprio.h and add

#define IOPRIO_NR_LEVELS	IOPRIO_BE_NR

in include/linux/ioprio.h ?

Both would still allow doing some cleanup kernel side.

Or I can just drop this patch too.

-- 
Damien Le Moal
Western Digital Research

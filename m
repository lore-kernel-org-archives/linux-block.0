Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F6FC4338F
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 06:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A7460FF2
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 06:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhHHGcX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Aug 2021 02:32:23 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46788 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHHGcW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Aug 2021 02:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628404324; x=1659940324;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=ZUKKExjkwoKwlQDbiX2Ci8kvte+LdrWVT0+BHiCgXTM=;
  b=n5onvIcBuvutgxIkfWWrlFHAugYnTH2wlDJ/Kci1elGrGeg7Te2s15Lr
   z75RgUIDshjuUX0AdhuG8VzvUxUhMUUNugbZbq9pqO4MNrYB9ypfssTlv
   tX8qgUFtKN/fsvMrd32v2n/GSsVFfNouyz1o2aGYzdbZSndmL3H/zYNtN
   hQpIS9icq6qFAcJFTfwy9HvHOLDPGHYv9Wwyx9paaNFHV1tMIFyaW1Jx0
   iPmUXaotgHMT82+qs4xKSdFdj0pal0fKfscPXdBePnpW6FleLinJ2uqoH
   IJEF9jCL9V4uDhF8tJ+hCP0RDMKYPbJSxT1jU4fL49j+BgYjhbMZMtcXC
   g==;
X-IronPort-AV: E=Sophos;i="5.84,304,1620662400"; 
   d="scan'208";a="280444387"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2021 14:32:03 +0800
IronPort-SDR: 1p0mQ7TFVzvGJKrb+HiW7ts1mfwOt5kEK6y7B1paQxxzblWS6L1lkfWJJC86HNpJ7ITvgGxooJ
 yHl/u2VaJsl7XHUv+mbmLQ6DKP3NA98u/DZc09kokmvmJfmEKbTLWHjNz3gc9gfuGhFyKCOGbM
 PRycwKpmB77M17jMtM/dFctaEUmQzzi5+HK37/wwYmHyd8nVi11aT4tKPTvPUY/EWw/dg/hOS/
 eHURISuRUg9rZbglDm/NWXvU+yajGPxLEayIqJfqGefqH828U9vjGfy9mh9vFBk2D9UVDvHfc7
 oMhNSMS1Tu4D+gXzVvm/j/QX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2021 23:07:38 -0700
IronPort-SDR: lE+X98U9mflErTJ+K3z7ct7dNHU1U68eVslWlvoVE/9B6k2r/ag2JC0PbT0zOfgDguyq34Pyor
 6vJLNllV2yFQwn3oPbx4rsehup4C+tXeVrbfrrd80z9nbvvWarKJin16tszUlICiqg19FwAcU5
 uAYcg7x+pkJy7Y6NAYjd/HQtZBM/4Y1M2BkgpMTF1SiJQaKIfx9zxlkECCLSi3O7xjxz4VBAEA
 phkMGfPH26XZkEG0CbFUxu2eibpVkWfYFAdg1SYomhxR8LtwT3JUcogcwkBOSrQIG3laGyLnaK
 FdI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2021 23:32:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Gj8Wl4x2Yz1RvlM
        for <linux-block@vger.kernel.org>; Sat,  7 Aug 2021 23:32:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-language
        :content-type:in-reply-to:mime-version:user-agent:date
        :message-id:organization:from:references:to:subject; s=dkim; t=
        1628404321; x=1630996322; bh=ZUKKExjkwoKwlQDbiX2Ci8kvte+LdrWVT0+
        BHiCgXTM=; b=FMNNgEcxsAPBkYxmdxbCuemvjg6wlfEqjXJ01vI7wY5foawbmtH
        1iAM5ueQWX9vYmyoDaSIyLcuHQPxtCOIHvn+oBT0Ig6vftNUc+/eQHe7fB3QbRmg
        AI9gaDxVoXU0VMUARuhQyO9OUXO5p9EGOhKoNhvGhpO5YE83hSl+RyDXYMsv/alT
        7zROsS+G6r0CUDnQYjjywqliiKY3JZkE+V5Lz4drYvlmsiCNGK6fQsXwDjrjUOqF
        gl+3FAX/Dzb5hAvgqCuBRtKUG/PtV56RVLSvzwt+NfCkqsfsYvDFvA5nbEINdGmz
        pxHBFZJHVPtYkax/+G9HedE4AoFKTkOZsiA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5FF7at8cqzgh for <linux-block@vger.kernel.org>;
        Sat,  7 Aug 2021 23:32:01 -0700 (PDT)
Received: from [10.225.48.54] (unknown [10.225.48.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Gj8Wh4zh4z1RvlC;
        Sat,  7 Aug 2021 23:32:00 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] block: fix default IO priority handling
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20210806111857.488705-1-damien.lemoal@wdc.com>
 <20210806111857.488705-5-damien.lemoal@wdc.com>
 <4bfdceb3-36a7-c224-c1cc-ab273ab15589@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
Message-ID: <2eb8cf57-952c-7485-e7b9-8c982b379975@opensource.wdc.com>
Date:   Sun, 8 Aug 2021 15:31:59 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <4bfdceb3-36a7-c224-c1cc-ab273ab15589@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/08 1:19, Jens Axboe wrote:
> On 8/6/21 5:18 AM, Damien Le Moal wrote:
>> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
>> index 99d37d4807b8..5b4a39c2f623 100644
>> --- a/include/uapi/linux/ioprio.h
>> +++ b/include/uapi/linux/ioprio.h
>> @@ -42,8 +42,8 @@ enum {
>>  };
>>  
>>  /*
>> - * Fallback BE priority
>> + * Fallback BE priority level.
>>   */
>> -#define IOPRIO_NORM	4
>> +#define IOPRIO_BE_NORM	4
> 
> This again seems like a very poor idea.

OK. Will remove that. Or we could do:

#define IOPRIO_NORM	4
#define IOPRIO_BE_NORM	IOPRIO_NORM

In case other classes want to set a different default... Though, that is not
critical I think.

-- 
Damien Le Moal
Western Digital Research

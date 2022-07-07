Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115DDC43334
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 22:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiGGWIB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 18:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiGGWIA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 18:08:00 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FF35C967
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657231679; x=1688767679;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Jcbkis6ueOEcETD9ZZvN8IRAci++ian9KhgTLSOCUY=;
  b=DbUAzu88oEzziw+3KqMfgSIJGsHjjAB4L4vMojOT/Led4XtOyNWge6Pq
   7VGAWPi0SFa3faXkpd/pm/n+Nes/LeBBqhHFLYRhRxktzquOrpU8ERR1s
   5vzC5i99mSHrrj2N/FvzVvRvEjfQJE+NN1ST/2NKCkqpGieOjxgF1Fof0
   VBBduh2HqKl76b8k7b8YeeLJw5X90bcKyiQd518OpzHvEltGjyF6BlpcV
   8WUwmjzoMvPuI1IrG15JV6FpKNvt/P+iZjmiw+XV66g+TNMGDo1JlP08d
   aSSZIwHWV/CsCJvv2cM1PYeteRVA6F4jrHhVgknLAPksF8jI1SuBaUiYZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,253,1650902400"; 
   d="scan'208";a="317257889"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2022 06:07:59 +0800
IronPort-SDR: 6AH0tGkXDWXO5o9rSImfaBjeRtpq2VgHMCQSZ1SPqbhoBiRXkpTXySCceMPduQhj9T0lfp0+8j
 1ry2Cc0FB0o2u0n4eOglVeOGBq5eDCxw7yVgkhIPcXK1/TLgejWS7rXIWGo8F9jelX99EQspWd
 Mi52n7JIDKS4ir4v0AtkLwS5QifHfTzG9sXUyu9xZ9GjWTDZhl+E8GRXDNoI4mSd3ydJ5mZZpY
 iqCnOcHZhTis+0A0Z8wAQsxYJHEmg5DqrEUBrkx7sNXD7L9iuNchc5hESfGqFb6BmX7KqgdHX4
 XpfQ+pqgaUJbcz8rw34e6p/T
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jul 2022 14:25:12 -0700
IronPort-SDR: vGGw49vf/t/qKELC0ChIIe8PNU5ka7l6OqcxFAz4KZTCvKvy3WPeashCQY13OIOvC/lUQJMvae
 tfq3wpt7kEXfN9qGU1CTfrETbrUtNAU0cZ1ygaC6Qj2y3ZZp7wK+mB/JkG7vndLELb3pjvF77Z
 v+/+fc7+qKHAA+UQuYjYIMJeHeYur4MWHe2qwLR2emVzwoipD9V04j52APPZgqlSlyLJeIbl30
 okOAr85OcA/KmLKveZuCZlFrqhhVR+mhVodAQR4/3N/t/uzK7q+LJ1O4Nz3vK3JfPE0TlOPqpi
 Oos=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jul 2022 15:08:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Lf9Wz0qXpz1Rwnx
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 15:07:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1657231678; x=1659823679; bh=8Jcbkis6ueOEcETD9ZZvN8IRAci++ian9Kh
        gTLSOCUY=; b=sBdYeYT//qBL4XiBOl6nAvLFS6uZQKf8z9l9kmuALXyfgdba9r0
        gKb23Lv+QzlFFc111wuZO7d6cqkeVpOAf982JZAEh+eiEpEV1zyqUdujEHZTyenB
        lcmWm/a10vr6o4KowjRPzcDbTZTUJcTIkgsHGC7knhpG7O+JFfWZ9kd++/0lLFyp
        3wrR0owkW9FzcQtF+rwiSwZyqHSruqQjIFVDIhK0/rmoSjco7PS4Ur6ND8cce/5l
        pgM1PXQUH+4KUkYIJ1pbJLqnxh3dWS6RFc0G21IotoW8DPX73Fv26bsjpk/9aacF
        fCPD86sFT3VY27sJu1TOZpFupwUkbsYxq9g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I8aYaaBecpkw for <linux-block@vger.kernel.org>;
        Thu,  7 Jul 2022 15:07:58 -0700 (PDT)
Received: from [10.225.163.110] (unknown [10.225.163.110])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Lf9Wx4vYmz1Rw4L;
        Thu,  7 Jul 2022 15:07:57 -0700 (PDT)
Message-ID: <c9ec1fe9-5949-635e-f26b-84283b7924ae@opensource.wdc.com>
Date:   Fri, 8 Jul 2022 07:07:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 63/63] fs/zonefs: Use the enum req_op type for request
 operations
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-64-bvanassche@acm.org>
 <f42c76ef-ae9a-71ee-e1e0-1aa3cbbad154@opensource.wdc.com>
 <ef46a115-62eb-2fa5-5e7c-264be950bda8@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ef46a115-62eb-2fa5-5e7c-264be950bda8@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/8/22 02:58, Bart Van Assche wrote:
> On 6/30/22 16:39, Damien Le Moal wrote:
>> On 6/30/22 08:31, Bart Van Assche wrote:
>>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Cc: Naohiro Aota <naohiro.aota@wdc.com>
>>> Cc: Johannes Thumshirn <jth@kernel.org>
>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>> ---
>>>   fs/zonefs/trace.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h
>>> index 21501da764bd..42edcfd393ed 100644
>>> --- a/fs/zonefs/trace.h
>>> +++ b/fs/zonefs/trace.h
>>> @@ -25,7 +25,7 @@ TRACE_EVENT(zonefs_zone_mgmt,
>>>   	    TP_STRUCT__entry(
>>>   			     __field(dev_t, dev)
>>>   			     __field(ino_t, ino)
>>> -			     __field(int, op)
>>> +			     __field(enum req_op, op)
>>>   			     __field(sector_t, sector)
>>>   			     __field(sector_t, nr_sectors)
>>>   	    ),
>>
>> Nit: the patch title could be more to the point, E.g.
>>
>> fs/zonefs: Use the enum req_op type for zone operation trace events
>>
>> Otherwise, looks good.
>>
>> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
> How about using the title "fs/zonefs: Use the enum req_op type for 
> tracing request operations"?

Works too.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research

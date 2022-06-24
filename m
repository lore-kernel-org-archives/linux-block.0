Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A2BC43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 00:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiFXADb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 20:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiFXAD3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 20:03:29 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1C2CE0A
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 17:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656029008; x=1687565008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=voxWz2uqAK5/OMOqise+kPm35L/6eZKl+JtetU5V+aE=;
  b=n2OnLMIprHgVPNJkWBiloiphcQOgDc7xC83OklZnHyfXKF1Nc4bMCREt
   0aEZJH7JLlmppksPfm0QFUoKDvJ9bY/ybzwBHp57wxsSe97CGNDpRx5xu
   GjGrA5Fek4UxOFj3L8x+LK5xQJ6pIR6PcHeHbOnr/NeMfeAnngx6yZkCg
   qn6eOBKOZarNGgjQdKpErxoX/DHFS/+SEBOg4tJNfYohEjP72BZaX5/3F
   u7+Esvh2iXSRmb4+4ECcMboYTlsA60IOAGo90avoh9TcoMkuFs+LbfFso
   lkvLMBlCmIwsVQLBrsPvTUAXc3WURAhc+T4iKQcuiABarWV4FBvThJWY4
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,217,1650902400"; 
   d="scan'208";a="203966317"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 08:03:27 +0800
IronPort-SDR: P1pR3aKjJvcyft/wkAwKpo+qwqcP2jSkfpRTZVovyjZvEulsI84PT5Vs2CufSDDBYuo75HrMZY
 QfAHm1p9TyY7O/ZJ3Waexrj/UgkodyYYkPSAYhGfeTmItBalY/JiK7SmcdvddBtlhXh/CFxMrq
 PkuEAFmqSi01T/yfOy6O/wZ3fMoyc3SGacYGsosTxaFPCNrCW7dQfGlqwt8TS9suiftJA75yLd
 wwaK+QO88spuf1X3IMMRVNHzPLGshUhyzsG9AWWjGY6/l2rXW5nAjKENzEppVVVeXnizMaMmqD
 rbK91FPqu+ocWRUOotSjMxDE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 16:21:13 -0700
IronPort-SDR: LINLgKoJVfLwhWWEJo2eX7ghwwmrDiQryWLrdm9vHqSxoyh5/dDa+uS7PwudC3I0vaP2GEd1A4
 eDFUiXV0W+TW7GSKoOPBd7Q5XAMGlPUa/PW5c12Y35HEkUGe8kYU/P3ky4px4wKBOsosNZ+jZX
 dA2BVTP5rdKTE5lAPgIeXix2vHaAR9maKHBuABLdHxbUZOtN6lKi95JD7AItnUAPk4JHFF+Bcc
 weAb+vkkt625+YoxAWEfEtzdKxJVGnOlmxbz0G8Uhh47eSZetzvU6y7WcQS2M/3cp6WqB83lwv
 ZPA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 17:03:29 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTclg50wLz1Rwqy
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 17:03:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656029007; x=1658621008; bh=voxWz2uqAK5/OMOqise+kPm35L/6eZKl+Jt
        etU5V+aE=; b=Gw+Qo2nEeINTSNj3EXvrYn9RpllK62N24V+aYhIJKyLPZM90yjj
        JlQvJ6BA1ea2WgUXdC9aPfisY6RPX3SElnm/EXSXZDv+8bwPdBVEUlFZeLnexkXa
        NMbapq35K/zvV5ga5hiqCBdZ6TwP9EkVGQdYaP9B7ib0z3cvjo5DsioPFDF1D0b3
        DoORaRHVjbOQsoZNZi8cwbFnL2waat+1rvq8VXJHGUoWw7ArRjkzofjL033fxWHW
        NRAUZEU+h9Ky8Vus3PjxCQKw7JVh6dHxNju8hqLZtZ4Rt1JEowUF3EtkGI0ImBU6
        Voeie9SE0gHRecMgpcZzBA+LZEzcSQXdmdw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GmnQ_CXPxq_i for <linux-block@vger.kernel.org>;
        Thu, 23 Jun 2022 17:03:27 -0700 (PDT)
Received: from [10.225.163.93] (unknown [10.225.163.93])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTcld5q2Jz1RtVk;
        Thu, 23 Jun 2022 17:03:25 -0700 (PDT)
Message-ID: <28a099c1-e0f8-3976-84f0-07500c28bead@opensource.wdc.com>
Date:   Fri, 24 Jun 2022 09:03:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 51/51] fs/zonefs: Fix sparse warnings in tracing code
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-52-bvanassche@acm.org>
 <c7de3cfd-ec60-05ab-d05c-a9c356ba6cf6@opensource.wdc.com>
 <d5896d8a-a30d-2778-58c4-2c4b998da6d3@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d5896d8a-a30d-2778-58c4-2c4b998da6d3@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/22 08:19, Bart Van Assche wrote:
> On 6/23/22 15:48, Damien Le Moal wrote:
>> On 6/24/22 03:05, Bart Van Assche wrote:
>>> Since __bitwise types are not supported by the tracing infrastructure, store
>>> the operation type as an int in the tracing event.
>>>
>>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Cc: Naohiro Aota <naohiro.aota@wdc.com>
>>> Cc: Johannes Thumshirn <jth@kernel.org>
>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>> ---
>>>   fs/zonefs/trace.h | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h
>>> index 21501da764bd..8707e1c3023c 100644
>>> --- a/fs/zonefs/trace.h
>>> +++ b/fs/zonefs/trace.h
>>> @@ -32,15 +32,15 @@ TRACE_EVENT(zonefs_zone_mgmt,
>>>   	    TP_fast_assign(
>>>   			   __entry->dev = inode->i_sb->s_dev;
>>>   			   __entry->ino = inode->i_ino;
>>> -			   __entry->op = op;
>>> +			   __entry->op = (__force int)op;
>>>   			   __entry->sector = ZONEFS_I(inode)->i_zsector;
>>>   			   __entry->nr_sectors =
>>>   				   ZONEFS_I(inode)->i_zone_size >> SECTOR_SHIFT;
>>>   	    ),
>>>   	    TP_printk("bdev=(%d,%d), ino=%lu op=%s, sector=%llu, nr_sectors=%llu",
>>>   		      show_dev(__entry->dev), (unsigned long)__entry->ino,
>>> -		      blk_op_str(__entry->op), __entry->sector,
>>> -		      __entry->nr_sectors
>>> +		      blk_op_str((__force enum req_op)__entry->op),
>>> +		      __entry->sector, __entry->nr_sectors
>>>   	    )
>>>   );
>>>   
>>
>> How do you get the warning ? I always run sparse and have not seen any
>> warning... Looks good anyway, will apply.
> 
> Hi Damien,
> 
> The warning fixed by this patch has been introduced by the patch that 
> changes enum req_op from a regular enum into a bitwise enum. The warning 
> does not occur with Jens' latest for-next branch.

I see. Thanks.

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> 
> Thanks,
> 
> Bart.
> 
> 


-- 
Damien Le Moal
Western Digital Research

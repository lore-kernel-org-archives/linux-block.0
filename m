Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6AEC6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 22:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjC3W7k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjC3W7i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 18:59:38 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29781DBE3
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 15:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680217177; x=1711753177;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b1mB3L4NjGZEffDy/ue8r/CTCwIk23f1Rgfxa7QDPE4=;
  b=J60z7lgCsJvOolq96R5bzjE62UaOGF1McGq7BvTxC2oJP+wKSBdsdKF2
   cgXZrZRvxlTVBclI/05z7X4Ht/TXK6CgrjwZ9LWeCGGWqnJqBdnCqQ6wj
   2Y7c14R0ciX5bYd/KPmAFVrLw9usPzq8pY4LdRtcv5U96Y83PQ/x9DsJ8
   PkXltl9kE4zLU1Xdjdt5spDNppe1m16BhFOII64y504tESMpxSjx4Pvvx
   +EFEHSHRYgkY27djiTBzHVjMt9iiMgWAF3I3tx4CXz9exAUoedB/9VHo1
   hER6Klc2pc5W3PJnu+4fi1YFFAu9hBNIe+rtsDWu4cTnMcL9uYds13ozx
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,306,1673884800"; 
   d="scan'208";a="226748717"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2023 06:59:36 +0800
IronPort-SDR: yfe9e3jXbK5Lhcg3hB4AiNLMdu0rDR3ODAExT+yHHI/iyx8d7n0J+iOx9ao6Tb18+uoClTdVQM
 /U9HVG1YT48NGNUTLDivFoLJbwb2XXUA9HIUnjkLruy14brywgOUbOd308ou4b3DQNSWH2ykze
 k67qqzfzIETSmPFlEurY2lg6R8jQhSKEvzGlF4Xl3aj0jbkQHSEq82CeJ5n356m9vqsSAFrArh
 EZeZdX5CHpB+ld8cMcn9uA5QDH7XstJrWsUpSg3/WO8aQJSL2zbyXULvwjIl+LgeZOOTzcx1as
 f+0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 15:15:44 -0700
IronPort-SDR: T4BBAstPuE1rqq0bKzBLI0N0pC3KxXuqQ/0eegd47+fA0Lz++U+0YO12S3PizOaGd4ni2g3A7j
 gBCNn67EWi8f0FzGxIMwd6jb6QpL+tytq8A8r1i7t0x9gOJ24ql3vXemDreHt6GhS4HTanaBYa
 Yp7CyoOHNp3RteniN2ifqPlYmGOrvAnq444wazHZAdIFKymikjkCoKnavck8N60YMewZPkX6bs
 EGs3mq94THM/Ie2jUT83qfGcx08MeO+PP9DqtglPCMT0EPpomoFx5lBWda7NuewIHJpMOEyORJ
 okc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 15:59:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pnf4m1cGwz1RtVv
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 15:59:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680217175; x=1682809176; bh=b1mB3L4NjGZEffDy/ue8r/CTCwIk23f1Rgf
        xa7QDPE4=; b=nBx8t68VMhAIl1jh235c30IgXYaQxAeVpokyn6umbbWu0mBfHTS
        5D5KZ2kyBvEYZvqCknlAKWTP40rr8bLxX9ZZs6WcMxvr+5BMkEz9J+7UbAUcYqT5
        hEo1aGTMlUrdVgbznZXofEzO92CqMq46Hn6BWwetWTmEscKRk67mAZONU45OtotZ
        ddFfT6XrWfDMaZHbnTajk+0COQVvjYW21d6GfkwE4GxTA56WfBLNgRURAVYp9H1j
        y6cqy1OQ7tGMoCFjtTynwx2VOGrxUXzgNbNyUs00nR7Qbz4eBr/ydEyZFD2AxgWA
        0Au06zRyqxH76B/bvxUmTt84dTU0NIi10MA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7ANtm1A9LlSL for <linux-block@vger.kernel.org>;
        Thu, 30 Mar 2023 15:59:35 -0700 (PDT)
Received: from [10.225.163.124] (unknown [10.225.163.124])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pnf4k2gG1z1RtVm;
        Thu, 30 Mar 2023 15:59:34 -0700 (PDT)
Message-ID: <b72ac98c-bd35-a111-b6db-0d7323678b20@opensource.wdc.com>
Date:   Fri, 31 Mar 2023 07:59:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 5/9] null_blk: check for valid block size value
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>
References: <20230330213134.131298-1-kch@nvidia.com>
 <20230330213134.131298-6-kch@nvidia.com>
 <002d5d2a-f12f-a64d-6719-250823dc5a76@opensource.wdc.com>
 <dba1e9e7-c288-9579-3976-d04899f7064a@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <dba1e9e7-c288-9579-3976-d04899f7064a@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/23 07:52, Chaitanya Kulkarni wrote:
> On 3/30/23 15:45, Damien Le Moal wrote:
>> On 3/31/23 06:31, Chaitanya Kulkarni wrote:
>>> Right now we don't check for valid module parameter value for
>>> block size, that allows user to set negative values.
>>>
>>> Add a callback to error out when block size value is set < 1 before
>>> module is loaded.
>>>
>>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>>> ---
>>>   drivers/block/null_blk/main.c | 17 ++++++++++++++++-
>>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>> index f55d88ebd7e6..d8d79c66a7aa 100644
>>> --- a/drivers/block/null_blk/main.c
>>> +++ b/drivers/block/null_blk/main.c
>>> @@ -190,8 +190,23 @@ static int g_gb = 250;
>>>   device_param_cb(gb, &null_gb_param_ops, &g_gb, 0444);
>>>   MODULE_PARM_DESC(gb, "Size in GB");
>>>   
>>> +static int null_set_bs(const char *s, const struct kernel_param *kp)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = null_param_store_int(s, kp->arg, 512, INT_MAX);
>>> +	if (ret)
>>> +		pr_err("valid range for bs value [512 ... %d]\n", INT_MAX);
>> This is is only checking the range. block sizes must be power-of-2 as well but
>> that is not checked. And for the range, block size up to INT_MAX ? That is not
>> very reasonable.
>>
>>
> 
> I'll add ^2 check to next version.
> any suggestions on what is a reasonable size we should limit to ?

4K if you want to limit this to testing only things that actually exist. 64K
sound like a reasonable limit to test things that could eventually (maybe)
appear. But allowing > 4K block size may actually trigger a lot of bugs in other
code (FS). So I wonder if it is really wise to allow that.

-- 
Damien Le Moal
Western Digital Research


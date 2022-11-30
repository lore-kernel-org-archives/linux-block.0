Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A0CC433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 12:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiK3MrM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 07:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiK3MrL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 07:47:11 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31094A5A4
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 04:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669812430; x=1701348430;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WdCZPc+F9MjZde5pW1azpanqqIlLm3Qf5vQgtnBDGoQ=;
  b=lZtGuvYkjauYlEBCM7A+NxSevFz5rrFCSyXB6vgyhSm91KvqRNn1jpko
   1gZBxVL38AkwvzuNRuw8VaZYgiBaRypcJO7Y/9aeDgQddqQA4i9oOl+W4
   qex/Duqko9n4sj66jnibAO6prLyKza9CxcCgY6AE2UuWIkYX+AUfudsrT
   o+Ad8yGXtve0OlEQ6vFTep17UUqayv/uvRDI899eYvRck6Qtfw/snfLpo
   xS5GoYwkZKFbBpWqTDY+slBmgJgPdfNYJjajoyiZmoPo1Uqqr7nCvagu7
   ORI4kL0IGD5vXlY3eE/Qdy2lL7kjVUdnmpvxLLpDbeKLK03oGjcskJxdI
   g==;
X-IronPort-AV: E=Sophos;i="5.96,206,1665417600"; 
   d="scan'208";a="217548409"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 20:47:10 +0800
IronPort-SDR: Oyn5CEaYxx1jhFPI7LVLgMj5XMeK62gFuAg+YZRUYHhOKRDtmcfPAKJdLgFXj9kiRdNOMWX3Jh
 adhQmjNd3vVTnMuqtjdxi866qFlJWh7XUD5i1ZJwE81AunGsOMer7uRSuHz6YcmmljWFnq3bmt
 bU9nA8tkLbxw4RSW68RY4ZS66XDrIZqhnCLw74004d7YyNAqbr5gKd5d5G7EF1lgxq1QwC66uF
 MrM3zWyAt0jv5pD9uxC1EwuogOvMMNpwmqsJz5jBNlkh5vOTBhUUotvBqV6WjXFlzw7GquSl4l
 IY8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2022 04:05:49 -0800
IronPort-SDR: 9ztfYpizpXR3gTuUhrlw14ZsQe7IiPkkqoS3oardkVi/nma4YSYKFTTsyTsuiLMeGGbfd946Lr
 n/SgCPa8pVj0UQI2hZlKHgCbISPpvzYDRNRYl4Vr4EhQzt0Z4TT5ru73Yg9Ir25AN3iGjmlfxn
 P1TdJ8n1d78puoYGne11e91QjPx3vUdlfiiNRH+xrVAqzn0RyvcFXAN5ifN25M3QhbU7b8zlA3
 6q0+XoYht4dHMduVpoj3K2Nx8Lo4xeTq0fOmbSMZZjjUH0sB7AA2BNNMp2jk9akPde+FFelLsP
 wBs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2022 04:47:10 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NMf9T6WHdz1RvTp
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 04:47:09 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669812429; x=1672404430; bh=WdCZPc+F9MjZde5pW1azpanqqIlLm3Qf5vQ
        gtnBDGoQ=; b=q75i/FpNmlV82phlt4NPYHCPbXH3iEE6qKzHIYn1H68AYJ+szcn
        /YHC5rF7e89BDTCx6OUxzD1FSHOsJXcTnuVxritEeZfD4wt/U2BED6dFMsWe1nv3
        AUKAqu7s+/v6XKb7sqJDA3W1UqOiTK2cyGhBbNCTTVN50SbuyL+HRa6Gn+VYc7Ja
        o7PsQeajqbIZt2BETnvQIPB1GZ4QLi9FbDI/2xpxSutBFc23X9BcDiSx+w3N9LyF
        KeVDBbVt//c5mJdO5mMzuunxy8Ocq4enXAAtUQZnHx5yRgjsFroF7/3W2mNMosye
        8PzAADxAe3heIDG/X+O5oaxgwiXQ2uXcEBw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vLEcHs-98H6x for <linux-block@vger.kernel.org>;
        Wed, 30 Nov 2022 04:47:09 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NMf9S6Ypbz1RvLy;
        Wed, 30 Nov 2022 04:47:08 -0800 (PST)
Message-ID: <bb51fd30-43cd-b9eb-a03c-d5c02ade41ba@opensource.wdc.com>
Date:   Wed, 30 Nov 2022 21:47:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] null_blk: support readonly and offline zone conditions
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20221130094121.2321485-1-shinichiro.kawasaki@wdc.com>
 <fde23932-d8a4-5a14-9298-7022edbb20de@opensource.wdc.com>
 <20221130111527.unxyntggkkyk2fom@shindev>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221130111527.unxyntggkkyk2fom@shindev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/22 20:15, Shinichiro Kawasaki wrote:
[...]
>>> +	if (zone_no >= dev->nr_zones) {
>>> +		pr_err("Sector out of range\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (dev->zones[zone_no].type == BLK_ZONE_TYPE_CONVENTIONAL) {
>>> +		pr_err("Can not change condition of conventional zones\n");
>>
>> Why ? Conventional zones can go read-only or offline too. At least on
>> ZBC/ZAC SMR HDDs, they can. So allowing this to happen with null_blk is
>> desired too.
> 
> As far as I refer ZBC r05 Table 10 and ZAC r05 Table 5, conventional zones can
> have only zone condition "NOT WRITE POINTER". I think the tables show that the
> zone conditions "READ ONLY" and "OFFLINE" are valid for sequential write
> required zones (and sequential write preferred zones). Do I misinterpret the
> specs?

Indeed, it looks like it. You are correct. So no read-only or offline for
conventional zones it is.

-- 
Damien Le Moal
Western Digital Research


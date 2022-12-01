Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8125FC4321E
	for <linux-block@archiver.kernel.org>; Thu,  1 Dec 2022 21:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiLAV0e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Dec 2022 16:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLAV0d (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Dec 2022 16:26:33 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C116C1BF6
        for <linux-block@vger.kernel.org>; Thu,  1 Dec 2022 13:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669929992; x=1701465992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jWOeXT9s27124ahJW3lhFHvrHEHbZR4TPcDIJBHK1Lk=;
  b=b8R8p/wa8fydltnda1r01rCFqrhmR+DQpYxrVln7s1JecyTrO8QGF8FF
   gsCXfXMAUxn0VEOIz90kzv64kfAFXvhNgbAKOfA46wgYV0DRRk1lyqpaw
   43C5kv4KFExZSO6iExq9789MRcUA/RZh6QdD0+cbhKuqPAWHWFg185oxa
   0YqwR8lAN61Fv5el5f8w9JlB7sbcz2iDaOZ6TzNEzjmgSNAhstqd8qHs+
   5GSVO3x7330Wegv9d38XD8enJm9SdaWkZgF8VDAnRcsuQFRe0sJoVx6Vt
   CNPvi1rSj5BaEuKDoCV9hO1GxsTA4vSVr/BAq0y5Twj4bgZpDT3KrFLpD
   A==;
X-IronPort-AV: E=Sophos;i="5.96,210,1665417600"; 
   d="scan'208";a="217697171"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2022 05:26:31 +0800
IronPort-SDR: 0NF3xhSta5C36+z/m6G+iWhXKD56oXxN8Z6S4v0+h0lHoTlbfVUZS2hxNdLMVuoh8EwRFul6EL
 XiVTbofvmG7JZQYW/je398169uOXSSSpOc7sQRS+5qq9sBZVUP8R5dHBmY8fXF8F5SnIYlFkpe
 pwspOjW5nPBnVjkNJmzAdoNM/SUfTNez9jhgSRtzonAenCIhSN5LOuFwEgVr/9bui2Yrcu3YKL
 736d8lPKWpwou3D2b5w3GpKhr1y2sQEz4XeAqdvzraMqVU3h3V216M7PjVWk7ApArwV4lZTgVj
 Wrg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Dec 2022 12:39:25 -0800
IronPort-SDR: UC2FID2HnllPNIiwTTkbZN1wiabloYJqqJq8V2s7lNip7v+gvAOQp8d0ToxqukZ+0pMBaTC9pm
 nLUskg5DsqrQyJSpJHBgAY70tJ30qDgGlxFL33uN21a7tYZcQjuQQySMxUqJ5o4ux9HfuN5eWx
 P+nJEhsqxDxEpYoATeiVHgo88Q2vtfNw1XZiDT1vCHD4Gx4S68BSNUzB7dyLOunmfAv+5kYrog
 tjALvVWyQiQdcptikj3SmM4gFi5bXodFsIl/xkOruk3A6S6PXqEMA/OrwncSWHQhSjYobNPm7U
 C4g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Dec 2022 13:26:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NNTfH2wZgz1RwqL
        for <linux-block@vger.kernel.org>; Thu,  1 Dec 2022 13:26:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669929990; x=1672521991; bh=jWOeXT9s27124ahJW3lhFHvrHEHbZR4TPcD
        IJBHK1Lk=; b=dSNj5WOenSBd+8UHHWYPOL8MtKHDbhzBUdCZP2ow9ar6U+XyMce
        2dQ5UJ2s8Q49+tSbhfx9kv1z40HMcK6XEfy0j4qb6XTg+oeJzqglB3FUehrw0sVf
        lsl+yjUd1YgvM5dI9Di9EAgtuSnwE0lAah7aszM9A/sKv6qqRO0y26lfxh4wgOiK
        BxZsUpm5V3wijgHOatTX4drui4NKdZD1iQZbVANSh2Oe2M6kySyQAn7czo5McgKm
        aYq+IkM1NmNAoOwC4dVSjsEQ4+4bfzR0IXojNGmu/rradLb1b4n4asfIcDNFFutE
        Epx3uZAClzX5eFhRDWMK9Y8aURQcmgUX9tA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kX9xq0fZAIs9 for <linux-block@vger.kernel.org>;
        Thu,  1 Dec 2022 13:26:30 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NNTfG2Gx4z1RvLy;
        Thu,  1 Dec 2022 13:26:30 -0800 (PST)
Message-ID: <6df84a2b-58cf-476f-79cb-e487e53a1a2f@opensource.wdc.com>
Date:   Fri, 2 Dec 2022 06:26:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] null_blk: support read-only and offline zone
 conditions
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20221201061036.2342206-1-shinichiro.kawasaki@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221201061036.2342206-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/1/22 15:10, Shin'ichiro Kawasaki wrote:
> In zoned mode, zones with write pointers can have conditions "read-only"
> or "offline". In read-only condition, zones can not be written. In
> offline condition, the zones can be neither written nor read. These
> conditions are intended for zones with media failures, then it is
> difficult to set those conditions to zones on real devices.
> 
> To test handling of zones in the conditions, add a feature to null_blk
> to set up zones in read-only or offline condition. Add new configuration
> attributes "zone_readonly" and "zone_offline". Write a sector to the
> attribute files to specify the target zone to set the zone conditions.
> For example, following command lines do it:
> 
>    echo 0 > nullb1/zone_readonly
>    echo 524288 > nullb1/zone_offline
> 
> When the specified zones are already in read-only or offline condition,
> normal empty condition is restored to the zones. These condition changes
> can be done only after the null_blk device get powered, since status
> area of each zone is not yet allocated before power-on.
> 
> Also improve zone condition checks to inhibit all commands for zones in
> offline conditions. In same manner, inhibit write and zone management
> commands for zones in read-only condition.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research


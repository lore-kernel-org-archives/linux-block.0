Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B9AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 00:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiFQAEj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 20:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFQAEi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 20:04:38 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D532762CC0
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 17:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655424277; x=1686960277;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7aH4wYdWLYsjG/9qP2xldw4GlqngeYSpfH5wn4+CgfE=;
  b=Ibx0hmxSJMsTHYaeRVa/OU8eQ80EmYcZLXYgX5oOJq8Pv2/PxcGhea+b
   05kwkVzMuOF7zhAwcZKdfmcNZUM+/1L0rzLp7C82Lf5Gy9uVkrWZvmMMA
   Y8xrZsGG80aZDrUhT8ihFm7Va0dZ9JJLV7RIxOQzu+3t2vSVBpF/insMp
   v1spm1U6ZaZR658eDiHv9OPmoAo/Qb0oHaxngl91bd0cvFDfQnMJezIsw
   NQWgLQoYiJWpUR2+RUf5vndFadf7YW+d5zP93tuvHaNcajjBVdY0JaVG+
   MTp++QAAggVnYbe1kyjbF1zRdpYQB+7j9JaSHyE91x/PfTsGpqQcWtlST
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="202085184"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 08:04:37 +0800
IronPort-SDR: ropkU5ulQEEUWx6DWqgXrMwE8MZ3BPG+GYiCquybejuHYKN1uFnBtVqLCHnRTYfollzl/3K9ot
 yKdLeFOjw0qyWNrG5F7zl8GPsejmGVjo2HA1J1vKey9WTtHi8zhUtn+X/c/nrdj0NixjJdoiJo
 ImfR7Wb3ViVwUYQYHWmeaNUT4fbSUAQryVEzT/XrQ4MrEnh8UIHnRrqY0BwsWlOTqSU8mhOXFg
 am/lvIH31Rnyhn3QgeH6Y1XAsaImXvQ+h3fYnj77tysuW4JYyg+sOIfof2ccy9OWnNHsXa4xjv
 WNsDDkBKeyNB/yK0xKMp4FMj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 16:22:50 -0700
IronPort-SDR: xNQt2vSIgqm5xLL932afxwDPeI5D5vbMR+OyDhB/ztWo3F/CxixjMFjPg8Xf4CjWn45J+hzbp3
 AzPQpytlI/DjO5mtsFbXaeWA02iSdgM1RB/0cfG18+/W35riv++P+WNmAOo+fFYayZyDdE3d2j
 tXJ5sgc9B3mjO6Y+LaliTN7WtRnHxUxv9OrhBJlttL7fkhkucTH7k1tZDQUKatO43zyaNZqzIf
 6tmTdKT/eZEloBUBdcVn2oCzAuNogiYy6tJso93NYCZ3LMAgaryrAs3bqICgiPbs4jGqJylXc0
 M58=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 17:04:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPK6F0p4yz1Rvlx
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 17:04:37 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655424276; x=1658016277; bh=7aH4wYdWLYsjG/9qP2xldw4GlqngeYSpfH5
        wn4+CgfE=; b=Oz8rjMWykaI2GOfMKU/8jRAsnyHocYKORS9PgBAAnIydT1yZWmq
        qUfWu23qAmlCVvdAqllxvj0xjzJIzeBSCOTAz8cyy9J+0ymxLp9/accRsbBBvoTO
        NEoDwOchWTHkwex9llh3miEA71JaTiT6e22PM48dxws4iQ+aBOJlR3ktlQADK6nL
        nHX0HL+FBAABWitCzbCih+9/euSXIyJQK+8lXzw0yx1yMIg92k862dFT69dJY4zM
        r0vEBa00ekKigKBvKjVjAx1gDEO9ELsKROBgL+h60vzljLkrdcpqs2TkH2wx+/TD
        m8prxkx5izO657Xa8sZ2Nv9esqF/iA5EqHQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D47gql1XrTx8 for <linux-block@vger.kernel.org>;
        Thu, 16 Jun 2022 17:04:36 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPK6C4BSnz1Rvlc;
        Thu, 16 Jun 2022 17:04:35 -0700 (PDT)
Message-ID: <6dc7d961-7129-e143-01be-5d086bf7be43@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 09:04:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 8/8] block: Always initialize bio IO priority on submit
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20220615160437.5478-1-jack@suse.cz>
 <20220615161616.5055-8-jack@suse.cz>
 <ece0af04-80c8-e0c3-702b-0d0d17f61ea9@opensource.wdc.com>
 <20220616112303.wywyhkvyr74ipdls@quack3.lan>
 <20220616122405.qifuahpn2mhzogwd@quack3.lan>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220616122405.qifuahpn2mhzogwd@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/22 21:24, Jan Kara wrote:
> On Thu 16-06-22 13:23:03, Jan Kara wrote:
>> On Thu 16-06-22 12:15:25, Damien Le Moal wrote:
>>> On 6/16/22 01:16, Jan Kara wrote:
>>>> +	if (ioprio_class == IOPRIO_CLASS_NONE)
>>>> +		bio->bi_ioprio = get_current_ioprio();
>>>>   }
>>>>   /**
>>>
>>> Beside this comment, I am still scratching my head regarding what the user
>>> gets with ioprio_get(). If I understood your patches correctly, the user may
>>> still see IOPRIO_CLASS_NONE ?
>>> For that case, to be in sync with the man page, I thought the returned
>>> ioprio should be the effective one based on the task io nice value, that is,
>>> the value returned by get_current_ioprio(). Am I missing something... ?
>>
>> The trouble with returning "effective ioprio" is that with IOPRIO_WHO_PGRP
>> or IOPRIO_WHO_USER the effective IO priority may be different for different
>> processes considered and it can be also further influenced by blk-ioprio
>> settings. But thinking about it now after things have settled I agree that
>> what you suggests makes more sense. I'll fix that. Thanks for suggestion!
> 
> Oh, now I've remembered why I've done it that way. With IOPRIO_WHO_PROCESS
> (which is probably the most used and the best defined variant), we were
> returning IOPRIO_CLASS_NONE if the task didn't have set IO priority until
> commit e70344c05995 ("block: fix default IO priority handling"). So my
> patch was just making behavior of IOPRIO_WHO_PGRP & IOPRIO_WHO_USER
> consistent with the behavior of IOPRIO_WHO_PROCESS. I'd be reluctant to
> change the behavior of IOPRIO_WHO_PROCESS because that has the biggest
> chances for userspace regressions. But perhaps it makes sense to keep
> IOPRIO_WHO_PGRP & IOPRIO_WHO_USER inconsistent with IOPRIO_WHO_PROCESS and
> just use effective IO priority in those two variants. That looks like the
> smallest API change to make things at least somewhat sensible...

Still bit lost. Let me try to summarize your goal:

1) If IOPRIO_WHO_PGRP is not set, ioprio_get(IOPRIO_WHO_PGRP) will return
the effective priority

2) If IOPRIO_WHO_USER is not set, ioprio_get(IOPRIO_WHO_USER) will also
return the effective priority

3) if IOPRIO_WHO_PROCESS is not set, return ? I am lost for this one. Do
you want to go back to IOPRIO_CLASS_NONE ? Keep default (IOPRIO_CLASS_BE)
? Or switch to using the effective IO priority ? Not that the last 2
choices are actually equivalent if the user did not IO nice the process
(the default for the effective IO prio is class BE)

For (1) and (2), I am not sure. Given that my last changes to the ioprio
default did not seem to have bothered anyone (nobody screamed at me :)) I
am tempted to say: any choice is OK. So we should try to get as close as
the man page defined behavior as possible.



-- 
Damien Le Moal
Western Digital Research

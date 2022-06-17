Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B574C433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 12:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350472AbiFQMDv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 08:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiFQMDu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 08:03:50 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833C95B898
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 05:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655467430; x=1687003430;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nhtfXQoIyT3MxFvxCHjx6ciWMIHHBk7X1mD7xcD18+g=;
  b=jG/IO44QYIP/Kja5inlASa77xmnsRvMg3LFHeh3c4TSjGV90l7vv0YCq
   PW6fsQeyL5uPKclDoxhPOi4oUyrYJ9tN2dgOnFvQUxttIARHujjvVGNkX
   gS2ErTSFGe7OHwm41o4NCF9k+03l6ekZOMI2gqyAGntNFgxh78TauwpvS
   KLb8e8fSKk+ILZz4L8SCvch0zw1+WMhjTbw+g/04Zoalpu+uA+9LdBCWV
   wXQALsgiqrK+hJvIHi++Qr9vjNMG8evyy3tV/ajqzftPsqZIXYEkJSPTo
   ucUpkK6r/VRJ1dtnvzL9Yn115WPrbkry4tBJ79UyXO4nv4/pW+fj0jFjW
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="204186736"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 20:03:50 +0800
IronPort-SDR: ZN3iaiwPgZ0pg/Sn1AdrMoOlwd5rs0K5VaxHeiW7VGK9gGyQLhbRM1W3h5wlfhn/xNCp92xhNq
 iLUm+yv39oBFzkOocuXo4PajA4b970JHMCzW1QMWnvuwKaBde+qYmFrD088tLfuTRkFYkOmCri
 ZFgxK5fwU0jIjBePsp201u4YImzA/UDy/9871xJzbwcSjFrtiOX+N8YpADTgIsT1t9E9Wisuq/
 xeIFgJJh8Skm3yYMHLXtQGW73v1FNs1bwIaTozxFk4vweXknAoIkQBQC3cvZjZlQNI7DwOT9OK
 dMmKaGCUJCSZ6ueJ36bjfWsy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 04:26:23 -0700
IronPort-SDR: tCm36nv9uvg5Zwh5UeBaSvKp1JlhZzKpkeSHrL6cdTgFg7Xe8fdP8yqwp5Xxhk2BeR7khMFWIb
 PQ6/VzgqJmcfyMPfiDLNgD7q1ii9WBycTC9HfdFUd55vCZeAZARJPPWzj+rp5PvE64jlKrDvnh
 fI6bv4R9Bfh4gjOMf55H7bES+xw+6RkmGfXEXedAzX00DhqWGwj6jkQGJi1KWjjOFVfPviowNs
 fWrpxTIyAwF2FhFlbmLceg0S4pbfvRfKARR/SnVrH055YU0xSoXUvs12zgyQVgHLjiQSGrFVT9
 H2s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 05:03:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPd441pMJz1SVnx
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 05:03:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655467427; x=1658059428; bh=nhtfXQoIyT3MxFvxCHjx6ciWMIHHBk7X1mD
        7xcD18+g=; b=nPSGFg5UJT3uzxPcuQ2TCvL7wcHyXwpbvgp/hvTe/+f47O9ZXg1
        fL9V4tDeDouRY+UabrSIWntVdHFLp1INVUbNrUSPEdVwHMihpxdli4MXZVD9mgEH
        UtRR0+Tok1tOVgmUkwPgFNG4yD3fsnJGD0di8wEtEynVZEqCXx3I/9sB7HSkHiYH
        QAFvQlI37IUiQotlSMiSwfpxfmnGA0sOx/XWIITwXgPVyqQXkDTLiUXSyXjO5NrW
        sSI53P/wxe0BwGcv2XjX/TrMKUzaewEL5yK9BFXQUMP/Uj8TdzHwGxnjqeCaG2GN
        RA/AXzGXhtuiCr1emj1tIUbHx6Jmwtiv47w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uD6sQOWhTcAc for <linux-block@vger.kernel.org>;
        Fri, 17 Jun 2022 05:03:47 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPd425bh5z1Rvlc;
        Fri, 17 Jun 2022 05:03:46 -0700 (PDT)
Message-ID: <ef6c0c90-2f9e-12ed-5ad1-8d1500f5f502@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 21:03:45 +0900
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
 <6dc7d961-7129-e143-01be-5d086bf7be43@opensource.wdc.com>
 <20220617114933.vn3ffx5vqmjcbnsp@quack3>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220617114933.vn3ffx5vqmjcbnsp@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/22 20:49, Jan Kara wrote:
> On Fri 17-06-22 09:04:34, Damien Le Moal wrote:
>> On 6/16/22 21:24, Jan Kara wrote:
>>> On Thu 16-06-22 13:23:03, Jan Kara wrote:
>>>> On Thu 16-06-22 12:15:25, Damien Le Moal wrote:
>>>>> On 6/16/22 01:16, Jan Kara wrote:
>>>>>> +	if (ioprio_class == IOPRIO_CLASS_NONE)
>>>>>> +		bio->bi_ioprio = get_current_ioprio();
>>>>>>   }
>>>>>>   /**
>>>>>
>>>>> Beside this comment, I am still scratching my head regarding what the user
>>>>> gets with ioprio_get(). If I understood your patches correctly, the user may
>>>>> still see IOPRIO_CLASS_NONE ?
>>>>> For that case, to be in sync with the man page, I thought the returned
>>>>> ioprio should be the effective one based on the task io nice value, that is,
>>>>> the value returned by get_current_ioprio(). Am I missing something... ?
>>>>
>>>> The trouble with returning "effective ioprio" is that with IOPRIO_WHO_PGRP
>>>> or IOPRIO_WHO_USER the effective IO priority may be different for different
>>>> processes considered and it can be also further influenced by blk-ioprio
>>>> settings. But thinking about it now after things have settled I agree that
>>>> what you suggests makes more sense. I'll fix that. Thanks for suggestion!
>>>
>>> Oh, now I've remembered why I've done it that way. With IOPRIO_WHO_PROCESS
>>> (which is probably the most used and the best defined variant), we were
>>> returning IOPRIO_CLASS_NONE if the task didn't have set IO priority until
>>> commit e70344c05995 ("block: fix default IO priority handling"). So my
>>> patch was just making behavior of IOPRIO_WHO_PGRP & IOPRIO_WHO_USER
>>> consistent with the behavior of IOPRIO_WHO_PROCESS. I'd be reluctant to
>>> change the behavior of IOPRIO_WHO_PROCESS because that has the biggest
>>> chances for userspace regressions. But perhaps it makes sense to keep
>>> IOPRIO_WHO_PGRP & IOPRIO_WHO_USER inconsistent with IOPRIO_WHO_PROCESS and
>>> just use effective IO priority in those two variants. That looks like the
>>> smallest API change to make things at least somewhat sensible...
>>
>> Still bit lost. Let me try to summarize your goal:
>>
>> 1) If IOPRIO_WHO_PGRP is not set, ioprio_get(IOPRIO_WHO_PGRP) will return
>> the effective priority
> 
> You make it sound here like IOPRIO_WHO_PGRP would be some different type of
> IO priority. For record it is not, there's just one IO priority per task,
> if you set ioprio with IOPRIO_WHO_PGRP, it will just iterate all the tasks
> in PGRP and set IO priority for each task. After my patches,
> ioprio_get(IOPRIO_WHO_PGRPIO) will return the best of the effective IO
> priorities of tasks within PGRP. Before my patch it was doing the same but
> if IO priority was unset for some task it considered it to be CLASS_BE,4.

OK. Got it. Thanks for clarifying.

> 
>> 2) If IOPRIO_WHO_USER is not set, ioprio_get(IOPRIO_WHO_USER) will also
>> return the effective priority.
> 
> This is the same as above. Just the calls iterate over all tasks of the
> given user...
> 
>> 3) if IOPRIO_WHO_PROCESS is not set, return ? I am lost for this one. Do
>> you want to go back to IOPRIO_CLASS_NONE ? Keep default (IOPRIO_CLASS_BE)
>> ? Or switch to using the effective IO priority ? Not that the last 2
>> choices are actually equivalent if the user did not IO nice the process
>> (the default for the effective IO prio is class BE)
>  
> I want to go back to returning IOPRIO_CLASS_NONE for tasks with unset IO
> priority.

And that would be to retain the older (broken) behavior. Because if we
consider the man page, tasks with an unset IO prio should be reported as
having the effective IO nice based priority, which is class BE if IO nice
is not set. Right ? I am OK with that, but I think we should add this
explanation as a comment somewhere in the prio code. No ?

> 
>> For (1) and (2), I am not sure. Given that my last changes to the ioprio
>> default did not seem to have bothered anyone (nobody screamed at me :)) I
>> am tempted to say: any choice is OK. So we should try to get as close as
>> the man page defined behavior as possible.
> 
> I also don't find (1) and (2) too important. (3) is IMHO somewhat important
> and I think that the reason why nobody complained about the change there is
> because your change is relatively new so it didn't propagate yet to any
> widely used distro kernel...

Indeed.

> 
> 								Honza


-- 
Damien Le Moal
Western Digital Research

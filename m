Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC65C3A5A7
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 23:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiLFXeS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 18:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLFXeS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 18:34:18 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98758303E9
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 15:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670369656; x=1701905656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vxeY8mVIA7CHkny4Zx5b+MvreBwEym4XdXljNgjVfXE=;
  b=E43eIpKpXyq3TN/UEWHnjSp91GjNxnjyzqTTNds21TBxjtJzxbIu2OEu
   O/2QkDslw0LevBzJNNxezzLEKkb29lh3vewnQKJL95uGrWjmqi11+OPJ2
   pX2tkdVrf954gHVQSeAdgl5sDTqXOwVRzxCkDwDNsxTZRCjry/JgzNhis
   MUIiTkN9YD7AuZMbaNogWvAwnEmSRbFi161MY8syd8RsMArrGuf3AUoY1
   piTL02iwsPF1yM7XMiKUpQHGulnGQNa+Duw774FlEK11om2r5+XT/QIVj
   qonzMRsWOebZS+AUbBmYOjXCna3JjM0XagzWfP0+2MHuRARhrsvgU8QDq
   w==;
X-IronPort-AV: E=Sophos;i="5.96,223,1665417600"; 
   d="scan'208";a="218314230"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 07:34:13 +0800
IronPort-SDR: I+Y5/aK5fjfEByrnVyfahySde/LROzXWuJAB/CrI/2VGv2usUKTnSSkhncYOasn2khbDAa3O9e
 zT2wdTXqVr76i3AoaHPmK6dNrG5JgxTJ4Kbi88ZrHawxOfPfZwsHP+RJNYc2zyKxEIVc/SMmcS
 P5TGqveF4EiI8Pf55/Iyf5UPDQuD4gcqWQC7Bo9QKHq37Na5q5jf4Zac3+AIURYPXRMgFRmRzs
 qRnVF8p4LdSfDw2cZMPkoPy6WWg2W+Lm7xBCFkQkOwzceOsmLqUY7vMcGfLmQp9l/ZVVs+FEOj
 R5U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2022 14:46:59 -0800
IronPort-SDR: NoNCH5Rlq5tVA98I6pfndsLboRljm6ZVKGBD8z3b6Z4QaUZnGYW3QM02W5Ffkii9qFx2Loq9kX
 rvK45TE+nq12XvNR6hLa+dwAyBGHcQ6N1gJ4rcY5bSc98c+PH8eztyiIQYyG0/sjN0xExZKLOP
 THGa2J5tgECzqf9A5NZWgsS00VxxOdmyui/l8L8W+hEwovjrdR/39+TyHAQzl8jgj/iZV6RWgp
 7MTkNgIK7aOJ8p+ll4BcHRZ/CM3FdgjHiFfm1waHH2+yXQWp8HTToLlL9B+b1baiHEDsKN2zuh
 kkc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2022 15:34:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NRcFK0MmYz1RwqL
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 15:34:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670369652; x=1672961653; bh=vxeY8mVIA7CHkny4Zx5b+MvreBwEym4XdXl
        jNgjVfXE=; b=FZOhb9vAnwhL2D+zw1g+CqDzz/DngDTfZnyI0PyGuti2mbdaUO5
        1JEXCm/0VuplTOLTWgLbcC82yUL7iy7nRQOWMXEYi0BVIJGiKmynZ+Co+iTJ08zA
        gg3S73FqFv6UH+JU5CzTjaFpr33U87+x/U0OaCXu/AiiI89dRs6hC/Jk4JNnf9gv
        kg1LgB/wkK3GzpXD0W0xJ2QeidEC//Fw5YBAiuatJHhgvfOAXxAmkoVf4ccCsG2R
        2Q0Nek9WCSa82wbH75Dmhly4MQBIDB6d21aMBoRUIZLmANeZ7ZF5MBDljds/e9Za
        gcuGn0kwH/Qn8EdFnncpyA7+yaq5mCDUn9Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4Ngzfs3ipLfR for <linux-block@vger.kernel.org>;
        Tue,  6 Dec 2022 15:34:12 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NRcFH0B86z1RvLy;
        Tue,  6 Dec 2022 15:34:10 -0800 (PST)
Message-ID: <9eba7529-8879-fbba-4e17-f174ef401513@opensource.wdc.com>
Date:   Wed, 7 Dec 2022 08:34:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 6/8] block, bfq: retrieve independent access ranges
 from request queue
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Federico Gavioli <f.gavioli97@gmail.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-7-paolo.valente@linaro.org>
 <5d062001-2fff-35e5-d951-a61b510727d9@opensource.wdc.com>
 <4C45BCC6-D9AB-4C70-92E2-1B54AB4A2090@linaro.org>
 <d27ca14b-e228-49b7-28a8-00ea67e8ea06@opensource.wdc.com>
 <76ADE275-1862-44F7-B9C4-4A08179A72E3@linaro.org>
 <6983f8b3-a320-ce32-ef0d-273d11dd8648@opensource.wdc.com>
 <518C279B-8896-470A-9D8C-974F3BB886DB@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <518C279B-8896-470A-9D8C-974F3BB886DB@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/22 00:43, Paolo Valente wrote:
>>>> In that case, bfq should process
>>>> all IOs using bfqd->ia_ranges[0]. The get range function will always
>>>> return that range. That makes the code clean and avoids different path for
>>>> nr_ranges == 1 and nr_ranges > 1. No ?
>>>
>>> Apart from the above point, for which maybe there is some other
>>> source of information for getting ranges, I see the following issue.
>>>
>>> What you propose is to save sector information and trigger the
>>> range-checking for loop also for the above single-actuator case.  Yet
>>> txecuting (one iteration of) that loop will will always result in
>>> getting a 0 as index.  So, what's the point is saving data and
>>> executing code on each IO, for getting a static result that we already
>>> know we will get?
>>
>> Surely, you can add an "if (bfqd->num_actuators ==1)" optimization in
>> strategic places to optimize for regular devices with a single actuator,
>> which bfqd->num_actuators == 1 *exactly* describes. Having
>> "bfqd->num_actuators = 0" makes no sense to me.
>>
> 
> Ok, I see your point at last, sorry.  I'll check the code, but I think
> that there is no problem in moving from 0 to 1 actuators for the case
> ia_ranges == NULL.  I meant to separate the case "single actuator with
> ia_ranges available" (num_actuators = 1), from the case "no ia_ranges
> available" (num_actuators = 0).  But evidently things don't work as I
> thought, and using the same value (1) is ok.

Any HDD always has at least 1 actuator. Per SCSI & ATA specs, ia_range
will be present only and only if the device has *more than one actuator*.
So the case "no ia_ranges available" means "num_actuator = 1" and the
implied access range is the entire device capacity.

> Just, let me avoid setting the fields bfqd->sector and
> bfqd->nr_sectors for a case where we don't use them.

Sure. But if you do not use them thanks to "if (num_actuators == 1)"
optimizations, it would still not hurt to set these fields. That actually
could be helpful for debugging.

Overall, I think that the code should not differ much for the
num_actuators == 1 case. Any actuator search loop would simply hit the
first and only entry on the first iteration, so should not add any nasty
overhead. Such single code path would likely greatly simplify the code.


-- 
Damien Le Moal
Western Digital Research


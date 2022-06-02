Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D18C433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 00:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiFBA4X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 20:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiFBA4R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 20:56:17 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9331C2440BC
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 17:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654131376; x=1685667376;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uuNmgm2vbeCXCkJfYxMy8RoXDcuzOiqsSNOZ+jR55ys=;
  b=n1o2hVxoSngdxJJSinUVKZAMT8iZzpQRO46ApxEmPQMb4SBbQDD7F6Ne
   P99sgm9RgvYSgdXisQwHYPVIsrdyRhWt3FZkr5AT255T9VDC74rhqFlY2
   3VdhJu5pTj0L871iuL15Cg07qb5Py3LBNLaNHtc/zlnsYYhWGu+NBrXy0
   ESr7OWJMQd+aCOCtniq2Xn7LM2P3Nf/WB1P8Ok2s6+TvOB97FexdbJAzc
   YEv0Kzxt3Oy39rP3nJpxI7xVVRFkrDzp9D4QlV+WZXqSs+HRoJSgAOBPu
   INmBMaOVGMboFOeKOjZUKVNziyyJQcREz7r6ww3TyGkB8kGqE4FgSnDb7
   w==;
X-IronPort-AV: E=Sophos;i="5.91,270,1647273600"; 
   d="scan'208";a="306297115"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2022 08:56:15 +0800
IronPort-SDR: nYr447XUQLtrZmG6RMzzDMux4YKZ/VFzo9vjJW7Pz5/ta68EQEzv/5UTwZfOZUfxV8o2RnD9K1
 n3buqRh6Lu1pvJlUGf9ZpLJ+3vkOwHWO1dexyqvd9uS1GRlMu4y6gUQ7gATL+UYUyo7eUPMNL3
 DREpCSs2UXH8v2K1DcGNJ6RVbq8dCIPOT9mVRskQAAXAGbA/4HyGVgeomkc9Io1eDS83zoF5lf
 Ql7lAFne7mVdM8nJI/8tR3y0Ej+o71TkBIllZtBYrnFekjDidnhkpOnHVwb/+oCJYjAkOU17qO
 iEtySPR1yqppX8Ku8U5hLSok
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 17:19:56 -0700
IronPort-SDR: 1HBns0UJxbl/GUcTnjbNhSvCX2aWm2v7T0vNJXVWe52syP5Di3CaqdpDN+zDrkg7SiIA42t8YB
 LvcbEch+KM52IiqaLtZi0PUFswQ4ZcdXFdJBPDyT5aNDM0mU0vuifYaNv34YaxezRMv8cI0ZUY
 q2UyoNelFR+BXSwMNU6GPEzF9aNiIopLZ2wKjVDbL2YBaZMPfSPAgf4ZM1VFElOOkwxZXxCzKv
 U1+O7K7niVW24KBpnhuODHpkwgksGIGT7v3hC6GTpO2QefbR43kfUuMbUjaDYzUHqUz6y0TqB1
 usI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 17:56:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LD6yl2THLz1SVnx
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 17:56:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654131374; x=1656723375; bh=uuNmgm2vbeCXCkJfYxMy8RoXDcuzOiqsSNO
        Z+jR55ys=; b=cyxOFEMZqjlgksJ/mvoiRH6LC0akHH206GRpwtaxOc/7hwr9WLG
        ozCF69wupTH1LI62IgZ2IRIM/TBPi3cg8yFWlw1ta9gobQExti1jmVCaDHO5V8uN
        8s2YA8Jb5kcFRoJ3eY2RDAR5dMlHk+CK4iFUiKVo+p2LIvu172o0voPgvu0462+i
        EGiqCzZ/WufHqC5s5I8VBfBr2BKtWOV3n1qUx0Q2wA+ugs4O0uNEIlxcExgtXEEL
        PjvP17pv/uyVwH2cc36uN0WRnhtAxtfzFVzSWPQvjkW+Ta39GBLM5bfoONK9cy8a
        DG5LfzQMhpsxFu88igj0PQ5B+lDi3VKpINg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 88270HzWYfT3 for <linux-block@vger.kernel.org>;
        Wed,  1 Jun 2022 17:56:14 -0700 (PDT)
Received: from [10.89.84.115] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.115])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LD6yk1SzZz1Rvlc;
        Wed,  1 Jun 2022 17:56:13 -0700 (PDT)
Message-ID: <678bdc0b-db31-4c6a-2ef9-afe8f91905d1@opensource.wdc.com>
Date:   Thu, 2 Jun 2022 09:56:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] block: Fix handling of tasks without ioprio in
 ioprio_get(2)
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
References: <20220601132347.13543-1-jack@suse.cz>
 <20220601145110.18162-1-jack@suse.cz>
 <6d40bebc-2880-5290-16dc-2807e1db9e77@opensource.wdc.com>
 <20220601152358.lgmn52cpwdfa7mxq@quack3.lan>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220601152358.lgmn52cpwdfa7mxq@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/06/02 0:23, Jan Kara wrote:
> On Thu 02-06-22 00:11:29, Damien Le Moal wrote:
>> On 2022/06/01 23:51, Jan Kara wrote:
>>> ioprio_get(2) can be asked to return the best IO priority from several
>>> tasks (IOPRIO_WHO_PGRP, IOPRIO_WHO_USER). Currently the call treats
>>> tasks without set IO priority as having priority
>>> IOPRIO_CLASS_BE/IOPRIO_BE_NORM however this does not really reflect the
>>> IO priority the task will get (which depends on task's nice value) and
>>> with the following fix it will not even match returned IO priority for a
>>> single task. So fix IO priority comparison to treat unset IO priority as
>>> the lowest possible one. This way we will return IOPRIO_CLASS_NONE
>>> priority only if none of the considered tasks has explicitely set IO
>>> priority, otherwise we return the highest set IO priority. This changes
>>> userspace visible behavior but hopefully the results are clearer and
>>> nothing breaks.
>>>
>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>> ---
>>>  block/ioprio.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/block/ioprio.c b/block/ioprio.c
>>> index 2fe068fcaad5..62890391fc80 100644
>>> --- a/block/ioprio.c
>>> +++ b/block/ioprio.c
>>> @@ -157,10 +157,9 @@ static int get_task_ioprio(struct task_struct *p)
>>>  int ioprio_best(unsigned short aprio, unsigned short bprio)
>>>  {
>>>  	if (!ioprio_valid(aprio))
>>> -		aprio = IOPRIO_DEFAULT;
>>> +		return bprio;
>>
>> bprio may not be valid...
> 
> Yes, bprio may be from IOPRIO_CLASS_NONE as well and IMHO that is a
> desirable return in that case. ioprio_valid() is IMHO a bit of a misnomer
> because IOPRIO_CLASS_NONE is a valid class and can be even set by
> userspace. It actually means, set IO priority based on task's CPU priority.
> But lets first settle on the desired meaning of ioprio in the discussion
> over patch 3/3. How we should behave in this case is a detail we can sort
> out after the general meaning is clear.

Sounds all good to me.

> 
> 								Honza


-- 
Damien Le Moal
Western Digital Research

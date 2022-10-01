Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CE6C433F5
	for <linux-block@archiver.kernel.org>; Sat,  1 Oct 2022 00:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiJAApW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Sep 2022 20:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiJAApV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2022 20:45:21 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085FC27CFF
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 17:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664585120; x=1696121120;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0k8Omvocy/Lmn1JNbD0D6pTNgD8xKFYnwKObyBLyY3Q=;
  b=LcJ2Lwnf/2fuVnv4WmLTwqhr0+dQe/oXx/5T6YSjY3F+dWsgpnLVq4Qn
   9ogb9XAoe5V/jcWbIfD0I1OgrPf+5ayGtS5ZcnlixAbY6ARgHPBHisufO
   2sNOZOqcQbJxltWPpbD3h2VgC+Ljb9Srri1795c7kUY2CZMpLMhichszo
   AMUEwP0Qr/nja+AIG7EW5qLVDwFQv5+KSZq9fJkbouvhTe8XtIUbcAHWC
   Y+KJ+p+Iq7LNi/xzj/g21trvkdoaZbyeat50q5zFASvvTYWYzYI0v7QBH
   v+YAhqlUPbM9fxo84AgV1zLZuK5UycGBC6Ui4ev5CfAp68TuvMeuTPWr2
   w==;
X-IronPort-AV: E=Sophos;i="5.93,359,1654531200"; 
   d="scan'208";a="316995697"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2022 08:45:17 +0800
IronPort-SDR: mlI8eGUgDQp4Kc2GoIw43unuSYNwAABK/b+Gh1CISBStMShSjDtp/NFTHn2rMqQEcFyby2rI2E
 ACKxpm+H3OnSBCxvLiVio60CxrT+F1iZYDspkQPkJybMUFAk8jhwDfEHvVSY8EqaS4eykvmlyO
 TxicBBm1063NT81LkdIeQxvAtnYTjXxN5QxKyXRMpYILcUdo0kHPfycd3K0yvQ88SVez3RFcR7
 xSdvNcR5yMUWZNOMYXmQWbFZlac8SbrCMC4wcOLfE9jAYlUSLZC2L4Pr44b/lBaaunhmrdghVn
 RPn5tdtZ+8oJ9x8vi+qAfyG0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2022 16:59:36 -0700
IronPort-SDR: TeBQzDjPIZqHyHgbDohPRk2gY3BQGSMi7zzcsG5ajdhseUXfy/DM+wcrGpJ8iNECIGNyRod8G7
 BIV3Ze9O8nrv3I9urRO5PZr53OUKoxI7d9oSktLoMNTneYp+hImQ2/v73u/uwnG7zWPD9ysO9R
 qb4k7VDKw0D9dP1FQsOtzX+bOff8XYA5kLALl+91amZjcgaC4szvdMYyvjIFPAcG1dAOAdKYbX
 RBnFJmcTJpJ4MEw0h5Ne7/R1M3ay24nS9Bq24/0RwAycKuQn1RRj9J0SaAF5Cajym7hvCNc5IY
 pYw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2022 17:45:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MfT0D0X29z1Rwt8
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 17:45:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664585115; x=1667177116; bh=0k8Omvocy/Lmn1JNbD0D6pTNgD8xKFYnwKO
        byBLyY3Q=; b=TBmgxUD6GnERjJmdq/0e0i+8yyLf3pp02kEDYv4DrQaFwp/O95E
        D+qy3e2Uo87AHw1O34ZcgRE4Zlvrggr1hP2DdqpE6ihqkKd+3wMtDyqp5HPHXef2
        PG8ulQHC7ut9HCxTvuSaNTqWuRb+F7nMkdNuLqGCpwzB47XZpTqwILKVVARsbsmw
        pdXs48ruVM7tKnCAIMze46IRWrk/AhxTr0fSnA6fbmzB5Ioof7WfHOETwFrUUIap
        iX73D1EoSLUH2PCw7/fX+uCpz3CEaeP9wnUBDUfsb0k7G8LM2/Jz76KhfBBTDFlW
        uDGkZbNTsPzlXsWya34a2a72rMhzYcB+fUQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P3vt0QQWMHhf for <linux-block@vger.kernel.org>;
        Fri, 30 Sep 2022 17:45:15 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MfT076V2Xz1RvLy;
        Fri, 30 Sep 2022 17:45:11 -0700 (PDT)
Message-ID: <bb2b3784-422f-fc82-e5be-e4d24412e21f@opensource.wdc.com>
Date:   Sat, 1 Oct 2022 09:45:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v15 00/13] support zoned block devices with non-power-of-2
 zone sizes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        Keith Busch <kbusch@kernel.org>
Cc:     jaegeuk@kernel.org, agk@redhat.com, gost.dev@samsung.com,
        snitzer@kernel.org, linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
 <20220923173618.6899-1-p.raghav@samsung.com>
 <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
 <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
 <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/1/22 04:38, Bart Van Assche wrote:
> On 9/30/22 08:13, Jens Axboe wrote:
>> On 9/29/22 12:31 AM, Pankaj Raghav wrote:
>>>> Hi Jens,
>>>>    Please consider this patch series for the 6.1 release.
>>>>
>>>
>>> Hi Jens, Christoph, and Keith,
>>>   All the patches have a Reviewed-by tag at this point. Can we queue this up
>>> for 6.1?
>>
>> It's getting pretty late for 6.1 and I'd really like to have both Christoph
>> and Martin sign off on these changes.
> 
> Hi Jens,
> 
> Agreed that it's getting late for 6.1.
> 
> Since this has not been mentioned in the cover letter, I want to add 
> that in the near future we will need these patches for Android devices. 
> JEDEC is working on supporting zoned storage for UFS devices, the 
> storage devices used in all modern Android phones. Although it would be 
> possible to make the offset between zone starts a power of two by 
> inserting gap zones between data zones, UFS vendors asked not to do this 
> and hence need support for zone sizes that are not a power of two. An 
> advantage of not having to deal with gap zones is better filesystem 
> performance since filesystem extents cannot span gap zones. Having to 
> split filesystem extents because of gap zones reduces filesystem 
> performance.

As mentioned many times, my opinion is that a good implementation should
*not* have any extent span zone boundaries. So personally, I do not
consider such argument as a valid justification for the non-power-of-2
zone size support.

> 
> Thanks,
> 
> Bart.
> 
> 

-- 
Damien Le Moal
Western Digital Research


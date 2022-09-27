Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13ADC54EE9
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 23:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiI0XKM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 19:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiI0XKL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 19:10:11 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6328E89CF4
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 16:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664320207; x=1695856207;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=t9B8hiHJeP1V1/rM82JljOiqW17uPjA1e2KxpGkdkhE=;
  b=em+GAkzvpfWX/+f+RBsFeNAkLDFNIONwve79hHX/sZ6YBDdDnYOmCGV2
   pbEVKg6fFSs/dBG0/cgqJ5qrq3nKz63s/3vzmH7cAl2zGlwfmivQ9WjHA
   +f1LcVxeRTM5u06BnkuWEJwopMXgMScJjqHGQFiRX1OKdTJVKqaSPGJ3v
   aIWzqMRBTGQMXIJlHjVCyA105rNSCsT4McjWvDLT+h+ZHL2VP0yBqMz3P
   iG/BgnplUIzT+EJKGW9LI6QfTD2N3V23atfWWwXwYPwaDqOl0vzmbySCC
   L5/jqQ2JVZmvD79/nhaORZ1AoBWnR1plkSMRAjSK82pjQWtV0n2SX6Bzj
   g==;
X-IronPort-AV: E=Sophos;i="5.93,350,1654531200"; 
   d="scan'208";a="212838577"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 07:10:06 +0800
IronPort-SDR: svW4T6N1J3HonpQajADM724R3iTWVJOvM4/QUSNbA9XttAx+/nuLkj5FXngG472ueAuD83iM5X
 NgB6T2dkOIz1DOfT1FeYaGISrm68ANJYMUzlBZna/8cyQgISQ91UI6a7ERcI6R8WthqtHncgBQ
 p2lIEcjDvQDs9MWyTzDJAwDtrJPUsSXws2/hvMEKkcU4AcTF9O5TzeOloLzgS9n4bGOAhiBiPa
 mImiIRog3gBPfIKGOwfRjiPJy+fTyOkZXcUSx6HTsM8lAwfwqf5irC5+q+BBaia2sXP+J1OhDJ
 EXb5rV/8jDcgP1B0DKRZL1az
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2022 15:24:30 -0700
IronPort-SDR: +JiCwNakfuZzYW2WicdItWH3UKQghqgO3UnEyjv1egNWIDwU/VLUz49CQHSJM5ZFwUzgiAXF5m
 jXoTNyQmugfczgsCAWRMHlJ+u1L5YATa+nDD0BICTqbVlJ/6neI7RTQa9U9mMPI4rz0icQ1f8H
 iUnI/FmqAS8Cqs/WgNRMaUVvvasfFkPBoltLwrc9v/IgXsYnno5/r2Pnu3e3rAxUA8Qwu7UL8f
 Fbr//GxBwGRwaaAOKSm9sWuwp4S59ojDJRFqeaggrf6v2nt0Ef7elGGXPHetg8QJywJ9HzZnJ1
 X8U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2022 16:10:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mcb1n3qD5z1Rwrq
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 16:10:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664320205; x=1666912206; bh=t9B8hiHJeP1V1/rM82JljOiqW17uPjA1e2K
        xpGkdkhE=; b=hZsTDlwlJfg7Em+m0QKSAtN85SsOt3UVwHms2TBxj+dFaXTcH+R
        7eyc0nzBUkdPYGLJVX4yOQOQpNh0ALebXKcXnA5FBDFwGXl/F+vXjC7PuV9JPqob
        3j89l6pfpSTqUOkGviJ7bP8Zo+L9KgNW7HDvqS8pY3+h0ps3mcZ0kTPx6zpVhBxt
        0R6QgP90e6cdBB/tDJ0F/fRQYTALzZ8TNwCmawP4Rj0ZX2WX2pGeU9NcN3EGy9Ew
        Kf4NWyYbrhkHv/4bpqxENsFntwMV6TsevX0J7/lmbHynvccpyzCL8UlhLW1kuB8B
        Xb3iYI8tivSmaEXfhaU1oOdDGLE36G+LKhw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mNVGUAfcPaa8 for <linux-block@vger.kernel.org>;
        Tue, 27 Sep 2022 16:10:05 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mcb1m0z2yz1RvLy;
        Tue, 27 Sep 2022 16:10:03 -0700 (PDT)
Message-ID: <80b83432-27a4-35ab-53a5-954bf1d7e415@opensource.wdc.com>
Date:   Wed, 28 Sep 2022 08:10:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, linux-block@vger.kernel.org,
        gost.dev@samsung.com
References: <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
 <20220925185348.120964-2-p.raghav@samsung.com>
 <YzG5RgmWSsH6rX08@infradead.org>
 <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
 <YzG6fZdz6XBDbrVB@infradead.org>
 <2ee6a897-87e7-0592-2482-9928a9a63ff6@kernel.dk>
 <a943acf8-f367-a1ba-0d57-2948a3ade6f4@samsung.com>
 <350366c3-1014-ac32-149f-689134631d73@kernel.dk>
 <6273f2c1-7889-1931-aec6-e567aa4d2d96@samsung.com>
 <fa80eef0-42a4-6ffc-cced-18ecbe5b1f5a@kernel.dk>
 <YzMp+SIsv6Aw4bFW@infradead.org>
 <3c6002c7-cd69-e020-24b8-650aaf9ad893@kernel.dk>
 <8ed09dfb-0c09-c04a-76fd-5971c7ddc794@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8ed09dfb-0c09-c04a-76fd-5971c7ddc794@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/28/22 08:07, Damien Le Moal wrote:
> On 9/28/22 01:52, Jens Axboe wrote:
>> On 9/27/22 10:51 AM, Christoph Hellwig wrote:
>>> On Tue, Sep 27, 2022 at 10:04:19AM -0600, Jens Axboe wrote:
>>>> Ah yes, good point. We used to have this notion of 'fs' request, don't
>>>> think we do anymore. Because it really should just be:
>>>
>>> A fs request is a !passthrough request.
>>
>> Right, that's the condition I made below too.
>>
>>>> if (zoned && (op & REQ_OP_WRITE) && fs_request)
>>>>          return NULL;
>>>>
>>>> for that condition imho. I guess we could make it:
>>>>
>>>> if (zoned && (op & REQ_OP_WRITE) && !(op & REQ_OP_DRV_OUT))
>>>>          return NULL;
>>>
>>> Well, the only opcodes we do zone locking for is REQ_OP_WRITE and
>>> REQ_OP_WRITE_ZEROES.  So this should be:
>>>
>>> 	if (zoned && (op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES))
>>> 		return NULL;
>>
>> I'd rather just make it explicit and use that. Pankaj, do you want
>> to spin a v2 with that?
> 
> It would be nice to reuse the bio equivalent of
> blk_req_needs_zone_write_lock().
> 
> The test would be:
> 
> 	if (bio_needs_zone_write_locking())
> 		return NULL;

Note that we could also add a "IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&" to the
condition or stub the helper to have this hunk disappear for the
!CONFIG_BLK_DEV_ZONED case.

> 
> With something like:
> 
> static inline bool bio_needs_zone_write_locking()
> {
> 	 if (!bdev_is_zoned(bio->bi_bdev))
> 		return false;
> 
> 	switch (bio_op(bio)) {
>         case REQ_OP_WRITE_ZEROES:
> 
>         case REQ_OP_WRITE:
> 
>                 return true;
>         default:
> 
>                 return false;
> 
>         }
> }
> 
> Which also has the advantage that going forward, we could refine this to
> plug writes to conventional zones (as these can be plugged).
> 

-- 
Damien Le Moal
Western Digital Research


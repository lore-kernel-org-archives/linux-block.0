Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF22CC636D3
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 03:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjAaDKo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 22:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjAaDKn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 22:10:43 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D5811B
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 19:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675134642; x=1706670642;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=74mUSSZbgXTIvUjr10/8l80yClPOJgEszMjAqE2My3I=;
  b=E0rDQ/aola8UnxAZvNQLbe6iIvMHzcz2N45kU1ikABZTc+3yrnD9VUG5
   16jS7mr+sqKJSC+tldTahJ+oahHpxHVytbrkd5zdnGabu4NVrl4eLOn8n
   bhI8qh2YiSIo/PlaTDtqhuvaGpTVzDUh4UNLmFyd9ZkAE/o/pufseC8Y0
   lhYdxvvK2LS60q812hqfElAgrR2LPauTVRCZDrI+GNQHs+V+85V5kLLNy
   BFzL6kHPUovE/8xsNbWzKLdAgWdmbSp8zQlGOZ7Zcpn4HxLrpT673JH0q
   jkCAsoPRUsdMvbd2iI7NCJZstQV6Mw9UN9U+Zq2kZ8C0A+DR8zDTOqO5R
   g==;
X-IronPort-AV: E=Sophos;i="5.97,259,1669046400"; 
   d="scan'208";a="227106787"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2023 11:10:42 +0800
IronPort-SDR: BW4odnVn2ENf+NMRWLdEFNpEYPllWRIKuf4D6yZpPrFU9H79d3rNKza3yojyG+Btg/Mw8bI7sp
 JczN7L1eVxJ8mDUK6a7NbCH1WoV7oWIoYW+J+awCw/j4Z7umg22ZA1Y0XLChpCKolf1Es4/WUA
 zZMeP237GFd48q9ndct0/9WQiRio8123sy5AdE3J32WxNJnr4hZb+ov6rM/IRMlFwQHo0Fr4R8
 beJYXZ0Ea41Cnk2BMS7Jm9+RJLXSupi68dxObtfPYI/yS3LUL/Rr4XF+usPEsvONk/CE5ikB5F
 g1Y=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 18:28:07 -0800
IronPort-SDR: cDM9SHAeeoeQK3WRNhT7kZL5/wosuOPsshYzJnY/Sk+n7kAYjzY0WTaE2nwThmZbUCq3/hFIYX
 XjnqePCG35oQZBqisjJ3BHd11DQyDPBkADP88Tkfd2cJ/VtIPbDnTe1a89vX5ww+XFt6JQkEjt
 chJ4SGYBVbGHQ6gMoszmt9QTH+9XdWbj+ITq3nXbrwRL6iVRFORgGEjhjSd1etCWSbKNj2300L
 Qk3uyqEH6Bu/grVZiowyvhcKmbdXwQx0lc2vVFemQn2zJvbMEiR4ff4YKwnI+yczj94Z6NykDI
 s5o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 19:10:43 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P5VRk13WYz1RvTr
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 19:10:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675134641; x=1677726642; bh=74mUSSZbgXTIvUjr10/8l80yClPOJgEszMj
        AqE2My3I=; b=chMl9+h6Sy4ZyHyaRKxQD2vlyTIsy2eo0OxUuSArbAlGoEhnNCa
        C75idSQWanVipKaEO1x0NaZxka/lhz9claSn5YjaUnB+jR+CqpubI077M7dAQR5H
        LBPml6dT36qsUFozQ5m8k6e53sym250KGJD5dbkOeqg1losx6Kc2ZuwynidgNQKk
        v0pX4phAml/Bsgwc+TDKRntTU8WPQfHR3RXRZ9n0z4Er02nfNxWH9ZmIObJLtfRM
        bIAYB5E0wokVT8JhVm8Pmmud3MzKakyJklgjnWVgrECbFF1YU9JGwEaezUl23yn2
        bonAS8NAKZVHcLrSyk7UT3p+GTfCZHP2KcA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id voBiJnCiw9RR for <linux-block@vger.kernel.org>;
        Mon, 30 Jan 2023 19:10:41 -0800 (PST)
Received: from [10.225.163.70] (unknown [10.225.163.70])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P5VRg5lpYz1RvLy;
        Mon, 30 Jan 2023 19:10:39 -0800 (PST)
Message-ID: <4a8a46cb-fec8-4ca8-a346-62fd0f0efb73@opensource.wdc.com>
Date:   Tue, 31 Jan 2023 12:10:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 01/18] block: introduce duration-limits priority class
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20230124190308.127318-2-niklas.cassel@wdc.com>
 <873e0213-94b5-0d81-a8aa-4671241e198c@acm.org>
 <4c345d8b-7efa-85c9-fe1c-1124ea5d9de6@opensource.wdc.com>
 <5066441f-e265-ed64-fa39-f77a931ab998@acm.org>
 <275993f1-f9e8-e7a8-e901-2f7d3a6bb501@opensource.wdc.com>
 <e8324901-7c18-153f-b47f-112a394832bd@acm.org> <Y9Gd0eI1t8V61yzO@x1-carbon>
 <86de1e78-0ff2-be70-f592-673bce76e5ac@opensource.wdc.com>
 <Y9KF5z/v0Qp5E4sI@x1-carbon> <7f0a2464-673a-f64a-4ebb-e599c3123a24@acm.org>
 <29b50dbd-76e9-cdce-4227-a22223850c9a@opensource.wdc.com>
 <c8ef76be-c285-c797-5bdb-3a960821048b@opensource.wdc.com>
 <ddc88fa1-5aaa-4123-e43b-18dc37f477e9@acm.org>
 <049a7e88-89d1-804f-a0b5-9e5d93d505f7@opensource.wdc.com>
 <b77d5e44-bc1e-7524-7e09-a609ba471dbc@acm.org>
 <4e803108-9526-6a75-f209-789a06ef52f9@opensource.wdc.com>
 <yq1r0veh2fa.fsf@ca-mkp.ca.oracle.com>
 <f8320ff3-0f52-aa0c-635e-c1e7c28ffe25@opensource.wdc.com>
 <yq1bkmfe88c.fsf@ca-mkp.ca.oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <yq1bkmfe88c.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/31/23 11:49, Martin K. Petersen wrote:
> 
> Damien,
> 
>> Makes sense. Though I think it will be hard to define a set of QoS
>> hints that are useful for a wide range of applications, and even
>> harder to convert the defined hint classes to CDL descriptors. I fear
>> that we may end up with the same issues as IO hints/streams.
> 
> Hints mainly failed because non-Linux OSes had very different
> expectations about how this was going to work. So that left device
> vendors in a situation where they had to essentially support 3 different
> approaches all implemented using the same protocol.
> 
> The challenge of being a general purpose OS is to come up with concepts
> that are applicable in a variety of situations. Twiddling protocol
> fields is the easy part.
> 
> I have a couple of experienced CDL users that I'd like to talk to and
> try to get a better idea of what a suitable set of defaults might look
> like.
> 
>> This hint applies to all priority classes and levels, that is, for the
>> CDL case, we can enrich any priority with a hint that specifies the
>> CDL index to use for an IO.
> 
> Yeah, I like that approach better.

Of note is that even though the IOPRIO_XXX macros in include/uapi/linux/ioprio.h
assume a 16bits value for the priority class + data, of which only 6 bits are
usable (3 for the class, 3 for the level), all syscall and kernel internal
interface has ioprio defined as an int. So we have in fact 32 bits to play with.
We could keep the lower 16 bits for ioprio as it was, and have the upper 16bits
used for QOS hints. More room that the 10 bits between the prio class and level.

The only place that will need changing is struct bio since bi_ioprio is defined
as an unsigned short. To solve this, as Bart suggested, we could add another
unsigned short in the bio struct hole for the qos hints (bi_iohint or bi_ioqoshint).

But if we can define a sensible set of hints that covers at least CDL with the
10 free bits we have in the current ioprio, that would be even better I think
(less changes needed in the block layer).

-- 
Damien Le Moal
Western Digital Research


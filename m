Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D811BC54E94
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 22:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjAXW7z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 17:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjAXW7y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 17:59:54 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E45548A35
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 14:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674601193; x=1706137193;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8SM70Dlf7fLYn+WUcdncVkekL58cqX2atq1y9lTSQy0=;
  b=jSvsKlDVT8uClJS7N05lMZ2l9p5pDTGonLoZdEt4Pi+gGhkdGdc+DIIr
   Br1EjqhaqOV2uRX8Q2RH8ip1O8ahnQNKUo8gD0peBdutGnKWZXPorHrhp
   Z8FyR+/h3TwpWtJXrx6VevAceH2djV/MlEpUlE35asxcQboYf6sb+/Co6
   vthXvA1s5ASIC/qZTdb7g0vD4/H5/BEsKlfhpK2uLiXdXY8Yi2V/UiE67
   6BwTj7qDG2LZygI2epxMKasSp9UGJ6kRFy+nSkgGx9dyGHi5gfrbn8vwp
   3Huq84Wj4VAEQlYEuBNO1qcZL7kzGc38iWar7kSaqoGEoEKiU0rsR/B5x
   A==;
X-IronPort-AV: E=Sophos;i="5.97,243,1669046400"; 
   d="scan'208";a="226657983"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2023 06:59:51 +0800
IronPort-SDR: 08dpz7Ro66kAItxREE//HcYSncOyx5JPUf5JB47vsYDv9dLZNFbCCSoSyCXUwvbhOHW9+Fn2fz
 0u1cTDXMiqDq46U0ZrYjFnjP8bIlgyURPLLw1Z+h9ziuL/Cq6S0brq5Zi9JXofFB5y+QzJvQA2
 3TYxgmCXBRJtuJm12peNvu53bFfCA3VPlBkKsAUbTsuDOsiKa9UEDE2iOYpsfaAVoHK10Y6X3+
 SESsgrTLDSjoVxiuxW6Qi2Ge2IUfZsWe8n1HIyOypK7uJyoujf+qSnPuAyBRSGhG3/9ey9SYsq
 Rwg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 14:11:39 -0800
IronPort-SDR: 4DFDudv+MyohaZH27+9CWwJGz+ddCulde60VOLIEHooDlVjKyRW5sEK3Dr34Pc0ygAubs+Wzq7
 2E6QI60rM5M0Llr5VCCAyeovWluR8UVR3L5bcJ3ywpEM56IeHsF8VLguqsOLtRe4IJOeP6+d4+
 WO/obWiI9qDZ1cM1anBWrOS37f0gmWLtIhvYeDs73ZieM8gvQENsDlwMNJAMNwgx7LmYjxTI4u
 NIWoyxXPWqOysVAkiZdoxZLp4IYoPmdGu8Cijzc5IEyKPrL6xV5k5/5Wce70buGxl++mIFxvy5
 Hzs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 14:59:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P1j930Hmsz1RwtC
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 14:59:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674601189; x=1677193190; bh=8SM70Dlf7fLYn+WUcdncVkekL58cqX2atq1
        y9lTSQy0=; b=P7Tsk03aU+0y7GaKVQjEHuq44KHdz7di5d4La5qjsk7YHbJ2Mbp
        0jjpsWkWQc2+ZKbwzzjiW0kSq+cbFRkPHmQPKEPW+v3evetrVgMd+iyJSb4uh+XI
        1Y7SEYO/Z89ga6akR2cz1a15QjKA4QYxWcbcp+B+bbI7fZrj0g8ttE+uTy3oCfRq
        WyfFRPgbenPl3Spuf6IGtwCerlxwWrVqHvXp3gbGMh5d/cu7YR7izY0ULbDYlEDx
        8K4xUxFVfwqQmWaKNui7o7q3bLtzV+cq3OzVOffdEA3qbv6krlo4GO7HgU4hXLPa
        Tm1l6L6ScfQYxhjQW5ZNexSNPcu6xF0zypA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L6Mgc77ErYQH for <linux-block@vger.kernel.org>;
        Tue, 24 Jan 2023 14:59:49 -0800 (PST)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P1j901bcfz1RvLy;
        Tue, 24 Jan 2023 14:59:47 -0800 (PST)
Message-ID: <4c345d8b-7efa-85c9-fe1c-1124ea5d9de6@opensource.wdc.com>
Date:   Wed, 25 Jan 2023 07:59:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 01/18] block: introduce duration-limits priority class
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20230124190308.127318-1-niklas.cassel@wdc.com>
 <20230124190308.127318-2-niklas.cassel@wdc.com>
 <bd0ce7ad-cf9e-a647-9b1e-cb36e7bbe30f@acm.org>
 <731aeacc-74c0-396b-efa0-f9ae950566d8@opensource.wdc.com>
 <873e0213-94b5-0d81-a8aa-4671241e198c@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <873e0213-94b5-0d81-a8aa-4671241e198c@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/23 07:43, Bart Van Assche wrote:
> On 1/24/23 13:29, Damien Le Moal wrote:
>> I/O priority at the device level does not exist with SAS and with SATA,
>> the ACS specifications mandates that NCQ I/O priority and CDL cannot be
>> used mixed together. So from the device point of view, I/O priority and
>> CDL are mutually exclusive. No issues.
>>
>> Now, if you are talking about the host level I/O priority scheduling done
>> by mq-deadline and bfq, the CDL priority class maps to the RT class. They
>> are the same, as they should. There is nothing more real-time than CDL in
>> my opinion :)
>>
>> Furthermore, if we do not reuse the I/O priority interface, we will have
>> to add another field to BIOs & requests to propagate the cdl index from
>> user space down to the device LLD, almost exactly in the manner of I/O
>> priorities, including all the controls with merging etc. That would be a
>> lot of overhead to achieve the possibility of prioritized CDL commands.
>>
>> CDL in of itself allows the user to define "prioritized" commands by
>> defining CDLs on the drive that are sorted in increasing time limit order,
>> i.e. with low CDL index numbers having low limits, and higher priority
>> within the class (as CDL index == prio level). With that, schedulers can
>> still do the right thing as they do now, with the additional benefit that
>> they can even be improved to base their scheduling decisions on a known
>> time limit for the command execution. But such optimization is not
>> implemented by this series.
> 
> Hi Damien,
> 
> What if a device that supports I/O priorities (e.g. an NVMe device that 
> supports configuring the SQ priority) and a device that supports command 
> duration limits (e.g. a SATA hard disk) are combined via the device 
> mapper into a single block device? Should I/O be submitted to the dm 
> device with one of the existing I/O priority classes (not supported by 
> SATA hard disks) or with I/O priority class IOPRIO_CLASS_DL (not 
> supported by NVMe devices)?

That is not a use case we considered. My gut feeling is that this is
something the target driver should handle when processing a user IO.
Note that I was not aware that Linux NVMe driver supported queue priorities...

> Shouldn't the ATA core translate the existing I/O priority levels into a 
> command duration limit instead of introducing a new I/O priority class 
> that is only supported by ATA devices?

There is only one priority class that ATA understands: RT (the level is
irrelevant and ignored). All RT class IOs are mapped to high priority NCQ
commands. All other classes map to normal priority (no priority bit set)
commands.

And sure, we could map the level of RT class IOs to a CDL index, as we do
for the CDL class, but what would be the point ? The user should use the
CDL class in that case.

Furthermore, there is one additional thing that we do not yet support but
will later: CDL descriptor 0 can be used to set a target time limit for
high priority NCQ commands. Without this new feature introduced with CDL,
the drive is free to schedule high priority NCQ commands as it wants, and
that is hard coded in FW. So you can endup with very aggressive scheduling
leading to significant overall IOPS drop and long tail latency for low
priority commands. See page 11 and 20 of this presentation for an example:

https://www.snia.org/sites/default/files/SDC/2021/pdfs/SNIA-SDC21-LeMoal-Be-On-Time-command-duration-limits-Feature-Support-in%20Linux.pdf

For a drive that supports both CDL and NCQ priority, with CDL feature
turned off, CDL descriptor 0 defines the time limit hint for high priority
NCQ commands. Again, CDL and NCQ high priority are mutually exclusive.

So for clarity, I really would prefer separating CDL and RT classes as we
did. We could integrate CDL support reusing the RT class + level for CDL
index, but I think this may be very confusing for users, especially
considering that the CLDs on a drive can be defined in any order the user
wants, resulting in indexes/levels that does do not have any particular
order, making it impossible for the host to correctly schedule commands.


-- 
Damien Le Moal
Western Digital Research


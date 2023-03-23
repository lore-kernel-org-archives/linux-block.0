Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5735BC6FD1C
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 10:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjCWKcY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCWKbu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 06:31:50 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963B138E91
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 03:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679567298; x=1711103298;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JoMpYt0e/2lF8hZ8I1anC1DPS7t6aYO2fKaLKY0Ots4=;
  b=dFoQyYUMcY9dKRffsA02AAr5nAVDonv3gp5uj7zaDgH1RFtX4iI4A487
   FnorXNP9pBfIbIDztAOCRKCyNSfxYpt8jTlGRCnCcyD6Au+1HwktgH5io
   mHGrGqSq47VzlgCWO2RR5oHuYkPcDSdr8AfgnGX6o2KL4I5X8MDv0QxEc
   YGWZr7IDoUAaNgsyGFRCs9dydZwShMqcW06O6d/FH8x9n0QuqeZvIpPaS
   LV9sh2X4m/v9RGKEi7y6AR+N9Oid1ugKnxGVi7Tv/FVYlyhRZ+wCK+76c
   iTXJCxOMSEuTivtROWA/mLsCiFtEFsFV2XFjJ0n4Vz4UEr7ZZLhcW8B+v
   A==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="338374678"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 18:28:17 +0800
IronPort-SDR: kd6Takqqni12PET3gjLiziX1fzYVaDUSp1WkT1AuzR9ZkPYgTXVa+Mi998wyofQc2eHGMm8ZyM
 WqGs9ViuGv08bEVurKAd5CJwXeH4z5To9Pdmxr0dImlD92XyW27K2N7zHlh+pEhobtHXPE8+JX
 rhkbm2WPluXEB+WbgTnqD3HKwD7FQydujAet4LJvFeJ5/7CKtblSJsu82/3ISuDfySDAevzydd
 CizqpvebvWMlqdmH5Yt2m7p+eCThGibiVbLUp1Er475yYdwUF5ynS1FJXD1W7UOQMtfSRDtKfV
 oz4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2023 02:38:52 -0700
IronPort-SDR: t3XtxxGwYwbjcOFY80309JWVVFLce5my5AViwHFrCQ6JTcG5dxJFrafELeLcwfV+mEU5MMpPDs
 sc+hAZoDddCQu6wZl6dBbgU0Oy3uyBxPStqnWg9zGERCC4vMbSLb2Bq89pRj3wqtp7nMMTNHpd
 n5LfSzUMo022zS9XmCY/R6M8DXlKm0a+2gdp2gv6P6XzgxnjUovwEo3jXJtBeyJ4r5upBukztb
 sa0iezukJY4EZee50ix0BLBdRkmfHEU0uOAr+mkr26W5BOEs7bypaIR/NCrKhuuQniHg9lU9EZ
 z0k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2023 03:28:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pj1l35wVnz1RtVp
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 03:28:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679567295; x=1682159296; bh=JoMpYt0e/2lF8hZ8I1anC1DPS7t6aYO2fKa
        LKY0Ots4=; b=qp9DuszvJEhn+Jg2wFRxQP4cwNH7z/vqeS0n9fmSJSybkOLoW4f
        j6cd3D2llkBJvd8WiYedrpB0c3RkUyYrO3d8Rw+Mi4ulDnwTOZrDgufiKXoCLQTC
        xDl6/42qrQKWsapewxI9kwv+2cubJT0Qj7ivRZfqtKicUj8T1GHg7APJm4d1MI6x
        8AJUhRLMrIoZkKynkpf4iRPVB0oHbN9tSDNcYo4bh4pq5lqkCczfYdpxqWy9/Scb
        ZfkacR3gm7XhDXDKXOd/jldi6BA1nuo3xjnKA7qkfJksIVuEF3FPUPpNhgf6+Qli
        NaMSiGQelWexLIxs7/3zGDMJS6iq2clcWZQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9yx-MKz5UGPi for <linux-block@vger.kernel.org>;
        Thu, 23 Mar 2023 03:28:15 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pj1l15v5Sz1RtVm;
        Thu, 23 Mar 2023 03:28:13 -0700 (PDT)
Message-ID: <acd13f8c-6cbe-a14d-e3b4-645d62811cec@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 19:28:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
 <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
 <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
 <20230321055537.GA18035@lst.de>
 <100dfc73-d8f3-f08f-e091-3c08707e95f5@acm.org>
 <20230323082604.GC21977@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230323082604.GC21977@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/23 17:26, Christoph Hellwig wrote:
> On Tue, Mar 21, 2023 at 07:36:12AM -0700, Bart Van Assche wrote:
>> The UFSHCI specification is very clear about the requirement that UFS host 
>> controllers must process SCSI commands in order if host software sets one 
>> bit at a time in the UFSHCI 3.0 doorbell register: "For Task Management 
>> Requests and Transfer Requests, software may issue multiple commands at a 
>> time, and may issue new commands before previous commands have completed. 
>> When software sets the corresponding doorbell register, the Task Management 
>> Requests and Transfer Requests automatically get a time stamp with their 
>> issue time. The commands within a command list (Task Management List or 
>> Transfer Request List) shall be processed in
>> the order of their time stamps, starting from the oldest time stamp. In the 
>> case multiple commands from the same list have the same time stamp, they 
>> shall be processed in the order of their command list index,
>> starting from the lowest index."
> 
> But we can't write Linux software just for UFS.  We have no sensible
> ordering guarantee anywhere else.
> 
>> Damien and Jens agree about introducing an additional hardware queue for 
>> preserving the order of zoned writes as one can see here: 
>> https://lore.kernel.org/linux-block/ed255a4a-a0da-a962-2da4-13321d0a75c5@kernel.dk/
>>
>> In our tests pipelining zoned writes (REQ_OP_WRITE) works fine as long as 
>> the UFS error handler is not activated. After the UFS error handler has 
>> been scheduled and before the SCSI host state is changed into 
>> SHOST_RECOVERY, the UFS host controller driver responds with 
>> SCSI_MLQUEUE_HOST_BUSY. I'm still working on a solution for the reordering 
>> caused by this mechanism.
> 
> We'll still need REQ_OP_ZONE_APPEND as the actual file system fast path
> interface.  For a low-end device like UFS the sd.c emulation might be
> able to take advantage of the above separate queue as an implementation
> detail.

For the zone append emulation, the write locking is done by sd.c and the upper
layer does not restrict to one append per zone. So we actually could envision a
UFS version of the sd write locking calls that is optimized for the device
capabilities and we can keep a common upper layer (which is preferable in my
opinion).

-- 
Damien Le Moal
Western Digital Research


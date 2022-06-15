Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E42C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 01:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiFOBJU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 21:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFOBJT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 21:09:19 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8CD27146
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 18:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655255358; x=1686791358;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+tRwNjRuhci1JHnRllp3ojdLM7zERqwW6RlnZz3xLwY=;
  b=rfY3Knpig7vdFZB96y64Ogb2kIvlCZ76+9kkj1RC7mWcxxS8dqLGx1NH
   eSo9zeVAIIOp3cb+q8tPFtR9KDLQhQYWi++oAu/TdHVLwP5AAPPKQpxbI
   x0lN+xabpy7P3WdENuYCI8S7ajumDQZ+XTK4wIsTmtkiGRt3I61LzuzH1
   7rNtPLM5TnMgIdy7SxaL/Hy6YhaW0+WwUvBCwChVcnDQ3khxqgvfscBvQ
   X1Cnohoz7B69Knd8CYEk+QjKJb7tyFT+jclP7JXxby0PX4x8rGmREspqJ
   P6bVFcg4QP24sLb6TYrs0pvv4hFuzE1tfO+Subs+V/OsE/8JE/2yKvgnQ
   g==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647273600"; 
   d="scan'208";a="203942258"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 09:09:18 +0800
IronPort-SDR: FeaT+VurOTqO0Y2xS6phozuHkTMYVO0oXWSMGs2mRvXpVNOWKSyti4z98JIOlclhm5nnheKtrW
 1bU78KfVaUPIhVsARsVGGirH9GeeUnZRFokxki/D59K1xlQF6+6Sllsi/EuGGw2rSGk68U3DrF
 f4c3MMvGxT/J5OUUG31ffghuqIpjcpHVoVnGOaZ9DKzEKgy+nVTQp2Dq2U3o2FRWj1s4Fxu4Ed
 dTcxhh2DK9Xw3xtELLamQ0en3INsIOM90mKLzFKfb9tkzQzx2AJYldO1UM1ljoWZPvUmX0aIL8
 n1xr9Dyp9UGyjD+PWACzAkio
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 17:32:15 -0700
IronPort-SDR: HhJTs+AyBjyscXfFAidzFy2AIlrjULzejXwT0sWs8wVctwqPAztTTYPWTCcnLPyAYCoQE22PPH
 u3TvPesg4wmVQO1VS7Y3qa8AZz/5u6Z8CBVajH+4ieWWFiLko3TOruS8EWl4FjXEeyf/zDOWOb
 JTLFd3D/hVfq5/fRk6icZfjIqF+S29nXL50yUV0BSsD4fHNbNm8UQP7YLqiLwg9iefAxptGXYW
 Et4T5+pkpR4JDx89WG7pooDJsjxxDq7ZhAcRO+rUp5gdAiqp5fC99haUFtNjg0CSyJrQRChHpU
 qVw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 18:09:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LN6dn1MYwz1Rvlx
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 18:09:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655255356; x=1657847357; bh=+tRwNjRuhci1JHnRllp3ojdLM7zERqwW6Rl
        nZz3xLwY=; b=LZYAjmsbXXpOwtfTPUZPsqNlxj1eMCCsO+HfdB2Va0oZ0vT8SYr
        2CcSaqBXvg2oLaLxhrVYC2nRAEewF5OpsZ64Ch8GimjFjvs03DPLbEhsx4G4nmkc
        P2tIhRttibA4DDfUdEirJq2aDUea+iuOJ4tw4i5tQLZQ3nd6tcbvvC2u0qhDuuqi
        0EeIE//grtLYki/luXC5Wizd3g+hrBzTr5IuBKr1w/Rla4zEau8sGOZ9GiiBlFgL
        u7OlZXzDo/VxFpOXDXkleo5foGMO+IkQgjEzk8vV28o4ukWKj784LhOXN0Y1DhlV
        m21kuMAQWHENP3OY6Pz1rTo7ULwh7X27i7A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n8RF3GavCjBs for <linux-block@vger.kernel.org>;
        Tue, 14 Jun 2022 18:09:16 -0700 (PDT)
Received: from [10.225.163.82] (unknown [10.225.163.82])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LN6dk6QgSz1Rvlc;
        Tue, 14 Jun 2022 18:09:14 -0700 (PDT)
Message-ID: <f0457062-ef63-f4fe-5dfe-e193d2ae2a29@opensource.wdc.com>
Date:   Wed, 15 Jun 2022 10:09:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/5] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
 <20220614174943.611369-3-bvanassche@acm.org>
 <399e595b-06d2-ceb1-1b42-2a98a7724320@opensource.wdc.com>
 <29a13708-56b1-60e8-558a-ec4a469eaa6d@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <29a13708-56b1-60e8-558a-ec4a469eaa6d@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/15/22 08:56, Bart Van Assche wrote:
> On 6/14/22 16:29, Damien Le Moal wrote:
>> On 6/15/22 02:49, Bart Van Assche wrote:
>>>  From ZBC-2: "The device server terminates with CHECK CONDITION status, with
>>> the sense key set to ILLEGAL REQUEST, and the additional sense code set to
>>> UNALIGNED WRITE COMMAND a write command, other than an entire medium write
>>> same command, that specifies: a) the starting LBA in a sequential write
>>> required zone set to a value that is not equal to the write pointer for that
>>> sequential write required zone; or b) an ending LBA that is not equal to the
>>> last logical block within a physical block (see SBC-5)."
>>>
>>> I am not aware of any other conditions that may trigger the UNALIGNED
>>> WRITE COMMAND response.
>>>
>>> Retry unaligned writes in preparation of removing zone locking.
>>
>> Arg. No. No way. AHCI will totally break with that because most AHCI
>> adapters do not send commands to the drive in the order they are delivered
>> to the LLD. In more details, the order in which tag bit in the AHCI ready
>> register are set does not determine the order of command delivery to the
>> disk. So if zone locking is removed, you constantly get unaligned write
>> errors.
> 
> The performance penalty of zone locking is not acceptable for our use 
> case. Does this mean that zone locking needs to be preserved for AHCI 
> but not for UFS?

I did mention that: if for a UFS device it is OK to not have zone write
locking, then sure, have mq-deadline not use it and eventually even do not
set ELEVATOR_F_ZBD_SEQ_WRITE for the device queue. But AHCI and SAS HBAs
definitely still need it. NVMe too since all it would take to see an
unaligned write is to have the writer context being rescheduled to a
different CPU or multiple contexts simultaneously writing. Also note that
the command requeue path uses a workqueue and that also results in
reordering, potentially with large delays. I seriously doubt that any
reasonable amount of retry will prevent unaligned write errors if there is
a requeue.

Another solution would be to try to hold the zone write lock for a shorter
interval. All we need is to guarantee in order delivery to the device. We
do not care about completion order. So theoretically, all we need, is to
have the LLD unlock the zone after it issues a write to a device. That is
very tricky to do though as that could be very racy. And that is not
always possible too. E.g., for AHCI, the "command delivered to the device"
essentially boils down to "command tag marked as ready in ready register".
But then you need to wait for that bit to be cleared before setting any
other bit for the next write command in sequence (the bit being cleared
means that the drive got the command). And with the current dispatch push
model, that is not easily possible. We would need to go back to legacy
command pull model.

Also note that for ATA & SAS, with recent drives, the performance penalty
of zone write locking is almost nill as long as the drive is running with
write-cache enabled. And even with write-cache disabled, recent drives are
almost as fast as the WCE case.

> 
> Thanks,
> 
> Bart.
> 


-- 
Damien Le Moal
Western Digital Research

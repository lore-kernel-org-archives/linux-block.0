Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A038DC54E94
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 21:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjAXV3e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 16:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjAXV3d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 16:29:33 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA0616ACB
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 13:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674595771; x=1706131771;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y1q6V757IBYa1qj4S9xlMkp5Y7al5XQnblfFT2qlxr4=;
  b=r4WpdCUVmpADutgf2qlIGtpM1HBh/WYXxDFBWwgF7Td1pN7V3LuPNml1
   EA8it4LqaUVzr1ErWCG0KQHRokQRLKrGYCGdc7EqDIAfvy4/TEJv/fK+j
   FECaZMoTruK9FA6byvwY2BrtIjyoWBmugSrVy1nJEZ1t9a2JPmYzItplM
   lpZXf46AeLs537UENjfsFrIsvQvEhszAAuXVOw2V6vfn6kSKJaVUMGmHu
   OW50/UvH9Hy86qdd0nJ75gg+Zj/qCJXF8K/Va3o2KsDKv5/oX+VMt9cVo
   XgV5mf3Dy1ffxYIdmU4ez+HcWgjXEc2adBGhH8j32Q+t8z4IjTA5TIL2k
   w==;
X-IronPort-AV: E=Sophos;i="5.97,243,1669046400"; 
   d="scan'208";a="325970812"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2023 05:29:31 +0800
IronPort-SDR: 4WX88PaQxrluumDvZU9sSaVtY8/if0bKVEaYlxjeO57p4VDzmaUIs3n9xec+Vj+V6fJzv0bkhT
 jbRxRNUO5jYOopREfs7SXDBhspfkKVt8QL1T4PBUzrGW8cfmkPXL464fdW/jf/IyOM2zmzRzLp
 jkxBAaJNqCkJ1gvATa4+Xg5yJkLtETobChJ3O10n1om3s+Boz5lAe35abBYeHLhdETkYaU8Irv
 YuzosayV+L3y81AKHHxXC81/jSp9ZAdjiV8XEPLnv51OYBzZUatPdv/PMHr9SbThJPsKsMKk1r
 wis=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 12:41:19 -0800
IronPort-SDR: FO5Nr4VHUvPb6uDwgvQ/gBq/NU4hT6qqb3ma5lTv50/KOYQNMXU2Xb7uACSIyl4J/Jnf1jERx/
 HUn8ZlSIbRlglLsxkN7izZVwC/AzkCv/wTR3c8OUvxeVPWk+DRTakRa0sWHJ3KSR38PQM8dg4+
 LqZe5Bo0k+ROQNUbN2WYuY8wFw/Y257y7SaONGb4adSh9Rt/vGEdFWaJ7QFXnDkTd5wbLw/0q0
 cjUQmZpBpyBf0lH5nlFkccopCNUwxs3h/sZMVsjgVJgYI/MYTDizCBHAYbl7WVkQ4swdxjWPIg
 oCk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 13:29:31 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P1g8q04LWz1Rwt8
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 13:29:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674595769; x=1677187770; bh=Y1q6V757IBYa1qj4S9xlMkp5Y7al5XQnblf
        FT2qlxr4=; b=Qp0ZgpdprEIhGnOQylawGI+ScE+ZjnZczRC0jdjcKAZfghXb0eX
        B0KHsi1tWXmc7RRVK3IDEJk5JW5ouIaeQNOOW93fmyQgvBF9z+4sDtSbdlvDkTy4
        EvhlK7AdkfnYWyxM8fd056Zj1ws+SQlx2RHvLOieT+5W5grjLgJqqCTEMqRi9//n
        g5wDXRpr8Ku5MRfPwY+FLRwzV9bHFURjY8/SejMViWTjjRNw5AcTeZ1ypFa8ZvB3
        Aylf7lTv+HT/KKunrHTHm2mvUMpJle8XkeqHXQ7QfFmZQRcN3ltfdxdcPCVnvuw7
        irGGIXLayK3YvRZ+EXK8eq3g3q8jeLPYGAw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GlWUmijJH6PM for <linux-block@vger.kernel.org>;
        Tue, 24 Jan 2023 13:29:29 -0800 (PST)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P1g8m2bz3z1RvLy;
        Tue, 24 Jan 2023 13:29:28 -0800 (PST)
Message-ID: <731aeacc-74c0-396b-efa0-f9ae950566d8@opensource.wdc.com>
Date:   Wed, 25 Jan 2023 06:29:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 01/18] block: introduce duration-limits priority class
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
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <bd0ce7ad-cf9e-a647-9b1e-cb36e7bbe30f@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/23 04:27, Bart Van Assche wrote:
> On 1/24/23 11:02, Niklas Cassel wrote:
>> Introduce the IOPRIO_CLASS_DL priority class to indicate that IOs should
>> be executed using duration-limits targets. The duration target to apply
>> to a command is indicated using the priority level. Up to 8 levels are
>> supported, with level 0 indiating "no limit".
>>
>> This priority class has effect only if the target device supports the
>> command duration limits feature and this feature is enabled by the user.
>>
>> While it is recommended to not use an ioscheduler when using the
>> IOPRIO_CLASS_DL priority class, if using the BFQ or mq-deadline scheduler,
>> IOPRIO_CLASS_DL is mapped to IOPRIO_CLASS_RT.
>>
>> The reason for this is twofold:
>> 1) Each priority level for the IOPRIO_CLASS_DL priority class represents a
>> duration limit descriptor (DLD) inside the device. Users can configure
>> these limits themselves using passthrough commands, so from a block layer
>> perspective, Linux has no idea of how each DLD is actually configured.
>>
>> By mapping a command to IOPRIO_CLASS_RT, the chance that a command exceeds
>> its duration limit (because it was held too long in the scheduler) is
>> decreased. It is still possible to use the IOPRIO_CLASS_DL priority class
>> for "low priority" IOs by configuring a large limit in the respective DLD.
>>
>> 2) On ATA drives, IOPRIO_CLASS_DL commands and NCQ priority commands
>> (IOPRIO_CLASS_RT) cannot be used together. A mix of CDL and high priority
>> commands cannot be sent to a device. By mapping IOPRIO_CLASS_DL to
>> IOPRIO_CLASS_RT, we ensure that a device will never receive a mix of these
>> two incompatible priority classes.
> 
> Implementing duration limit support using the I/O priority mechanism 
> makes it impossible to configure the I/O priority for commands that have 
> a duration limit. Shouldn't the duration limit be independent of the I/O 
> priority? Am I perhaps missing something?

I/O priority at the device level does not exist with SAS and with SATA,
the ACS specifications mandates that NCQ I/O priority and CDL cannot be
used mixed together. So from the device point of view, I/O priority and
CDL are mutually exclusive. No issues.

Now, if you are talking about the host level I/O priority scheduling done
by mq-deadline and bfq, the CDL priority class maps to the RT class. They
are the same, as they should. There is nothing more real-time than CDL in
my opinion :)

Furthermore, if we do not reuse the I/O priority interface, we will have
to add another field to BIOs & requests to propagate the cdl index from
user space down to the device LLD, almost exactly in the manner of I/O
priorities, including all the controls with merging etc. That would be a
lot of overhead to achieve the possibility of prioritized CDL commands.

CDL in of itself allows the user to define "prioritized" commands by
defining CDLs on the drive that are sorted in increasing time limit order,
i.e. with low CDL index numbers having low limits, and higher priority
within the class (as CDL index == prio level). With that, schedulers can
still do the right thing as they do now, with the additional benefit that
they can even be improved to base their scheduling decisions on a known
time limit for the command execution. But such optimization is not
implemented by this series.

> 
> Thanks,
> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research


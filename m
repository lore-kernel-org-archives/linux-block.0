Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7BAC64ED8
	for <linux-block@archiver.kernel.org>; Mon, 27 Feb 2023 21:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjB0VRf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Feb 2023 16:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjB0VRf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2023 16:17:35 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E9829140
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 13:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677532637; x=1709068637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xxn/izsHXNxccjKpNyqtYLS2tHI/CG77XwiE70PaQRg=;
  b=LsgfjJsPHEMd1wdcGBAOEBmmqQGXZIsfoeIh7e23mYzRKSjU2v1XbfAA
   NCAbpGTYXkYBitYUNLr7fargqhi2HqomNuasLBK9uFJ7UbP3F9crsYLAs
   wKATqCGpzsMlGd3yb2S0p8uqun5YTfQRdgYYTqwCLlYb1Zb74+JXZlDzv
   DuFe0ZDt4MqNKtYkmZzhw8xVmVhOmwn6ydNiXB+np8fwfXcwK+B+vALdP
   uzPX2u9dkZ04ysNLhZT6OUUsXTCjNpbKnJMAJCOJga/hlMhNXKgE4eXu3
   5xa9r+NABoeSBxpHTZslp0WNVrvQmfcN5rr4tE7x1h4xiXhQJWfrJEjzT
   g==;
X-IronPort-AV: E=Sophos;i="5.98,220,1673884800"; 
   d="scan'208";a="328672227"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2023 05:17:16 +0800
IronPort-SDR: p5S3uxZpaMaFnXRZV4VesMREqd9V4G89JEd+dYtIZmc4Nwzj0g5oCIGzeHvT2s+qHouoJ5TrmG
 KrNd4wdP9G8iVIB6iSJ39zDftY8Z7MyS59nRS+JBbvv5JmBkXjsXzoK5b1okjybPv1bvniReaO
 3cmLnTs2VMcBewtCJv+wT2cgfMuh71m6DHVcKKGTHjpvAJEJ0sRg3DE2yQ2hKkpwob6N1kuvFE
 l/Ju/EBeXiuf+HaD7lEuOyUtz5HBKeXfJojgW+gf10MRGuQzhq7VgOylJLxpV7RQQqcv7LC0u6
 qOI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2023 12:34:08 -0800
IronPort-SDR: gHlkV1bhYhxkSlqjmlintBbjkXC1QAy6jbOUNbQ9CypjFTQ/XsfasfOzi9hZ1VXGymHtjHZBMs
 MJxdzWFsG7iNm/t2M6csvHiXRw8sc3we0T2tEalzl+ZsXu/YFaFaNqxddnbeX1UefbbzmnC58B
 aKYCRPZG3T1FD+9XdQ/kOLYGObaHMadjN3AC2KR1cjpa6KiKOrwZ4ZSbMky/LKc2aUv2f5dc8l
 D8L0kjJzH6kpNMfbzeLKOgHqzyH2tB3MVOMDdEYrnaNeOfkA5MEsw8aF971iayQf0q2SPh6N0F
 C78=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2023 13:17:16 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PQYH02rKzz1RvTr
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 13:17:16 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677532635; x=1680124636; bh=xxn/izsHXNxccjKpNyqtYLS2tHI/CG77Xwi
        E70PaQRg=; b=et55ld0J8h6PZm4pyTwvdRpOBaX67ZaMIGPP0WaLuaan5tPOVGG
        mJB3TuPzS58drEj4i9FQlgbgmW6sdyo5nub1aXly96H7bKMhgH/UHHZvgCPlrcMb
        clbpjWwL1hXZF2UItcjMC9GkAmMEZI0TF+/IOsEN6l2O38zGVl53z6jnfyi+k8vl
        XYpq4yEcjkvTO1rSH7rJrOwZg1Ytgtr5Z8sD2bNdXLS5MGKbpN9JkiYwEDsMbZeO
        tIBGbH7F4IHW/LMxdIIgjRYPIo36E4OQKXRo8ja0ejhNIhPbpjCg4dPXXvGPixaR
        hbrJeHwv6Lk9kzV3KKc66jovYFjyewIpTdg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TI69KEGMVYRg for <linux-block@vger.kernel.org>;
        Mon, 27 Feb 2023 13:17:15 -0800 (PST)
Received: from [10.225.163.44] (unknown [10.225.163.44])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PQYGx4lFFz1RvLy;
        Mon, 27 Feb 2023 13:17:13 -0800 (PST)
Message-ID: <ba7180f8-dbae-bbe3-3ca7-e6a3f2d87954@opensource.wdc.com>
Date:   Tue, 28 Feb 2023 06:17:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [LSF/MM/BPF BOF] Userspace command abouts
To:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        Hannes Reinecke <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "lsf-pc@lists.linuxfoundation.org" <lsf-pc@lists.linuxfoundation.org>
References: <3d3369f1-7ebe-b3b8-804c-ff2b97ec679d@suse.de>
 <Y+5cjPBE6h/IW9VH@kbusch-mbp>
 <ad837a26-948a-c690-cd9e-4dfffb5f990d@grimberg.me>
 <57d8dff9-2fdb-8198-6cdc-7265797a704a@interlog.com>
 <23526cf9-d912-59a7-4742-6003d6ccfd45@grimberg.me>
 <Y/Yscr82hqdKl1Hw@kbusch-mbp.dhcp.thefacebook.com>
 <561afa67-04d0-c675-6bbb-048313da152b@grimberg.me>
 <73b4dd39-9ce8-9b55-8a1d-06865f3bde32@nvidia.com>
 <Y/lpmrwuehnsWmmR@kbusch-mbp.dhcp.thefacebook.com>
 <0fe59301-65e6-d8a9-033e-0243ad59c56b@opensource.wdc.com>
 <316431ed-1727-7e80-2090-84ac5b334f74@grimberg.me>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <316431ed-1727-7e80-2090-84ac5b334f74@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/23 01:33, Sagi Grimberg wrote:
> 
>>> On Fri, Feb 24, 2023 at 11:54:39PM +0000, Chaitanya Kulkarni wrote:
>>>> I do think that we should work on CDL for NVMe as it will solve some of
>>>> the timeout related problems effectively than using aborts or any other
>>>> mechanism.
>>>
>>> That proposal exists in NVMe TWG, but doesn't appear to have recent activity.
>>> The last I heard, one point of contention was where the duration limit property
>>> exists: within the command, or the queue. From my perspective, if it's not at
>>> the queue level, the limit becomes meaningless, but hey, it's not up to me.
>>
>> Limit attached to the command makes things more flexible and easier for the
>> host, so personally, I prefer that. But this has an impact on the controller:
>> the device needs to pull in *all* commands to be able to know the limits and do
>> scheduling/aborts appropriately. That is not something that the device designers
>> like, for obvious reasons (device internal resources...).
>>
>> On the other hand, limits attached to queues could lead to either a serious
>> increase in the number of queues (PCI space & number of IRQ vectors limits), or,
>> loss of performance as a particular queue with the desired limit would be
>> accessed from multiple CPUs on the host (lock contention). Tricky problem I
>> think with lots of compromises.
> 
> I'm not up to speed on how CDL is defined, but I'm unclear how CDL at
> the queue level would cause the host to open more queues?

There would be the need for one queue pair per limit defined, in addition to the
regular "no limits" queue pairs. And given that CDL allows defining up to 7
limits for read AND write commands, if kept as-is, this means potentially 14
additional queue pairs shared among all CPUs, or even more than that if one
wants per CPU queues with limits.

> Another question, does CDL have any relationship with NVMe "Time Limited
> Error Recovery"? where the host can set a feature for timeout and
> indicate if the controller should respect it per command?

This NVMe feature does map to one of the possible limits that can be defined
with CDL. CDL currently allows 3 different limits:
 - Active time limit: limit on command execution involving media access
 - inactive time limit: limit on device internal queueing time before processing
of the command starts (aging control)
 - Duration guideline: overall limit on the command processing by the device

> While this is not a full-blown every queue/command has its own timeout,
> it could address the original use-case given by Hannes. And it's already
> there.

The above limits are what is currently defined in T10/T13 for SCSI/ATA devices.
NVMe may need some tweaks to get a better mapping to the different use cases.

-- 
Damien Le Moal
Western Digital Research


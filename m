Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1BCC433F5
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 06:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8A460F9B
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 06:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhKJGuS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Nov 2021 01:50:18 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3607 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhKJGuR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Nov 2021 01:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636526851; x=1668062851;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AIPDptCB11ujzANMn09j2WFokE+HQ4B3Z7lv5l1i9og=;
  b=ltNnzyS/OBJgPalep2Q4mRvtjf2XqDPrZ0PFFe0skZycWqeU2WMSo5SI
   JkU8u1wA6Acs2BSFy/LIt/9q2OXdMbV1J9OcvxPq+uGi4HNmXUX8qTZ4H
   6FDwG18ekGqlkJeESolwfT3TSonLJvdbdwwlNOV+DwbFKpxfNK0qm9oUq
   0qEPos7JKbNSEDbXpfUGP9f7RMV8dxf8T78Mjb3bYXwxBTlszxRcml+Z+
   MjW5QiaSRYjTU/seAQ1BT8E8VX27/FmGMIVmayAr8ypw/YIHcaU4ZCYAv
   RUG6bv7LOc2whgyyiwZQaVU1nuhmAb/cuZ4ceY+0MninQECvbRyCrWm8p
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,223,1631548800"; 
   d="scan'208";a="184215774"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2021 14:47:29 +0800
IronPort-SDR: 1OxxyxS0O8/WW+ClpdlqINHeG1tTXnv37kfUxF/IfdJgpJjlqcREcNerBVws5LQ8Kz2UCPzJXa
 s1TjKMZAJ02zEPoL20bGdsnibxz9+wmjgw4z8+k1xQ+OhH44M31sZCC0jF8C0/ChvcCPJRl8IY
 Q9l3E/axRpiWjx7NeLjA89kjBXDFDYSVo3sMGECDPNKkAwvNLoVSzXZ+hiWH5RF5ylTP2Xs+GX
 e2UPLIWwYf7knXL3/NT6JivhueHvB8INNI2qqaZk1IIc05/PBnoOInvhayhrrMplxb2xPeJ7ny
 SWc4J2lshdrE9uxtxgQ/XSzi
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 22:22:40 -0800
IronPort-SDR: FflV5YcfSAaAeJn/1Ws8AOaplzkQVwbHPQljMNos6BJMeiyxR47cfCrmtDhmWy7YZ5hhCwSOgY
 zbu2uj7iDvqVxuH8Od685SR2GqgXh0ePXaANmETwxAjUvheks1XTScVM+UIdmj2VnK/UrOrtpF
 8CqA+jOsI94wMYkmAHA7L/NuGy/4VZVZ0iDScmx/sACEedFk2nJ+E83vszr6ZKaG5yFzsFCfS0
 Mx6kxspcWHxzxje4dE8g81w66tABWM2VRo6RM0Xl42k8wdrBIMXCgzumMlLiQIUNnkJFZTJk4i
 lso=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 22:47:30 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HpwQ86dnhz1RtVt
        for <linux-block@vger.kernel.org>; Tue,  9 Nov 2021 22:47:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1636526848; x=1639118849; bh=AIPDptCB11ujzANMn09j2WFokE+HQ4B3Z7l
        v5l1i9og=; b=Nc06IPrLGzX1iL07DkTzIT4O6WaH3m1hA6heGTIkAi3x9iD5v+d
        b1Ju7IW6rxUowrTlT/2p1gR4InGlAkhGxUsnTrViUCJ9KIQIfvbAC7KIh1vIQ+dr
        pQ2vAdWABrNaOK6AAfI2yL+LxWNqAOEZSbfom0h68Vk6bZ2pvWajhG47J5QxNHIg
        oC71Z2dAm+8or1fZPsRSUjbQS868YBlQjRGaOtpaDfR0c3NMo6s33425REPHmxZh
        VJfJtvuU8zESE099EfJ2F5UmamsLWcACvA2IEsVGP4+iQ6uJY7g7OGYONnMfKvaz
        W+Gjk9H5KKHXT+kiyzuOh0MOGl8U+eqJ+lQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eZ9ENSmX6_0d for <linux-block@vger.kernel.org>;
        Tue,  9 Nov 2021 22:47:28 -0800 (PST)
Received: from [10.89.81.216] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.81.216])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HpwQ71M97z1RtVl;
        Tue,  9 Nov 2021 22:47:26 -0800 (PST)
Message-ID: <10a53200-41c3-4b8c-c70d-5dc2a13aee60@opensource.wdc.com>
Date:   Wed, 10 Nov 2021 15:47:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH 0/2] block: Fix stale page cache of discard or zero out
 ioctl
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
 <6181461f-ba46-f277-2dd4-683013122995@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <6181461f-ba46-f277-2dd4-683013122995@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/10 15:37, Chaitanya Kulkarni wrote:
> Shinichiro,
> 
> On 11/9/2021 2:47 AM, Shin'ichiro Kawasaki wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> When BLKDISCARD or BLKZEROOUT ioctl race with data read, stale page cache is
>> left. This patch series have two fox patches for the stale page cache. Same
>> fix approach was used as blkdev_fallocate() [1].
>>
>> [1] https://marc.info/?l=linux-block&m=163236463716836
> 
> Thanks for the fixes, do we have blktest to validate this fix ?

Yes. The problem was detected with block/009.

-- 
Damien Le Moal
Western Digital Research

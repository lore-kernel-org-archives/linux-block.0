Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86CFC433F5
	for <linux-block@archiver.kernel.org>; Fri, 20 May 2022 03:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345211AbiETDrT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 23:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345207AbiETDrQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 23:47:16 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BFB340F1
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 20:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653018434; x=1684554434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6lc1EXDyRH/qdIBQrgfdid5K6UO5RT0eqtEDiI6MCtI=;
  b=UTXtkRQuc8LhJYZHKrE6M5vFktpj4WL9lot2eO++A4QKswwdDiPm3eMJ
   tiTlXxKDd+TvMlOFATMA/bWrv+zRQYxSTfb6GyLHQM2t7uKOHPMlWl4ym
   OWAW+U9LSzvg2zSAu5SjHa9//9wKsupMuA9PlNikEJOtO8UKtoDTC1WfH
   CEYmxpZSb96oEiIKHnu3+bjKgYQ/g9vg5Cn9MKAD+iT0BiQMnF0/1Tw7y
   sjD65V/bn+x8WBtmwOcm0Q1HgKgIV6GZ6GYotXiiiEKlWTSmEZHDnxJ39
   AJfAg2AzpJyyXD3Uq1lhtpkvClZ4h2ep5mYrtDWYnFYpZw8EJsuXm51pp
   w==;
X-IronPort-AV: E=Sophos;i="5.91,238,1647273600"; 
   d="scan'208";a="305089253"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2022 11:47:09 +0800
IronPort-SDR: fLp3kAMrEHUWRzhADXlHIigDXkap209f4aZZpx9KxM9MiLVws94Mq3Y9hfwWLNpY5BCgclaiOV
 ZuWebYuhLvRa5Ot95WNY+wBTr2huFdjOy5w2iqIWkyv+lC3GZC/0IslUzKA3vUOrBXfbNMBV+q
 dFU7Kn2i/3loFh98RXGUH9LaMjzbp8fiWZtqmjzIUuEE6zGhp8bnARtGzoSP4bezDkoAGH1I3+
 i7SWzwV9Hc5EIVkAr5urI7tVPQYDTh/DzW7A8FCTfV0ph6PoLqqBtibLLsJ8352syBhCayjVgh
 QVAJkxkOW3jfWiAlGhcHXCH0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2022 20:12:32 -0700
IronPort-SDR: OZf5spczlT8IwmI/7WUuKBO3mgRl43kN7Sl+K9eHeLyZcuLnrYTaNZKRSjQzv7H2KvtqtJ5leA
 DwX+YAMJWCKHhCbVqj9TsrSUb0SwT7e9pwN8a/81XKufgKG5lNrlQbOGJDGXWMjPRWOsKHMbrZ
 2CxXdPKXjqe5CiL+tTmVSMlvcllO/xAWGHq/onEZhguWNsXbqqV6fur+rxjHyJhyEeBASEuetu
 keOkOH3Q1rpKLanbjYy3HKl3J0MBbGxr0q442V4tajkGgkWoPsesj0COUgU+uRnHJzB6qLR4hk
 Iic=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2022 20:47:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4CMw5Clwz1SVp8
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 20:47:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653018427; x=1655610428; bh=6lc1EXDyRH/qdIBQrgfdid5K6UO5RT0eqtE
        DiI6MCtI=; b=Qs9M+NujlyY8B4k/o4j7hSbfG13ti0oADtMb/umY3xRCYTQNY3J
        T2xdFmUh9CSB7RfRlgugV018loJtAR0z9EGT0S58D6UYUFDTmHf8P8VRWqemnD12
        hS5OmTUPjVTzO+ZX5W6IdWB0kk6jh2k0nN3xK9Z0v3wpoOMnabK1LKBbkgGTqBxf
        z7r3LFquTotFb5ib6u0lxv3Tw3J3qHygfRYrez3CbkQ5MZOQjEIeRlWkIKwHWt+R
        TYFK2ggtvkfb8RaQH6RyquQyFCRfVmNQe16t3cZb3xRBq3AUFjgPefGP0/pWMal0
        Ic2RxZWrwEWckGJNSitECSJ/V7Iv8+V+Fqg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sJV9S2lqLHkd for <linux-block@vger.kernel.org>;
        Thu, 19 May 2022 20:47:07 -0700 (PDT)
Received: from [10.225.163.45] (unknown [10.225.163.45])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4CMr5cBWz1Rvlc;
        Thu, 19 May 2022 20:47:04 -0700 (PDT)
Message-ID: <4a8f0e1b-0acb-1ed4-8d7a-c9ba93fcfd02@opensource.wdc.com>
Date:   Fri, 20 May 2022 12:47:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
 <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
 <20220519031237.sw45lvzrydrm7fpb@garbanzo>
 <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
 <PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/22 16:34, Johannes Thumshirn wrote:
> On 19/05/2022 05:19, Damien Le Moal wrote:
>> On 5/19/22 12:12, Luis Chamberlain wrote:
>>> On Thu, May 19, 2022 at 12:08:26PM +0900, Damien Le Moal wrote:
>>>> On 5/18/22 00:34, Theodore Ts'o wrote:
>>>>> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
>>>>>> I'm a little surprised about all this activity.
>>>>>>
>>>>>> I though the conclusion at LSF/MM was that for Linux itself there
>>>>>> is very little benefit in supporting this scheme.  It will massively
>>>>>> fragment the supported based of devices and applications, while only
>>>>>> having the benefit of supporting some Samsung legacy devices.
>>>>>
>>>>> FWIW,
>>>>>
>>>>> That wasn't my impression from that LSF/MM session, but once the
>>>>> videos become available, folks can decide for themselves.
>>>>
>>>> There was no real discussion about zone size constraint on the zone
>>>> storage BoF. Many discussions happened in the hallway track though.
>>>
>>> Right so no direct clear blockers mentioned at all during the BoF.
>>
>> Nor any clear OK.
> 
> So what about creating a device-mapper target, that's taking npo2 drives and
> makes them po2 drives for the FS layers? It will be very similar code to 
> dm-linear.

+1

This will simplify the support for FSes, at least for the initial drop (if
accepted).

And more importantly, this will also allow addressing any potential
problem with user space breaking because of the non power of 2 zone size.

> 
> After all zoned support for FSes started with a device-mapper (dm-zoned) and 
> as the need for a more integrated solution arose, it changed into natiive
> support.
> 
> And all that is there is simple arithmetic and a bio_clone(), if this is the
> slowest part of the stack involving a FS like f2fs or btrfs I'm throwing a
> round of anyone's favorite beverage at next year's LSFMM.
> 
> Byte,
> 	Johannes
> 


-- 
Damien Le Moal
Western Digital Research

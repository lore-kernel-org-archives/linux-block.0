Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB530C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 07:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiCNHq3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiCNHq2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 03:46:28 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952FD4130A
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 00:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647243918; x=1678779918;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V+3KYbua71jUhDORfVa83LVFcqf30QkwdJlYrkUTcVY=;
  b=dBbBCEJKuYnYX/6OhsIi4DyTPjAA/6bUoFUbr6Mf7tVD3Lm8kefkICOR
   IDavo/bpBz4nfViXCSG1FOfMHgYU/GS0gAjdL5qUosdFnQdFhEStYOxr8
   IoMUajePHAScz+nEvfnTDPuhZ15UKnMqCqYZkS8yYC8tNCV1qyK960MWJ
   7oclCQnlfQ/AHwgCfqa99uYlrdJLNjIWshlftgPzB8vW3f9EtdesPEEsw
   vR6z98c4419AVGUxMxx7o/fDJ7KQ2+34caVf+BxFMzlsd3+AkCpPerCE5
   tzc/8j0cW2Z8Klpib8XuGgINFYkxmXRlsf3RI4gcH6IH1Cyal42xHqiz7
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,180,1643644800"; 
   d="scan'208";a="307239762"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2022 15:45:17 +0800
IronPort-SDR: QtOqfJAlZUJCE11R3Qb9tBc4L3jtOXnU2lKedeRhTyKH7WM0E/6gNmuM5zEXxyLLjWSNFFnvzE
 oFRMjtxUjEjJ6YlxgGX/HLW023R1w0I9AbG4+sdZFVzRY1f6cSQmr/PyzVm97fa0zhNN0TZz4I
 Gcfp/LqOZxp4nbkcDsVPv7l2BJu77SrOVua2qUbSID/If1rZz5oirS8pG8IfqEqaiIFh30sa08
 y7KPIoyd2dqPXBgS+kNcDCI0wog8abTE4s9UwPcVIiCnoi7hRA2i5Y8Q0Zm77ZtxVOXmFPEDpH
 riivn4h8JSuLvsc9/rFkfEVD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 00:17:26 -0700
IronPort-SDR: wf1cOQZuuFlRmktnorbiY/DL54NNDE1TlDwovP+dDbT5KZ8Myqyv3EN4Ke73RSl2j2/R0OXhxz
 /1WzCfb/L6KnFeipWFAQQpVMuMJv8eAdLkSi1QEFte2A7o3cLwAv2hddgX0vl4vypWoH17joS4
 XcwXvVAYLKABxzQjulvXRTGZ/Fra7cf1JH+SChZBUcZNHkaedvPqCul2w1BAZ0CAWKoQc8ePeV
 gtxW86i1Zg7b81n6VIbaITH3E1j04bbcVdfhx1czBrfo+Bq18O3aOgDnLoRlIZkD6L0HrYWSjt
 zYM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 00:45:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KH7qd2LLtz1SVp7
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 00:45:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647243916; x=1649835917; bh=V+3KYbua71jUhDORfVa83LVFcqf30QkwdJl
        YrkUTcVY=; b=EMSCGg1vtL0OMQ/pQyrqZ4MRLnBRNNTLlzCjQCXidNdkUDKkBw6
        qyH28PZg+fBtAFung3UsyKTIaZPo54azKyNG6YLyanojXFDdNTJKv0Rph8ndIzAJ
        MIJv+xuBsOf/agIrLHW1AqyYiF2Qv0yqKM64duyq1TBSDlQIP6MPZ5JVx/NDwzxD
        quPhQ70zGgKhEpyNqGrXpKCGt7gzSSiHZH12EKQZlxSx8Jl4GqXKzHMHsj/gDm/k
        EpcyQF9C2jTXDKRUkTasZBCsC0y3+VUNTSYv2X20maqahraz3Gnbr3yljxPILLIZ
        prTxrrBGLP0U8jGIycrI/jmut+eNqvbYsdg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UONpjeQVKpRe for <linux-block@vger.kernel.org>;
        Mon, 14 Mar 2022 00:45:16 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KH7qY5yctz1Rvlx;
        Mon, 14 Mar 2022 00:45:13 -0700 (PDT)
Message-ID: <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
Date:   Mon, 14 Mar 2022 16:45:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de> <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220314073537.GA4204@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/22 16:35, Christoph Hellwig wrote:
> On Sat, Mar 12, 2022 at 04:58:08PM +0900, Damien Le Moal wrote:
>> The reason for the power of 2 requirement is 2 fold:
>> 1) At the time we added zone support for SMR, chunk_sectors had to be a
>> power of 2 number of sectors.
>> 2) SMR users did request power of 2 zone sizes and that all zones have
>> the same size as that simplified software design. There was even a
>> de-facto agreement that 256MB zone size is a good compromise between
>> usability and overhead of zone reclaim/GC. But that particular number is
>> for HDD due to their performance characteristics.
> 
> Also for NVMe we initially went down the road to try to support
> non power of two sizes.  But there was another major early host that
> really wanted the power of two zone sizes to support hardware based
> hosts that can cheaply do shifts but not divisions.  The variable
> zone capacity feature (something that Linux does not currently support)
> is a feature requested by NVMe members on the host and device side
> also can only be supported with the the zone size / zone capacity split.
> 
>> The other solution would be adding a dm-unhole target to remap sectors
>> to remove the holes from the device address space. Such target would be
>> easy to write, but in my opinion, this would still not change the fact
>> that applications still have to deal with error recovery and active/open
>> zone resources. So they still have to be zone aware and operate per zone.
> 
> I don't think we even need a new target for it.  I think you can do
> this with a table using multiple dm-linear sections already if you
> want.

Nope, this is currently not possible: DM requires the target zone size
to be the same as the underlying device zone size. So that would not work.

> 
>> My answer to your last question ("Are we sure?") is thus: No. I am not
>> sure this is a good idea. But as always, I would be happy to be proven
>> wrong. So far, I have not seen any argument doing that.
> 
> Agreed. Supporting non-power of two sizes in the block layer is fairly
> easy as shown by some of the patches seens in this series.  Supporting
> them properly in the whole ecosystem is not trivial and will create a
> long-term burden.  We could do that, but we'd rather have a really good
> reason for it, and right now I don't see that.


-- 
Damien Le Moal
Western Digital Research

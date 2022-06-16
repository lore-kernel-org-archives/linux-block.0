Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74F4CCA473
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 00:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347209AbiFPAO0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 20:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347950AbiFPAOW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 20:14:22 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD8735DF5
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 17:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655338457; x=1686874457;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fyHpupnYtGUPirbwadi+/UoXNfHRheNvvtNveX8JPTo=;
  b=C2UNjuWuYkixMeqm71K28/GqJmQPO3EdxU35yfz48VK8uKeAD/P9Vpyo
   zliWA6DGbTFykcgIh/tE1wP9RuK7YVZh8l3SG7gsrlM1rdblIAAXMUdpt
   R6qZ6aKoKsa5DDNo+Otixc1L4XAL/vKIL4sClUFGTxcTqUgFhlB4SJ4sk
   e4DwW4SUl4GmdffE07+nZ1bdKP2tLE5WewxvjiuYTnOOZUKQgEAoLpheM
   OwpLyuAjhGVKjsDrSfLDelQ2LW9I9pc7r6YjB8yrTsBn6yFnLylHS6ykY
   me52KIVOyJ5My+mzD1GGYsU7Thsp1M18NEs5CnHl8IdNFlxu1IuWinch2
   g==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="307572902"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 08:14:15 +0800
IronPort-SDR: +uA1v6fk5FURDTep9+LoUCD5kJs8RSdNwSGMsdQm+N5dJT4TpEiejvtdK+5OoqnAoGj4qsRhZ6
 oqGxFF4KdPmy72+syrl+dAB11T434fB4xyjCL5ToysXF+T0pAR1GjatKjnLp6sRTEwUiEFwF+C
 XPfwpjuxmKS2a/TJerG6RG7t6vcqbaJNNJNYcW7fjw29Fpx18pqOuuBld5qnUk+Whsw40FR0Gn
 TxZiiWfv5gy8V0oPExHe9k5QoN8KSeHrjThi8wuDZfUJ7eE2Oef5qNABl7b9FyG91fkdeU6f39
 u7eYLnbK4uERqJPw1s4h/xFW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 16:37:05 -0700
IronPort-SDR: l+RrZ2GF32mgMvphGHkVd6NlPx0LRhfhrCuuHL9o7Su+MoHD732ofE/88MuDFXugXK3TniLcw/
 OJ32yEYc0VUbSqyCrZy9IvuE3RtDmdKQV3v5bgoWKf8LHsF0man5P+6g1C3yBsi39G5pkRlNDR
 eVtbzl8yF2FYuxans2X6X+QgSCVIs4G2kbM9bgODcJrGRAS0jZ5ikm6QjwaiwAUNdoTfrEfQRR
 W+KRTp276GhkBCu6T0D05zYSfiRTA0yIwjYYDjNFZT+pjz+n5idm7ifDC8RgEXLpYrDHycRaCL
 b+8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 17:14:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNjMq1tSKz1Rwrw
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 17:14:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655338454; x=1657930455; bh=fyHpupnYtGUPirbwadi+/UoXNfHRheNvvtN
        veX8JPTo=; b=Y2y4iB/X552bgjnLE0pZYv+cIkWoUuBvtF2yM9t0OxO/eQsSx1p
        RwDiH8SkK9FrO0IfC2gaJ5ajjXgK9LklvdfSCDC+mEfaR4CJBgQOFTEfqCYYJKBm
        HXWevjCo23uMRlH7wQC3/TlDk/bCUJYFR2xGUIORrBEXXxNubLRlVqmYeTHGZY5n
        yjPqpV+5mWN6zH+ap++NPHvW5jBv8RXjJeV9SBDPk3Z2VugSnwfv1LXe5+sIr3Bs
        cUp5xJext4fKWFmGNCNRy6Ir4o/Gw62O8Ys4fDemiZv0J8mtP/aGQkb0cQGBC1oa
        F441d9flLVyC1D/OzXzeqq+8S3ejJ0VDOhg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8FvGQ1_vyrcO for <linux-block@vger.kernel.org>;
        Wed, 15 Jun 2022 17:14:14 -0700 (PDT)
Received: from [10.89.84.185] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.185])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNjMn3Kn2z1Rvlc;
        Wed, 15 Jun 2022 17:14:13 -0700 (PDT)
Message-ID: <6a17bdb3-af76-edf7-85a4-0991ee66d380@opensource.wdc.com>
Date:   Thu, 16 Jun 2022 09:14:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 2/5] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
 <20220614174943.611369-3-bvanassche@acm.org>
 <399e595b-06d2-ceb1-1b42-2a98a7724320@opensource.wdc.com>
 <29a13708-56b1-60e8-558a-ec4a469eaa6d@acm.org>
 <20220615054909.GA22044@lst.de>
 <434cb0ae-a6e7-62a0-81dc-cd86f55108d4@opensource.wdc.com>
 <6096a273-c88d-3e15-927a-add3071ffbad@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <6096a273-c88d-3e15-927a-add3071ffbad@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/06/16 4:38, Bart Van Assche wrote:
> On 6/15/22 00:21, Damien Le Moal wrote:
>> On 6/15/22 14:49, Christoph Hellwig wrote:
>>> On Tue, Jun 14, 2022 at 04:56:52PM -0700, Bart Van Assche wrote:
>>>> The performance penalty of zone locking is not acceptable for our use case.
>>>> Does this mean that zone locking needs to be preserved for AHCI but not for
>>>> UFS?
>>>
>>> It means you use case needs to use zone append, and we need to make sure
>>> it is added to SCSI assuming your are on SCSI based on your other comments.
>>
>> For scsi, we already have the zone append emulation in the sd driver which
>> issues regular writes together with taking the zone lock. So UFS has zone
>> append, not as a native command though. But if for UFS device there are no
>> issue of command reordering underneath sd, then the zone append emulation
>> can be done without taking the zone write lock, which would result in the
>> same performance as what a native zone append command would give.
>>
>> At least for the short term, that could be a good solution until native
>> zone append is added to zbc specs. That last part may face a lot of
>> pushback because of the difficulty of having that same command on ATA side.
> 
> Is there more information available about the difficulties of defining a 
> ZONE APPEND command for ATA? It seems to me that there is enough space 
> available in the ATA Status Return Descriptor to report the LBA back to 
> the host?

Unfortunately no, there is not enough space. See table 354 of ACS-5
specifications for the normal output of NCQ commands: 1B error, 1B status and 4B
sactive field. That is all you get. No room for an LBA. And even worse: sata IO
does not define any FIS to do that (return an LBA). So adding zone append to ATA
without relying on an extra command to get the written LBA (similarly to how you
get sense data from ATA drives using an extra command) would need both ATA/ACS
changes *and* SATA-IO changes, which mean that all HBAs/AHCI/SATA adapters
existing today would not work.

But in the context of UFS only, it should be possible to add zone append to ZBC
without going into ZAC. Since we have zone append emulation already, that would
not break anything in Linux stack.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research

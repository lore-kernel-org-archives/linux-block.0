Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C36C43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 07:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiFOHVx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 03:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiFOHVw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 03:21:52 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B847943AC3
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 00:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655277711; x=1686813711;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=izlKgFtXFAiS7qlPzgUvTlFl3rHcGt2DCiEG8dyFTgk=;
  b=d3aO/6W4YEJJNFcYT1nytZ6cTKmFlEPzcSPstccy1YgPpV3f0tV1nJ+f
   Ui4di/IsgqhC9v349WidDUh2X+GlE6KFhBgGau5k2QVJ2qkkyTvH5j51W
   MBIkuEpy4ebeUnJoyYJMEoxiGG41pzd8B7P+5pd9f8IzkAA4kBZ0xeBhD
   8WUkJfkvfAkbwUaj2CyJmH7O9WbtXRRv70WGnbMThxjzzeTOas7z9tPL7
   4Us2ul2IyU35kcYr2sOtP1Fhb1pkcXRYW01GK03El3GZ/IyBPfiFOOXiS
   yALBkUiVU2aAR4BpHkDlPj9Fj+7mF0A4kKZDsmVZ6LHVhgRssjBeV1ONp
   w==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647273600"; 
   d="scan'208";a="307495022"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 15:21:51 +0800
IronPort-SDR: xnD4ojduN5/yI1IIGrerrYqSDYVt68z+fmaUzCDfQ7YZRSFIsSqPWwUgOPzq3Bfz4iTPibLvCO
 bfi8lWJZVRSvazmVaaV3BWkKGrlYNKTvt0pni4jYzox+5PQV3+9o2beBNgIG2u3sSK9+Kucjsf
 VKSRGuKedz00mttfWLx+LeyM+PkBQE4TEDvmA/PHYjf8EIMWlbrU/tXxDI8K01956lXEMRHPW0
 3kYK7rAwoQ3uEjbzuvkn8broDChtgcdXRONXBi5g1gjYsGtextqRsGPDBQiE8CYkPqg+km5QFF
 6BJ/p1KFw8pL6qe35VmlB19j
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 23:40:15 -0700
IronPort-SDR: yAG7haH1CxfXT0n3y4lpyv74DFxUely0YsMksHsHSUm5YdAKmPg0XR92rCBuiMVHoZLrjXtOmw
 o3k/617m2cPzEZQOsaAU597XyXG3yYA6tNSG70PC7cFCYqkSyHux3Z8446aHhhq1qIsZki3jkM
 EynbuDhz0n3qzMB86nSo5i9hkIc0vE+Btv0cLqdH0xucCopk3/kb+C92OLR9wWFLnGWSZIt5ok
 sbMc+1kslStH2V3b7DVeSjRUv5MWWOn4iOz30/JmabxoV9wndXvMEhEB4sWvnYrtp66rdIaENI
 pV0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 00:21:51 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNGvf4KDpz1SVp2
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 00:21:50 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655277710; x=1657869711; bh=izlKgFtXFAiS7qlPzgUvTlFl3rHcGt2DCiE
        G8dyFTgk=; b=rT9XRuf1TcAnN665s2ZMLjiTWsT+WDgHH6sTJVqGEbjeORNuhVR
        rDD6pEagAYlSZnajBECIH+iT3jk0+WEBB0jLG/mtw4mrSlgH/HEj2aCVLMlvGPvi
        lqxTaIFzPadT0x0ibr6sYyGpk15AS9oGtt+K9FJrfwiz/QUJQQmVmUjmX4YA1FRt
        4FX1rPoZLHPRnZuaUa/BbTyVo2SDHB+b5v5zcWPLUDXqZMi7GKQy6MZw7WnTC0BG
        Uzf3POvBDH4sxYgssvzfQrGKujhaFrikpDHn3oSjypSNuLBKjFsh+24sUgviDN9B
        GNKrj6xS0hgzlxLuHN5eR1X9bRMfpLnAxxw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2l4ScYk0ZqHi for <linux-block@vger.kernel.org>;
        Wed, 15 Jun 2022 00:21:50 -0700 (PDT)
Received: from [10.225.163.82] (unknown [10.225.163.82])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNGvc524nz1Rvlc;
        Wed, 15 Jun 2022 00:21:48 -0700 (PDT)
Message-ID: <434cb0ae-a6e7-62a0-81dc-cd86f55108d4@opensource.wdc.com>
Date:   Wed, 15 Jun 2022 16:21:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/5] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615054909.GA22044@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/15/22 14:49, Christoph Hellwig wrote:
> On Tue, Jun 14, 2022 at 04:56:52PM -0700, Bart Van Assche wrote:
>> The performance penalty of zone locking is not acceptable for our use case. 
>> Does this mean that zone locking needs to be preserved for AHCI but not for 
>> UFS?
> 
> It means you use case needs to use zone append, and we need to make sure
> it is added to SCSI assuming your are on SCSI based on your other comments.

For scsi, we already have the zone append emulation in the sd driver which
issues regular writes together with taking the zone lock. So UFS has zone
append, not as a native command though. But if for UFS device there are no
issue of command reordering underneath sd, then the zone append emulation
can be done without taking the zone write lock, which would result in the
same performance as what a native zone append command would give.

At least for the short term, that could be a good solution until native
zone append is added to zbc specs. That last part may face a lot of
pushback because of the difficulty of having that same command on ATA side.


-- 
Damien Le Moal
Western Digital Research

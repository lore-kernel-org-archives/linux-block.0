Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E850C74A5B
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 22:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjCWWyD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 18:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCWWxm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 18:53:42 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775652ED60
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 15:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679612011; x=1711148011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jSJBAwov6N7MJF4XEPya5qdNZooDpXcLf56RbKICjWA=;
  b=A8EO47lxjtAXk7G08xqk25iAQSncL8sqEnn36OF1EUo2TiGWGdJy5YhC
   NVKHlkn6SO1yWY6RmEpMjxGE2HX65wdOR0zYXjfz75177iFg2V7HmsfVI
   iyf2h8GOk4qwsxBvvEDMEwzRK1M//JqaZW3rPTWi2vAnsdpwsJPy4xR47
   ERFLkHaqvu8KG4M7R1nuxoYZIxrT0htHJUlKJpL3jEClmv/HYGoZGb04w
   43VsKyHD0bBcXcidHZ65G/dYHRL6ZGWkP8+raItiODbYFqkUfPZ1XRquc
   ukvDpS6S/Bp2CXbdBcM3lIWvdVCLQz5n2h71M7z7F2/43beLmd8aINlfE
   w==;
X-IronPort-AV: E=Sophos;i="5.98,286,1673884800"; 
   d="scan'208";a="338434482"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2023 06:53:30 +0800
IronPort-SDR: its9R4G6OmZ7+DE7zhV+FcjeGnU4O/DM4YPPLIinHxZbiWtQSn0vv/VRwo0HhqsB2kFm9rZcv2
 HewT47l5z8F/xytvZwzmtg8wagXisO4osQTsl3kHVGmbCDXXWvhRKPqaxdboiVWPl0wSvALrnb
 roUHvhv4D9VDG8qSZN3Zzri6ci+lhPOVvmvYeUpq7wwDIs6wejRVt1hdAhCa6N5DjSR2E18Hda
 f+1X9Xx1/WuXdLsKugw8IL5CBYWwN2EVaRsZcoG1GPXvJs0rcn9M9XB7p6FNjMLh+50hdzLQCy
 qK0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2023 15:09:47 -0700
IronPort-SDR: uI8uVcb5pGhGFmtQ+xCcsCWP/UhXXGrIdDUxhKfCjZ5oZf98qKCNxZc/StsgNytB5qAAenf86v
 wkMt+QzGvFcOSg5P8dyCouCVXKWfSc3JlvhZkiu9ItqHTkeXCopIUx9lQ2csyoj+5SlsxItb9z
 qnZ+20Unk1fUGfT0SulvvryLmIQIDqpukXoS35rim7N191GRPHXSfvCoC+lBxHYy0CKmAE0Jg5
 f/gzScahcZ/3BveeQm2xiuB/UjKxH5zgYgbQF6ZtVBLjBG19Q+XObjwa7UaMSQQ1iQBD2Pw8O3
 lOQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2023 15:53:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PjLGy446wz1RtVx
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 15:53:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679612009; x=1682204010; bh=jSJBAwov6N7MJF4XEPya5qdNZooDpXcLf56
        RbKICjWA=; b=QOiHJN7F1KuAuaBA964/DrhibQVZaEq7EcH0s34AReKErUjCfnY
        GZZdrNd3I6Vp7MyfLbUL69qtjIB5vHWRTZBojPZr0HFXBpDS6KpgXvVpwxCeNO8S
        lhDkucEHiaGtccaceGyhNOdw5xGonLcgxj6tXzUN521E8VErQG7q/InIK9cQv73P
        3jKJJPg30NhEi3P5vvNpEYThLW1Q3cNkhYgiT7LEP9JFvPJXBSh+zXG3ZhHBxl/N
        SUUpIR3GoKOW/UVE1rOdZftxg6jKKizoqzZkIAlHSAXa6wJx0OB2QPHO0EaDrDkB
        9uJwWwKGwcwlU1qu5Fyq0an5D4tiMYs3u6g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O0ZbH6RJ7Sdf for <linux-block@vger.kernel.org>;
        Thu, 23 Mar 2023 15:53:29 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PjLGw4Fxwz1RtVm;
        Thu, 23 Mar 2023 15:53:28 -0700 (PDT)
Message-ID: <7a795b9b-51dc-9166-1cf0-6c51db77b195@opensource.wdc.com>
Date:   Fri, 24 Mar 2023 07:53:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
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
 <acd13f8c-6cbe-a14d-e3b4-645d62811cec@opensource.wdc.com>
 <122cdca2-b0ae-ce74-664d-e268fe0699a8@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <122cdca2-b0ae-ce74-664d-e268fe0699a8@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/23 01:27, Bart Van Assche wrote:
> On 3/23/23 03:28, Damien Le Moal wrote:
>> For the zone append emulation, the write locking is done by sd.c and the upper
>> layer does not restrict to one append per zone. So we actually could envision a
>> UFS version of the sd write locking calls that is optimized for the device
>> capabilities and we can keep a common upper layer (which is preferable in my
>> opinion).
> 
> I see a blk_req_zone_write_trylock() call in 
> sd_zbc_prepare_zone_append() and a blk_req_zone_write_unlock() call in 
> sd_zbc_complete() for REQ_OP_ZONE_APPEND operations. Does this mean that 
> the sd_zbc.c code restricts the queue depth to one per zone for 
> REQ_OP_ZONE_APPEND operations?

Yes, since the append becomes a regular write and HBAs are often happy to
reorder these commands, even for SMR, we need the locking.

But if I understand your use case correctly, given that UFS gives guarantees on
the command dispatching order, you could probably relax this locking for zone
append requests. But you cannot for regular writes as the locking is up in the
block layer and needed to avoid block layer level reordering.

> 
> Thanks,
> 
> Bart.

-- 
Damien Le Moal
Western Digital Research


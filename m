Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC98C433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 03:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2328A60E8C
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 03:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbhJ0Dol (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 23:44:41 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34938 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbhJ0Dol (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 23:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635306136; x=1666842136;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=xPGvWc/CDKA9F05lC6rPfMyvBm5J0XVlHTqQNKB5Uag=;
  b=XBRkXvBo2qAF/f26M29A3zvwlamm2l6hVzoqFZxJXoBUhQ73Jmo17SD9
   2LXyzUdK+tWTW2HvJQtYJEWY7iNg5qYVTPr5fdcJk5qcm24+WzZ+gXY0s
   WlRiTCbeV0c3oBS73NJ22gkqddEdKOn++rMUKoIOGs7oCM2G6Z+JoOl72
   hC/D+X5i8c270lgogtwEdF/BrVx+o7Ub9TmustuRNWNMr35GvZpBY8Rva
   7tlHmjAu7yCigbWenDHDsnC9y2ojqqAmlJQUP8FGOsTuTwtilDb0V+QyM
   tkK8hijyOStJNqMQOWeKh6Z7VudtZ2N8N9c/2+OzjGFk7a8+7scmGbZYX
   w==;
X-IronPort-AV: E=Sophos;i="5.87,184,1631548800"; 
   d="scan'208";a="182940834"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2021 11:42:16 +0800
IronPort-SDR: +AQok7pQNB19I/dQPTPSWBmVoknGPFhNxxi0q0J4CfNyoSSWDtkq5Nk6GdA6rqRDQiZBYZCx+Q
 sx67ONC+BDVGMaeExNF5wS4rdHR/LZjnmmlRqYEF2+BuGHPxHr85M226nQpHdpgyWF274TgIQy
 9JhocSA1Bs3XFMvggUM4p3SXkSERckzmwNQ1iHEG9kI8VN6x755Jrxi6Qomo7yXx3+lLtH0VPf
 h82yycmfqbGOZkZ1MhsVxwZ0zNjUJl77Uu89dNw0dsDVcsWZQekPdiZsFbTsOjmfpLZ+RiKiLK
 tr0QwRcUCfW9NCWONECx6C6k
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 20:17:45 -0700
IronPort-SDR: nG7po36/moCYYbmLSMy+d4MmfeLtykQGUOSeIfzXb1wYoYO96xcU/OU/CEQurEexEWGq/61RSi
 w07h6gJXuqXeflu5TOJp0fGKBpdkRZnuP6DzgYcT4H2xRvR9eXUfeeU3fV1MvMbl1NM95oJKK+
 3B6tBWoJIu1RYBXLOd1pUav5nfs1K68Xi8Dt3o2R+YhOx81LrM5G2yGCDe7kTeBfmN9Lm1xQVX
 X3usw5ez5HYic8dDDaRrcvy4tMaMFE3S7bzB7U7Lty0pUbE8i9PjVusS6wClVF1+HZQo7Zfpi1
 NvI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 20:42:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HfDyw0TLHz1RtVn
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 20:42:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1635306135; x=1637898136; bh=xPGvWc/CDKA9F05lC6rPfMyvBm5J0XVlHTq
        QNKB5Uag=; b=DmhuyViXMiYIEWLuaxh6z1VVq0f1tqJFvt6cDm4t7Ofp6g9zYlq
        DPOmrYNRsCc1Y4Tawz3Yu7iPKL80/21IZ+RUpCT7EXnAtcHB9swQW+Bia1H9gYqp
        d2XkmccjmWBFcsNtiuTopvTOy/WwWMt9oQ467MJQJ6Pj6giLdBOlvgtkCxngjYf6
        7HLmhrqp4q3v4B36iF6L+F+lL6aI4tH5fpHK6wJjuZ2LpCa3LRvkUq+59szTxJwu
        rcnZRy1EQ5fWXeEq38mIJM9dJM4anq8IsEndSzyNOLBcErJMPsjN61mQcBu01oSi
        LDvMhk546pXCQnnms+53Eu5ujQkooxPtjeQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lq92Tl9nZmYT for <linux-block@vger.kernel.org>;
        Tue, 26 Oct 2021 20:42:15 -0700 (PDT)
Received: from [10.89.86.157] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.86.157])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HfDyt4RM1z1RtVl;
        Tue, 26 Oct 2021 20:42:14 -0700 (PDT)
Message-ID: <c47af2f2-2d33-fc54-efe3-f20b286e80c5@opensource.wdc.com>
Date:   Wed, 27 Oct 2021 12:42:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v9 0/5] Initial support for multi-actuator HDDs
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20211027022223.183838-1-damien.lemoal@wdc.com>
 <cea34b2a-6835-d090-4f0c-3bf456a6ed00@kernel.dk>
 <CH2PR04MB70782D5877F24ECC9A0F644AE7859@CH2PR04MB7078.namprd04.prod.outlook.com>
 <64a81be7-ef62-8f8c-bfdc-759e04530366@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <64a81be7-ef62-8f8c-bfdc-759e04530366@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/10/27 12:03, Jens Axboe wrote:
> On 10/26/21 8:49 PM, Damien Le Moal wrote:
>> On 2021/10/27 11:38, Jens Axboe wrote:
>>> On 10/26/21 8:22 PM, Damien Le Moal wrote:
>>>> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>>>
>>>> Single LUN multi-actuator hard-disks are cappable to seek and execute
>>>> multiple commands in parallel. This capability is exposed to the host
>>>> using the Concurrent Positioning Ranges VPD page (SCSI) and Log (ATA).
>>>> Each positioning range describes the contiguous set of LBAs that an
>>>> actuator serves.
>>>>
>>>> This series adds support to the scsi disk driver to retreive this
>>>> information and advertize it to user space through sysfs. libata is
>>>> also modified to handle ATA drives.
>>>>
>>>> The first patch adds the block layer plumbing to expose concurrent
>>>> sector ranges of the device through sysfs as a sub-directory of the
>>>> device sysfs queue directory. Patch 2 and 3 add support to sd and
>>>> libata. Finally patch 4 documents the sysfs queue attributed changes.
>>>> Patch 5 fixes a typo in the document file (strictly speaking, not
>>>> related to this series).
>>>>
>>>> This series does not attempt in any way to optimize accesses to
>>>> multi-actuator devices (e.g. block IO schedulers or filesystems). This
>>>> initial support only exposes the independent access ranges information
>>>> to user space through sysfs.
>>>
>>> I've applied 1/9 for now, as that clearly belongs in the block tree.
>>> Might be the cleanest if SCSI does a post tree that depends on
>>> for-5.16/block. Or I can apply it all as they are reviewed. Let me
>>> know.
>>
>> Forgot: They are all reviewed, including Martin who sent a Reviewed-by for the
>> series, but not an Acked-by for patch 2. As for libata patch 3, obviously, this
>> is Acked-by me.
> 
> Queued up 2-5 in the for-5.16/scsi-ma branch.
> 

Thanks !

-- 
Damien Le Moal
Western Digital Research

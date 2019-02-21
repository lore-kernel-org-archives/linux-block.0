Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D98C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544DA20842
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pLpkN5c0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfBUP0R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:26:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53322 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfBUP0F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 10:26:05 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LFIYQH024651;
        Thu, 21 Feb 2019 15:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=6KbppNFHzraf80vko23Id4VTbMn3llPdPtTeI4mmcyc=;
 b=pLpkN5c0HULP4SsCIbI1I4DQ1vKVF1DO/bYsHQyoLEY8fnfdrCiYh/xZPgL9UsKhGEop
 SIodqiTl1oqTMv/gr2Slq4u0QeSYxEihWKAmMAtAREYlq7jFJf2Asqnw59TmAEnEYTUk
 DNzmVjistO+O1IuNNiC5EsaCcGBcGpo9EisayHN6HKKMC9pKJ7/ASuXIQlpOcxtHZrol
 N3I0FEcgpELiu7RG3hZV0kU0beMtau2R3ftYzvgdD6WW0RMSnCm9mZP/X4yZf20SBpd8
 n/mEOAJs3v+5+k+X1EPKDbPSled2zWwmyqJyFYoeYbe7EEM+wKv9HGn2LCI8zz9M83p4 9A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2qpb5rrkm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 15:26:00 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1LFPxrA015766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 15:26:00 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1LFPxBb011586;
        Thu, 21 Feb 2019 15:25:59 GMT
Received: from [10.191.27.185] (/10.191.27.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 07:25:59 -0800
Subject: Re: [PATCH 2/2] loop: set GENHD_FL_NO_PART_SCAN after
 blkdev_reread_part()
To:     Jan Kara <jack@suse.cz>
References: <1550722655-15102-1-git-send-email-dongli.zhang@oracle.com>
 <1550722655-15102-3-git-send-email-dongli.zhang@oracle.com>
 <20190221113005.GF27474@quack2.suse.cz>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <a2260140-e2e4-a460-cd7e-dc9990d840b4@oracle.com>
Date:   Thu, 21 Feb 2019 23:25:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190221113005.GF27474@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210111
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 02/21/2019 07:30 PM, Jan Kara wrote:
> On Thu 21-02-19 12:17:35, Dongli Zhang wrote:
>> Commit 0da03cab87e6
>> ("loop: Fix deadlock when calling blkdev_reread_part()") moves
>> blkdev_reread_part() out of the loop_ctl_mutex. However,
>> GENHD_FL_NO_PART_SCAN is set before __blkdev_reread_part(). As a result,
>> __blkdev_reread_part() will fail the check of GENHD_FL_NO_PART_SCAN and
>> will not rescan the loop device to delete all partitions.
>>
>> Below are steps to reproduce the issue:
>>
>> step1 # dd if=/dev/zero of=tmp.raw bs=1M count=100
>> step2 # losetup -P /dev/loop0 tmp.raw
>> step3 # parted /dev/loop0 mklabel gpt
>> step4 # parted -a none -s /dev/loop0 mkpart primary 64s 1
>> step5 # losetup -d /dev/loop0
> 
> Can you perhaps write a blktest for this? Thanks!

I will write a blktest for above case. Thanks for the suggestion.

> 
>> Step5 will not be able to delete /dev/loop0p1 (introduced by step4) and
>> there is below kernel warning message:
>>
>> [  464.414043] __loop_clr_fd: partition scan of loop0 failed (rc=-22)
>>
>> This patch sets GENHD_FL_NO_PART_SCAN after blkdev_reread_part().
>>
>> Fixes: 0da03cab87e6 ("loop: Fix deadlock when calling blkdev_reread_part()")
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  drivers/block/loop.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 7908673..736e55b 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -1034,6 +1034,15 @@ loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
>>  	return err;
>>  }
>>  
>> +static void loop_disable_partscan(struct loop_device *lo)
>> +{
>> +	mutex_lock(&loop_ctl_mutex);
>> +	lo->lo_flags = 0;
>> +	if (!part_shift)
>> +		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
>> +	mutex_unlock(&loop_ctl_mutex);
>> +}
>> +
>>  static int __loop_clr_fd(struct loop_device *lo, bool release)
>>  {
>>  	struct file *filp = NULL;
>> @@ -1096,9 +1105,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>>  
>>  	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
>>  	lo_number = lo->lo_number;
>> -	lo->lo_flags = 0;
>> -	if (!part_shift)
>> -		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
>>  	loop_unprepare_queue(lo);
>>  out_unlock:
>>  	mutex_unlock(&loop_ctl_mutex);
>> @@ -1121,6 +1127,9 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>>  		/* Device is gone, no point in returning error */
>>  		err = 0;
>>  	}
>> +
>> +	loop_disable_partscan(lo);
>> +
>>  	/*
>>  	 * Need not hold loop_ctl_mutex to fput backing file.
>>  	 * Calling fput holding loop_ctl_mutex triggers a circular
> 
> So I don't think this change is actually correct. The problem is that once
> lo->lo_state is set to Lo_unbound and loop_ctl_mutex is unlocked, the loop
> device structure can be reused for a new device (bound to a new file). So
> you cannot safely manipulate flags on lo->lo_disk anymore. But I think we
> can just move the setting of lo->lo_state to Lo_unbound after partscan has
> finished as well. There cannot be anybody else entering __loop_clr_fd() as
> lo->lo_backing_file is already cleared and Lo_rundown state protects us
> from all the other places trying to change the 'lo' device (please make
> this last sentence into a comment in the code explaining why setting
> lo->lo_state so late is fine). Thanks!

I will set lo->lo_state to Lo_unbound after partscan in v2.

Thank you very much!

Dongli Zhang

> 
> 								Honza
> 

Return-Path: <SRS0=hB6L=Q5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75534C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 12:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5112075A
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 12:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gMB/D84D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfBVMky (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:40:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41728 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfBVMky (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Feb 2019 07:40:54 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1MCdmrQ144095;
        Fri, 22 Feb 2019 12:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=rCeqDH57tQHRvT9HUFG8NH+r0MRaeil+Dp6Zb7Z4S20=;
 b=gMB/D84DgMobNi2zurh0dymnya3y28C+oC+DDw0FaTVSDnoza5mP74hseqBqUnNMfoq4
 SKLchrRj2U0QZSr5/P1uFhYnwOLtEHGXz5EMvhGM6sarlc8+GPim5UPKEuIoRjDOqQnQ
 okQMAysgkAfM+ANAv2d4kk2wdJM0HMwdo5qk/lD05M3nUvq0tNHNrBggJqbBERTKcsvz
 fAOc1rM8Jz15bnjYMqgnA5CzGAKv9fxrQ4Z1hVz4QzwKDNxYdNZ2g1uIXIF57DSQjoa5
 FXWoCZ443ZZNUp9aXqp23iKziKHLDtnib3JlopqD3Ny+I2qNu+jeoFxMqO4ZerDvdj/A JQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qpb5rxxx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 12:40:45 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1MCedqH025983
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 12:40:39 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1MCedJc031513;
        Fri, 22 Feb 2019 12:40:39 GMT
Received: from [10.191.5.134] (/10.191.5.134)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Feb 2019 04:40:38 -0800
Subject: Re: [PATCH v2 2/2] loop: set GENHD_FL_NO_PART_SCAN after
 blkdev_reread_part()
To:     Jan Kara <jack@suse.cz>
References: <1550763223-21764-1-git-send-email-dongli.zhang@oracle.com>
 <1550763223-21764-3-git-send-email-dongli.zhang@oracle.com>
 <20190222114719.GI23071@quack2.suse.cz>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <cdc952f8-2df7-a34b-8395-8fd076c10f8f@oracle.com>
Date:   Fri, 22 Feb 2019 20:40:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190222114719.GI23071@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902220090
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 02/22/2019 07:47 PM, Jan Kara wrote:
> On Thu 21-02-19 23:33:43, Dongli Zhang wrote:
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
>>
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
>> Changed since v1:
>>   * move the setting of lo->lo_state to Lo_unbound after partscan has finished as well
>>     (suggested by Jan Kara)
>>
>>  drivers/block/loop.c | 26 ++++++++++++++++++++++----
>>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> Thanks the patch looks good! Just one nit below:
> 
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 7908673..a13f5dc 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -1034,6 +1034,16 @@ loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
>>  	return err;
>>  }
>>  
>> +static void loop_disable_partscan(struct loop_device *lo)
>> +{
> 
> I don't think there's any benefit in having this small function with a single
> caller and furthermore with the subtle sideeffect that it changes lo_state.
> So I'd just put the code inline in __loop_clr_fd(). With that you can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thank you very much!

I will send out v3 with the Reviewed-by and put the code inline in __loop_clr_fd().

Dongli Zhang

> 
> 								Honza
> 

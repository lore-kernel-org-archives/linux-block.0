Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C69C33CAC
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 12:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E072082E
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 12:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WGKBXawb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBCMhB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:37:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53076 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgBCMhB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 07:37:01 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013CSMFJ096252;
        Mon, 3 Feb 2020 12:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=IJGUSyWiTaDYU5n8SmGWHykGFqXTyFbeX+/CFLNeh/s=;
 b=WGKBXawbXQfi/qnDTR0v9uR3p39edwt4+FuFM6cy4ibIWN0/YnU5bt84tC68Ah75uLPK
 op1nohif4RCeyrGIrxb3c3U6c6ghwN7C7TfQsmkn3/m4m6rjHusEoRdu2twLedOs4mvS
 IyN7N72StYNN2eFrJDEB/jQ6nveIazVBn/N5AN+01201pDgeQFFr1zC5hcC9q6Z4C1gm
 eSF2NmSRSoQJ4JlBUNvl9mVP7ZAlg246zfOBD6kP1yVkHEoWjYhnKGrGR8/Pmgk5BiB/
 R7xH4swz0LvPW/FaakFczCZEIvHxlOLB7e4hcjWPbeGsLm3DctSrfW8P3CWwUvpAcUKa 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xw0rtyh2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 12:36:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013CSMZZ081244;
        Mon, 3 Feb 2020 12:36:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2xwkg8pbuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 12:36:48 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 013CajHQ004519;
        Mon, 3 Feb 2020 12:36:45 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Feb 2020 04:36:45 -0800
Subject: Re: [PATCH V4] brd: check and limit max_part par
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, Guiyao <guiyao@huawei.com>,
        wubo40@huawei.comwubo, Louhongxiang <louhongxiang@huawei.com>
References: <76ad8074-c2ba-4bb3-3e8b-3a4925999964@huawei.com>
 <fe925c14-fe70-b237-b793-e6b865687c11@huawei.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <606d4b34-7f2f-2207-a725-2999b75cbbb7@oracle.com>
Date:   Mon, 3 Feb 2020 20:36:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <fe925c14-fe70-b237-b793-e6b865687c11@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002030095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002030095
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/3/20 9:53 AM, Zhiqiang Liu wrote:
> Friendly ping...
> 
> On 2020/1/21 12:04, Zhiqiang Liu wrote:
>>
>> In brd_init func, rd_nr num of brd_device are firstly allocated
>> and add in brd_devices, then brd_devices are traversed to add each
>> brd_device by calling add_disk func. When allocating brd_device,
>> the disk->first_minor is set to i * max_part, if rd_nr * max_part
>> is larger than MINORMASK, two different brd_device may have the same
>> devt, then only one of them can be successfully added.
>> when rmmod brd.ko, it will cause oops when calling brd_exit.
>>
>> Follow those steps:
>>   # modprobe brd rd_nr=3 rd_size=102400 max_part=1048576
>>   # rmmod brd
>> then, the oops will appear.
>>
>> Oops log:
>> [  726.613722] Call trace:
>> [  726.614175]  kernfs_find_ns+0x24/0x130
>> [  726.614852]  kernfs_find_and_get_ns+0x44/0x68
>> [  726.615749]  sysfs_remove_group+0x38/0xb0
>> [  726.616520]  blk_trace_remove_sysfs+0x1c/0x28
>> [  726.617320]  blk_unregister_queue+0x98/0x100
>> [  726.618105]  del_gendisk+0x144/0x2b8
>> [  726.618759]  brd_exit+0x68/0x560 [brd]
>> [  726.619501]  __arm64_sys_delete_module+0x19c/0x2a0
>> [  726.620384]  el0_svc_common+0x78/0x130
>> [  726.621057]  el0_svc_handler+0x38/0x78
>> [  726.621738]  el0_svc+0x8/0xc
>> [  726.622259] Code: aa0203f6 aa0103f7 aa1e03e0 d503201f (7940e260)
>>
>> Here, we add brd_check_and_reset_par func to check and limit max_part par.
>>
>> --
>> V3->V4:(suggested by Ming Lei)
>>  - remove useless change
>>  - add one limit of max_part
>>
>> V2->V3: (suggested by Ming Lei)
>>  - clear .minors when running out of consecutive minor space in brd_alloc
>>  - remove limit of rd_nr
>>
>> V1->V2: add more checks in brd_check_par_valid as suggested by Ming Lei.
>>
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> ---
>>  drivers/block/brd.c | 27 +++++++++++++++++++++++----
>>  1 file changed, 23 insertions(+), 4 deletions(-)
>>

Looks good to me.
Reviewed-by: Bob Liu <bob.liu@oracle.com>

>> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
>> index df8103dd40ac..4684f95e3369 100644
>> --- a/drivers/block/brd.c
>> +++ b/drivers/block/brd.c
>> @@ -389,11 +389,12 @@ static struct brd_device *brd_alloc(int i)
>>  	 *  is harmless)
>>  	 */
>>  	blk_queue_physical_block_size(brd->brd_queue, PAGE_SIZE);
>> -	disk = brd->brd_disk = alloc_disk(max_part);
>> +	disk = brd->brd_disk = alloc_disk(((i * max_part) & ~MINORMASK) ?
>> +			0 : max_part);
>>  	if (!disk)
>>  		goto out_free_queue;
>>  	disk->major		= RAMDISK_MAJOR;
>> -	disk->first_minor	= i * max_part;
>> +	disk->first_minor	= i * disk->minors;
>>  	disk->fops		= &brd_fops;
>>  	disk->private_data	= brd;
>>  	disk->queue		= brd->brd_queue;
>> @@ -468,6 +469,25 @@ static struct kobject *brd_probe(dev_t dev, int *part, void *data)
>>  	return kobj;
>>  }
>>
>> +static inline void brd_check_and_reset_par(void)
>> +{
>> +	if (unlikely(!max_part))
>> +		max_part = 1;
>> +
>> +	if (max_part > DISK_MAX_PARTS) {
>> +		pr_info("brd: max_part can't be larger than %d, reset max_part = %d.\n",
>> +			DISK_MAX_PARTS, DISK_MAX_PARTS);
>> +		max_part = DISK_MAX_PARTS;
>> +	}
>> +
>> +	/*
>> +	 * make sure 'max_part' can be divided exactly by (1U << MINORBITS),
>> +	 * otherwise, it is possiable to get same dev_t when adding partitions.
>> +	 */
>> +	if ((1U << MINORBITS) % max_part != 0)
>> +		max_part = 1UL << fls(max_part);
>> +}
>> +
>>  static int __init brd_init(void)
>>  {
>>  	struct brd_device *brd, *next;
>> @@ -491,8 +511,7 @@ static int __init brd_init(void)
>>  	if (register_blkdev(RAMDISK_MAJOR, "ramdisk"))
>>  		return -EIO;
>>
>> -	if (unlikely(!max_part))
>> -		max_part = 1;
>> +	brd_check_and_reset_par();
>>
>>  	for (i = 0; i < rd_nr; i++) {
>>  		brd = brd_alloc(i);
>>
> 


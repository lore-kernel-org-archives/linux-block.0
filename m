Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB085C33C99
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 04:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8971B2072A
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 04:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m4vYxuSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbgAGEFw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:05:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59612 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgAGEFv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jan 2020 23:05:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00744Fev084711;
        Tue, 7 Jan 2020 04:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=e12reUCeRU/k2/QOOmj9xpED6pDBlEI9Ccx7feyX41s=;
 b=m4vYxuSoHYk+ZMQkgoidcB4eCNIrU9Me49Z5ZrWDLK09SRzT5glgET8m409tB/KiDKPc
 vXAOL7DWfSr/+fAQgsVerq2BZf9RjXMKGAWegwZzSXEfdCfPHiUIwwvNwMv9g06U3wxu
 eDHiNcCI0a9xCY7rz1pivQTgA38mbj4MnUFEBq7D5ENN5OnC9xmba6Dqddrm9bRPEpSI
 dsY/3oDY40KRW6tUYMvEF3kkPyllaTBSyp/Gw3sv+0Pc7nSqvjizwHhTYvrTUg+Nidwn
 ZATQRMall2fYWh0PE3IZsou/j+S4iIetOWNIng3kFP7z46nN1MJ4P0UP1c+/qNPWuVk5 VQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xaj4tu1qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 04:05:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00744Bb9191203;
        Tue, 7 Jan 2020 04:05:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xb4v28fd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 04:05:38 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00745aPZ016230;
        Tue, 7 Jan 2020 04:05:36 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 20:05:35 -0800
Subject: Re: [PATCH] blk-map: add kernel address validation in blk_rq_map_kern
 func
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        jens.axboe@oracle.com, namhyung@gmail.com, bharrosh@panasas.com,
        renxudong <renxudong1@huawei.com>
Cc:     Mingfangsen <mingfangsen@huawei.com>, zhengbin13@huawei.com,
        Guiyao <guiyao@huawei.com>, ming.lei@redhat.com
References: <239c8928-aea0-abe9-a75d-dc3f1b573ec5@huawei.com>
 <6b282b91-b157-5260-57d9-774be223998c@huawei.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <91b13d6f-04b5-28b0-ea1b-d99564ecc898@oracle.com>
Date:   Tue, 7 Jan 2020 12:05:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <6b282b91-b157-5260-57d9-774be223998c@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070031
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/7/20 10:38 AM, Zhiqiang Liu wrote:
> Friendly ping...
> 
> On 2019/12/30 20:17, Zhiqiang Liu wrote:
>> From: renxudong <renxudong1@huawei.com>
>>
>> Blk_rq_map_kern func is used to map kernel data to a request,
>> in which kbuf par should be a valid kernel buffer. However,
>> kbuf par is only checked whether it is null in blk_rq_map_kern func.
>>
>> If users pass a non kernel address to blk_rq_map_kern func in the
>> non-aligned scenario, the invalid kbuf will be set to bio->bi_private.
>> When the request is completed, bio_copy_kern_endio_read will be called
>> to copy data to the kernel address in bio->bi_private. If the bi_private
>> is not a valid kernel address, the system will oops. In this case, we

This patch looks fine to me, but curious did you trigger the real oops?
If yes, it's better add the oops info into commit log.

>> cannot judge whether the bio structure is damaged or the kernel address is
>> invalid.
>>
>> Here, we add kernel address validation by calling virt_addr_valid.
>>
>> Signed-off-by: renxudong <renxudong1@huawei.com>
>> Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> ---
>>  block/blk-map.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/blk-map.c b/block/blk-map.c
>> index 3a62e471d81b..7deb1b44d1e3 100644
>> --- a/block/blk-map.c
>> +++ b/block/blk-map.c
>> @@ -229,7 +229,7 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
>>
>>  	if (len > (queue_max_hw_sectors(q) << 9))
>>  		return -EINVAL;
>> -	if (!len || !kbuf)
>> +	if (!len || !virt_addr_valid(kbuf))
>>  		return -EINVAL;
>>
>>  	do_copy = !blk_rq_aligned(q, addr, len) || object_is_on_stack(kbuf);
>>
> 


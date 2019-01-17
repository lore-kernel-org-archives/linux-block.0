Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0525DC43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 02:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFC0205C9
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 02:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A9iD/QmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfAQCHr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 21:07:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41208 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfAQCHr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 21:07:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0H1wvd0171654;
        Thu, 17 Jan 2019 02:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=wm23DvvNOHtr368PIcEkk4KyJOHMmhsEJx2qEA+s3ns=;
 b=A9iD/QmTbvqUJbwDRqWMBchSjzqKFCjgDKFrVP3UpGV99aN95WHqvEpGpb69Akwxur0S
 ElHJl2UFX3B8tk01ebRpJDZzoXgzNh0nnisXbe8Y6oWpe66bf5x2Apb7GEltNgtgrxYz
 Qd279V5Fv7qAxKAgftJCIVfR+AHXBHfzEOrWOW+pUeuWX4PJAX/LtZTfRHEudK6M23mn
 Yif3IvhorayhuAoboiOONxv0f0MdREapkcHkssKb8j46yRWXYLwtIcKqmZ8nu/Rv79R6
 aDIT7LX8Gn4Egp5CZZ1fr+tr4LZ9Js4TEg5sI1/INRUreHYxPu+7rs4vbHy7Kc4edl+O 6Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2pybjsdaqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 02:07:42 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0H27g5J006764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 02:07:42 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0H27fP9027943;
        Thu, 17 Jan 2019 02:07:41 GMT
Received: from [10.182.71.41] (/10.182.71.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Jan 2019 18:07:41 -0800
Subject: Re: [Xen-devel] [PATCH 1/1] xen-blkback: do not wake up shutdown_wq
 after xen_blkif_schedule() is stopped
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        konrad.wilk@oracle.com
References: <1547646461-29803-1-git-send-email-dongli.zhang@oracle.com>
 <20190116145215.igakzdkklc6f7h6k@mac>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <30770f68-34e0-d707-b087-c43f0b51cd81@oracle.com>
Date:   Thu, 17 Jan 2019 10:10:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116145215.igakzdkklc6f7h6k@mac>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9138 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901170012
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Roger,

On 2019/1/16 下午10:52, Roger Pau Monné wrote:
> On Wed, Jan 16, 2019 at 09:47:41PM +0800, Dongli Zhang wrote:
>> There is no need to wake up xen_blkif_schedule() as kthread_stop() is able
>> to already wake up the kernel thread.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  drivers/block/xen-blkback/xenbus.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
>> index a4bc74e..37ac59e 100644
>> --- a/drivers/block/xen-blkback/xenbus.c
>> +++ b/drivers/block/xen-blkback/xenbus.c
>> @@ -254,10 +254,8 @@ static int xen_blkif_disconnect(struct xen_blkif *blkif)
>>  		if (!ring->active)
>>  			continue;
>>  
>> -		if (ring->xenblkd) {
>> +		if (ring->xenblkd)
>>  			kthread_stop(ring->xenblkd);
>> -			wake_up(&ring->shutdown_wq);
> 
> I've now realized that shutdown_wq is basically useless, and should be
> removed, could you please do it in this patch?

I do not think shutdown_wq is useless.

It is used to halt the xen_blkif_schedule() kthread when
RING_REQUEST_PROD_OVERFLOW() returns true in __do_block_io_op():

1121 static int
1122 __do_block_io_op(struct xen_blkif_ring *ring)
... ...
1134         if (RING_REQUEST_PROD_OVERFLOW(&blk_rings->common, rp)) {
1135                 rc = blk_rings->common.rsp_prod_pvt;
1136                 pr_warn("Frontend provided bogus ring requests (%d - %d =
%d). Halting ring processing on dev=%04x\n",
1137                         rp, rc, rp - rc, ring->blkif->vbd.pdevice);
1138                 return -EACCES;
1139         }


If there is bogus/invalid ring requests, __do_block_io_op() would return -EACCES
without modifying prod/cons index.

Without shutdown_wq (just simply assuming we remove the below code without
handling -EACCES in xen_blkif_schedule()), the kernel thread would continue the
while loop.

648                 if (ret == -EACCES)
649                         wait_event_interruptible(ring->shutdown_wq,
650                                                  kthread_should_stop());


If xen_blkif_be_int() is triggered again (let's assume there is no optimization
on guest part and guest would send event for every request it puts on ring
buffer), we may come to do_block_io_op() again.


As the prod/cons index are not modified last time the code runs into
do_block_io_op() to process bogus request, we would hit the bogus request issue
again.


With shutdown_wq, the kernel kthread is blocked forever until such queue/ring is
destroyed. If we remove shutdown_wq, we are changing the policy to handle bogus
requests on ring buffer?

Please correct me if my understanding is wrong.

Thank you very much!

Dongli Zhang

Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1D4C7618F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 23:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E76D21BF6
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 23:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JTKVwsYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfGVXgw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:36:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51568 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfGVXgw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 19:36:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MNXqjV001985;
        Mon, 22 Jul 2019 23:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=egqqW/mZD3nk8a5ohX29bdMEufJeiEnpm1IdWpCZRK0=;
 b=JTKVwsYPWPsu3AU08JPRXmOo/VtI5VqrdAtfGHg9VkamStKFb3mdvMwn4SkSdRQt6Um9
 w/ahqK9ioeMad5i4KNM9oaUIttmsdZ8ZynR9NnVzp7WZbgmvDoJlTs+MwH0kcGthzE+D
 gfgQewbXzP5bSVzNyuV3CYuxm8O+PQU9vWqp+c2slPWvJS2W1FqZwDisHWIFcxCtn+Q8
 GDbsSeV04Iz/k3k6RV+gUjg0ttX8x1/EzePJ0SYK5VEiKtZsdlSxB+tw7gmVDrSEycxU
 TMp4qotn+NZaQ0amJKm79LrCTkXeARDGkdlkxEyndOIHbclT2WNq6dCW+UmpjkVlN+9l hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2tutwpadq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 23:36:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MNWYeR080720;
        Mon, 22 Jul 2019 23:36:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tur2u2x3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 23:36:24 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6MNaMkC003855;
        Mon, 22 Jul 2019 23:36:22 GMT
Received: from [192.168.1.14] (/180.165.87.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jul 2019 16:36:22 -0700
Subject: Re: [PATCH] bfq: Check if bfqq is NULL in bfq_insert_request
To:     Guenter Roeck <linux@roeck-us.net>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Doug Anderson <dianders@chromium.org>
References: <1563816648-12057-1-git-send-email-linux@roeck-us.net>
 <20190722202920.GA18431@roeck-us.net>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <f3f2764a-90b4-e294-d364-a25156933a71@oracle.com>
Date:   Tue, 23 Jul 2019 07:36:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190722202920.GA18431@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907220249
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907220249
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/23/19 4:29 AM, Guenter Roeck wrote:
> On Mon, Jul 22, 2019 at 10:30:48AM -0700, Guenter Roeck wrote:
>> In bfq_insert_request(), bfqq is initialized with:
>> 	bfqq = bfq_init_rq(rq);
>> In bfq_init_rq(), we find:
>> 	if (unlikely(!rq->elv.icq))
>> 		return NULL;
>> Indeed, rq->elv.icq can be NULL if the memory allocation in
>> create_task_io_context() failed.
>>
> 
> The above function should have been ioc_create_icq(), sorry.
> 
> Guenter
> 
>> A comment in bfq_insert_request() suggests that bfqq is supposed to be
>> non-NULL if 'at_head || blk_rq_is_passthrough(rq)' is false. Yet, as
>> debugging and practical experience shows, this is not the case in the
>> above situation.
>>
>> This results in the following crash.
>>
>> Unable to handle kernel NULL pointer dereference
>> 	at virtual address 00000000000001b0
>> ...
>> Call trace:
>>  bfq_setup_cooperator+0x44/0x134
>>  bfq_insert_requests+0x10c/0x630
>>  blk_mq_sched_insert_requests+0x60/0xb4
>>  blk_mq_flush_plug_list+0x290/0x2d4
>>  blk_flush_plug_list+0xe0/0x230
>>  blk_finish_plug+0x30/0x40
>>  generic_writepages+0x60/0x94
>>  blkdev_writepages+0x24/0x30
>>  do_writepages+0x74/0xac
>>  __filemap_fdatawrite_range+0x94/0xc8
>>  file_write_and_wait_range+0x44/0xa0
>>  blkdev_fsync+0x38/0x68
>>  vfs_fsync_range+0x68/0x80
>>  do_fsync+0x44/0x80
>>
>> The problem is relatively easy to reproduce by running an image with
>> failslab enabled, such as with:
>>
>> cd /sys/kernel/debug/failslab
>> echo 10 > probability
>> echo 300 > times
>>
>> Avoid the problem by checking if bfqq is NULL before using it. With the
>> NULL check in place, requests with missing io context are queued
>> immediately, and the crash is no longer seen.
>>


What about other place use blk_init_rq()?
E.g in bfq_request_merged():
1897                 struct bfq_queue *bfqq = bfq_init_rq(req);
1898                 struct bfq_data *bfqd = bfqq->bfqd;

Which may have same Null-pointer bug?

-Bob

>> Fixes: 18e5a57d79878 ("block, bfq: postpone rq preparation to insert or merge")
>> Reported-by: Hsin-Yi Wang  <hsinyi@google.com>
>> Cc: Hsin-Yi Wang <hsinyi@google.com>
>> Cc: Nicolas Boichat <drinkcat@chromium.org>
>> Cc: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  block/bfq-iosched.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 72860325245a..56f3f4227010 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -5417,7 +5417,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>  
>>  	spin_lock_irq(&bfqd->lock);
>>  	bfqq = bfq_init_rq(rq);
>> -	if (at_head || blk_rq_is_passthrough(rq)) {
>> +	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
>>  		if (at_head)
>>  			list_add(&rq->queuelist, &bfqd->dispatch);
>>  		else
>> -- 
>> 2.7.4
>>


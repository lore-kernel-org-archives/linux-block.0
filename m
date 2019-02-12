Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75306C169C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 01:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4222E20836
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 01:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JdZSJk5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfBLByl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:54:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43332 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbfBLByl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 20:54:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1C1nHrl006938;
        Tue, 12 Feb 2019 01:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=YJXzhy7WlbTUkMbSYIK8Xtmwi248YbHdbKAh+N2PN8Y=;
 b=JdZSJk5rhI5GCoAN6/fYvHl7yUwZRnaPFsUfhbHQ83s2BTX0Jy/ogR8aobA71yZ88Sfk
 PUCpj4YTl1kfRhn8rv3sPjlfN8mh8cbJR3WPXDXMBEpwpXsxqQ9Dg4ioToHYzj+TxLou
 8MckK3+QPaGz/09bkCk6qv2rd8mamUesCNBOWyT6a+ejDpiNi+SDupaPraQI5e9td+py
 TqJ+vRVlo+mqkbJP0/TSkc+a/dyKGlZGieodgCaFCmYkDwjj+om4jseOaEaDKHcZ22bc
 dInyyBkBJjvxIjSqCwihWMMj08dSyaFA8fCN1kZ16aW+QlBGtW7kO0xy1DjMzPoZzlZS UA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qhrek9802-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 01:54:38 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1C1sbt1008754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 01:54:38 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1C1sbEB011237;
        Tue, 12 Feb 2019 01:54:37 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Feb 2019 17:54:37 -0800
Subject: Re: [PATCH] blk-mq: insert rq with DONTPREP to hctx dispatch list
 when requeue
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1549863665-1691-1-git-send-email-jianchao.w.wang@oracle.com>
 <937e9207-dcf7-dab5-1917-8a10303edc67@kernel.dk>
 <82deee13-a4ff-9bf5-5e01-0e4df01b7ff7@kernel.dk>
 <e68f8017-2f56-6305-1c08-2368435b274b@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <0ae89a37-7b6e-0cc4-f474-2e5c45cc1aec@oracle.com>
Date:   Tue, 12 Feb 2019 09:56:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e68f8017-2f56-6305-1c08-2368435b274b@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9164 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902120011
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens

Thanks for your kindly response.

On 2/12/19 7:20 AM, Jens Axboe wrote:
> On 2/11/19 4:15 PM, Jens Axboe wrote:
>> On 2/11/19 8:59 AM, Jens Axboe wrote:
>>> On 2/10/19 10:41 PM, Jianchao Wang wrote:
>>>> When requeue, if RQF_DONTPREP, rq has contained some driver
>>>> specific data, so insert it to hctx dispatch list to avoid any
>>>> merge. Take scsi as example, here is the trace event log (no
>>>> io scheduler, because RQF_STARTED would prevent merging),
>>>>
>>>>    kworker/0:1H-339   [000] ...1  2037.209289: block_rq_insert: 8,0 R 4096 () 32768 + 8 [kworker/0:1H]
>>>> scsi_inert_test-1987  [000] ....  2037.220465: block_bio_queue: 8,0 R 32776 + 8 [scsi_inert_test]
>>>> scsi_inert_test-1987  [000] ...2  2037.220466: block_bio_backmerge: 8,0 R 32776 + 8 [scsi_inert_test]
>>>>    kworker/0:1H-339   [000] ....  2047.220913: block_rq_issue: 8,0 R 8192 () 32768 + 16 [kworker/0:1H]
>>>> scsi_inert_test-1996  [000] ..s1  2047.221007: block_rq_complete: 8,0 R () 32768 + 8 [0]
>>>> scsi_inert_test-1996  [000] .Ns1  2047.221045: block_rq_requeue: 8,0 R () 32776 + 8 [0]
>>>>    kworker/0:1H-339   [000] ...1  2047.221054: block_rq_insert: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
>>>>    kworker/0:1H-339   [000] ...1  2047.221056: block_rq_issue: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
>>>> scsi_inert_test-1986  [000] ..s1  2047.221119: block_rq_complete: 8,0 R () 32776 + 8 [0]
>>>>
>>>> (32768 + 8) was requeued by scsi_queue_insert and had RQF_DONTPREP.
>>>> Then it was merged with (32776 + 8) and issued. Due to RQF_DONTPREP,
>>>> the sdb only contained the part of (32768 + 8), then only that part
>>>> was completed. The lucky thing was that scsi_io_completion detected
>>>> it and requeued the remaining part. So we didn't get corrupted data.
>>>> However, the requeue of (32776 + 8) is not expected.
>>>
>>> Good catch, but how about something like this? Makes it more integrated,
>>> I think that's cleaner.
>>
>> This is probably better (and safer):
> 
> Here's the one I wanted to send, not a half done one. Maybe I'll be
> luckier this time around?
> 
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8f5b533764ca..35e6aba52808 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -737,12 +737,21 @@ static void blk_mq_requeue_work(struct work_struct *work)
>  	spin_unlock_irq(&q->requeue_lock);
>  
>  	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
> -		if (!(rq->rq_flags & RQF_SOFTBARRIER))
> +		if (!(rq->rq_flags & (RQF_SOFTBARRIER | RQF_DONTPREP)))
>  			continue;
>  
>  		rq->rq_flags &= ~RQF_SOFTBARRIER;
>  		list_del_init(&rq->queuelist);
> -		blk_mq_sched_insert_request(rq, true, false, false);
> +
> +		/*
> +		 * If RQF_DONTPREP is set, rq may contain some driver
> +		 * specific data. Insert it to hctx dispatch list to avoid
> +		 * any merge.
> +		 */
> +		if (rq->rq_flags & RQF_DONTPREP)
> +			blk_mq_request_bypass_insert(rq, false);
> +		else
> +			blk_mq_sched_insert_request(rq, true, false, false);
>  	}
>  
>  	while (!list_empty(&rq_list)) {
> 

The test is OK.
And I will send out the V2 based on this.

Thanks
Jianchao

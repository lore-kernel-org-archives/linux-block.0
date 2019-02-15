Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C044C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C526720840
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2Gz4gsL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbfBOCc0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:32:26 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38110 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387502AbfBOCcW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 21:32:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1F2Somd157770;
        Fri, 15 Feb 2019 02:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=xO1w+teFlFK717d22F2DOLGWawS50hLQv1+2lk/zGpo=;
 b=2Gz4gsL1rpDfByUvrja5UD4xHmWTYHnX8v3MhV2R7Q8c0OtHoqQHyAOgRXrqYIVBGkKO
 k2Xct1Dsj97JRfw7tVNruELqM6FfCx78RnPq3WQCeknKp4cuj9Jh2vPVJ0/eNMcUV3T1
 VMBSgPmnt5Oa+fqyDyYz/czSszmgYJS3475qCF0J0yWfiN6WNDhOdQP9DRHpbTnDB2S8
 2FeFdFJ5yD9OMoWq5Oiac/Ukc+qXU5g41e73Pox8yA2L45YgRbUgEJB9HxlmR5oRoqmH
 ptLbfsBSbmgSiOg/qNjqZjlgDbXHifQV2u4ldNfacV91oN6pepzdDPYHCiqTznA9q+ZF Pg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qhrekub2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 02:32:18 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1F2WHbU021695
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 02:32:17 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1F2WHjh006450;
        Fri, 15 Feb 2019 02:32:17 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Feb 2019 02:32:16 +0000
Subject: Re: [PATCH V2] blk-mq: insert rq with DONTPREP to hctx dispatch list
 when requeue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <1549936585-1702-1-git-send-email-jianchao.w.wang@oracle.com>
 <20190215020049.GA21045@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <07260476-307a-efdc-63aa-95ea0a3e7489@oracle.com>
Date:   Fri, 15 Feb 2019 10:34:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190215020049.GA21045@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9167 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902150015
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming

Thanks for your kindly response.

On 2/15/19 10:00 AM, Ming Lei wrote:
> On Tue, Feb 12, 2019 at 09:56:25AM +0800, Jianchao Wang wrote:
>> When requeue, if RQF_DONTPREP, rq has contained some driver
>> specific data, so insert it to hctx dispatch list to avoid any
>> merge. Take scsi as example, here is the trace event log (no
>> io scheduler, because RQF_STARTED would prevent merging),
>>
>>    kworker/0:1H-339   [000] ...1  2037.209289: block_rq_insert: 8,0 R 4096 () 32768 + 8 [kworker/0:1H]
>> scsi_inert_test-1987  [000] ....  2037.220465: block_bio_queue: 8,0 R 32776 + 8 [scsi_inert_test]
>> scsi_inert_test-1987  [000] ...2  2037.220466: block_bio_backmerge: 8,0 R 32776 + 8 [scsi_inert_test]
>>    kworker/0:1H-339   [000] ....  2047.220913: block_rq_issue: 8,0 R 8192 () 32768 + 16 [kworker/0:1H]
>> scsi_inert_test-1996  [000] ..s1  2047.221007: block_rq_complete: 8,0 R () 32768 + 8 [0]
>> scsi_inert_test-1996  [000] .Ns1  2047.221045: block_rq_requeue: 8,0 R () 32776 + 8 [0]
>>    kworker/0:1H-339   [000] ...1  2047.221054: block_rq_insert: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
>>    kworker/0:1H-339   [000] ...1  2047.221056: block_rq_issue: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
>> scsi_inert_test-1986  [000] ..s1  2047.221119: block_rq_complete: 8,0 R () 32776 + 8 [0]
>>
>> (32768 + 8) was requeued by scsi_queue_insert and had RQF_DONTPREP.
> 
> scsi_mq_requeue_cmd() does uninit the request before requeuing, but
> __scsi_queue_insert doesn't do that.

Yes.
scsi layer use both of them.

> 
> 
>> Then it was merged with (32776 + 8) and issued. Due to RQF_DONTPREP,
>> the sdb only contained the part of (32768 + 8), then only that part
>> was completed. The lucky thing was that scsi_io_completion detected
>> it and requeued the remaining part. So we didn't get corrupted data.
>> However, the requeue of (32776 + 8) is not expected.
>>
>> Suggested-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>> V2:
>>  - refactor the code based on Jens' suggestion
>>
>>  block/blk-mq.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 8f5b533..9437a5e 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -737,12 +737,20 @@ static void blk_mq_requeue_work(struct work_struct *work)
>>  	spin_unlock_irq(&q->requeue_lock);
>>  
>>  	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
>> -		if (!(rq->rq_flags & RQF_SOFTBARRIER))
>> +		if (!(rq->rq_flags & (RQF_SOFTBARRIER | RQF_DONTPREP)))
>>  			continue;
>>  
>>  		rq->rq_flags &= ~RQF_SOFTBARRIER;
>>  		list_del_init(&rq->queuelist);
>> -		blk_mq_sched_insert_request(rq, true, false, false);
>> +		/*
>> +		 * If RQF_DONTPREP, rq has contained some driver specific
>> +		 * data, so insert it to hctx dispatch list to avoid any
>> +		 * merge.
>> +		 */
>> +		if (rq->rq_flags & RQF_DONTPREP)
>> +			blk_mq_request_bypass_insert(rq, false);
>> +		else
>> +			blk_mq_sched_insert_request(rq, true, false, false);
>>  	}
> 
> Suppose it is one WRITE request to zone device, this way might break
> the order.

I'm not sure about this.
Since the request is dispatched, it should hold and zone write lock.
And also mq-deadline doesn't have a .requeue_request, zone write lock
wouldn't be released during requeue.

IMO, this requeue action is similar with what blk_mq_dispatch_rq_list does.
The latter one also issues the request to underlying driver and requeue rqs
on dispatch_list if get BLK_STS_SOURCE or BLK_STS_DEV_SOURCE.

And in addition, RQF_STARTED is set by io scheduler .dispatch_request and
it could be stop merging as RQF_NOMERGE_FLAGS contains it. 

Thanks
Jianchao

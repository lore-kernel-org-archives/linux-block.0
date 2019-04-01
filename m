Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771F3C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 02:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3237320870
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 02:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yZfa8bDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbfDACoX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 22:44:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57642 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731593AbfDACoX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 22:44:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x312d5p6186902;
        Mon, 1 Apr 2019 02:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=rvJQfwDH5nDyJsjlQb/PGBtVQ084bs/DNS8zaBC4iBc=;
 b=yZfa8bDL/hc9j+i7p7+u7CmfxmrbT9WP071dMh59YArSjwG01H78FmQ5eYvQKPWAj4yC
 w29QoR9stlzm3n1rq9APPDESk+Rc71WF7BnW/7FWFzb4y6blhZip83JT4ewCcaUyN06+
 LZmo09au69Gmx3K9Dcwh/jSbvMVs3hqjmLw6AFcUGfTQqWHcyLyDsdmTq4dw6wdiSyEx
 Ue4CjNO+7/2hTD+NEV+dhojt/j69G+2iQIGh9sIBWXFJg9DoiJXXJlKZPg/Kp+2YKJiR
 Hmw9GCMS6aARGLtKtbeLtBxRsrbA6ZydsslyKs9L3DHKKDgstQI0UV2vj89cOL1sGIMD BQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2rhyvsva2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 02:44:10 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x312i81M016507
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 02:44:08 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x312i6Bs021217;
        Mon, 1 Apr 2019 02:44:06 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 31 Mar 2019 19:44:06 -0700
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
References: <20190331030954.22320-1-ming.lei@redhat.com>
 <10c8ed10-3c96-b73c-18d8-114773b1d675@acm.org>
 <20190401020036.GB30776@ming.t460p>
 <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <fa9375ec-a2a7-d065-b941-7822f3791242@oracle.com>
Date:   Mon, 1 Apr 2019 10:44:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9213 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010019
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/1/19 10:39 AM, Bart Van Assche wrote:
> On 3/31/19 7:00 PM, Ming Lei wrote:
>> On Sun, Mar 31, 2019 at 08:27:35AM -0700, Bart Van Assche wrote:
>>> I'm not sure the approach of this patch series is really the direction we
>>> should pursue. There are many block driver that free resources immediately
>>
>> Please see scsi_run_queue(), and the queue refcount is always held
>> before run queue.
> 
> That's not correct. There is no guarantee that q->q_usage_counter > 0 when scsi_run_queue() is called from inside scsi_requeue_run_queue().
> 
>>> I'd like to avoid having to modify all block drivers that free resources
>>> immediately after blk_cleanup_queue() has returned. Have you considered to
>>> modify blk_mq_run_hw_queues() such that it becomes safe to call that
>>> function while blk_cleanup_queue() is in progress, e.g. by inserting a
>>> percpu_ref_tryget_live(&q->q_usage_counter) /
>>> percpu_ref_put(&q->q_usage_counter) pair?
>>
>> It can't work because blk_mq_run_hw_queues may happen after
>> percpu_ref_exit() is done.
>>
>> However, if we move percpu_ref_exit() into queue's release handler, we
>> don't need to grab q->q_usage_counter any more in blk_mq_run_hw_queues(),
>> and we still have to free hw queue resources in queue's release handler,
>> that is exactly what this patchset is doing.
>>
>> In short, getting q->q_usage_counter doesn't make a difference on this
>> issue.
> 
> percpu_ref_tryget_live() fails if a per-cpu counter is in the "dead" state. percpu_ref_kill() changes the state of a per-cpu counter to the "dead" state. blk_freeze_queue_start() calls percpu_ref_kill(). blk_cleanup_queue() already calls blk_set_queue_dying() and that last function calls blk_freeze_queue_start(). So I think that what you wrote is not correct and that inserting a percpu_ref_tryget_live()/percpu_ref_put() pair in blk_mq_run_hw_queues() or blk_mq_run_hw_queue() would make a difference and also that moving the percpu_ref_exit() call into blk_release_queue() makes sense.
> 

percpu_ref_tryget would be better to get pending requests to be issued when queue is frozen.

Thanks
Jianchao

Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F8FC43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 05:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B1E20870
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 05:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TA251E6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfDAFCH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:02:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59720 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDAFCH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 01:02:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x314wUVj084392;
        Mon, 1 Apr 2019 05:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=CiqXy3lCRlQrTKlZNflhYuELS5Rdpvnb9SMrpEr3VW4=;
 b=TA251E6VQei5TH43rrYARY/6E5jE6MMz8TbFzaAjIhEVqNYaGNsagHPu0jY/xjmbqKay
 fLqMiZDRzX+jwz7EKHiKuGL+iz4uAptAAeCjJi3BqARos1PPnjl1bhddvL6roYd6gpJG
 uPf3ByGFm7NZRHLr61mCwdfEbyh9H4iTpc0K6j0lvMZzdEtvZ3ZCRs55Yuy0NFGrV8ch
 RM5OkbpEAPd89p+JMwDF7rMOXfClUqmRyu4vJHJeORakFTCk1fUpXk1MZ104WZZKjV9t
 xJ8/2L0PT2TyW0C+tOgP/7iKvdo78fRitJO9AGKIIDfdSGoVsrWnqgUL5zyu9HB0espG yA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2rhyvsvmbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 05:01:45 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x3151juP004102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 05:01:45 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3151hbf021672;
        Mon, 1 Apr 2019 05:01:43 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 31 Mar 2019 22:01:43 -0700
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
References: <20190331030954.22320-1-ming.lei@redhat.com>
 <10c8ed10-3c96-b73c-18d8-114773b1d675@acm.org>
 <20190401020036.GB30776@ming.t460p>
 <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
 <20190401025237.GE30776@ming.t460p>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <a6dc5d0e-8e51-0714-ac25-6cb6ab78fa18@oracle.com>
Date:   Mon, 1 Apr 2019 13:05:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190401025237.GE30776@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9213 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010037
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/1/19 10:52 AM, Ming Lei wrote:
> On Sun, Mar 31, 2019 at 07:39:17PM -0700, Bart Van Assche wrote:
>> On 3/31/19 7:00 PM, Ming Lei wrote:
>>> On Sun, Mar 31, 2019 at 08:27:35AM -0700, Bart Van Assche wrote:
>>>> I'm not sure the approach of this patch series is really the direction we
>>>> should pursue. There are many block driver that free resources immediately
>>>
>>> Please see scsi_run_queue(), and the queue refcount is always held
>>> before run queue.
>>
>> That's not correct. There is no guarantee that q->q_usage_counter > 0 when
>> scsi_run_queue() is called from inside scsi_requeue_run_queue().
> 
> We don't need the guarantee of 'q->q_usage_counter > 0', I mean the
> queue's kobj reference counter.
> 
> What we need is to allow run queue to work correctly after queue is frozen
> or cleaned up.
> 
>>
>>>> I'd like to avoid having to modify all block drivers that free resources
>>>> immediately after blk_cleanup_queue() has returned. Have you considered to
>>>> modify blk_mq_run_hw_queues() such that it becomes safe to call that
>>>> function while blk_cleanup_queue() is in progress, e.g. by inserting a
>>>> percpu_ref_tryget_live(&q->q_usage_counter) /
>>>> percpu_ref_put(&q->q_usage_counter) pair?
>>>
>>> It can't work because blk_mq_run_hw_queues may happen after
>>> percpu_ref_exit() is done.
>>>
>>> However, if we move percpu_ref_exit() into queue's release handler, we
>>> don't need to grab q->q_usage_counter any more in blk_mq_run_hw_queues(),
>>> and we still have to free hw queue resources in queue's release handler,
>>> that is exactly what this patchset is doing.
>>>
>>> In short, getting q->q_usage_counter doesn't make a difference on this
>>> issue.
>>
>> percpu_ref_tryget_live() fails if a per-cpu counter is in the "dead" state.
>> percpu_ref_kill() changes the state of a per-cpu counter to the "dead"
>> state. blk_freeze_queue_start() calls percpu_ref_kill(). blk_cleanup_queue()
>> already calls blk_set_queue_dying() and that last function calls
>> blk_freeze_queue_start(). So I think that what you wrote is not correct and
>> that inserting a percpu_ref_tryget_live()/percpu_ref_put() pair in
>> blk_mq_run_hw_queues() or blk_mq_run_hw_queue() would make a difference and
>> also that moving the percpu_ref_exit() call into blk_release_queue() makes
>> sense.
> 
> If percpu_ref_exit() is moved to blk_release_queue(), we still need to
> move freeing of hw queue's resource into blk_release_queue() like what
> the patchset is doing.

Hi Ming,

Would you mind help explain why we still need to move freeing of hw queue's
resource into blk_release_queue() like what the patchset is doing?

Let's assume there is no deadlock when percpu_ref_tryget_live() is used,
blk_mq_run_hw_queues() would not be able to move forward as __PERCPU_REF_DEAD is
already set. Why we still need to move freeing of hw queue's resource into
blk_release_queue()?

Thank you very much!

Dongli Zhang

> 
> Then we don't need to get/put q_usage_counter in blk_mq_run_hw_queues() any more,
> do we?
> 
> 
> Thanks,
> Ming
> 

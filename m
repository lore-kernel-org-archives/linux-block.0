Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA4CC43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 03:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7881A20870
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 03:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j+fsEwRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbfDADct (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:32:49 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53596 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731658AbfDADcs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 23:32:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x313U5KA026855;
        Mon, 1 Apr 2019 03:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=2+VLmE5K4iir9As9ExLDJgWhHgoPOJyYNJWFS+YLVMQ=;
 b=j+fsEwRSS4OlsoCQmWUoCCAuPVmC7YQ11yM1adFmcVXSQ8hZ2yBNvy91boey0DJWegWZ
 4uErBE41pzOYORi0IX/HiWlRaRsxNLn0e8dYafg6o498lsA3bG2wfPd3pLxGFTjvTgj0
 Anq6/lW/Ca4Ttggth6mS//Aamz6APBvOFMnSYmclSN2EhRjSCb7BWx5Vp4989IA8tq2t
 gg0V6ngDjdqrs2TzaWAlRU2e82AA+smgDq7GFV38jVfrDWXPkWuhvXtTv7p2bLSPRrnm
 XBqOfv9pYNjCzbv0MV+6F/qNaOOvtDiCMQkual26f+NdQQdSVJva67VMmnkNai6LZqfr 5A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2rhwycvhdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 03:32:37 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x313Wbui008428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 03:32:37 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x313WZA3008927;
        Mon, 1 Apr 2019 03:32:35 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 31 Mar 2019 20:32:35 -0700
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
To:     Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
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
 <20190401032716.GF30776@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <b3eb2a1a-60bc-c08a-3f7a-1b7ec62a7254@oracle.com>
Date:   Mon, 1 Apr 2019 11:32:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401032716.GF30776@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9213 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010024
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/1/19 11:27 AM, Ming Lei wrote:
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
> This way is easy to cause deadlock!!!
> 
> If percpu_ref_tryget_live() is called in the entry of blk_mq_run_hw_queues(), 
> at the same time, blk_freeze_queue_start() is called, then percpu_ref_tryget_live()
> will fail, and run queue can't move on, then blk_mq_freeze_queue_wait() will wait
> forever.
> 

percpu_ref_tryget would be better to get pending requests to be issued when queue is frozen.

Thanks
Jianchao

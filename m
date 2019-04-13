Return-Path: <SRS0=i+2c=SP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFF5C10F0E
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 00:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE522084E
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 00:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GJNXk1n8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfDMAhJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Apr 2019 20:37:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42480 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfDMAhJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Apr 2019 20:37:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3D0Y7ic087176;
        Sat, 13 Apr 2019 00:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=kRNQCwM8FpZHxwe8/9ezNk8fldWVvnUDKJOkQ9SWaoM=;
 b=GJNXk1n8wFe5Wobm9wPHvnCw2jsnu/GB9nof231kdxyfwd0drOI4TQum1KksQjL/FumQ
 9HTdfEuaev0nd3DUEUCQpaVmT8XB1DLSE2M0XDzVk78GxkHsyppeGtwMh2y2rkqLHFTO
 v6rcyGH+6jTdI1/KrT+A13thfJ5OR+ftazImL+M1e9qHHRGCNlX4g9s5yEGF0ICSpd6Z
 OT0tSv7OuqxwemsHvvig+RFSyPk1G8wFv7FWcBnjKgrhfnPhKmTzaJLU+EmHMwtVy430
 MhUuvC6tVxJmCjKRrWQ9rETolRipdushibBVm2+Mbd2WKKI9Vfn1Qlz2wpv9Zm7CLgzh 8g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2ru59cr09m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Apr 2019 00:37:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3D0a1QW072693;
        Sat, 13 Apr 2019 00:37:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2rtyj2v5dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Apr 2019 00:37:02 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3D0b1kM024131;
        Sat, 13 Apr 2019 00:37:01 GMT
Received: from [192.168.1.12] (/180.165.90.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Apr 2019 17:37:01 -0700
Subject: Re: [RESEND PATCH] blk-mq: fix hang caused by freeze/unfreeze
 sequence
To:     Jinpu Wang <jinpuwang@gmail.com>, r.peniaev@gmail.com
Cc:     linux-block@vger.kernel.org, shirley.ma@oracle.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190409090828.16282-1-bob.liu@oracle.com>
 <CAD9gYJKYu15b7ZuAvud-BzG5fRP=B33yPJuEq84nsN_8y3EC1Q@mail.gmail.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <5ba280ed-b4f8-dfe0-16ea-1a10b0de7eb4@oracle.com>
Date:   Sat, 13 Apr 2019 08:36:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAD9gYJKYu15b7ZuAvud-BzG5fRP=B33yPJuEq84nsN_8y3EC1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9225 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904130002
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9225 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904130002
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/9/19 5:29 PM, Jinpu Wang wrote:
> Bob Liu <bob.liu@oracle.com> 于2019年4月9日周二 上午11:11写道：
>>
>> This patch was proposed by Roman Pen[3] years ago.
>> Recently we hit a bug which is likely caused by the same reason,so rebased his
>> fix to v5.1 and resend.
>> Below is almost copied from that patch[3].
>>
>> ------
>> Long time ago there was a similar fix proposed by Akinobu Mita[1],
>> but it seems that time everyone decided to fix this subtle race in
>> percpu-refcount and Tejun Heo[2] did an attempt (as I can see that
>> patchset was not applied).
>>
>> The following is a description of a hang in blk_mq_freeze_queue_wait() -
>> same fix but a bug from another angle.
>>
>> The hang happens on attempt to freeze a queue while another task does
>> queue unfreeze.
>>
>> The root cause is an incorrect sequence of percpu_ref_reinit() and
>> percpu_ref_kill() and as a result those two can be swapped:
>>
>>  CPU#0               CPU#1
>>  ----------------    -----------------
>>  percpu_ref_kill()
>>
>>                      percpu_ref_kill() << atomic reference does
>>  percpu_ref_reinit()                   << not guarantee the order
>>
>>                      blk_mq_freeze_queue_wait() << HANG HERE
>>
>>                      percpu_ref_reinit()
>>
>> Firstly this wrong sequence raises two kernel warnings:
>>
>>   1st. WARNING at lib/percpu-recount.c:309
>>        percpu_ref_kill_and_confirm called more than once
>>
>>   2nd. WARNING at lib/percpu-refcount.c:331
>>
>> But the most unpleasant effect is a hang of a blk_mq_freeze_queue_wait(),
>> which waits for a zero of a q_usage_counter, which never happens
>> because percpu-ref was reinited (instead of being killed) and stays in
>> PERCPU state forever.
>>
>> The simplified sequence above can be reproduced on shared tags, when
>> queue A is going to die meanwhile another queue B is in init state and
>> is trying to freeze the queue A, which shares the same tags set:
>>
>>  CPU#0                           CPU#1
>>  ------------------------------- ------------------------------------
>>  q1 = blk_mq_init_queue(shared_tags)
>>
>>                                 q2 = blk_mq_init_queue(shared_tags):
>>                                   blk_mq_add_queue_tag_set(shared_tags):
>>                                     blk_mq_update_tag_set_depth(shared_tags):
>>                                       blk_mq_freeze_queue(q1)
>>  blk_cleanup_queue(q1)                 ...
>>    blk_mq_freeze_queue(q1)   <<<->>>   blk_mq_unfreeze_queue(q1)
>>
>> [1] Message id: 1443287365-4244-7-git-send-email-akinobu.mita@gmail.com
>> [2] Message id: 1443563240-29306-6-git-send-email-tj@kernel.org
>> [3] https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.kernel.org_patch_9268199_&d=DwIFaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=1ktT0U2YS_I8Zz2o-MS1YcCAzWZ6hFGtyTgvVMGM7gI&m=OcA07QqFechuCug2pqm_-JpGP_mOt0YouTXApdePMGw&s=VM_-8S5gkFo8zUjT5RoY0CkbxN6hQmTwVmslulwsFJM&e=
>>
>> Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
>> Signed-off-by: Bob Liu <bob.liu@oracle.com>
>> Cc: Akinobu Mita <akinobu.mita@gmail.com>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: linux-block@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>>
> 
> Replaced Roman's email address.
> 
> We at 1 & 1 IONOS (former ProfitBricks) have been carried this patch
> for some years,
> it has been running in production for some years too,

Nice to hear that!

> would be good to see it in upstream :)

Yes.
Could anyone have a review? Thanks!

> 
> Thanks,
> 
> Jack Wang
> Linux Kernel Developer @ 1 & 1 IONOS
> 


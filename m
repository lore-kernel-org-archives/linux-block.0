Return-Path: <SRS0=vbI/=SQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3E0C10F13
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 13:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7352148E
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 13:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dBYe7cHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfDNNKU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Apr 2019 09:10:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43876 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfDNNKU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Apr 2019 09:10:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3ED9XdH090767;
        Sun, 14 Apr 2019 13:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=s/vRKsZnbEF2PHEx3aLsv+Ea+RUVqcytRWZdLiC55kA=;
 b=dBYe7cHqwr3IWM3+VtfaNvutZSwwxKi5Nhgyv8xs0+AWJLdY6f4heSFeElyXS3bcaRE1
 Uy0AOUDcmWq/HQ4y6LtlUzrHvEku42YDMGiYdiOIWAfcSwGQpYnbvhsq/pX5PTHf2tia
 cQGZAgOn5JhhzZ6yQZRtIZJkhBdPcEucYQ4G6uwG6vXjd0QlJh5T8Z33vde7bX/wgaUU
 6MR6D4XkXJZbdz9UqJvv1qM2bKBlseUT2XpJ688avfzplhp7TNemtoDcWvp3YMKHG54E
 ToMfTRJBaxaS8z/Ejqln8oHVDyUhvWATtRkW1T1ClgGvzqkoVAfgHU8a2K2Bnz3weJTg LQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2ru59cu9jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Apr 2019 13:10:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3EDA5Ri052252;
        Sun, 14 Apr 2019 13:10:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2rv2tts247-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Apr 2019 13:10:07 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3ED9twE021557;
        Sun, 14 Apr 2019 13:09:55 GMT
Received: from [192.168.1.12] (/180.165.90.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 14 Apr 2019 13:09:55 +0000
Subject: Re: [RESEND PATCH] blk-mq: fix hang caused by freeze/unfreeze
 sequence
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Cc:     shirley.ma@oracle.com, martin.petersen@oracle.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
References: <20190409090828.16282-1-bob.liu@oracle.com>
 <0763cb5a-5598-69e3-e5ac-765989aab5b1@acm.org>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <9ca4314d-fe45-9b24-8ba0-44d80f790502@oracle.com>
Date:   Sun, 14 Apr 2019 21:09:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <0763cb5a-5598-69e3-e5ac-765989aab5b1@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9226 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904140098
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9226 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904140099
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/19 11:42 AM, Bart Van Assche wrote:
> On 4/9/19 2:08 AM, Bob Liu wrote:
>>  void blk_freeze_queue_start(struct request_queue *q)
>>  {
>> -	int freeze_depth;
>> -
>> -	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
>> -	if (freeze_depth == 1) {
>> +	mutex_lock(&q->mq_freeze_lock);
>> +	if (++q->mq_freeze_depth == 1) {
>>  		percpu_ref_kill(&q->q_usage_counter);
>> +		mutex_unlock(&q->mq_freeze_lock);
>>  		if (queue_is_mq(q))
>>  			blk_mq_run_hw_queues(q, false);
>> +	} else {
>> +		mutex_unlock(&q->mq_freeze_lock);
>>  	}
>>  }
> Have you considered to move the mutex_unlock() call to the end of the function
> such that there is only one mutex_unlock() call instead of two? In case you> would be worried about holding the mutex around the code that runs the queue,
> how about changing the blk_mq_run_hw_queues() call such that the queues are
> run async?
>
 
Yes, but this bug is difficult to reproduce. I'd prefer keep the change minimum.

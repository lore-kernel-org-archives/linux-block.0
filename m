Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDFCC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 06:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1597D223CB
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 06:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1zYs7PVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1597D223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeKPQWR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 11:22:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59616 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeKPQWR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 11:22:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAG60DE2031636;
        Fri, 16 Nov 2018 06:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=wL5oeS7dpj9woym8mr98sfm5kh/DgpQflB6f7xA6Jck=;
 b=1zYs7PVF1Z94XCfZUCkN/NQC6DDVKEKJqj6PyPut5DspfnR3EBpue+dLxK6x+zJCrEiH
 D9GhEU6n2a3O2kTgXIT+bXPNb1HoAisl0B306dd3WkaV/wR7b8+hrLI0s2WFD5eCtdNb
 Ii+OOwQ6PDDmupewp+q4vjtFnGrr1BhwG1D4y5G5h/gBIlguSZH2lWHg616npq4r/EVs
 LoPlKfRHf0lXoHihfTM1zi13qdmHVNAwQKfr6Mrd/Z/iCcMWpt5ykmwZtqYEcqgp9ROa
 Rc4+aiuQhboozub1Bz9bBHweWH1zbxzWsaBDwR5kPRpyQ1QKEJL+X6AOK+T4rNOuxbzB qg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nr7csddtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Nov 2018 06:10:54 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAG6AsI9012398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Nov 2018 06:10:54 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAG6ArgU008064;
        Fri, 16 Nov 2018 06:10:53 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Nov 2018 22:10:53 -0800
Subject: Re: [PATCH 1/2] blk-mq: not embed .mq_kobj and ctx->kobj into queue
 instance
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
References: <20181116032826.11901-1-ming.lei@redhat.com>
 <20181116032826.11901-2-ming.lei@redhat.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <64abb411-f4af-a169-e878-2119f7c792d5@oracle.com>
Date:   Fri, 16 Nov 2018 14:11:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116032826.11901-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9078 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811160054
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/16/18 11:28 AM, Ming Lei wrote:
...
>  
> +struct blk_mq_kobj {
> +	struct kobject kobj;
> +};
> +
>  static void blk_mq_sysfs_release(struct kobject *kobj)
>  {
> +	struct blk_mq_kobj *mq_kobj = container_of(kobj, struct blk_mq_kobj,
> +						   kobj);
> +	kfree(mq_kobj);
> +}
> +
...
>  
> -void blk_mq_sysfs_init(struct request_queue *q)
> +int blk_mq_sysfs_init(struct request_queue *q)
>  {
>  	struct blk_mq_ctx *ctx;
>  	int cpu;
> +	struct blk_mq_kobj *mq_kobj;
> +
> +	mq_kobj = kzalloc(sizeof(struct blk_mq_kobj), GFP_KERNEL);
> +	if (!mq_kobj)
> +		return -ENOMEM;
>  
> -	kobject_init(&q->mq_kobj, &blk_mq_ktype);
> +	kobject_init(&mq_kobj->kobj, &blk_mq_ktype);
>  
>  	for_each_possible_cpu(cpu) {
> -		ctx = per_cpu_ptr(q->queue_ctx, cpu);
> +		ctx = kzalloc_node(sizeof(*ctx), GFP_KERNEL, cpu_to_node(cpu));
> +		if (!ctx)
> +			goto fail;
> +		*per_cpu_ptr(q->queue_ctx, cpu) = ctx;
>  		kobject_init(&ctx->kobj, &blk_mq_ctx_ktype);
>  	}
> +	q->mq_kobj = &mq_kobj->kobj;
> +	return 0;
> +
> + fail:
> +	for_each_possible_cpu(cpu) {
> +		ctx = *per_cpu_ptr(q->queue_ctx, cpu);
> +		if (ctx)
> +			kobject_put(&ctx->kobj);
> +	}
> +	kobject_put(&mq_kobj->kobj);
> +	return -ENOMEM;
>  }


blk_mq_kobj looks meaningless, why do we need it, or do I miss something ?
And maybe we should allocate ctx in blk_mq_init_allocated_queue.

Thanks
Jianchao


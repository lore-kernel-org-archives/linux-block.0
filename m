Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AFEC43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABDC2192B
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 02:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2kkm5nhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfBOCzj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:55:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57910 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfBOCzi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 21:55:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1F2rlV4174819;
        Fri, 15 Feb 2019 02:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=c0ywC1BLmSCAMyYZeF46+/4C7cTaAeowLZ7jWuhCQ7Y=;
 b=2kkm5nhJD8anYHGPWpUPdde4RelelFLj2WTAXzQnmE0loYbxPdtCQLvAE7LB1kqwjWeM
 eH9wBBRPAPZynsNfjM6midjR+k43zxD4LdMkMrjhxz31k0kswiZn6uhMuDlHgY1fj18K
 0fRIaJk6I9hZxx38a1CoTCzUZu5MC82DJfIPnKZjXx8kwHlV7S3BfLD+GpiRU6Qb0enw
 BlL8qNX1/o6D7b9xGbcun9XZHi09Q+i0Od7KBAZ4u6RZ/10YR4A3K4SLJLBusuAlUZCD
 FPFBVGp0EAt16pZuy0FZESGsIZFRtRqCA10xgB+F+D4/aHGSAzqjwCw4XlvhQfSq0WhU 6w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qhrekucs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 02:55:32 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1F2tVUD027420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 02:55:32 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1F2tVlc012029;
        Fri, 15 Feb 2019 02:55:31 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Feb 2019 18:55:31 -0800
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1545261885.185366.488.camel@acm.org>
 <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com>
 <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
 <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk>
 <1545328865.185366.508.camel@acm.org>
 <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk>
 <b9c3bd7c-9e82-7300-d525-0bd72ed66f66@kernel.dk>
 <1545339362.185366.511.camel@acm.org>
 <e7d6d857-b20a-245c-c6c7-fb9b110215e9@kernel.dk>
 <1545340987.185366.515.camel@acm.org>
 <120bb59a-af93-7d8c-9afc-7087973632bf@kernel.dk>
 <1545341470.185366.519.camel@acm.org>
 <61515137-0565-e3b7-e6de-554af7d49753@kernel.dk>
 <1545342043.185366.523.camel@acm.org>
 <60b4819c-4c19-a4e3-41f3-e21b0544c9a4@kernel.dk>
 <68c73daa-10e7-29da-b890-bf167ec164c2@kernel.dk>
 <1545344398.185366.531.camel@acm.org>
 <1864f5b8-cf64-a406-a3e0-9f5124ff95b5@kernel.dk>
 <a04dee3c-f355-4d28-caa4-21c7265ccae4@kernel.dk>
 <5869f2ed-dc65-135f-f12f-c14a1184125e@kernel.dk>
 <71fb9eff-43eb-24aa-fb67-be56a3a97983@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <215bfcfd-e290-7017-76b0-13702a32628b@oracle.com>
Date:   Fri, 15 Feb 2019 10:57:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <71fb9eff-43eb-24aa-fb67-be56a3a97983@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9167 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150019
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/21/18 6:50 AM, Jens Axboe wrote:
...
> @@ -228,13 +228,15 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>  
>  	if (!reserved)
>  		bitnr += tags->nr_reserved_tags;
> -	rq = tags->rqs[bitnr];
> +	if (tags->rqs[bitnr].queue != hctx->queue)
> +		return true;
>  
>  	/*
>  	 * We can hit rq == NULL here, because the tagging functions
>  	 * test and set the bit before assigning ->rqs[].
>  	 */
> -	if (rq && rq->q == hctx->queue)
> +	rq = tags->rqs[bitnr].rq;
> +	if (rq)
>  		return iter_data->fn(hctx, rq, iter_data->data, reserved);
>  	return true;
>  }
> @@ -263,7 +265,9 @@ static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
>  		.reserved = reserved,
>  	};
>  
> +	rcu_read_lock();
>  	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
> +	rcu_read_unlock();
>  }
>  
>  struct bt_tags_iter_data {
...
> @@ -2038,15 +2071,30 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>  		}
>  	}

Just checking request_queue match in bt_iter seems not enough.
The blk_mq_free_rqs could be invoked by switching io scheduler.
At the moment, request_queue could match. Maybe we still need to clear the
associated tags->rqs[] entries.

With cleaning the associated tags->rqs[] entries and synchronize_rcu after that,
bt_iter would only see some stable request with idle state but not a freed one.


Thanks
Jianchao

>  
> -	while (!list_empty(&tags->page_list)) {
> -		page = list_first_entry(&tags->page_list, struct page, lru);
> -		list_del_init(&page->lru);
> +	if (list_empty(&tags->page_list))
> +		return;
> +
> +	rpl = kmalloc(sizeof(*rpl), GFP_NOIO);
> +	if (rpl) {
> +		INIT_LIST_HEAD(&rpl->list);
> +		list_splice_init(&tags->page_list, &rpl->list);
> +
> +		/* Punt to RCU free, so we don't race with tag iteration */
> +		INIT_RCU_WORK(&rpl->rcu_work, blk_mq_rcu_free_pages);
> +		rpl->on_stack = false;
> +		queue_rcu_work(system_wq, &rpl->rcu_work);
> +	} else {


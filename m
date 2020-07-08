Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5625AC433E0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 14:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C7A20720
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 14:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgGHOGq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:06:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2443 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729468AbgGHOGq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Jul 2020 10:06:46 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id BD8F47FBA4FCE7FBE20F;
        Wed,  8 Jul 2020 15:06:44 +0100 (IST)
Received: from [127.0.0.1] (10.210.171.111) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 8 Jul 2020
 15:06:44 +0100
Subject: Re: [PATCH V2] blk-mq: streamline handling of q->mq_ops->queue_rq
 result
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20200701135857.2445459-1-ming.lei@redhat.com>
 <20200708122749.GA3340386@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <90d57d37-6da9-cae4-55b0-264c3dd885b0@huawei.com>
Date:   Wed, 8 Jul 2020 15:05:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200708122749.GA3340386@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.111]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/07/2020 13:27, Ming Lei wrote:
> k;
> -		} else if (ret == BLK_STS_ZONE_RESOURCE) {
> +		case BLK_STS_RESOURCE:
> +		case BLK_STS_DEV_RESOURCE:
> +			blk_mq_handle_dev_resource(rq, list);
> +			goto out;
> +		case BLK_STS_ZONE_RESOURCE:
>   			/*
>   			 * Move the request to zone_list and keep going through
>   			 * the dispatch list to find more requests the drive can

question not on this patch specifically: is this supposed to be 
"driver", and not "drive"? "driver" is mentioned earlier in the function

>   			 * accept.
>   			 */
>   			blk_mq_handle_zone_resource(rq, &zone_list);
> -			if (list_empty(list))
> -				break;
> -			continue;
> -		}
> -


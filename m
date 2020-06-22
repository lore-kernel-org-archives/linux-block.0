Return-Path: <SRS0=vyV1=AD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BFAC433DF
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 03:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13062168B
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 03:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgFVD0E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:26:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbgFVD0E (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jun 2020 23:26:04 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9449AD0E39D143FD9445;
        Mon, 22 Jun 2020 11:26:01 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.138) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 22 Jun 2020
 11:25:54 +0800
Subject: Re: [PATCH v2] nbd: Fix memory leak in nbd_add_socket
To:     Markus Elfring <Markus.Elfring@web.de>,
        <linux-block@vger.kernel.org>
CC:     <nbd@other.debian.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        "Navid Emamdoost" <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <mccamant@cs.umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        Yi Zhang <yi.zhang@huawei.com>
References: <b55f8af2-b20c-214f-90f0-9b6efcb7273c@web.de>
From:   "Zhengbin (OSKernel)" <zhengbin13@huawei.com>
Message-ID: <db17d022-a53a-3781-63d4-c38d5cf5b1e4@huawei.com>
Date:   Mon, 22 Jun 2020 11:25:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <b55f8af2-b20c-214f-90f0-9b6efcb7273c@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.166.215.138]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2020/6/20 20:05, Markus Elfring wrote:
>> If we add first socket to nbd, config->socks is malloced but
>> num_connections does not update(nsock's allocation fail), the memory
>> is leaked. Cause in later nbd_config_put(), will only free config->socks
>> when num_connections is not 0.
>>
>> Let nsock's allocation first to avoid this.
> I suggest to improve this change description.
> Can an other wording variant be nicer?

em, how about this?


When adding first socket to nbd, if nsock's allocation fails, config->socks

is malloced but num_connections does not update, memory leak will 
occur(Function

nbd_config_put will only free config->socks when num_connections is not 0).

>
>
> …
>> +++ b/drivers/block/nbd.c
>> @@ -1037,21 +1037,22 @@  static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
>>   		return -EBUSY;
>>   	}
>>
>> +	nsock = kzalloc(sizeof(struct nbd_sock), GFP_KERNEL);
> Please use the following code variant.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=4333a9b0b67bb4e8bcd91bdd80da80b0ec151162#n854
>
> +	nsock = kzalloc(sizeof(*nsock), GFP_KERNEL);
>
>
> …
>>   	if (!socks) {
>>   		sockfd_put(sock);
>> +		kfree(nsock);
>>   		return -ENOMEM;
>>   	}
> Please take another software design possibility into account.
>
>   	if (!socks) {
> -		sockfd_put(sock);
> -		return -ENOMEM;
> +		kfree(nsock);
> +		goto put_socket;
>   	}
>
>
> Regards,
> Markus
>
> .
>


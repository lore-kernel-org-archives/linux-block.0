Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBDFC433FF
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 03:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9234A2063F
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 03:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfHODNW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Aug 2019 23:13:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfHODNW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Aug 2019 23:13:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05BC74628B;
        Thu, 15 Aug 2019 03:13:22 +0000 (UTC)
Received: from [10.10.120.60] (ovpn-120-60.rdu2.redhat.com [10.10.120.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E90D1001B02;
        Thu, 15 Aug 2019 03:13:21 +0000 (UTC)
Subject: Re: [PATCH] nbd: add a missed nbd_config_put() in nbd_xmit_timeout()
To:     "sunke (E)" <sunke32@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <1565613086-13776-1-git-send-email-sunke32@huawei.com>
 <05b3cd4a-d2c1-5ad7-7a39-64bac470032a@huawei.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D54CDD0.1010701@redhat.com>
Date:   Wed, 14 Aug 2019 22:13:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <05b3cd4a-d2c1-5ad7-7a39-64bac470032a@huawei.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 15 Aug 2019 03:13:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Josef had ackd my patch for the same thing here:

https://www.spinics.net/lists/linux-block/msg43800.html

so maybe Jens will pick that up with the rest of the set Josef had acked:

https://www.spinics.net/lists/linux-block/msg43809.html

to make it easier.

On 08/14/2019 08:27 PM, sunke (E) wrote:
> ping
> 
> ÔÚ 2019/8/12 20:31, Sun Ke Ð´µÀ:
>> When try to get the lock failed, before return, execute the
>> nbd_config_put() to decrease the nbd->config_refs.
>>
>> If the nbd->config_refs is added but not decreased. Then will not
>> execute nbd_clear_sock() in nbd_config_put(). bd->task_setup will
>> not be cleared away. Finally, print"Device being setup by another
>> task" in nbd_add_sock() and nbd device can not be reused.
>>
>> Fixes: 8f3ea35929a0 ("nbd: handle unexpected replies better")
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>>   drivers/block/nbd.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index e21d2de..a69a90a 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -357,8 +357,10 @@ static enum blk_eh_timer_return
>> nbd_xmit_timeout(struct request *req,
>>       }
>>       config = nbd->config;
>>   -    if (!mutex_trylock(&cmd->lock))
>> +    if (!mutex_trylock(&cmd->lock)) {
>> +        nbd_config_put(nbd);
>>           return BLK_EH_RESET_TIMER;
>> +    }
>>         if (config->num_connections > 1) {
>>           dev_err_ratelimited(nbd_to_dev(nbd),
>>
> 


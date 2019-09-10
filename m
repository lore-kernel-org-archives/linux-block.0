Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099EBC49ED7
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 23:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A862084C
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 23:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfIJX60 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 19:58:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfIJX6Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 19:58:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F96E18CB91F;
        Tue, 10 Sep 2019 23:58:25 +0000 (UTC)
Received: from [10.72.12.79] (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC10D19C6A;
        Tue, 10 Sep 2019 23:58:23 +0000 (UTC)
Subject: Re: [PATCH] nbd: remove the duplicated code
To:     Mike Christie <mchristi@redhat.com>, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20190910063608.10081-1-xiubli@redhat.com>
 <5D77C7C4.9000306@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <62fb6a4d-b648-c8bb-e19d-d5f642869b92@redhat.com>
Date:   Wed, 11 Sep 2019 07:58:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5D77C7C4.9000306@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Tue, 10 Sep 2019 23:58:25 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/9/10 23:56, Mike Christie wrote:
> On 09/10/2019 01:36 AM, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> The followed code will do the same check, and this part is redandant.
>>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   drivers/block/nbd.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 478aa86fc1f2..8c10ab51a086 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -1046,9 +1046,6 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
>>   	for (i = 0; i < config->num_connections; i++) {
>>   		struct nbd_sock *nsock = config->socks[i];
>>   
>> -		if (!nsock->dead)
>> -			continue;
>> -
> Was this check to used to speed up reconnects? For example, if a send
> was stuck waiting on socket memory to free up in the network layer, then
> the above check would allow us to skip past those sockets without having
> to wait on the socket that was trying to send.
>
Yeah, in this case it really could help a little bit. Or maybe in the 
network layer when allocating new memories but it needs to do the memory 
reclaim, which will be stuck for a long time ?

Thanks
BRs
Xiubo



>
>>   		mutex_lock(&nsock->tx_lock);
>>   		if (!nsock->dead) {
>>   			mutex_unlock(&nsock->tx_lock);
>>


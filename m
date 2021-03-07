Return-Path: <SRS0=nGPF=IF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEC7C433E0
	for <linux-block@archiver.kernel.org>; Sun,  7 Mar 2021 02:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBCE6505D
	for <linux-block@archiver.kernel.org>; Sun,  7 Mar 2021 02:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhCGCoV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Mar 2021 21:44:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229957AbhCGCoP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 6 Mar 2021 21:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615085054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0WnSa3naWt2OVfaPh0CiLpNPziDQ+aRkwGpZTCk1hI=;
        b=E5VIhx3ZPhIWfbZKwwSvBhKGTA4ZOYMvgrvRVjDpYU79N9Ictigia+qCWWEkg9QKV7pUHp
        rNMblXxYkmx46OwX3kTK2FwuAy4rar1J84f53eCLarcq8dXogtQUXHzJqBf9R3LgzBWLf6
        l9zJ0fBBgEm3Re5McI69jjfiEQ7KAak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-UyPtakhFNjOWSh53soEQNw-1; Sat, 06 Mar 2021 21:44:13 -0500
X-MC-Unique: UyPtakhFNjOWSh53soEQNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FD2F1842142;
        Sun,  7 Mar 2021 02:44:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 706D91002382;
        Sun,  7 Mar 2021 02:44:10 +0000 (UTC)
Subject: Re: [PATCH blktests] tests/srp/rc, tests/nvmeof-mp/rc: add fio check
 to group_requires
To:     Bart Van Assche <bvanassche@acm.org>, osandov@fb.com
Cc:     linux-block@vger.kernel.org
References: <20210306071943.31194-1-yi.zhang@redhat.com>
 <7b0ec432-07e4-7f08-dd66-06e0bfd3ae56@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <20390115-41e8-3833-4dba-004ffce0fea3@redhat.com>
Date:   Sun, 7 Mar 2021 10:44:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7b0ec432-07e4-7f08-dd66-06e0bfd3ae56@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/7/21 2:14 AM, Bart Van Assche wrote:
> On 3/5/21 11:19 PM, Yi Zhang wrote:
>> Most of the srp and nvmeof-mp tests need fio, we need add fio
>> check before running the tests
>>
>> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
>> ---
>>   tests/nvmeof-mp/rc | 2 +-
>>   tests/srp/rc       | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
>> index ab7770f..4348b16 100755
>> --- a/tests/nvmeof-mp/rc
>> +++ b/tests/nvmeof-mp/rc
>> @@ -42,7 +42,7 @@ and multipathing has been enabled in the nvme_core kernel module"
>>   	)
>>   	_have_modules "${required_modules[@]}" || return
>>   
>> -	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof; do
>> +	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof fio; do
>>   		_have_program "$p" || return
>>   	done
>>   
>> diff --git a/tests/srp/rc b/tests/srp/rc
>> index 700cd71..2daf199 100755
>> --- a/tests/srp/rc
>> +++ b/tests/srp/rc
>> @@ -59,7 +59,7 @@ group_requires() {
>>   	)
>>   	_have_modules "${required_modules[@]}" || return
>>   
>> -	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof sg_reset; do
>> +	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof sg_reset fio; do
>>   		_have_program "$p" || return
>>   	done
> This patch looks good to me but unfortunately it conflicts with my patch
> with title "[PATCH blktests v2] rdma: Use rdma link instead of
> /sys/class/infiniband/*/parent" ...
Yeah, will send V2 based on yours, thanks.

> Bart.
>


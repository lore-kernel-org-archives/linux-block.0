Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D22C63798
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 14:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F741206FB
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 14:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQWiA6E8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbgKXOEj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729631AbgKXOEi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 09:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606226677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cu0ognzQ+lIIPUcy1xCELQQzHBoxXk/kFczCzP+30wE=;
        b=dQWiA6E82Y/In+8vT7fuYT7I2osQWHRED1dh6NgDPmRXRVWIlmlWimp5oHzvtBswxxWVjj
        cSFFOZQvlpDUA98Eo0EcQSDFhD1Rm8Se4cqmr69i2qH5U2/vC8hO9YxZgkRIlo7WlGChjR
        XKXklFyOZgUeIsXO+1+wSyYTNWJhG0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-Jh-8X8F1MXuYFRStvRtWdw-1; Tue, 24 Nov 2020 09:04:32 -0500
X-MC-Unique: Jh-8X8F1MXuYFRStvRtWdw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A70078145F3;
        Tue, 24 Nov 2020 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 669AD60BE5;
        Tue, 24 Nov 2020 14:04:29 +0000 (UTC)
Subject: Re: [PATCH blktests 2/5] tests/nvmeof-mp/rc: run nvmeof-mp tests if
 we set multipath=N
To:     Bart Van Assche <bvanassche@acm.org>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-3-yi.zhang@redhat.com>
 <324d227a-7ba2-309f-4298-ea787dfb76c0@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <04404583-9b7c-571d-7680-9b5253258268@redhat.com>
Date:   Tue, 24 Nov 2020 22:04:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <324d227a-7ba2-309f-4298-ea787dfb76c0@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/24/20 11:26 AM, Bart Van Assche wrote:
> On 11/23/20 5:04 PM, Yi Zhang wrote:
>> To enable it, just do bellow step before we run it:
>> $ echo "options nvme_core multipath=N" >/etc/modprobe.d/nvme.conf
>>
>> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
>> ---
>>   tests/nvmeof-mp/rc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
>> index d7a7c87..bc78f14 100755
>> --- a/tests/nvmeof-mp/rc
>> +++ b/tests/nvmeof-mp/rc
>> @@ -17,7 +17,7 @@ group_requires() {
>>   	# Since the nvmeof-mp tests are based on the dm-mpath driver, these
>>   	# tests are incompatible with the NVME_MULTIPATH kernel configuration
>>   	# option.
>> -	if _have_kernel_option NVME_MULTIPATH; then
>> +	if _have_kernel_option NVME_MULTIPATH && _have_module_param_value nvme_core multipath Y; then
>>   		SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config"
>>   		return
>>   	fi
> Please set different SKIP_REASON string for each case such that it
> remains easy for a blktests user to figure out why these tests have been
> skipped.
Do you mean something like this, could you add more detail here, thanks.

diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index d7a7c87..af700d9 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -16,9 +16,9 @@ group_requires() {

         # Since the nvmeof-mp tests are based on the dm-mpath driver, these
         # tests are incompatible with the NVME_MULTIPATH kernel 
configuration
-       # option.
-       if _have_kernel_option NVME_MULTIPATH; then
-               SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config"
+       # option and nvme_core: multipath set with Y.
+       if _have_kernel_option NVME_MULTIPATH && 
_have_module_param_value nvme_core multipath Y; then
+               SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in 
.config and nvme_core: multipath should be set with N"
                 return
         fi


> Thanks,
>
> Bart.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


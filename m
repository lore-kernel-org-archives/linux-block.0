Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304DBC56201
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 14:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2932076E
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 14:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIiBVRTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgKXOCG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:02:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729608AbgKXOBc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 09:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606226491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ybBUCTPpM+IE7e0jQVEPGYP8RejqHf99vC6SEQa19w=;
        b=AIiBVRTI0pyRYwxoRDHuKIp5kIpFbG9TNCk+WovCHMjh6ftrD/LBKEutuR5TMg5a98N54b
        2os8ZF81w6F50RvMVaz94KOAZBrFK/iOQ1c3J6wgEYxLZTAqkH2mRiWvrC6rk5xUTwNfV8
        w6KBNcLoA6mLC7Et4FiUvoiEerSRGvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-d_-hdKFmPs60TbRbsbMUzA-1; Tue, 24 Nov 2020 09:01:26 -0500
X-MC-Unique: d_-hdKFmPs60TbRbsbMUzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBFCE835B61;
        Tue, 24 Nov 2020 14:01:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E47B6087C;
        Tue, 24 Nov 2020 14:01:22 +0000 (UTC)
Subject: Re: [PATCH blktests 1/5] tests/srp/rc: update the ib_srpt module name
To:     Bart Van Assche <bvanassche@acm.org>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-2-yi.zhang@redhat.com>
 <7b6d00d7-2cf8-5a4b-f861-a7efe152843f@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <54f41dc8-41a5-e782-e135-dc7dc81209c0@redhat.com>
Date:   Tue, 24 Nov 2020 22:01:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7b6d00d7-2cf8-5a4b-f861-a7efe152843f@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/24/20 11:23 AM, Bart Van Assche wrote:
> On 11/23/20 5:04 PM, Yi Zhang wrote:
>> -	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko" "${opts[@]}" || return $?
>> +	insmod "$(ls /lib/modules/"$(uname -r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*)" "${opts[@]}" || return $?
> Is 'ls' needed here or is 'echo' sufficient?
Actually it doesn't work without ls
$ insmod "/lib/modules/"$(uname 
-r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*"
insmod: ERROR: could not load module 
/lib/modules/5.10.0-rc5/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*: No 
such file or directory

and it works with echo, I can change to echo if you prefer
$ insmod "$(echo /lib/modules/"$(uname 
-r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*)" "${opts[@]}" || 
return $?

> Thanks,
>
> Bart.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


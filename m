Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA96C56201
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 14:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFAB206FB
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 14:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fw4y/bgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgKXOHK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:07:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbgKXOHJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 09:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606226829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l20bhJycc9x14kM2+fmmOrl3TACGnUBVSRfcgPItEmk=;
        b=Fw4y/bgXtj2UcsXZ3jMw58UFeqLNOoJEoSvfVJvVhtPozI5EVGET5MPM15wLY0FFbueofu
        bcXLofI3CiC5zJMn3F8Ne/t4ssarBfnOF9SBZs7ZzaernWUv+Yxo84Z815YZc5T3kdUKAF
        34iHxcvVv5oXNPUx+Vgven67bAE+wLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-6gqhqp7wPkyd0_kAR_su4g-1; Tue, 24 Nov 2020 09:07:06 -0500
X-MC-Unique: 6gqhqp7wPkyd0_kAR_su4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 762DF106F6E9;
        Tue, 24 Nov 2020 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 655C619C44;
        Tue, 24 Nov 2020 14:07:03 +0000 (UTC)
Subject: Re: [PATCH blktests 4/5] common/rc: _have_iproute2 fix for "ip -V"
 change
To:     Bart Van Assche <bvanassche@acm.org>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-5-yi.zhang@redhat.com>
 <6f235fda-3d68-f0cc-f714-5c1daf67c28b@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <f4b82046-1ab4-5c44-c3d3-fbdfa17f927c@redhat.com>
Date:   Tue, 24 Nov 2020 22:07:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6f235fda-3d68-f0cc-f714-5c1daf67c28b@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/24/20 11:29 AM, Bart Van Assche wrote:
> On 11/23/20 5:04 PM, Yi Zhang wrote:
>> With bellow commit, the version will be updated base on the tag
>         ^^^^^^
>         below?
Thanks, will update it in the v2

>> fbef6555 replace SNAPSHOT with auto-generated version string
> Thanks,
>
> Bart.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>


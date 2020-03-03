Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DE9C3F2C6
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 22:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B537D20842
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 22:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U69QO1D2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgCCWHD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:07:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53859 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726004AbgCCWHD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Mar 2020 17:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583273222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9zgzfztGm5w03ag2NgBZIfBFhT+NxNTEZwCFUL0LthI=;
        b=U69QO1D2B0ubI9IBzMuGVPPRYh8LxqAe8gmx5Y+Ynqmks1UZQEeEFSzp+gfirgwhMNxk3T
        ftiahp/nO3FTRgeTlA9JA2jJ6aD3MZqMKh42bmh3y2Y7gW6EHqPUj0HN9wWoT1OVpptq+F
        QZDWFRSGvKFzKR0LwdEU0UGKgEjUhj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-c_zK1p7pMGiyUNZTJNA7KQ-1; Tue, 03 Mar 2020 17:06:58 -0500
X-MC-Unique: c_zK1p7pMGiyUNZTJNA7KQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3903118B5FA0;
        Tue,  3 Mar 2020 22:06:57 +0000 (UTC)
Received: from [10.10.123.90] (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63D5060C05;
        Tue,  3 Mar 2020 22:06:56 +0000 (UTC)
Subject: Re: [PATCH 2/2] nbd: requeue command if the soecket is changed
To:     Josef Bacik <josef@toxicpanda.com>, Hou Pu <houpu.main@gmail.com>,
        axboe@kernel.dk
References: <20200228064030.16780-1-houpu@bytedance.com>
 <20200228064030.16780-3-houpu@bytedance.com>
 <34249aaa-7f0e-d0f4-7c1a-28aee9bddaa0@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E5ED4FF.8020209@redhat.com>
Date:   Tue, 3 Mar 2020 16:06:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <34249aaa-7f0e-d0f4-7c1a-28aee9bddaa0@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/03/2020 03:13 PM, Josef Bacik wrote:
> On 2/28/20 1:40 AM, Hou Pu wrote:
>> In commit 2da22da5734 (nbd: fix zero cmd timeout handling v2),
>> it is allowed to reset timer when it fires if tag_set.timeout
>> is set to zero. If the server is shutdown and a new socket
>> is reconfigured, the request should be requeued to be processed by
>> new server instead of waiting for response from the old one.
>>
>> Signed-off-by: Hou Pu <houpu@bytedance.com>
> 
> I'm confused by this, if we get here we've already timed out and
> requeued once right?  Why do we need to requeue again?  Thanks,
> 

We may not have timed out already. If the tag_set.timeout=0, then the
block timer will fire every 30 seconds. This could be the first time the
timer has fired. If it has fired multiple times already then it still
would not have been requeued because the num_connections=1 code just
does a BLK_EH_RESET_TIMER when timeout=0 and does not have support for
detecting reconnects.

In this second patch if timeout=0 and num_connections=1 we restart the
command when the command timer fires and we detect a new connection
(nsock->cookie has incremented).

I was saying in the last patch, maybe waiting for reconnect is wrong.
Does a cmd timeout=0 mean to wait for a reconnect or in this patch
should we do:

1. if timeout=0, num_connections=1, and the cmd timer fires and the
conneciton is marked dead then requeue the command.
2. we then rely on the dead_conn_timeout code to decide how long to wait
for a reconnect.


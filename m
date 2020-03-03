Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10924C3F2C6
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 21:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C673720870
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 21:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgH0jKdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgCCVs4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:48:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29197 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725932AbgCCVsz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Mar 2020 16:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583272134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mJ5IJZxUXYJY2aPXcozMT1iXwsLhHQPCUda0tz0Kbwc=;
        b=MgH0jKdwsTTyQKvqZe4KIxO7GvCd5mrs7SRyfut7nQk9CawrdO3qH9VhsjIuPuVxAB4Loc
        2eqQoUGKdZcLepN3gnPDOQ8r7srtb9jwBq/pdSWcnT9se3QFJYjXWz+KbZE+LxCpW7KJd4
        7B+O1QjzeXCRvxfOYzT1n/RDN7XacOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-vq0HrggBPvGdSR5XfVhlYw-1; Tue, 03 Mar 2020 16:48:51 -0500
X-MC-Unique: vq0HrggBPvGdSR5XfVhlYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82FCC801E72;
        Tue,  3 Mar 2020 21:48:49 +0000 (UTC)
Received: from [10.10.123.90] (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85DAB8C09A;
        Tue,  3 Mar 2020 21:48:48 +0000 (UTC)
Subject: Re: [PATCH 1/2] nbd: enable replace socket if only one connection is
 configured
To:     Josef Bacik <josef@toxicpanda.com>, Hou Pu <houpu.main@gmail.com>,
        axboe@kernel.dk
References: <20200228064030.16780-1-houpu@bytedance.com>
 <20200228064030.16780-2-houpu@bytedance.com>
 <3b6ae210-f942-b74d-1e53-768c7e8c3675@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E5ED0BF.7030407@redhat.com>
Date:   Tue, 3 Mar 2020 15:48:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <3b6ae210-f942-b74d-1e53-768c7e8c3675@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/03/2020 03:12 PM, Josef Bacik wrote:
> On 2/28/20 1:40 AM, Hou Pu wrote:
>> Nbd server with multiple connections could be upgraded since
>> 560bc4b (nbd: handle dead connections). But if only one conncection
>> is configured, after we take down nbd server, all inflight IO
>> would finally timeout and return error. We could requeue them
>> like what we do with multiple connections and wait for new socket
>> in submit path.
>>
>> Signed-off-by: Hou Pu <houpu@bytedance.com>
>> ---
>>   drivers/block/nbd.c | 17 +++++++++--------
>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 78181908f0df..83070714888b 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -395,16 +395,19 @@ static enum blk_eh_timer_return
>> nbd_xmit_timeout(struct request *req,
>>       }
>>       config = nbd->config;
>>   -    if (config->num_connections > 1) {
>> +    if (config->num_connections > 1 ||
>> +        (config->num_connections == 1 && nbd->tag_set.timeout)) {
> 
> This is every connection, do you mean to couple this with
> dead_conn_timeout? Thanks,
> 

In

commit 2da22da573481cc4837e246d0eee4d518b3f715e
Author: Mike Christie <mchristi@redhat.com>
Date:   Tue Aug 13 11:39:52 2019 -0500

    nbd: fix zero cmd timeout handling v2

we can set tag_set.timeout=0 again.

So if timeout != 0 and num_connections = 1, we requeue here and let
nbd_handle_cmd->wait_for_reconnect decide to wait or fail the command if
dead_conn_timeout is not set.

If timeout = 0, then we give it more time because it might have just
been a slow server or connection. I think this behavior is wrong for the
case Hou is fixing. See comment in the next patch.


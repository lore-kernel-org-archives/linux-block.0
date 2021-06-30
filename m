Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C96AC11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 19:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86AB61474
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 19:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhF3TtI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 15:49:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37964 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhF3TtH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 15:49:07 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D05231FEED;
        Wed, 30 Jun 2021 19:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625082397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sOrVdN96EFG02Nt1Orskqd1mwnvmf43ZLsBmFEb7uA=;
        b=aS08WQOpPfT/HM02tdg+pYFp6j21Lx64JgCaLR91Vyhdzpfu0JT1DZVvY2BAITNdpkQDEU
        6GCY9wGy2ZHXo74NwqDn36XCLKLQgVE9a+k9BwsZMQYstsLhWopDL3OEG3r0NbYf8GFPxG
        bSRE7KJJUmsidokNf/tvxhcgdBFuMic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625082397;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sOrVdN96EFG02Nt1Orskqd1mwnvmf43ZLsBmFEb7uA=;
        b=TGY8ltgnR+psVd40iGsbS7vZeHXvNWUnRrN3rgHgw+eagngCNhrIzmXP917bZNXYvKwYmB
        MYlvLieXu6ubcICA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A977D118DD;
        Wed, 30 Jun 2021 19:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625082397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sOrVdN96EFG02Nt1Orskqd1mwnvmf43ZLsBmFEb7uA=;
        b=aS08WQOpPfT/HM02tdg+pYFp6j21Lx64JgCaLR91Vyhdzpfu0JT1DZVvY2BAITNdpkQDEU
        6GCY9wGy2ZHXo74NwqDn36XCLKLQgVE9a+k9BwsZMQYstsLhWopDL3OEG3r0NbYf8GFPxG
        bSRE7KJJUmsidokNf/tvxhcgdBFuMic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625082397;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/sOrVdN96EFG02Nt1Orskqd1mwnvmf43ZLsBmFEb7uA=;
        b=TGY8ltgnR+psVd40iGsbS7vZeHXvNWUnRrN3rgHgw+eagngCNhrIzmXP917bZNXYvKwYmB
        MYlvLieXu6ubcICA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id hFsnJhzK3GA1QwAALh3uQQ
        (envelope-from <hare@suse.de>); Wed, 30 Jun 2021 19:46:36 +0000
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
To:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de> <YNwug8n7qGL5uXfo@T590>
 <c1de513a-5477-9d1d-0ddc-24e9166cc717@suse.de> <YNw/DcxIIMeg/2VK@T590>
 <e106f9c4-35c3-b2da-cdd8-3c4dff8234d6@grimberg.me>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <89081624-fedd-aa94-1ba2-9a137708a1f1@suse.de>
Date:   Wed, 30 Jun 2021 21:46:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <e106f9c4-35c3-b2da-cdd8-3c4dff8234d6@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/21 8:59 PM, Sagi Grimberg wrote:
> 
>>>>> Shouldn't we rather modify the tagset to only refer to the current 
>>>>> online
>>>>> CPUs _only_, thereby never submit a connect request for hctx with only
>>>>> offline CPUs?
>>>>
>>>> Then you may setup very less io queues, and performance may suffer even
>>>> though lots of CPUs become online later.
>>>> ;
>>> Only if we stay with the reduced number of I/O queues. Which is not 
>>> what I'm
>>> proposing; I'd rather prefer to connect and disconnect queues from 
>>> the cpu
>>> hotplug handler. For starters we could even trigger a reset once the 
>>> first
>>> cpu within a hctx is onlined.
>>
>> Yeah, that need one big/complicated patchset, but not see any advantages
>> over this simple approach.
> 
> I tend to agree with Ming here.

Actually, Daniel and me came to a slightly different idea: use cpu 
hotplug notifier.
Thing is, blk-mq already has cpu hotplug notifier, which should ensure 
that no I/O is pending during cpu hotplug.
If we now add a nvme cpu hotplug notifier which essentially kicks off a 
reset once all cpu in a hctx are offline the reset logic will rearrange 
the queues to match the current cpu layout.
And when the cpus are getting onlined we'll do another reset.

Daniel is currently preparing a patch; let's see how it goes.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

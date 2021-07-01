Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D3FC11F64
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 08:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31EA76148E
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 08:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhGAIDC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 04:03:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59438 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhGAIDB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jul 2021 04:03:01 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BA3831FF83;
        Thu,  1 Jul 2021 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625126430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xu5YUbI3OC/pK+LofYl5biLJ3jiA/0IbxgNEllDpcrw=;
        b=SU3S6cAqZY/uad+f4m4Z/rrw3/eqMV0dHoKcOkWRvETFCy1CX+H1o0EgrRE368XOsTvXzg
        GDy0BjFni0n3P0KnRx+dwRiSAZ4vw7YsMeP4W5imhNTRUdNnHO+DiIRDHWkAI6RNYJAowX
        o/V+DNFgLuiFjG9z6d0ITUlVbGYAPHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625126430;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xu5YUbI3OC/pK+LofYl5biLJ3jiA/0IbxgNEllDpcrw=;
        b=XplvibhW/d0RhjgNllxiFUj0n9JyyInx5EQRCMY4z5E3IWo05J6JAtRaXwnRJvn/6XuQHZ
        Oz/u0YZGqvSlIxAA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A19D3118DD;
        Thu,  1 Jul 2021 08:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625126430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xu5YUbI3OC/pK+LofYl5biLJ3jiA/0IbxgNEllDpcrw=;
        b=SU3S6cAqZY/uad+f4m4Z/rrw3/eqMV0dHoKcOkWRvETFCy1CX+H1o0EgrRE368XOsTvXzg
        GDy0BjFni0n3P0KnRx+dwRiSAZ4vw7YsMeP4W5imhNTRUdNnHO+DiIRDHWkAI6RNYJAowX
        o/V+DNFgLuiFjG9z6d0ITUlVbGYAPHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625126430;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xu5YUbI3OC/pK+LofYl5biLJ3jiA/0IbxgNEllDpcrw=;
        b=XplvibhW/d0RhjgNllxiFUj0n9JyyInx5EQRCMY4z5E3IWo05J6JAtRaXwnRJvn/6XuQHZ
        Oz/u0YZGqvSlIxAA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id n9KjGxx23WCofAAALh3uQQ
        (envelope-from <hare@suse.de>); Thu, 01 Jul 2021 08:00:28 +0000
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de> <YNwug8n7qGL5uXfo@T590>
 <c1de513a-5477-9d1d-0ddc-24e9166cc717@suse.de> <YNw/DcxIIMeg/2VK@T590>
 <e106f9c4-35c3-b2da-cdd8-3c4dff8234d6@grimberg.me>
 <89081624-fedd-aa94-1ba2-9a137708a1f1@suse.de> <YN0FXrcwXfAwGU6w@T590>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c3a3a25b-a36b-e20d-6f7f-828f22650a30@suse.de>
Date:   Thu, 1 Jul 2021 10:00:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YN0FXrcwXfAwGU6w@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/21 1:59 AM, Ming Lei wrote:
> On Wed, Jun 30, 2021 at 09:46:35PM +0200, Hannes Reinecke wrote:
>> On 6/30/21 8:59 PM, Sagi Grimberg wrote:
>>>
>>>>>>> Shouldn't we rather modify the tagset to only refer to
>>>>>>> the current online
>>>>>>> CPUs _only_, thereby never submit a connect request for hctx with only
>>>>>>> offline CPUs?
>>>>>>
>>>>>> Then you may setup very less io queues, and performance may suffer even
>>>>>> though lots of CPUs become online later.
>>>>>> ;
>>>>> Only if we stay with the reduced number of I/O queues. Which is
>>>>> not what I'm
>>>>> proposing; I'd rather prefer to connect and disconnect queues
>>>>> from the cpu
>>>>> hotplug handler. For starters we could even trigger a reset once
>>>>> the first
>>>>> cpu within a hctx is onlined.
>>>>
>>>> Yeah, that need one big/complicated patchset, but not see any advantages
>>>> over this simple approach.
>>>
>>> I tend to agree with Ming here.
>>
>> Actually, Daniel and me came to a slightly different idea: use cpu hotplug
>> notifier.
>> Thing is, blk-mq already has cpu hotplug notifier, which should ensure that
>> no I/O is pending during cpu hotplug.
> 
> Why should we ensure that for non-managed irq?
> 

While not strictly necessary, it does align the hctx layout with the 
current CPU topology.
As such we won't have any 'stale' CPUs or queues in the hctx layout, and 
with that avoid any issues we'll be having due to inactive CPUs in the 
cpumask.

>> If we now add a nvme cpu hotplug notifier which essentially kicks off a
>> reset once all cpu in a hctx are offline the reset logic will rearrange the
>> queues to match the current cpu layout.
>> And when the cpus are getting onlined we'll do another reset.
>>
>> Daniel is currently preparing a patch; let's see how it goes.
> 
> What is the advantage of that big change over this simple way?
> 

With the simple way we might (and, as the results show, do) run the 
nvme_ctrl_reset() in parallel to CPU hotplug.
This leads to quite some complexity, and as we've seen is triggering 
quite some race conditions.

Hence I do think we need to synchronize nvme_ctrl_reset() with CPU 
hotplug, to ensure that the reset handler is completed before the cpu is 
completely torn down.

But synchronizing with nvme_ctrl_reset() means to issue a flush_work(); 
and if we do that we might as well go full circle and call 
nvme_ctrl_reset_sync(). And as this will rearrange the hctx to match the 
current CPU topology we don't need to fiddle with it in the hotplug 
handler, and can leave everything to nvme_ctrl_reset().

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

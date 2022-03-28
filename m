Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8109EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 28 Mar 2022 05:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiC1Fue (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Mar 2022 01:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiC1Fud (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Mar 2022 01:50:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC18E51583
        for <linux-block@vger.kernel.org>; Sun, 27 Mar 2022 22:48:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 59ADB1F381;
        Mon, 28 Mar 2022 05:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648446528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kawOGhKAao/Hc7VwVCSVymQvOtYx0Iz3hM7jJFcZ4h4=;
        b=rrc6IwwoENqpllrykplL5CAySsA3Nb9n3qppk/MCFeWkDSCvcZ3BUB1rhraluKra5h4XV2
        wKiPfB76OZKoLvzY9UqqiuzsyD+4576r83GZJkbu5ep2ThusZyKoBL7ICm5drfihr8zJjJ
        92x3t+q41oOCFPpB+v4k/hsJRlBVX1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648446528;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kawOGhKAao/Hc7VwVCSVymQvOtYx0Iz3hM7jJFcZ4h4=;
        b=4Hva7HYpwroLqB/2KbbOxab13lJe2nGhT8VEpJ3fO20TnbllP+7/VI4bcz299pjQmAbj8D
        uh8YI3Caa6O4zKAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DC5413A72;
        Mon, 28 Mar 2022 05:48:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vLRdCkBMQWIGVQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 28 Mar 2022 05:48:48 +0000
Message-ID: <f328815c-a68d-0d00-a8dd-5ed6ace491ce@suse.de>
Date:   Mon, 28 Mar 2022 07:48:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        linux-mm@kvack.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de> <YkCSVSk1SwvtABIW@T590>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <YkCSVSk1SwvtABIW@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/22 18:35, Ming Lei wrote:
> On Tue, Feb 22, 2022 at 07:57:27AM +0100, Hannes Reinecke wrote:
>> On 2/21/22 20:59, Gabriel Krisman Bertazi wrote:
>>> I'd like to discuss an interface to implement user space block devices,
>>> while avoiding local network NBD solutions.  There has been reiterated
>>> interest in the topic, both from researchers [1] and from the community,
>>> including a proposed session in LSFMM2018 [2] (though I don't think it
>>> happened).
>>>
>>> I've been working on top of the Google iblock implementation to find
>>> something upstreamable and would like to present my design and gather
>>> feedback on some points, in particular zero-copy and overall user space
>>> interface.
>>>
>>> The design I'm pending towards uses special fds opened by the driver to
>>> transfer data to/from the block driver, preferably through direct
>>> splicing as much as possible, to keep data only in kernel space.  This
>>> is because, in my use case, the driver usually only manipulates
>>> metadata, while data is forwarded directly through the network, or
>>> similar. It would be neat if we can leverage the existing
>>> splice/copy_file_range syscalls such that we don't ever need to bring
>>> disk data to user space, if we can avoid it.  I've also experimented
>>> with regular pipes, But I found no way around keeping a lot of pipes
>>> opened, one for each possible command 'slot'.
>>>
>>> [1] https://dl.acm.org/doi/10.1145/3456727.3463768
>>> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
>>>
>> Actually, I'd rather have something like an 'inverse io_uring', where an
>> application creates a memory region separated into several 'ring' for
>> submission and completion.
>> Then the kernel could write/map the incoming data onto the rings, and
>> application can read from there.
>> Maybe it'll be worthwhile to look at virtio here.
> 
> IMO it needn't 'inverse io_uring', the normal io_uring SQE/CQE model
> does cover this case, the userspace part can submit SQEs beforehand
> for getting notification of each incoming io request from kernel driver,
> then after one io request is queued to the driver, the driver can
> queue a CQE for the previous submitted SQE. Recent posted patch of
> IORING_OP_URING_CMD[1] is perfect for such purpose.
> 

Ah, cool idea.

> I have written one such userspace block driver recently, and [2] is the
> kernel part blk-mq driver(ubd driver), the userspace part is ubdsrv[3].
> Both the two parts look quite simple, but still in very early stage, so
> far only ubd-loop and ubd-null targets are implemented in [3]. Not only
> the io command communication channel is done via IORING_OP_URING_CMD, but
> also IO handling for ubd-loop is implemented via plain io_uring too.
> 
> It is basically working, for ubd-loop, not see regression in 'xfstests -g auto'
> on the ubd block device compared with same xfstests on underlying disk, and
> my simple performance test on VM shows the result isn't worse than kernel loop
> driver with dio, or even much better on some test situations.
> 
Neat. I'll have a look.

Thanks for doing that!

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

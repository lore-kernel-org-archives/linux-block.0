Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A319FC433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 06:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiCOGq0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 02:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiCOGqZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 02:46:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107422F01E
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 23:45:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B92EA21906;
        Tue, 15 Mar 2022 06:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647326712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLDEwHTq6OeDD06wchGhc+SIAoEHQdz8GdEdmP1IkzM=;
        b=tt33XCVIzBf+GGITJDwHeen3c6g5SaGVLdPNCDwRpdFhdl5fzcnMixpTG7YtrrbVW+0DVK
        2rHKQLkKIRcY97We4v4gjPAvYNh5z6h58jqWLHbFXcVuMlkANwuVOLGJCwvaoQ0QR/i6Bw
        an5pVoM1unqs1VvSux8TTwaef9Tkj9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647326712;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLDEwHTq6OeDD06wchGhc+SIAoEHQdz8GdEdmP1IkzM=;
        b=89jInKPWctZbuHhtwvIHqi6rEJwBo2YdXs7pghvODSG2LD1PbvhIene+qI6AwO/SdHChAW
        /ZpmW0mWiaXsCZCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E48613B4E;
        Tue, 15 Mar 2022 06:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JVxQIfg1MGJRPgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 15 Mar 2022 06:45:12 +0000
Message-ID: <af66086d-a6c2-3a44-d9fd-d20e9408266f@suse.de>
Date:   Tue, 15 Mar 2022 07:45:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <526a8360-d7d3-1211-087b-c86d5a68380b@oracle.com>
 <57af4fe0-9042-729a-18e9-839a5f0a84ac@suse.de>
 <49964bde-da7b-24be-19ae-9d14c72ce631@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <49964bde-da7b-24be-19ae-9d14c72ce631@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/22 18:04, Mike Christie wrote:
> On 3/3/22 1:09 AM, Hannes Reinecke wrote:
>> On 3/2/22 17:52, Mike Christie wrote:
>>> On 2/21/22 1:59 PM, Gabriel Krisman Bertazi wrote:
>>>> I'd like to discuss an interface to implement user space block devices,
>>>> while avoiding local network NBD solutions.  There has been reiterated
>>>
>>> Besides the tcmu approach, I've also worked on the local nbd based
>>> solution like here:
>>>
>>> https://urldefense.com/v3/__https://github.com/gluster/nbd-runner__;!!ACWV5N9M2RV99hQ!YY39rbV9MpaNUtr7ElzgcG1TyPznVEt1yppLwAGkq32-Fw9rQkqB6FzcaHiwIdgXp00K$
>>> Have you looked into a modern take that uses io_uring's socket features
>>> with the zero copy work that's being worked on for it? If so, what are
>>> the issues you have hit with that? Was it mostly issues with the zero
>>> copy part of it?
>>>
>>>
>> Problem is that we'd need an _inverse_ io_uring interface.
>> The current io_uring interface writes submission queue elements,
>> and waits for completion queue elements.
> 
> I'm not sure what you meant here.
> 
> io_uring can do recvs right? So userspace nbd would do
> IORING_OP_RECVMSG to wait for drivers/block/nbd.c to send userspace
> cmds via the local socket. Userspace nbd would do IORING_OP_SENDMSG
> to send drivers/block/nbd.c the cmd response.
> 
> drivers/block/nbd doesn't know/care what userspace did. It's just
> reading/writing from/to the socket.

I was talking about the internal layout of io_uring.
It sets up submission and completion rings, writes the command & data
into the submission rings, and waits for the corresponding completion
to show up on the completion rings.

A userspace block driver would need the inverse; waiting for submissions
to show up in the submission rings, and writing completions into the 
completion ring.

recvmsg feels awkward here as one would need to write a recvmsg op into 
the submission ring, get the completion, handle the I/O, write a sendmsg 
op, wait for the completion.
IE we would double the number of operations.

Sure it's doable, and admittedly doesn't need (much) modifications for 
io_uring. But still feels like a waste, and we certainly can't reach max 
performance with that setup.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

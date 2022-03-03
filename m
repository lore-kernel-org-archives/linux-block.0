Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7216C433EF
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 07:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiCCHUD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 02:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiCCHUC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 02:20:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA18155C11
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 23:19:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F93C219A5;
        Thu,  3 Mar 2022 07:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646291948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y0dMBKu3FX21vIZiLV6qJK/E3Wt3JOOy7pCetSXmUdM=;
        b=cVMflKgWS2mhhWXpwf7upC0FaZuXO4OfiYFVK3INAYTzUnB3/zjPufmzjlWLtHFJvn3uQB
        lbkOJNq/y2PzYU/LDRammL1jBxSnvKzdsZC7YoXdVFLEQjvVi+2kD2ac7K/OAd8rEaDbIT
        o7TiV1Y8YjTNIY82uou9mv4FAWH5Zb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646291948;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y0dMBKu3FX21vIZiLV6qJK/E3Wt3JOOy7pCetSXmUdM=;
        b=EGthssoJU6k8QHvHWf7EZzP/cMEkyOn12o+JtGhR8x2/iJEKv/lzdSOEKGupRAnUJJNw6F
        wNPRWFGRhPv0PvDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5125913AB4;
        Thu,  3 Mar 2022 07:19:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r+isEuxrIGLhMgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 03 Mar 2022 07:19:08 +0000
Message-ID: <7f100042-20d0-f783-30d8-1108b43725a8@suse.de>
Date:   Thu, 3 Mar 2022 08:17:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de> <87tucgj6s7.fsf@collabora.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <87tucgj6s7.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/3/22 00:04, Gabriel Krisman Bertazi wrote:
> Hannes Reinecke <hare@suse.de> writes:
> 
>> Actually, I'd rather have something like an 'inverse io_uring', where an
>> application creates a memory region separated into several 'ring' for
>> submission and completion.
>> Then the kernel could write/map the incoming data onto the rings, and
>> application can read from there.
>> Maybe it'll be worthwhile to look at virtio here.
> 
>>
>> But in either case, using fds or pipes for commands doesn't really
>> scale, as the number of fds is inherently limited. And using fds
>> restricts you to serial processing (as you can read only sequentially
>> from a fd); with mmap() you'll get a greater flexibility and the option
>> of parallel processing.
> 
> Hannes,
> 
> I'm not trying to push an fd implementation, and seems clear that
> io_uring is the right way to go.  But isn't fd virtually unlimited,
> as they can be extended up to procfs's file-max for a specific user?
> 
In principle, yes. But in practice there will _always_ be a limit (even 
if you raise the limit you _still_ have a limit), as essentially the 
number of files is the size of the fd array table.
So you can only have a very large number of fds, but not an infinite 
number of fds.

And experience with multipath-tools have taught us that you hit the fd 
limit far more often than you thought; we've seen installations where we 
had to increase the fd limit beyond 4096
(Mind you, multipath-tools is using only two fds per device).

So on those installations we'll be running out of fds pretty fast if we 
start using one fd per I/O.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

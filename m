Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB265C001DE
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 16:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjGUQhL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjGUQgV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 12:36:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23453A8C
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 09:35:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D51A91F7AB;
        Fri, 21 Jul 2023 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689957344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I8N8UPzdHsXt8zyD+0Iu4lzNtBkmFQ10QLkyHs69xaA=;
        b=07PFlsoE2qTfQ/8nL4pluvELLRPAuRcTiTjCUG5Br7M2xClmV5QndZz1QAg/Ul0a4Ts3EP
        Ph26liK1v3mzX3fdIVAhtb9gOe9DjXitTFt0TO00h8Xu1GMF+CKNGO0/Qht3+ryPFVvz+P
        EvqHxvYpax2NNSXsBDSHrsXhtmdcs70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689957344;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I8N8UPzdHsXt8zyD+0Iu4lzNtBkmFQ10QLkyHs69xaA=;
        b=onBiKn7tifUIK+Y8PXoV5Pf9M3c9bW0c4UCcEi6260TBqdkE8mVa0VOZAf8F/2tKDbIXH8
        Tz1CY8UO8swx44CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DEAC134BA;
        Fri, 21 Jul 2023 16:35:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WXHnIOCzumSiSQAAMHmgww
        (envelope-from <krisman@suse.de>); Fri, 21 Jul 2023 16:35:44 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        David Jeffery <djeffery@redhat.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] sbitmap: fix batching wakeup
Organization: SUSE
References: <20230721095715.232728-1-ming.lei@redhat.com>
Date:   Fri, 21 Jul 2023 12:35:43 -0400
In-Reply-To: <20230721095715.232728-1-ming.lei@redhat.com> (Ming Lei's message
        of "Fri, 21 Jul 2023 17:57:15 +0800")
Message-ID: <87jzut43z4.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming Lei <ming.lei@redhat.com> writes:

> From: David Jeffery <djeffery@redhat.com>
>
> Current code supposes that it is enough to provide forward progress by just
> waking up one wait queue after one completion batch is done.
>
> Unfortunately this way isn't enough, cause waiter can be added to
> wait queue just after it is woken up.
>
> Follows one example(64 depth, wake_batch is 8)
>
> 1) all 64 tags are active
>
> 2) in each wait queue, there is only one single waiter
>
> 3) each time one completion batch(8 completions) wakes up just one waiter in each wait
> queue, then immediately one new sleeper is added to this wait queue
>
> 4) after 64 completions, 8 waiters are wakeup, and there are still 8 waiters in each
> wait queue
>
> 5) after another 8 active tags are completed, only one waiter can be wakeup, and the other 7
> can't be waken up anymore.
>
> Turns out it isn't easy to fix this problem, so simply wakeup enough waiters for
> single batch.

yes, I think this makes sense. When working on this algorithm I remember
I considered it (thus wake_up_nr being ready), but ended up believing it
wasn't needed.  please take:

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

I wonder how likely it is to reach it.  Did you get a bug report?

Thanks,

-- 
Gabriel Krisman Bertazi

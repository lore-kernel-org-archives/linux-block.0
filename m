Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318FAC433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Dec 2021 19:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhLTTi0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhLTTiZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 14:38:25 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEB0C06173E
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 11:38:24 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id y16so14737662ioc.8
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 11:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EkArDJeCYv0Njtdx4aTXVLgHs6oe3qECOtCPjjJ9u9k=;
        b=ERlIz8DWPxRf4Ov6ICyoDn3BYJsHG/T+9YGqe6l6lFF1WrwKn4AyujKupEUzZ3VwRS
         34Tko/VtM56X5H+m/o5Epcyt6wyxSCjtrz3ckDftMVITdRkFwYL2e2DvKtu0aHUbFfij
         pcsyOkLasOS2tbQt8fEWCIGkJ37SfNh6QRlMHMfa1/PE1uu3qKUMy3KJO58wVx2xEetM
         51JqbVk0pXWWCo8QeFjJCkSEk4W6H2RTqEj0qLH10KeRwA3/YxO46IQ0EAj3EbhLVgsy
         JVRk2TrnOuK83a0LVKUTlpZF3uvZJIr6r5NmmEX+hZkCQUY/14eozz85PsPu69jnpQ+Y
         7TKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EkArDJeCYv0Njtdx4aTXVLgHs6oe3qECOtCPjjJ9u9k=;
        b=xvxyI7AfU10kiakXVoeRnD3aJTLZ7S0KJGOR+5qA/0EBtWAM3nhJ5WTc4ME2DpNzta
         pwiQ30si58dhiaTFo+jNLFILuPaWBsJETpRqzsoX2EWKy4iFFJ7XZVOmmHiGCKUMT1lb
         4VOAteMBDbQH1z6gzEeRTWWc0n70bgiZsFHUEM7Rajg8gsxbwVz1rRxsQny4Fw43HT6f
         h064tZZ8OBQckA6UjwivBkE3sQczCQMPonxF+c/z0TUDWkjRsYGxeaG0lJdTwcAlhCQh
         urOkEtF342hPmIcOLBNBGWGzDRMn1Acn5JpOgiLHzLxJ6d5xFj+9qZFN/2njAvAL2Kzz
         3Khw==
X-Gm-Message-State: AOAM532PTWnw4lIE3f1s9ktwGejDjC8QdmIoTndXCl+TSSCD+Hyve9YE
        6cwZ6fZyiemiZyYkJqsSnIDFjA==
X-Google-Smtp-Source: ABdhPJwAZ5teUso6Vx4YqlHG/mdWZAGrZc46rnxhyMCRmWTX0vVTebmuoPw0Dn6fKiJvKo/RQZjx/w==
X-Received: by 2002:a02:c9c8:: with SMTP id c8mr5173155jap.175.1640029103720;
        Mon, 20 Dec 2021 11:38:23 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v23sm9319460ioj.4.2021.12.20.11.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 11:38:23 -0800 (PST)
Subject: Re: [PATCH v5 1/1] blktrace: switch trace spinlock to a raw spinlock
To:     Wander Lairson Costa <wander@redhat.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20211220192827.38297-1-wander@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8340efc7-f922-fb8c-772c-de72cefe3470@kernel.dk>
Date:   Mon, 20 Dec 2021 12:38:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211220192827.38297-1-wander@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/21 12:28 PM, Wander Lairson Costa wrote:
> The running_trace_lock protects running_trace_list and is acquired
> within the tracepoint which implies disabled preemption. The spinlock_t
> typed lock can not be acquired with disabled preemption on PREEMPT_RT
> because it becomes a sleeping lock.
> The runtime of the tracepoint depends on the number of entries in
> running_trace_list and has no limit. The blk-tracer is considered debug
> code and higher latencies here are okay.

You didn't put a changelog in here. Was this one actually compiled? Was
it runtime tested?

-- 
Jens Axboe


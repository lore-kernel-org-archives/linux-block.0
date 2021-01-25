Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B33EC433E0
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 09:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC0B224B1
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 09:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbhAYJkz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 04:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbhAYJkW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 04:40:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381D2C06174A;
        Mon, 25 Jan 2021 01:29:10 -0800 (PST)
Date:   Mon, 25 Jan 2021 10:29:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611566948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jku6Tec7q+qisOnosheK7vPMPoB+SzWJoKjJCzgdLxg=;
        b=DrPEmKrc4+G8WhLciMvGkpFc4uAI2a8BdHh8QU8pB3a+unm7cxOiq1DEOPoc1GTsSfd/3C
        frMHNk7Sam/2rNyhTkDRsamHk48BJNeIpcIsDCIpzmiErE7SAZu8YvZYgoJ65G8vOIYRsh
        c3x7EnfPf/BKR6Gqp73SzHCPFrxAiadldUqwkiXVhv1tqXRkuZshREBt5Zy8KuyJ5ZC/j0
        uYg8OKkIe5Ip2erc1HJI6nOAqHjzUKFH/7+a7/24759mfkugEaei10WDQMY9DWKAXK09HC
        fHX+5hVbz/N2T9h1KEXN5sNgFnPKGTI2DCUKnMDRgZI5rJgwZFdYGb2ojph5tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611566948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jku6Tec7q+qisOnosheK7vPMPoB+SzWJoKjJCzgdLxg=;
        b=HuTQnFwN9rYs6voYZat4Kwko1csP9h7nuja7LDtXWfVh9hWfcWxzyjMah87AWxEuaniJUT
        mrnNdDj6m6cH1+BQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20210125092908.ntugyvnbyigxpoyl@linutronix.de>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-3-bigeasy@linutronix.de>
 <30ce5ce2-8b9a-8873-4b37-c8720300942b@suse.de>
 <20210125082542.GC942655@infradead.org>
 <20210125083029.utnjqs2s3diqb5vx@linutronix.de>
 <20210125083248.GA945284@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125083248.GA945284@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021-01-25 08:32:48 [+0000], Christoph Hellwig wrote:
> Well, I put it in quotes because I'm not sure what the exact effect
> is.  But we do delay these completions to the softirq now instead of
> hardirq context, which at least in theory increases latency.  OTOH it
> might even have positive effects on the rest of the system.

The last part is/was my motivation ;)

Sebastian

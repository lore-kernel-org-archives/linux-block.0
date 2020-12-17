Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1406DC4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6FF020725
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgLQQ72 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 11:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQQ72 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 11:59:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D96C0617A7
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 08:58:47 -0800 (PST)
Date:   Thu, 17 Dec 2020 17:58:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608224326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1k/3j9L77ugdQkS0K4bHazEZxtGukoU6G0rYoFRiuu0=;
        b=exLoQlJbuVU7kcjlHr//EHpXPe73SI4ea/cfMDI+ywNYS9eSGCRbHDEEZzYyerTAbhgkyC
        PTQpAJNs8LajsOoPh5HGa6SuI6PKnN1B/8oWSMEf6BWtMowtgvKwoEzuanLMeAxowYzNR3
        Dh54qboiVSZbEHfsAdrPWD+6DD7iozwp8gTMtVSpoqbXlpjuEVb1xnvS45E6UBS90daPfy
        /puU9DhkEgIfRnFsUXjDTq93aZ//JWHkQ3yLcJSUvmjl4fIOXmqYtdHQIkNgHhyHwVo0s3
        YiebE8yrZnoesXwCsHrcN8CBpGE+T+nZDwAZSBN906h1KTxg5owFi+kGwxmChw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608224326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1k/3j9L77ugdQkS0K4bHazEZxtGukoU6G0rYoFRiuu0=;
        b=/wAn6E/bJn1zXsHAQPjvGqjscJqZLd9oJSyO0MClUemCE4KthQo4la/OF2tZA7b1XaRw0n
        UEqETPC7UkL9BwBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>, Daniel Wagner <dwagner@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20201217165844.z4sikj43pf6d3c57@linutronix.de>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208131319.GB22219@infradead.org>
 <20201217164308.ueki3scv3oxt4uta@linutronix.de>
 <e3ca3c82-cddc-ea06-39ae-48605abc77eb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3ca3c82-cddc-ea06-39ae-48605abc77eb@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-12-17 09:55:08 [-0700], Jens Axboe wrote:
> 
> Yeah, I think we're good at this point. I'll queue this up for 5.11.
Thank you very much.
Thank you Daniel for running all these tests.

Sebastian

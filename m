Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E8EC11D04
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 13:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D47222C4
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 13:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgBTNVR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:21:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:41328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgBTNVR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 08:21:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 36E2EABBD;
        Thu, 20 Feb 2020 13:21:15 +0000 (UTC)
Subject: Re: [PATCH 1/3] bcache: ignore pending signals when creating gc and
 allocator thread
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20200213141207.77219-1-colyli@suse.de>
 <20200213141207.77219-2-colyli@suse.de>
 <20200219163200.GA18377@infradead.org>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <1f6cd622-3476-068b-3593-f918ab011156@suse.de>
Date:   Thu, 20 Feb 2020 21:20:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219163200.GA18377@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/2/20 12:32 上午, Christoph Hellwig wrote:
> On Thu, Feb 13, 2020 at 10:12:05PM +0800, Coly Li wrote:
>> +	/*
>> +	 * In case previous btree check operation occupies too many
>> +	 * system memory for bcache btree node cache, and the
>> +	 * registering process is selected by OOM killer. Here just
>> +	 * ignore the SIGKILL sent by OOM killer if there is, to
>> +	 * avoid kthread_run() being failed by pending signals. The
>> +	 * bcache registering process will exit after the registration
>> +	 * done.
>> +	 */
>> +	if (signal_pending(current))
>> +		flush_signals(current);
>> +
>> +	k = kthread_run(bch_allocator_thread, ca, "bcache_allocator");
> 
> This really needs to go into the kthread code itself instead of
> requiring cargo culting in the callers.
> 

Hi Christoph,

Correct me if I am wrong.

If the signal is set before calling kthread_run(), kthread_run() will
fail and return -EINTR as code comment of __kthread_create_on_node() says,

 315  /*
 316   * Wait for completion in killable state, for I might be chosen by
 317   * the OOM killer while kthreadd is trying to allocate memory for
 318   * new kernel thread.
 319   */
 320   if (unlikely(wait_for_completion_killable(&done))) {
 321       /*
 322       * If I was SIGKILLed before kthreadd (or new kernel thread)
 323       * calls complete(), leave the cleanup of this structure to
 324       * that thread.
 325       */
 326       if (xchg(&create->done, NULL))
 327             return ERR_PTR(-EINTR);
 328       /*
 329        * kthreadd (or new kernel thread) will call complete()
 330        * shortly.
 331        */
 332        wait_for_completion(&done);
 333   }

So the caller of kthread_run(), in this case it is
bch_cache_allocator_start() will receive -EINTR, and returns error to
its caller bch_cache_set_alloc(). Then the registration will fail and
ignore what the kthread routine does in parallel.

Therefore I need to explicitly call pending_signal() before calling
kthread_run().


-- 

Coly Li

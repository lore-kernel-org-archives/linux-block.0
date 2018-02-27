Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44450 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeB0SUu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 13:20:50 -0500
Received: by mail-pg0-f65.google.com with SMTP id l4so7826778pgp.11
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2018 10:20:50 -0800 (PST)
Subject: Re: [PATCH v7 9/9] bcache: stop bcache device when backing device is
 offline
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Junhui Tang <tang.junhui@zte.com.cn>
References: <20180227165557.20442-1-colyli@suse.de>
 <20180227165557.20442-10-colyli@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <f4eb2061-67d7-28a3-6187-6390ff974836@lyle.org>
Date: Tue, 27 Feb 2018 10:20:47 -0800
MIME-Version: 1.0
In-Reply-To: <20180227165557.20442-10-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Coly Li--

Just a couple of questions.

On 02/27/2018 08:55 AM, Coly Li wrote:
> +#define BACKING_DEV_OFFLINE_TIMEOUT 5

I think you wanted this to be 30 (per commit message)-- was this turned
down for testing or deliberate?

> +static int cached_dev_status_update(void *arg)
> +{
> +	struct cached_dev *dc = arg;
> +	struct request_queue *q;
> +	char buf[BDEVNAME_SIZE];
> +
> +	/*
> +	 * If this delayed worker is stopping outside, directly quit here.
> +	 * dc->io_disable might be set via sysfs interface, so check it
> +	 * here too.
> +	 */
> +	while (!kthread_should_stop() && !dc->io_disable) {
> +		q = bdev_get_queue(dc->bdev);
> +		if (blk_queue_dying(q))

I am not sure-- is this the correct test to know if the bdev is offline?
 It's very sparsely used outside of the core block system.  (Is there
any scenario where the queue comes back?  Can the device be "offline"
and still have a live queue?  Another approach might be to set
io_disable when there's an extended period without a successful IO, and
it might be possible to do this with atomics without a thread).

This approach can work if you're certain that blk_queue_dying is an
appropriate test for all failure scenarios (I just don't know).

Mike

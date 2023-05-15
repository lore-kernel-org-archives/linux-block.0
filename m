Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41FFC77B7D
	for <linux-block@archiver.kernel.org>; Mon, 15 May 2023 06:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbjEOGBL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 02:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbjEOGA1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 02:00:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF70859E3
        for <linux-block@vger.kernel.org>; Sun, 14 May 2023 22:54:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 64C1221D41;
        Mon, 15 May 2023 05:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684130069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2g2SRYrfL0FsqPNDX6p//ghRaOiZy0Uhnjt4q+fH5MU=;
        b=FROqecaKMuexOzGH3mwY7yBusf7OEzWAIDx7xq4W9uNUasoKrYVvn11VOtuO3zOYqblpSL
        K602eifFSNA9mxY5Sh0JyrYX05KSUlPKn/xBxclkbp0aPPsmMBb7bpset2lQyAGgb/K4IA
        PP7AK6VfRbQptcBo4GQVu140Ayb1ekI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684130069;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2g2SRYrfL0FsqPNDX6p//ghRaOiZy0Uhnjt4q+fH5MU=;
        b=BUr6UGSB4yeTZb7D2IAkK+LUs1tT3SMVmySry2rX+5bf7i+31GT5JSMi2E3jNuUQVCPYXM
        saejdp1e0wkf+eBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 367BF13499;
        Mon, 15 May 2023 05:54:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uKZvDBXJYWSAYwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 15 May 2023 05:54:29 +0000
Message-ID: <1c9fc9df-817c-e6cb-1375-2013c0c5a9bb@suse.de>
Date:   Mon, 15 May 2023 07:54:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] blk-mq: fix blk_mq_hw_ctx active request accounting
Content-Language: en-US
To:     Tian Lan <tilan7663@gmail.com>, ming.lei@redhat.com
Cc:     axboe@kernel.dk, horms@kernel.org, linux-block@vger.kernel.org,
        lkp@intel.com, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        tian.lan@twosigma.com
References: <ZGDur5+koRgNh5Ih@ovpn-8-17.pek2.redhat.com>
 <20230514145328.595743-1-tilan7663@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230514145328.595743-1-tilan7663@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/14/23 16:53, Tian Lan wrote:
> From: Tian Lan <tian.lan@twosigma.com>
> 
> The nr_active counter continues to increase over time which causes the
> blk_mq_get_tag to hang until the thread is rescheduled to a different
> core despite there are still tags available.
> 
> kernel-stack
> 
>    INFO: task inboundIOReacto:3014879 blocked for more than 2 seconds
>    Not tainted 6.1.15-amd64 #1 Debian 6.1.15~debian11
>    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>    task:inboundIORe state:D stack:0  pid:3014879 ppid:4557 flags:0x00000000
>      Call Trace:
>      <TASK>
>      __schedule+0x351/0xa20
>      scheduler+0x5d/0xe0
>      io_schedule+0x42/0x70
>      blk_mq_get_tag+0x11a/0x2a0
>      ? dequeue_task_stop+0x70/0x70
>      __blk_mq_alloc_requests+0x191/0x2e0
> 
> kprobe output showing RQF_MQ_INFLIGHT bit is not cleared before
> __blk_mq_free_request being called.
> 
>    320    320  kworker/29:1H __blk_mq_free_request rq_flags 0x220c0
>           b'__blk_mq_free_request+0x1 [kernel]'
>           b'bt_iter+0x50 [kernel]'
>           b'blk_mq_queue_tag_busy_iter+0x318 [kernel]'
>           b'blk_mq_timeout_work+0x7c [kernel]'
>           b'process_one_work+0x1c4 [kernel]'
>           b'worker_thread+0x4d [kernel]'
>           b'kthread+0xe6 [kernel]'
>           b'ret_from_fork+0x1f [kernel]'
> 
> The issue is caused by the difference between blk_mq_free_request() and
> blk_mq_end_request_batch() wrt. when to call __blk_mq_dec_active_requests().
> The former does it before calling req_ref_put_and_test(), and the latter
> decreases the active request after req_ref_put_and_test().
> 
> - Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")
> 
> Signed-off-by: Tian Lan <tian.lan@twosigma.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


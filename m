Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55892C47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38288613CB
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhFJGj5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 02:39:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55254 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJGj5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 02:39:57 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EDBF41FD61;
        Thu, 10 Jun 2021 06:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623307080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWToRXv+uYwHyR00EShVvSnZfmPCmMK9LB6SZ/hQJjI=;
        b=tlq8YbTTJlmzRwdDkixrEes6KOT6OnFzTUoaBPVOxLutYcq6x4Wv71zpk4vpK43i+gVCjg
        5bxVhET1laDxJzUfh7F0t7ohLExStY3dXOCg6B7Pw2sw5K735tysik5Nub9ryqnieKbJLR
        K1oPCxMl0kHRHca8JClnGdJAWpR8GZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623307080;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWToRXv+uYwHyR00EShVvSnZfmPCmMK9LB6SZ/hQJjI=;
        b=iwHyIgcKsDt8yJcuvF9fdXX0ZacTF8gBfiWo45H6J6tmEPryGkgLRWJQJQmQVk6gY3dJFR
        k0Dw7YJajsnwTnDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B4DC3118DD;
        Thu, 10 Jun 2021 06:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623307080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWToRXv+uYwHyR00EShVvSnZfmPCmMK9LB6SZ/hQJjI=;
        b=tlq8YbTTJlmzRwdDkixrEes6KOT6OnFzTUoaBPVOxLutYcq6x4Wv71zpk4vpK43i+gVCjg
        5bxVhET1laDxJzUfh7F0t7ohLExStY3dXOCg6B7Pw2sw5K735tysik5Nub9ryqnieKbJLR
        K1oPCxMl0kHRHca8JClnGdJAWpR8GZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623307080;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWToRXv+uYwHyR00EShVvSnZfmPCmMK9LB6SZ/hQJjI=;
        b=iwHyIgcKsDt8yJcuvF9fdXX0ZacTF8gBfiWo45H6J6tmEPryGkgLRWJQJQmQVk6gY3dJFR
        k0Dw7YJajsnwTnDA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id pNTdKkizwWAFYAAALh3uQQ
        (envelope-from <hare@suse.de>); Thu, 10 Jun 2021 06:38:00 +0000
Subject: Re: [PATCH 13/14] block/mq-deadline: Add cgroup support
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-14-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <b59b1680-da53-21b0-15bd-ba6c7936d393@suse.de>
Date:   Thu, 10 Jun 2021 08:37:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608230703.19510-14-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 1:07 AM, Bart Van Assche wrote:
> Maintain statistics per cgroup and export these to user space. These
> statistics are essential for verifying whether the proper I/O priorities
> have been assigned to requests. With this patch applied the output of
> (cd /sys/fs/cgroup/blkio/ && ls) is as follows:
> blkio.dd.dispatched_pri0  blkio.dd.inserted_pri3  cgroup.clone_children
> blkio.dd.dispatched_pri1  blkio.dd.merged_pri0    cgroup.procs
> blkio.dd.dispatched_pri2  blkio.dd.merged_pri1    cgroup.sane_behavior
> blkio.dd.dispatched_pri3  blkio.dd.merged_pri2    notify_on_release
> blkio.dd.inserted_pri0    blkio.dd.merged_pri3    release_agent
> blkio.dd.inserted_pri1    blkio.prio.class        tasks
> blkio.dd.inserted_pri2    blkio.reset_stats
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/Kconfig.iosched                       |   6 +
>  block/Makefile                              |   2 +
>  block/mq-deadline-cgroup.c                  | 185 ++++++++++++++++++++
>  block/mq-deadline-cgroup.h                  | 112 ++++++++++++
>  block/{mq-deadline.c => mq-deadline-main.c} |  85 +++++++--
>  5 files changed, 376 insertions(+), 14 deletions(-)
>  create mode 100644 block/mq-deadline-cgroup.c
>  create mode 100644 block/mq-deadline-cgroup.h
>  rename block/{mq-deadline.c => mq-deadline-main.c} (94%)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)

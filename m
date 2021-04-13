Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7A3C433B4
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 07:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 556A361244
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 07:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhDMHuq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:50:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:55710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238190AbhDMHup (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 03:50:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 287BFAFD2;
        Tue, 13 Apr 2021 07:50:25 +0000 (UTC)
Date:   Tue, 13 Apr 2021 09:50:24 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Khazhy Kumykov <khazhy@google.com>
Subject: Re: [PATCH v6 2/5] blk-mq: Introduce atomic variants of
 blk_mq_(all_tag|tagset_busy)_iter
Message-ID: <20210413075024.xivnj3jy6olaqglc@beryllium.lan>
References: <20210406214905.21622-1-bvanassche@acm.org>
 <20210406214905.21622-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406214905.21622-3-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 06, 2021 at 02:49:02PM -0700, Bart Van Assche wrote:
> Since in the next patch knowledge is required of whether or not it is
> allowed to sleep inside the tag iteration functions, pass this context
> information to the tag iteration functions. I have reviewed all callers of
> tag iteration functions to verify these annotations by starting from the
> output of the following grep command:
> 
>     git grep -nHE 'blk_mq_(all_tag|tagset_busy)_iter'
> 
> My conclusions from that analysis are as follows:
> - Sleeping is allowed in the blk-mq-debugfs code that iterates over tags.
> - Since the blk_mq_tagset_busy_iter() calls in the mtip32xx driver are
>   preceded by a function that sleeps (blk_mq_quiesce_queue()), sleeping is
>   safe in the context of the blk_mq_tagset_busy_iter() calls.
> - The same reasoning also applies to the nbd driver.
> - All blk_mq_tagset_busy_iter() calls in the NVMe drivers are followed by a
>   call to a function that sleeps so sleeping inside blk_mq_tagset_busy_iter()
>   when called from the NVMe driver is fine.
> - scsi_host_busy(), scsi_host_complete_all_commands() and
>   scsi_host_busy_iter() are used by multiple SCSI LLDs so analyzing whether
>   or not these functions may sleep is hard. Instead of performing that
>   analysis, make it safe to call these functions from atomic context.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Khazhy Kumykov <khazhy@google.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Maybe you could also annotate blk_mq_all_tag_iter() with a
might_sleep(). This would help to find API abusers more easily.

Reviewed-by: Daniel Wagner <dwagner@suse.de>


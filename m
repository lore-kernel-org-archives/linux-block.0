Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84694C433B4
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 07:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E75261042
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 07:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhDZHSA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 03:18:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:44744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232119AbhDZHR5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 03:17:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB651AF31;
        Mon, 26 Apr 2021 07:17:15 +0000 (UTC)
Subject: Re: [PATCH V6 09/12] block: use per-task poll context to implement
 bio based io polling
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210422122038.2192933-1-ming.lei@redhat.com>
 <20210422122038.2192933-10-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <527cf81d-5d6c-03ca-a6ae-cc18b9a67787@suse.de>
Date:   Mon, 26 Apr 2021 09:17:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210422122038.2192933-10-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/21 2:20 PM, Ming Lei wrote:
> Currently bio based IO polling needs to poll all hw queue blindly, this
> way is very inefficient, and one big reason is that we can't pass any
> bio submission result to blk_poll().
> 
> In IO submission context, track associated underlying bios by per-task
> submission queue and store returned 'cookie' in bio->bi_poll_data which
> is added by filling a hole of .bi_iter, and return current->pid to
> caller of submit_bio() for any bio based driver's IO, which is
> submitted from FS.
> 
> In IO poll context, the passed cookie tells us the PID of submission
> context, then we can find bios from the per-task io pull context of
> submission context. Moving bios from submission queue to poll queue of
> the poll context, and keep polling until these bios are ended. Remove
> bio from poll queue if the bio is ended. Add bio flags of BIO_DONE and
> BIO_END_BY_POLL for such purpose.
> 
> In was found in Jeffle Xu's test that kfifo doesn't scale well for a
> submission queue as queue depth is increased, so a new mechanism for
> tracking bios is needed. So far bio's size is close to 2 cacheline size,
> and it may not be accepted to add new field into bio for solving the
> scalability issue by tracking bios via linked list, switch to bio group
> list for tracking bio, the idea is to reuse .bi_end_io for linking bios
> into a linked list for all sharing same .bi_end_io(call it bio group),
> which is recovered before ending bio really, since BIO_END_BY_POLL is
> added for enhancing this point. Usually .bi_end_bio is same for all
> bios in same layer, so it is enough to provide very limited groups, such
> as 16 or less for fixing the scalability issue.
> 
> Usually submission shares context with io poll. The per-task poll context
> is just like stack variable, and it is cheap to move data between the two
> per-task queues.
> 
> Also when the submission task is exiting, drain pending IOs in the context
> until all are done.
> 
> Tested-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/bio.c               |   5 +
>  block/blk-core.c          |  39 ++++-
>  block/blk-ioc.c           |   3 +
>  block/blk-poll.c          | 345 +++++++++++++++++++++++++++++++++++++-
>  block/blk.h               |  33 ++++
>  include/linux/blk_types.h |  27 ++-
>  6 files changed, 448 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)

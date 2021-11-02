Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C99C433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 18:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B9061051
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 18:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhKBSTg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:19:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59832 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbhKBSTg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 14:19:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 08DE51FD29;
        Tue,  2 Nov 2021 18:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635877020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8NngKdLtGmNqca8maMDyltlLXI8MB9OQe/WkEYrAW80=;
        b=Dm+hZ+eSc3eNBTkpjqW5JFAkS9yxJmZSGo4WqTb0OD8Lb/jmID5CUoJOUTBPC29S71YRg4
        noPAmYMzcFNGntHKAgMFoQSqNDixuj7XxFXiIM1B/V68mGfqHEhBu9JAaW3ndESZobxWUQ
        W4t/M7Pe6sYXjcstmNn6GjFwF3QjUxM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E226813EAF;
        Tue,  2 Nov 2021 18:16:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R+ibNpuAgWG8HQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 02 Nov 2021 18:16:59 +0000
Date:   Tue, 2 Nov 2021 19:16:58 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4/8] bfq: Limit number of requests consumed by each cgroup
Message-ID: <20211102181658.GA63407@blackbody.suse.cz>
References: <20211006164110.10817-1-jack@suse.cz>
 <20211006173157.6906-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006173157.6906-4-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

On Wed, Oct 06, 2021 at 07:31:43PM +0200, Jan Kara <jack@suse.cz> wrote:
> +	for (level--; level >= 0; level--) {
> +		entity = entities[level];
> +		if (level > 0) {
> +			wsum = bfq_entity_service_tree(entity)->wsum;
> +		} else {
> +			int i;
> +			/*
> +			 * For bfqq itself we take into account service trees
> +			 * of all higher priority classes and multiply their
> +			 * weights so that low prio queue from higher class
> +			 * gets more requests than high prio queue from lower
> +			 * class.
> +			 */
> +			wsum = 0;
> +			for (i = 0; i <= class_idx; i++) {
> +				wsum = wsum * IOPRIO_BE_NR +
> +					sched_data->service_tree[i].wsum;
> +			}
> +		}
> +		limit = DIV_ROUND_CLOSEST(limit * entity->weight, wsum);

This scheme caught my eye. You mutliply (tree) weights by a factor
depending on the class when counting the wsum but then you don't apply
the same scaling for the evaluated entity in the numerator.

IOW, I think there should be something like
	scale = (level > 0) ? 1 : int_pow(IOPRIO_BE_NR, BFQ_IOPRIO_CLASSES - bfq_class_idx(entity));
	limit = DIV_ROUND_CLOSEST(limit * entity->weight * scale, wsum);

For instance, if there are two cgroups (level=1) with weights 100 and
200, and each cgroup has a single IOPRIO_CLASS_BE entity (level=0) in
it, the `limit` distribution would honor the ratio of weights from
level=1 (100:200) but it would artificially lower the absolute amount of
allowed tags. If I am not mistaken, that would be reduced by factor
1/BFQ_IOPRIO_CLASSES.

Also if I consider it more broadly, is this supposed to match/extend
bfq_io_prio_to_weight() calculation?


Michal

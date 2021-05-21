Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7088C433B4
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 00:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F31613AC
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 00:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbhEUAnx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 20:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232540AbhEUAnx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 20:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621557750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHrceV1w57Vma4DJJBBq4xS+FUx6JQj6B2XZD/3lSC0=;
        b=LLKKvS6nR4DG8scXt+qWZf8LPFT8E1qEsRkArVdnc/fgft9EO9FVLtyKjj73K/MYevB3mc
        T4k/6v1+GteWxopJje77lBZUoe3fwEQ6H0DpkBEYOKH4rqBfcpbz2gO7pJ5gIiYrU/LoIa
        C6KqkgnHDW7U8j+XKYrGkcuCP3LCvbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-nuzRI5EGNHmz4dKrscmjlg-1; Thu, 20 May 2021 20:42:27 -0400
X-MC-Unique: nuzRI5EGNHmz4dKrscmjlg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 671C41007467;
        Fri, 21 May 2021 00:42:26 +0000 (UTC)
Received: from T590 (ovpn-12-75.pek2.redhat.com [10.72.12.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 653045C3FD;
        Fri, 21 May 2021 00:42:20 +0000 (UTC)
Date:   Fri, 21 May 2021 08:42:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Khazhy Kumykov <khazhy@google.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 1/2] block: Do not merge recursively in
 elv_attempt_insert_merge()
Message-ID: <YKcB6Hxhe3a1St31@T590>
References: <20210520223353.11561-1-jack@suse.cz>
 <20210520223353.11561-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520223353.11561-2-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 12:33:52AM +0200, Jan Kara wrote:
> Most of the merging happens at bio level. There should not be much
> merging happening at request level anymore. Furthermore if we backmerged
> a request to the previous one, the chances to be able to merge the
> result to even previous request are slim - that could succeed only if
> requests were inserted in 2 1 3 order. Merging more requests in

Right, but some workload has this kind of pattern.

For example of qemu IO emulation, it often can be thought as single job,
native aio, direct io with high queue depth. IOs is originated from one VM, but
may be from multiple jobs in the VM, so bio merge may not hit much because of IO
emulation timing(virtio-scsi/blk's MQ, or IO can be interleaved from multiple
jobs via the SQ transport), but request merge can really make a difference, see
recent patch in the following link:

https://lore.kernel.org/linux-block/3f61e939-d95a-1dd1-6870-e66795cfc1b1@suse.de/T/#t

> elv_attempt_insert_merge() will be difficult to handle when we want to
> pass requests to free back to the caller of
> blk_mq_sched_try_insert_merge(). So just remove the possibility of
> merging multiple requests in elv_attempt_insert_merge().

This way will cause regression.


Thanks, 
Ming


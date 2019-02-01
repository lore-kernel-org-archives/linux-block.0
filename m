Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEE4C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 18:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C8E21726
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 18:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfBASVA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:21:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730668AbfBASVA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Feb 2019 13:21:00 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 197B6623;
        Fri,  1 Feb 2019 18:21:00 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-124.ams2.redhat.com [10.36.116.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6831B5DD86;
        Fri,  1 Feb 2019 18:20:58 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com, jannh@google.com
Subject: Re: [PATCH 05/18] Add io_uring IO interface
References: <20190201152414.23296-1-axboe@kernel.dk>
        <20190201152414.23296-6-axboe@kernel.dk>
Date:   Fri, 01 Feb 2019 19:20:57 +0100
In-Reply-To: <20190201152414.23296-6-axboe@kernel.dk> (Jens Axboe's message of
        "Fri, 1 Feb 2019 08:24:01 -0700")
Message-ID: <871s4r8j5i.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 01 Feb 2019 18:21:00 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

* Jens Axboe:

> +/*
> + * Filled with the offset for mmap(2)
> + */
> +struct io_sqring_offsets {
> +	__u32 head;
> +	__u32 tail;
> +	__u32 ring_mask;
> +	__u32 ring_entries;
> +	__u32 flags;
> +	__u32 dropped;
> +	__u32 array;
> +	__u32 resv[3];
> +};
> +
> +struct io_cqring_offsets {
> +	__u32 head;
> +	__u32 tail;
> +	__u32 ring_mask;
> +	__u32 ring_entries;
> +	__u32 overflow;
> +	__u32 cqes;
> +	__u32 resv[4];
> +};
> +
> +/*
> + * io_uring_enter(2) flags
> + */
> +#define IORING_ENTER_GETEVENTS	(1U << 0)
> +
> +/*
> + * Passed in for io_uring_setup(2). Copied back with updated info on success
> + */
> +struct io_uring_params {
> +	__u32 sq_entries;
> +	__u32 cq_entries;
> +	__u32 flags;
> +	__u32 resv[7];
> +	struct io_sqring_offsets sq_off;
> +	struct io_cqring_offsets cq_off;
> +};

I still think it might be a good idea to have one reserved __u64 field
for alignment purposes.

Thanks,
Florian

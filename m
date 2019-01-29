Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2E9C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 12:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D742148E
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 12:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfA2MM7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:12:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfA2MM6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 07:12:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A18EC0828C7;
        Tue, 29 Jan 2019 12:12:58 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-219.str.redhat.com [10.33.192.219])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1030819487;
        Tue, 29 Jan 2019 12:12:56 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org, hch@lst.de,
        jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 05/18] Add io_uring IO interface
References: <20190128213538.13486-1-axboe@kernel.dk>
        <20190128213538.13486-6-axboe@kernel.dk>
Date:   Tue, 29 Jan 2019 13:12:55 +0100
In-Reply-To: <20190128213538.13486-6-axboe@kernel.dk> (Jens Axboe's message of
        "Mon, 28 Jan 2019 14:35:25 -0700")
Message-ID: <87tvhrpsqg.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 29 Jan 2019 12:12:58 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

* Jens Axboe:

> +#define IORING_MAX_ENTRIES	4096

Where does this constant come from?  Should it really be exposed to
userspace?

> +struct io_uring_params {
> +	__u32 sq_entries;
> +	__u32 cq_entries;
> +	__u32 flags;
> +	__u16 resv[10];
> +	struct io_sqring_offsets sq_off;
> +	struct io_cqring_offsets cq_off;
> +};

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

Should the reserved fields include a __u64 member, to increase struct
alignment on architectures that might need it in the future?

> +#define IORING_ENTER_GETEVENTS	(1 << 0)

Should this be unsigned, to match the u32 flags argument?  (Otherwise
using 32 flags can be difficult).

Thanks,
Florian

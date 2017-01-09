Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbdAITz5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Jan 2017 14:55:57 -0500
From: Jeff Moyer <jmoyer@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] virtio_blk: fix panic in initialization error path
References: <4bc0f759ce198dc36e9b678a3c8f69bfef5cb728.1483990999.git.osandov@fb.com>
Date: Mon, 09 Jan 2017 14:55:56 -0500
In-Reply-To: <4bc0f759ce198dc36e9b678a3c8f69bfef5cb728.1483990999.git.osandov@fb.com>
        (Omar Sandoval's message of "Mon, 9 Jan 2017 11:44:12 -0800")
Message-ID: <x49zij0gg8j.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Omar Sandoval <osandov@osandov.com> writes:

> From: Omar Sandoval <osandov@fb.com>
>
> If blk_mq_init_queue() returns an error, it gets assigned to
> vblk->disk->queue. Then, when we call put_disk(), we end up calling
> blk_put_queue() with the ERR_PTR, causing a bad dereference. Fix it by
> only assigning to vblk->disk->queue on success.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

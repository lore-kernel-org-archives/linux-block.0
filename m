Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:33873 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753378AbdCBCxv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Mar 2017 21:53:51 -0500
MIME-Version: 1.0
In-Reply-To: <7e888cad9e6c35835559281d3ab9e05ea48836d0.1488393750.git.osandov@fb.com>
References: <7e888cad9e6c35835559281d3ab9e05ea48836d0.1488393750.git.osandov@fb.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 2 Mar 2017 09:57:28 +0800
Message-ID: <CACVXFVMOSz6ge1u3-Z0cu4LdjboYHnff6Qqpt9z7qHwFHr5=tw@mail.gmail.com>
Subject: Re: [PATCH 1/2] loop: fix LO_FLAGS_PARTSCAN hang
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        FB Kernel Team <kernel-team@fb.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Mar 2, 2017 at 2:42 AM, Omar Sandoval <osandov@osandov.com> wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> loop_reread_partitions() needs to do I/O, but we just froze the queue,
> so we end up waiting forever. This can easily be reproduced with losetup
> -P. Fix it by moving the reread to after we unfreeze the queue.
>
> Fixes: ecdd09597a57 ("block/loop: fix race between I/O and set_status")
> Reported-by: Tejun Heo <tj@kernel.org>
> Cc: Ming Lei <tom.leiming@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming

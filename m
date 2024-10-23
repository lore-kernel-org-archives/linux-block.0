Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725CC4D599
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729723846; cv=none; b=IpZgQjmjNON0ewOFoRgPYYMRbDET6wX5wFlqeNWFf/qkWY+G13EUOizkGjqsyID2xUXv6JPzlYpDyr/YbcJquiUAuUeF8dGwj52JBgvh/76sUTdln4QLHbQ7i5UbuaXMvTJbuQhmvN9d0n/BulEO+jlGc26TMAeU32RF+kgweXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729723846; c=relaxed/simple;
	bh=91+nDc11MAfgAZ0YhuP+IlecYInS/GBMRQ6PMBSu4/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCAN7+c5yoNQgzYnY8RqtnZWpB4OCwFb+cIoJ3WXga3hoMX9qccXdhfBWe28yCCDFSvo9FNKXDu84JC/bd+42tMHiI87dey5VVoaVyFkrX3Y1BzFdxium8SQ7CdRr2/CG5Gk4jqBq6zrJWVFDxj5pvKhknqdpmLVJlMTqtDWauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SBqfmwp1; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SBqfmwp1"
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-46089a6849bso1636591cf.3
        for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1729723843; x=1730328643; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UX20ujn+undovFvsqj4/UPhRIVoe2uvTZTSbTAZEccc=;
        b=SBqfmwp1RdO0CsyPyta9w8Hd39znIrj3KEJwcMIMPlmY2gYK7S8R7gQK46UE8Poaz6
         gRRUkynTM7CyI+UFqHDT9wKvTqRbx1GWxGMYBnGOIrt7LNnV6b2mdTfQsTj3tmw7B64N
         pYaMTW4ulxDqdgQ5oEYMNz4tmH+TgmfuxtHs7H+IKSoQRJ0HVG/cg3rMo1+h/rO97vgA
         v2mp7xY9aF4XwY3A+AjrV3q7D4vrHw5pcaXyvEOHDwrxCAWi9fbXEVK/WbFJ7Z59i+E9
         QcvJqmBgYvZSbhK2n42FsAZAWg8fhtTaDhuWxCdq7dMpYBmcKZNDFXT25ujyu4XNCxaN
         VIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729723843; x=1730328643;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UX20ujn+undovFvsqj4/UPhRIVoe2uvTZTSbTAZEccc=;
        b=gxJbNixuIKy/dUPtNAbUnHbi7o43o7TDf9UChy24/9722rscn7JT5Em8WwXDGccCg2
         AJR61MsUhI0yeZRC9bsurSFOn+g5bI7AraBvrIlMzPrPDbdrC8MgxXFGO18HVatB3CUd
         t9hmhDW1X3xY4acQrAMyLajADEH5beJveVq6zHSzoCHWQzOBpZXRWSTypRFXuihoCvQ8
         W6/Il9GBlUn8jK7BQ88WT83Jg7nk0CNzQ0XPje+0SLrOJiETE4UpBkaI4d449ukxVJFn
         32tRu0e6DFk21DNz+9xMBj6IlAlPYU7z18vRhkugk4bex1MWbZ9DERmwSQ6U0PTgns5l
         U31Q==
X-Gm-Message-State: AOJu0Yw0I0j85ETFGAsk/4YClnbdTlQx0ZTThImGtbdpVfFPgSXBwPLE
	ss0zxArKL9qztzeuqDDxqlDGWBn7cL2MAKG2WzhxhMyq1pgUfoE0vHcRPy5hVqF0jaRk2flKf9o
	QP3ceR2ibu8NpMLZNaoqUe3rtYNf5AhuwS5BrMBRWHyEHvANS
X-Google-Smtp-Source: AGHT+IGlH24LQrtRbLW2PozgtIQflU4hpwqomrfR3oyuOME3PIPWdtz+5j2rZkKi6xA0myC2APwolGdVJ9cv
X-Received: by 2002:a05:622a:1e15:b0:460:ddc3:4dd2 with SMTP id d75a77b69052e-461147270b7mr52552991cf.40.1729723843129;
        Wed, 23 Oct 2024 15:50:43 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-460e2dff310sm1924091cf.26.2024.10.23.15.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 15:50:43 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id BB48B3400E6;
	Wed, 23 Oct 2024 16:50:41 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id AC536E40152; Wed, 23 Oct 2024 16:50:41 -0600 (MDT)
Date: Wed, 23 Oct 2024 16:50:41 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Xinyu Zhang <xizhang@purestorage.com>
Subject: Re: [PATCH] block: fix sanity checks in blk_rq_map_user_bvec
Message-ID: <Zxl9wS2j5mUkye9o@dev-ushankar.dev.purestorage.com>
References: <20241023211519.4177873-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241023211519.4177873-1-ushankar@purestorage.com>

On Wed, Oct 23, 2024 at 03:15:19PM -0600, Uday Shankar wrote:
> From: Xinyu Zhang <xizhang@purestorage.com>
> 
> blk_rq_map_user_bvec contains a check bytes + bv->bv_len > nr_iter which
> causes unnecessary failures in NVMe passthrough I/O, reproducible as
> follows:
> 
> - register a 2 page, page-aligned buffer against a ring
> - use that buffer to do a 1 page io_uring NVMe passthrough read
> 
> The second (i = 1) iteration of the loop in blk_rq_map_user_bvec will
> then have nr_iter == 1 page, bytes == 1 page, bv->bv_len == 1 page, so
> the check bytes + bv->bv_len > nr_iter will succeed, causing the I/O to
> fail. This failure is unnecessary, as when the check succeeds, it means
> we've checked the entire buffer that will be used by the request - i.e.
> blk_rq_map_user_bvec should complete successfully. Therefore, terminate
> the loop early and return successfully when the check bytes + bv->bv_len
> > nr_iter succeeds.

For anyone interested, here are the details on how to reproduce the
issue described above:

# cat test.c
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <liburing.h>
#include <stdlib.h>
#include <assert.h>
#include <linux/nvme_ioctl.h>

int main(int argc, char *argv[]) {
    struct io_uring ring;

    assert(io_uring_queue_init(1, &ring, IORING_SETUP_SQE128 | IORING_SETUP_CQE32) == 0);

    void *buf = memalign(4096, 2 * 4096);
    printf("buf %p\n", buf);
    struct iovec iov = {
        .iov_base = buf,
        .iov_len = 2 * 4096,
    };

    assert(io_uring_register_buffers(&ring, &iov, 1) == 0);

    struct io_uring_sqe *sqe = io_uring_get_sqe(&ring);
    assert(sqe != NULL);

    int fd = open("/dev/ng0n1", O_RDONLY);
    assert(fd > 0);
    sqe->fd = fd;
    sqe->opcode = IORING_OP_URING_CMD;
    sqe->cmd_op = NVME_URING_CMD_IO;
    sqe->buf_index = 0;
    sqe->flags = 0;
    sqe->uring_cmd_flags = IORING_URING_CMD_FIXED;

    struct nvme_passthru_cmd *cmd = &sqe->cmd;
    cmd->opcode = 2; // read
    cmd->nsid = 1;
    cmd->data_len = 1 * 4096;
    cmd->addr = buf;

    struct io_uring_cqe *cqe;
    assert(io_uring_submit(&ring) == 1);
    assert(io_uring_wait_cqe(&ring, &cqe) == 0);

    printf("res %d\n", cqe->res);

    return 0;
}
# gcc -o test -luring test.c
test.c: In function ‘main’:
test.c:15:17: warning: implicit declaration of function ‘memalign’ [-Wimplicit-function-declaration]
   15 |     void *buf = memalign(4096, 2 * 4096);
      |                 ^~~~~~~~
test.c:15:17: warning: initialization of ‘void *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
test.c:36:37: warning: initialization of ‘struct nvme_passthru_cmd *’ from incompatible pointer type ‘__u8 (*)[0]’ {aka ‘unsigned char (*)[]’} [-Wincompatible-pointer-types]
   36 |     struct nvme_passthru_cmd *cmd = &sqe->cmd;
      |                                     ^
test.c:40:15: warning: assignment to ‘__u64’ {aka ‘long long unsigned int’} from ‘void *’ makes integer from pointer without a cast [-Wint-conversion]
   40 |     cmd->addr = buf;
      |
# ./test
buf 0x406000
res -22

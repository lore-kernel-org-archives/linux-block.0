Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFF4C636D4
	for <linux-block@archiver.kernel.org>; Sat, 11 Feb 2023 15:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBKPpY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Feb 2023 10:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBKPpY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Feb 2023 10:45:24 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDA1211F3
        for <linux-block@vger.kernel.org>; Sat, 11 Feb 2023 07:45:21 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z1so9545758plg.6
        for <linux-block@vger.kernel.org>; Sat, 11 Feb 2023 07:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4VEswFG9C7YW8tLmxKeZ3hDt57pvn+8QY3hw2oHokhY=;
        b=t82cKAZFQyx4ZN66NzqffSnEW7pM2IX8oxlz/EEvv/Yu6dZIy/d+qyIdQWuFj8C7dE
         ngXG0YUlPnrtOEHiMw2FW4mJu6cAm7vuMavU8Ju4+9WnJW4zIwZoULOl5Z2Fy7TB0Zfs
         uKug/3Bs84iv+ffoiDghKh7hrrdxmKhIw2lgFdvRNDxI3QN0aRSanxZJ1ybkrGBizeLw
         7t8dFXhdiNj24xf9jmMVH6yZJuV9b8oat+FoBGfDlJln6QSDKV0LFjKxUGPg66S3anfh
         U4hnsYVrgC61Z7WM9g+L4HciEQDMwnQU1M7uuaL/w9FIn3IBTb4TjSk0VndiH13yzNcz
         o75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VEswFG9C7YW8tLmxKeZ3hDt57pvn+8QY3hw2oHokhY=;
        b=yx/NvCBcJO0XIp6rIqvpu3LiDgAHmD028vXm/Ql1Dyb0/Z16EIR/aX4bUFy04W2jkU
         eiXQOjdKmYI5CM2yUJclSDDXXNBZzHCtrEk6CRE8UmQ7GBPi/qziIba+G3Meehn3yVe4
         G6z6FZd/yUwtiXV528Wb9erUN53ObNRWnZSjcjKyKM/geJReCnrDVJDbgRn5q+1mfHti
         Sa1fDBgPQaZQ2eFutxqvsp1qOlIQFaMDCm8JMhwu/OR+zy7f/ACDnzEDpupGjpLR3Xb1
         ddKvsPmdzIyZILg6iEKfa4doHnzee8MNd39muHHV+msB0A35yan4wFmyJ7LvVCAu4tVI
         HDCw==
X-Gm-Message-State: AO0yUKWhGFVkLrAC7Nv15rMurGf7hPPaPj36YD9l51YYXaquyiusFy0B
        MJKDS7ydWnWu4Xeb/2+yl2yeFA==
X-Google-Smtp-Source: AK7set+NCFjHIs7XPORhKLiTYuXBT8m+B1POG2YNxtMB4UxVI7wYhdDQA3jrc25p4no7/NBSxHA1xg==
X-Received: by 2002:a17:903:2286:b0:19a:723a:8405 with SMTP id b6-20020a170903228600b0019a723a8405mr5967067plh.6.1676130320553;
        Sat, 11 Feb 2023 07:45:20 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b0019682e27995sm4479699plb.223.2023.02.11.07.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 07:45:19 -0800 (PST)
Message-ID: <a487261c-cc0e-134b-cd8e-26460fe7cf59@kernel.dk>
Date:   Sat, 11 Feb 2023 08:45:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 3/4] io_uring: add IORING_OP_READ[WRITE]_SPLICE_BUF
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
References: <20230210153212.733006-1-ming.lei@redhat.com>
 <20230210153212.733006-4-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230210153212.733006-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/23 8:32?AM, Ming Lei wrote:
> IORING_OP_READ_SPLICE_BUF: read to buffer which is built from
> ->read_splice() of specified fd, so user needs to provide (splice_fd, offset, len)
> for building buffer.
> 
> IORING_OP_WRITE_SPLICE_BUF: write from buffer which is built from
> ->read_splice() of specified fd, so user needs to provide (splice_fd, offset, len)
> for building buffer.
> 
> The typical use case is for supporting ublk/fuse io_uring zero copy,
> and READ/WRITE OP retrieves ublk/fuse request buffer via direct pipe
> from device->read_splice(), then READ/WRITE can be done to/from this
> buffer directly.

Main question here - would this be better not plumbed up through the rw
path? Might be cleaner, even if it either requires a bit of helper
refactoring or accepting a bit of duplication. But would still be better
than polluting the rw fast path imho.

Also seems like this should be separately testable. We can't add new
opcodes that don't have a feature test at least, and should also have
various corner case tests. A bit of commenting outside of this below.

> diff --git a/io_uring/opdef.c b/io_uring/opdef.c
> index 5238ecd7af6a..91e8d8f96134 100644
> --- a/io_uring/opdef.c
> +++ b/io_uring/opdef.c
> @@ -427,6 +427,31 @@ const struct io_issue_def io_issue_defs[] = {
>  		.prep			= io_eopnotsupp_prep,
>  #endif
>  	},
> +	[IORING_OP_READ_SPLICE_BUF] = {
> +		.needs_file		= 1,
> +		.unbound_nonreg_file	= 1,
> +		.pollin			= 1,
> +		.plug			= 1,
> +		.audit_skip		= 1,
> +		.ioprio			= 1,
> +		.iopoll			= 1,
> +		.iopoll_queue		= 1,
> +		.prep			= io_prep_rw,
> +		.issue			= io_read,
> +	},
> +	[IORING_OP_WRITE_SPLICE_BUF] = {
> +		.needs_file		= 1,
> +		.hash_reg_file		= 1,
> +		.unbound_nonreg_file	= 1,
> +		.pollout		= 1,
> +		.plug			= 1,
> +		.audit_skip		= 1,
> +		.ioprio			= 1,
> +		.iopoll			= 1,
> +		.iopoll_queue		= 1,
> +		.prep			= io_prep_rw,
> +		.issue			= io_write,
> +	},

Are these really safe with iopoll?

> +static int io_prep_rw_splice_buf(struct io_kiocb *req,
> +				 const struct io_uring_sqe *sqe)
> +{
> +	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
> +	unsigned nr_pages = io_rw_splice_buf_nr_bvecs(rw->len);
> +	loff_t splice_off = READ_ONCE(sqe->splice_off_in);
> +	struct io_rw_splice_buf_data data;
> +	struct io_mapped_ubuf *imu;
> +	struct fd splice_fd;
> +	int ret;
> +
> +	splice_fd = fdget(READ_ONCE(sqe->splice_fd_in));
> +	if (!splice_fd.file)
> +		return -EBADF;

Seems like this should check for SPLICE_F_FD_IN_FIXED, and also use
io_file_get_normal() for the non-fixed case in case someone passed in an
io_uring fd.

> +	data.imu = &imu;
> +
> +	rw->addr = 0;
> +	req->flags |= REQ_F_NEED_CLEANUP;
> +
> +	ret = __io_prep_rw_splice_buf(req, &data, splice_fd.file, rw->len,
> +			splice_off);
> +	imu = *data.imu;
> +	imu->acct_pages = 0;
> +	imu->ubuf = 0;
> +	imu->ubuf_end = data.total;
> +	rw->len = data.total;
> +	req->imu = imu;
> +	if (!data.total) {
> +		io_rw_cleanup_splice_buf(req);
> +	} else  {
> +		ret = 0;
> +	}
> +out_put_fd:
> +	if (splice_fd.file)
> +		fdput(splice_fd);
> +
> +	return ret;
> +}

If the operation is done, clear NEED_CLEANUP and do the cleanup here?
That'll be faster.

-- 
Jens Axboe


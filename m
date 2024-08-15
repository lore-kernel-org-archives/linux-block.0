Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A370A1B9B5B
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732981; cv=none; b=VZkCP3j2lqQaUviMUHJ0YX0RXDYyTmSxJzXkaAN5/WA+IMygNNZzkvWN65O/C3kSbQb4YS4UR3189JT639MXx2UtUizf/2y3sq5IClkyea9UgqYrBhzKcq/cc9FjWv+BNwPl9Jrzb2UMPD17WT1PmLMP1Zj0Hf7Gpxk4m+6R5dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732981; c=relaxed/simple;
	bh=BdkFx2l/WomPo83NMJAsTV54fOrmRMhpw8MfNgdmLvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGUZ1wDOM3Q0iYRxOVUcMCzJENo3DvSSBq4AkvZUjzIrYQKXUIYDLM/DJUiTGCoh2+1lqAiR8mff2kJjUXS662RtsOD71DaNNQPduE84ziXdT6yLWmXsktxR2/ld6Dpf2gJWXDLepF3pNPjUQsidknvb5PWR87af7vVii2MN2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VW2CgO0o; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VW2CgO0o"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-81f8add99b6so2134639f.2
        for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723732978; x=1724337778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLQVxjToRHTTsTWidnkDOxtormh+P4ETVsPs0u31nWw=;
        b=VW2CgO0ofzCdY1R0grU75fsW+cOFSJPR7+1VtfE/2hKMavw6R/Qf61w/Tcz491mn5Q
         v2Oo6FwHCb2K+mw1CnrEmPpWGJNYZD83BGZEgnQpQrZdE7fPdbvBxX3uMGkv1+tv798a
         P/ouOzVN4ONLLWGhvWfVJ3ALb/yiNS8aNDea1At1GcSKiECne3yz9U7hNRph6gPwR6pq
         VjhYHOJRKBRIXU0awaDzhg6temsMU2+GzsY04gSJFH1Ae7mapFBTJJQ9b/HUvXgVFsZc
         vfp8TWE8PK8xFgk/dNCWjKgWWBryBLajbGi754nPBvKXWQvN1taKZP/nCv7RGWUSFf8d
         wrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723732978; x=1724337778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLQVxjToRHTTsTWidnkDOxtormh+P4ETVsPs0u31nWw=;
        b=qfvG8ERBwX2UeHqr/QM6G8fkvOVASibJFY0cgGDwmcAutAWr717JdI5DGBtFx0CVvn
         Zf6Fr3YJ6ycRpOuvEXIVh55TWljXb+0wktLeBM/4X3KXMJWBgDUJGCDbV78VCOyyi2+B
         MKRUZRBbTyb7fq+JjIcYrhJi3Q2ZdrPMkxgBjcknwlkYAGDCTUnHIczbylhEA1NwXV3U
         FSQd9WxNvn1FRDh4+++cDOL+51adg/vjvfwi/k/YhhrmS3IIusTZfA90sBJSvSYoMp+1
         5uFxnPTDTC0a1ApcaZAVahwh7Z9ev4Yb0dW1jBdeGbFQKnuvVGESAydU5kPJUmCe9a8q
         RPpw==
X-Forwarded-Encrypted: i=1; AJvYcCU/LgxwJte0W3TwQlFJcv5pS2HIGJ69OLilRar9+Cb+zFgcpOhVrr/755l7GLa2rC7idkVryygLE2+QbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOUc1vCddsWq9xEPzY7tSwTa6jhmEXn7Lh8E1WB5OfoQfEpnJR
	GqnG43+QtSP4kXfImoaj7jTbQQLX/R8zmogh83wobBdaiJH78WL/JifctVgeUbaDo9sfXrwqHBP
	U
X-Google-Smtp-Source: AGHT+IFzaXrg2hNk3mBUNAtA5z5C3113LDJGI8/gSRITKFMwrG8Z4L861A6eJ+m0YKVu9a5r7Zss9g==
X-Received: by 2002:a05:6602:314f:b0:81f:8295:fec5 with SMTP id ca18e2360f4ac-824f261391dmr1020039f.1.1723732977636;
        Thu, 15 Aug 2024 07:42:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-824e990d5b4sm53016239f.14.2024.08.15.07.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 07:42:56 -0700 (PDT)
Message-ID: <57951efc-2f43-4cd1-a053-f4a8f323118f@kernel.dk>
Date: Thu, 15 Aug 2024 08:42:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] block: implement io_uring discard cmd
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: Conrad Meyer <conradmeyer@meta.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org
References: <cover.1723601133.git.asml.silence@gmail.com>
 <6ecd7ab3386f63f1656dc766c1b5b038ff5353c2.1723601134.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6ecd7ab3386f63f1656dc766c1b5b038ff5353c2.1723601134.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/24 4:45 AM, Pavel Begunkov wrote:
> diff --git a/block/ioctl.c b/block/ioctl.c
> index c7a3e6c6f5fa..f7f9c4c6d6b5 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -11,6 +11,8 @@
>  #include <linux/blktrace_api.h>
>  #include <linux/pr.h>
>  #include <linux/uaccess.h>
> +#include <linux/pagemap.h>
> +#include <linux/io_uring/cmd.h>
>  #include "blk.h"
>  
>  static int blkpg_do_ioctl(struct block_device *bdev,
> @@ -744,4 +746,96 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
>  
>  	return ret;
>  }
> +
> +struct blk_cmd {
> +	blk_status_t status;
> +	bool nowait;
> +};
> +
> +static void blk_cmd_complete(struct io_uring_cmd *cmd, unsigned int issue_flags)
> +{
> +	struct blk_cmd *bc = io_uring_cmd_to_pdu(cmd, struct blk_cmd);
> +	int res = blk_status_to_errno(bc->status);
> +
> +	if (res == -EAGAIN && bc->nowait)
> +		io_uring_cmd_issue_blocking(cmd);
> +	else
> +		io_uring_cmd_done(cmd, res, 0, issue_flags);
> +}
> +
> +static void bio_cmd_end(struct bio *bio)
> +{
> +	struct io_uring_cmd *cmd = bio->bi_private;
> +	struct blk_cmd *bc = io_uring_cmd_to_pdu(cmd, struct blk_cmd);
> +
> +	if (unlikely(bio->bi_status) && !bc->status)
> +		bc->status = bio->bi_status;
> +
> +	io_uring_cmd_do_in_task_lazy(cmd, blk_cmd_complete);
> +	bio_put(bio);
> +}
> +
> +static int blkdev_cmd_discard(struct io_uring_cmd *cmd,
> +			      struct block_device *bdev,
> +			      uint64_t start, uint64_t len, bool nowait)
> +{
> +	sector_t sector = start >> SECTOR_SHIFT;
> +	sector_t nr_sects = len >> SECTOR_SHIFT;
> +	struct bio *prev = NULL, *bio;
> +	int err;
> +
> +	err = blk_validate_discard(bdev, file_to_blk_mode(cmd->file),
> +				   start, len);
> +	if (err)
> +		return err;
> +	err = filemap_invalidate_pages(bdev->bd_mapping, start,
> +					start + len - 1, nowait);
> +	if (err)
> +		return err;
> +
> +	while ((bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects,
> +					    GFP_KERNEL))) {
> +		if (nowait) {
> +			if (unlikely(nr_sects)) {
> +				bio_put(bio);
> +				return -EAGAIN;
> +			}
> +			bio->bi_opf |= REQ_NOWAIT;
> +		}
> +		prev = bio_chain_and_submit(prev, bio);
> +	}
> +	if (!prev)
> +		return -EFAULT;
> +
> +	prev->bi_private = cmd;
> +	prev->bi_end_io = bio_cmd_end;
> +	submit_bio(prev);
> +	return -EIOCBQUEUED;
> +}
> +
> +int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
> +{
> +	struct block_device *bdev = I_BDEV(cmd->file->f_mapping->host);
> +	struct blk_cmd *bc = io_uring_cmd_to_pdu(cmd, struct blk_cmd);
> +	const struct io_uring_sqe *sqe = cmd->sqe;
> +	u32 cmd_op = cmd->cmd_op;
> +	uint64_t start, len;
> +
> +	if (unlikely(sqe->ioprio || sqe->__pad1 || sqe->len ||
> +		     sqe->rw_flags || sqe->file_index))
> +		return -EINVAL;
> +
> +	bc->status = BLK_STS_OK;
> +	bc->nowait = issue_flags & IO_URING_F_NONBLOCK;
> +
> +	start = READ_ONCE(sqe->addr);
> +	len = READ_ONCE(sqe->addr3);
> +
> +	switch (cmd_op) {
> +	case BLOCK_URING_CMD_DISCARD:
> +		return blkdev_cmd_discard(cmd, bdev, start, len, bc->nowait);
> +	}
> +	return -EINVAL;
> +}

This is inside the CONFIG_COMPAT section, which doesn't seem right.

-- 
Jens Axboe


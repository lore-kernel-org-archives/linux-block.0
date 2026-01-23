Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A7628751F
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 03:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769139166; cv=none; b=Wg0lrG0erXOkQE/XF6ra2LOMmP7eh58/2M0WL5qijTLmUv4/zqypyerEn19PYug7xhIf7tXKLPhPbZN5ZtfvujuZrHJMDNzMQsDQ3+SGZ/t1Zpb5IN6I7t/n2n3LwMgvgglxeafBVYh2zwmRHV57AkENJLsYsvho0c7uRjC2w3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769139166; c=relaxed/simple;
	bh=tuRVSF3SKRKBDSthLQ1PyR8NPfxw8My0GMqonFgsOTE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QMcZGnrPLuwZ3HNguK7Fg+wcdVcbm3KLE0jMLNq2MG7QllbRTlPLi3rZuJC/6PNFTE1txrS3igJrkBC1kNL/vSttV0O7W5xyQkbue36b14jK/xf6i3wG2r+f7GhyVKa5AOgTfTkj5JAFyZMz9Ax3U/45im3wglq9Ub77jT4l+94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rzePrDvA; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rzePrDvA"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7cfca52ac2dso1261376a34.0
        for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 19:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769139146; x=1769743946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hxzS+YjAYZ/Z4fbIAWQo/yLtdb+CpF3mDoXOB1ku/v0=;
        b=rzePrDvAham03TLFsB6lWECN7B/1h++aI1CCIrpAd4/UdjNgJ0TJqnnp/KLV2FdHOD
         dGWX9IivrjR0aUituPYQIy78iBxFdEuumoJdyWOcwcsgRaEia+33uZbdBqPRtVCnEpd7
         QKoA6sqG/r/icdhqyEglYk4/HKn+ha2qIESxEkNPve7fdhJuiGSr4l3ModVJ/d7rO22L
         +blPlFsBsZf1UpNa1jsiM8xi8kuxEMkFUgXgUVX7vgQiPAef1J07GFfayN2mfFVpGVNY
         So5lc4331kSdN8Q3fiaEAr1Y3dEIgGLQi+U3LQ+7fhFIdjABimKa0HfSxj7KJuCXp+mS
         C6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769139146; x=1769743946;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxzS+YjAYZ/Z4fbIAWQo/yLtdb+CpF3mDoXOB1ku/v0=;
        b=niZaCDIjsfi7YlsOiwwM5bTXQFRGAi97VliWTJwLBptYNhslU5HQOox2MqLbsrbOYv
         TA/7jRUw8cjhpubSAkojGY0fMiG4T3MN7oifmbX5RMzc2iaVaLvXzXZTXMIX9Gorl0hJ
         1ljZKfx9SD7bAitP6hN9gtndrTVRRMz6lVkl7mqvr14GS8RJWMKNh73yGMueOsWBGvof
         WrpsP/tj4jwQR39sn0ADpxaQYjGzZYVWWTmbCWakV4h/L1rBuFx8+fWV0SFVKYUGQiPN
         feUVrrYnWguURy0fSaI4Fg1yfxO5I2x+s/Dy2funnWqPp8nG27hnubF5BqJEXEubCMHQ
         nPEw==
X-Gm-Message-State: AOJu0Yy9rXQ7qDC8yWxdf+NcT6Q/9Gyg8olzBO5YDScFcex+0iqG7khJ
	GENC+JOkFxvg3n1cfrVtr3UihLkMMurUl8zWyGFPBW9l+8MyaUpfi+RwOhZY9b9vVHA=
X-Gm-Gg: AZuq6aJdQMYMA6kpFiDyrNUx3h4i1Na84Q72F46Of6jWN796Ncs0VO/+Whi8TJmQM1O
	uxPIO7t551qS2Kre8NlFouLURaNHlOdgB+8v+fBJD1t/SICxc4DEaGeC5mZz4xF6ZozNEXqZajx
	YLd/BlYXRo5zmoDrUnHMyxiKX2YFtmuuCDpseuncBWgIaVKBsus+kwSdZSE3s6IPXpeu5g+x7Dv
	6pLwCjt75ZufH0eiBHgETKm1bkOC9j5N1j9rVuq5zI+sLZKDESOicWSrav45NL2zBP0LBDx8cqa
	UJQzhCEuQGBpWit4rRRsK9EXrIXKU+ryZKMT5CMLCJbSPFftrdzodvk9yIgQjt4856S/hCGxUCM
	+s0BYzRFl76OzUOFy138SeA/ZVmFwfmA1jrkAUqHuBZk1igMFp6Zg9xzuBycoxknNMHNL7HS+c0
	dn5/0/r2pE80G41k1JiTQGWyfsnOyy4LXHaGd9rD12h0QeNMajC/f48BmhSx0U7ibA0vAnUg==
X-Received: by 2002:a05:6830:2aac:b0:7cf:d213:7ecf with SMTP id 46e09a7af769-7d15a633c68mr944024a34.32.1769139146302;
        Thu, 22 Jan 2026 19:32:26 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d15b346e1fsm937858a34.4.2026.01.22.19.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 19:32:25 -0800 (PST)
Message-ID: <a56a1182-72da-47ff-98fc-d1d33afcd557@kernel.dk>
Date: Thu, 22 Jan 2026 20:32:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V6 07/24] ublk: add batch I/O dispatch infrastructure
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Caleb Sander Mateos
 <csander@purestorage.com>, Uday Shankar <ushankar@purestorage.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
 <20260116141859.719929-8-ming.lei@redhat.com>
Content-Language: en-US
In-Reply-To: <20260116141859.719929-8-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Claude says:

> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index e5db5a552357..e7bd7e7b1731 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c

[ ... ]

> +static bool __ublk_batch_prep_dispatch(struct ublk_queue *ubq,
> +				       const struct ublk_batch_io_data *data,
> +				       unsigned short tag)
> +{
> +	struct ublk_device *ub = data->ub;
> +	struct ublk_io *io = &ubq->ios[tag];
> +	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
> +	enum auto_buf_reg_res res = AUTO_BUF_REG_FALLBACK;
> +	struct io_uring_cmd *cmd = data->cmd;
> +
> +	if (!ublk_start_io(ubq, req, io))
> +		return false;
> +
> +	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req)) {
> +		res = __ublk_do_auto_buf_reg(ubq, req, io, cmd,
> +				data->issue_flags);
> +
> +		if (res == AUTO_BUF_REG_FAIL)
> +			return false;
> +	}
> +
> +	ublk_io_lock(io);
> +	ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res);
> +	ublk_io_unlock(io);
> +
> +	return true;
> +}

[ ... ]

> +#define MAX_NR_TAG 128
> +static int __ublk_batch_dispatch(struct ublk_queue *ubq,
> +				 const struct ublk_batch_io_data *data,
> +				 struct ublk_batch_fetch_cmd *fcmd)
> +{

[ ... ]

> +	sel.val = ublk_batch_copy_io_tags(fcmd, sel.addr, tag_buf, len * tag_sz);
> +	ret = ublk_batch_fetch_post_cqe(fcmd, &sel, data->issue_flags);
> +	if (unlikely(ret < 0)) {
> +		int i, res;
> +
> +		/*
> +		 * Undo prep state for all IOs since userspace never received them.
> +		 * This restores IOs to pre-prepared state so they can be cleanly
> +		 * re-prepared when tags are pulled from FIFO again.
> +		 */
> +		for (i = 0; i < len; i++) {
> +			struct ublk_io *io = &ubq->ios[tag_buf[i]];
> +			int index = -1;
> +
> +			ublk_io_lock(io);
> +			if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
> +				index = io->buf.auto_reg.index;
> +			io->flags &= ~(UBLK_IO_FLAG_OWNED_BY_SRV | UBLK_IO_FLAG_AUTO_BUF_REG);
> +			io->flags |= UBLK_IO_FLAG_ACTIVE;
> +			ublk_io_unlock(io);
> +
> +			if (index != -1)
> +				io_buffer_unregister_bvec(data->cmd, index,
> +						data->issue_flags);
> +		}

Should io->task_registered_buffers also be cleared here?

When __ublk_batch_prep_dispatch() succeeds with AUTO_BUF_REG_OK, the call to
ublk_prep_auto_buf_reg_io() sets io->task_registered_buffers = 1.  In this
error recovery path, the buffer is unregistered and UBLK_IO_FLAG_AUTO_BUF_REG
is cleared, but task_registered_buffers is not reset to 0.

If the tag is later re-dispatched and __ublk_do_auto_buf_reg() returns
AUTO_BUF_REG_FALLBACK (e.g., due to -ENOMEM), task_registered_buffers will
remain at 1 even though no buffer is actually registered.

This could affect ublk_sub_req_ref() which calculates:

    sub_refs = UBLK_REFCOUNT_INIT - io->task_registered_buffers

If task_registered_buffers is incorrectly 1 when it should be 0, the
refcount subtraction would leave an extra reference, potentially causing
the IO to never complete.

-- 
Jens Axboe

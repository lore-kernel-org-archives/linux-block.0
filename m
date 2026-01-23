Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2FA2D3A89
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769139083; cv=none; b=pHLhGSmAGvXWugQv6Fx0Al5aW5X3ZuDKX5i3xIqU3uwGUx4WauV6o9/ncyQtYovY97eNuT2PtqQuC8X/95ul0RBM5/GnxZTN9PAcJVvLcrYguMkV9PEit84MLaSN0bKfVLXyJ9gC4FKQm2cJIZ+nL5aoflGoKzmIqkRoxXkQ894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769139083; c=relaxed/simple;
	bh=GCzNM3NmwjjxxxlQLJ2P1I+5nAZi3pMpi2vxw5fZ1Ko=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lnT/o/8HrJyIfSI3u+dS6ytPFK9wP4SD1APN3pJo+Uza55TKxcoDag/d+PS86Q5/y90kvey5Prr3xHwaxuLjiPeMhXwFI/wQbxVRAw39+9/gwxpHEVRbSePu6ZiaC6XvxXE6cbDyEBbvOO7xBfmTUJB/R8qZGKc5XMByYhDFjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rgiPOW7Y; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rgiPOW7Y"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-408199852c5so763838fac.0
        for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 19:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769139076; x=1769743876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bu5bL8n6asIqvqMYEtrCuB43385ClA9yMFw7iXYJ5WI=;
        b=rgiPOW7YkOk+QDW2geedNe/VIQJeYLvI56ig/BRqRKzhlg8hOsCQDpzexHEa/IlPdP
         6K8vFs0B6dWqfJvZVod9fU0wHZAYFQHyff6NME0e9y4ldfC8pAbJKYy/Ekx0mPNjlVml
         HFttVkAMBvnKaTnQ5Uw4c0ArPe4KyEyiai84gNA3GDLSAR9g4vFqI1QZkhi6NR7MHAj9
         2F/CTV9quxe2lRD0jHLSy8kYa58UKLamxgs+qdvxUH6WYIY5Gmhlr85gDCqWOf/fvzw/
         o0JKkv14NWSJH3OWmIpXYp8pORPD+4kSsrEe724Ls/6DOoeHFQvNumpMKS/vf1xUkW5z
         8mLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769139076; x=1769743876;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bu5bL8n6asIqvqMYEtrCuB43385ClA9yMFw7iXYJ5WI=;
        b=ezl6xNfliY4jsrzTI1V8s/JCraNsmm21WIZ44EwBFs2JI+3yZ0haNUuPjTbKprEoO2
         wbtGvztY3l1zH+GuybDXZVprTJbGoGUO+P9PMNi5FwN67nSO4cbVBrkIBbOlBit3QPEO
         HmRbgex8i373dzAVDZkMMszXCbHmsvb5AU4vsiMUCT0eUitCtX4IbPPIv/ea2sH13imc
         PNle3beJWF4aPIBNxyKd56cP3rhLcoJOsydGUQ/ypyhuN1CzBukvIWGZmnTD/EdCX4cI
         dD5+qzrsqUX75/yMw/IhHwtl5GTyvevYcldKYWJsABCR0LVyM7IVzrmqp+WwUg38To+U
         Km6A==
X-Gm-Message-State: AOJu0YwvmpFROGHLWG7jn6/rP7ugaphjIQv6nLm+MucLDuxOFaPMU1px
	tySSN9GBAIwM7JVSfTMOxp1hsGqg2cDQFkvIE3kQRPmd2kqK42plZe3nQNjj3q77WahLkATrl7R
	IdFAJyjU=
X-Gm-Gg: AZuq6aKBCTHAxbgwZvmqyHq0uSH0YzPyGJLGITfOALtSiBRVkzaCvg2jNx31GtI4ex7
	G6XX3DD4XgX8sBqH6dwaT52gL2ysulmgOjOswSYL8iKc5rUo5HnD813X1pPSkzfmPt81MFwLGT1
	vkshsy6kQ7cOV1pcctPE7pedN97L/Z2t4W4Hcm76yO19ibbfERMj47h/orNhaaCVeXy7bxldwNy
	kO1FjP3mhLGqXbXPaKxfaKLVDO8NDYWrMh0f9JR1JToC8a9XcpKV1Evot0kITCN5KFDdFpWNDKV
	w4IdMJiX4S/gpk5R6UI1zJTl4JkieusQeQ8nBXoBucYOWba/FqxLp+9MjWcCnGTnE3s/KzDJIuO
	fzCnAR9jQ+F58/P6FPROsO/929oIuc2ic4+gKgwJOC5cqZuR1+exisfrUCxELkx936kHj99BMQU
	woAlhyR0FoGJW0RcDNuu8LYZmyrGaBZDpDCo0pUMUJbl9JE/yxPbrqe38RyUhknod8a7zfNcV00
	tXoaAmd
X-Received: by 2002:a05:6820:4c86:b0:65e:f0f9:aa5d with SMTP id 006d021491bc7-662cab43c38mr775969eaf.40.1769139076155;
        Thu, 22 Jan 2026 19:31:16 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662cb4e5f47sm637086eaf.3.2026.01.22.19.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 19:31:15 -0800 (PST)
Message-ID: <0a09d08d-b400-4111-b2b6-b0a70b5bbd71@kernel.dk>
Date: Thu, 22 Jan 2026 20:31:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V6 04/24] ublk: handle UBLK_U_IO_PREP_IO_CMDS
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Caleb Sander Mateos
 <csander@purestorage.com>, Uday Shankar <ushankar@purestorage.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
 <20260116141859.719929-5-ming.lei@redhat.com>
Content-Language: en-US
In-Reply-To: <20260116141859.719929-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Claude says:

This commit implements handling of UBLK_U_IO_PREP_IO_CMDS for batch I/O
preparation. It adds a per-io spinlock and walks the uring_cmd buffer to
prepare each I/O element.

> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 9fd81213b81b..6aef1a856a80 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c

[ ... ]

> +static int ublk_batch_prep_io(struct ublk_queue *ubq,
> +			      const struct ublk_batch_io_data *data,
> +			      const struct ublk_elem_header *elem)
> +{
> +	struct ublk_io *io = &ubq->ios[elem->tag];
> +	const struct ublk_batch_io *uc = &data->header;
> +	union ublk_io_buf buf = { 0 };
> +	int ret;
> +
> +	if (ublk_dev_support_auto_buf_reg(data->ub))
> +		buf.auto_reg = ublk_batch_auto_buf_reg(uc, elem);
> +	else if (ublk_dev_need_map_io(data->ub)) {
> +		buf.addr = ublk_batch_buf_addr(uc, elem);
> +
> +		ret = ublk_check_fetch_buf(data->ub, buf.addr);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ublk_io_lock(io);
> +	ret = __ublk_fetch(data->cmd, data->ub, io);
                ^^^^^^^^^^^^

Can this cause a sleeping-while-atomic bug? The call chain is:

  ublk_batch_prep_io()
    -> ublk_io_lock(io)         // acquires spinlock
    -> __ublk_fetch()
       -> ublk_mark_io_ready()
          -> ublk_reset_io_flags()
             -> mutex_lock(&ub->cancel_mutex)  // sleeps

When preparing the last I/O that makes the device ready (nr_io_ready ==
total), ublk_mark_io_ready() calls ublk_reset_io_flags() which tries to
acquire ub->cancel_mutex. This is a sleeping operation but io->lock
spinlock is held.

The existing ublk_fetch() avoids this by NOT holding the spinlock when
calling __ublk_fetch() - it only holds ub->mutex. Should ublk_batch_prep_io()
move the __ublk_fetch() call outside the spinlock-protected section?

-- 
Jens Axboe


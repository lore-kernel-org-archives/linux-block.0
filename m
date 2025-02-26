Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BB621E096
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595230; cv=none; b=gc6d7qrfekuHgp5hpWk3cEj4LZX4ZdjIJdubgHTJ8VpRN+F4WG7bRbcwnIp9fRCw7YJe+5b5/Gg5KxPrNGZs9gH86+ZfW8uoCN8Dfr9nP0FpbW8fuDRpUUyxV7WGvCER/fus7yU3AkL0sxWK8UAtQ47URcxKu0zcv2DLMhD5qtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595230; c=relaxed/simple;
	bh=SDS0zwcWP2Bd6umi8vdUr3ksCcJLy0HftJFhDpHch6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGAhxRQzB73EwL+wLX4ZeYKyY5NTKrdT70HkNZkzHnvIeyJpERFPsgM99My5fQkZZ5RPIQ7oBSv0mUO/+gPVsxuZTpBTpiGB0lykxcAGCeKUbCUD8cUyvwyxpxdl9aqgoX/fYtCCBm8N2rrZY4wKcYm2S7fgTLeDBfTqIRsXn1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HUaa5P1B; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HUaa5P1B"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso523225ab.1
        for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 10:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740595227; x=1741200027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=symdU9EMvj/OBJzqzheNQbsiM+qkoxN4bra1Wzcsq1I=;
        b=HUaa5P1B61CeVR4yzIeb40L4W1lNYAMP+Ls0sQLoCvEKekHVSS3NG5NNZ5FG+PW57I
         U2iS+eJrulNo2wAG7Uq1JIbmzyI5Dy3kAUgimN7wRg8giPpvfFyA2FlcZXnNmnTxSM0h
         U+5hPcP3iJms3aKcKlhgEdc+fi9ZvKnTg3sAJ0xWlo4WqZt0eitaj0Nr+qEr5nYXOE2G
         eXfTf+R3xMtaHT8GQ3DDIrv+Lmt9NEacNM/o38jYvDfezXlNFsZn6tfOnEQpFKcloECu
         pYrKdZogP1VT4h21LFMuCq65yZsFzQ7d6L0w4xj+EywQRrlfk6jl5tWrY3HRjknfrCAi
         nzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740595227; x=1741200027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=symdU9EMvj/OBJzqzheNQbsiM+qkoxN4bra1Wzcsq1I=;
        b=f21D/W6+oUHHOWfUES4rdUtu409zT1Xg4956PJjIrGJxKmpOK+Hbin0SpIjCzefNfx
         fFgcWzrSMJrL9ij/5qC6IXSF30+IWVC6CPzw1u+tmV/Q/ZoICK/lirg21SFi4JSleFyd
         46Zl+haFqEnS7yH2p0FS+RCD3XVTkfZlnshaSnzUUbAoT46fEL18pcuIuEzRmHWZXfhN
         c1aPS2SbMHGy7nSIfgrOQLHBuUXdliqya+/anNGZtGYpFeLOa/otTNh7dnGMIWPDnsy+
         pmsvGhtWaEol6VvU5Mndoces/3ShufAcNQHLsMHM2ZO5Mynn0pJOAVNToBBhd50W5NuT
         fmbg==
X-Forwarded-Encrypted: i=1; AJvYcCVb5FYTE374zh9vu24yePhWKo8taCEvVh5xORWK5ixTji+TzbdbGfMclfa7TD0TVwtR8jJm/C2wqKEt4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPGBuqDfLqdRpq1B5O6aNVd+bdq2AjahfKqZJPPI2A4oNvnOkx
	AeJnYRRDkjbtaqw8F3j3TB2+TSDtG2s28uINqRpY893xW63+DLcY63+2YvNnz6yXu5FOBZZMvRi
	5
X-Gm-Gg: ASbGncv8rFTO+YDrIEYOX9c3dVP44JCiuHnraEdffIckn7TdvEGlu58UmAraSwrkNQb
	HYSDEe5nh7V7DKMP7Z3i4tHw86w4C3GpZxxvISlVE4WIDx+tjFDTgS+2i4XC1VoLrnGU0OJNz8J
	qRMHYpoNJsZAo/DTVfkzSbgZxoz6bfHrlMGAYu9CVCUzwmPTskdmclzPjaYVfWYLuM3Y2cWIb2F
	M3R77r5s1sMfrPc8h0I59gF1hbvr85zTV/zsj6mdN61RC5/9ttTtvacGFImuEsx7IkCDCzjznBn
	4tI+fKIMQglWt4pLL/4akw==
X-Google-Smtp-Source: AGHT+IEcVGZxj+MZL024go/7Ek44HCywTu0ZTaoD2vxe2DtY/vJ/oJ+MqLDaGS+x97+xAMqCCyDQ4g==
X-Received: by 2002:a05:6e02:339f:b0:3d3:d23b:21f7 with SMTP id e9e14a558f8ab-3d3d23b23a8mr56142825ab.18.1740595226635;
        Wed, 26 Feb 2025 10:40:26 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f047530650sm1033139173.117.2025.02.26.10.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 10:40:26 -0800 (PST)
Message-ID: <f987f9da-4aa0-47d0-b906-8790afe6be60@kernel.dk>
Date: Wed, 26 Feb 2025 11:40:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 4/6] ublk: zc register/unregister bvec
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-5-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250226182102.2631321-5-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 11:20 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide new operations for the user to request mapping an active request
> to an io uring instance's buf_table. The user has to provide the index
> it wants to install the buffer.
> 
> A reference count is taken on the request to ensure it can't be
> completed while it is active in a ring's buf_table.

Looks pretty sane to me, just a few minor nits below where only one of
them actually is required to change.

> +static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
> +				  const struct ublksrv_io_cmd *ub_cmd,
> +				  unsigned int issue_flags)
> +{
> +	int index = (int)ub_cmd->addr;
> +
> +	io_buffer_unregister_bvec(cmd, index, issue_flags);
> +	return 0;
> +}
> +

Minor nit here too, I'd drop 'index' and just cast it in the argument.

> -static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
> -		struct ublk_queue *ubq, int tag, size_t offset)
> -{
> -	struct request *req;
> -
> -	if (!ublk_need_req_ref(ubq))
> -		return NULL;
> -
> -	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
> -	if (!req)
> -		return NULL;
> -
> -	if (!ublk_get_req_ref(ubq, req))
> -		return NULL;
> -
> -	if (unlikely(!blk_mq_request_started(req) || req->tag != tag))
> -		goto fail_put;
> -
> -	if (!ublk_rq_has_data(req))
> -		goto fail_put;
> -
> -	if (offset > blk_rq_bytes(req))
> -		goto fail_put;
> -
> -	return req;
> -fail_put:
> -	ublk_put_req_ref(ubq, req);
> -	return NULL;
> -}
> -

This could be a prep patch to cut down on unrelated changes, but not
really important.

> @@ -2459,7 +2507,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>  		 * buffer by pwrite() to ublk char device, which can't be
>  		 * used for unprivileged device
>  		 */
> -		if (info.flags & UBLK_F_USER_COPY)
> +		if (info.flags & UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY)
>  			return -EINVAL;
>  	}

Missing parens here around mask.

-- 
Jens Axboe

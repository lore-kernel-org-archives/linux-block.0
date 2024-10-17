Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6CB36AF5
	for <linux-block@vger.kernel.org>; Thu, 17 Oct 2024 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729204291; cv=none; b=OBd6PgQFU5ddWgICuP3H/mOfNhl62Bjpo3aCERprcLkKFnv6CnpAjGIf0MjbHbpGpydB3TYeM0xoJte2GG/hZj0vuYF9d+K3UL9pMfcj9m8Jm1B9mtPvn7Zqbgl2wDv63EGxBU9uJYlOWfGn/4vThuaLJLN0Xut4ZyZ/YCAXKBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729204291; c=relaxed/simple;
	bh=wk78pm9A4wHGUJAGgC3pZI461YJyrUTx/sPnr9UF0G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IT0UW7Naob9+Q2lnN1Q5i5mUmW98MTUHG9eVBdTew0QuEgXlPXPKk6GYwArYdDCAzIUZT5hWR2SGQxLqs5K8ZtrulGQD4J0hFZp3oEVNs/EV/UrLbF36E9fi8BWJKPoF2mQIBBJ7JTNVfACoKcZzXFxBlLrsf5z/FYDQvn+Ka6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bul45V/m; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bul45V/m"
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-5e5a0519d00so655091eaf.3
        for <linux-block@vger.kernel.org>; Thu, 17 Oct 2024 15:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1729204289; x=1729809089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01Ao9hN/kTz0hVqpiuP+bXoNmbAQDLYKmsJTnEYA3R4=;
        b=bul45V/magsAj6PbCCBG/ZBdrigA7WqE9SqUygwi2tK39SCQ7zr28RNml/EloFcBFB
         Jm/exItr0zyy6mwbZvOI2mULO9OrtWySBEa2qX9pMFRMlkQFv19plz9Ni9dGaoMbxx+8
         GXhDgtBKw22HfNx/O4wkQOwLePDsoYYdwuaQdAj8xqhCq88W+AxJIPG1bPwN9AWJdm8/
         xxa5ZuePu18Z0Tb0knXlyhSo3Ap0yh9W5tm/GWfngtPXiaclMiJ8y8zE6zdGK+u2+JFh
         byZC1lFJue4GLKtdLhmJILaDG5g9WUxhM9SUDZbl4Q0+cIyAPNWM65sQ4aL4rNo61r8F
         Q/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729204289; x=1729809089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01Ao9hN/kTz0hVqpiuP+bXoNmbAQDLYKmsJTnEYA3R4=;
        b=flv4Aq8R7//GfQn7E1xuVGtOkg8D4LcD9/3cNLe1dEZGyIfmrWxt1fmMLMO0goUEt1
         QdiQI99Z7d+ooEKe0SJyj/8Wp8VvwCMt+0w/uTJHn0k8N938Um7E/6q02T3zRg7kuWjN
         KtiJfTxih9l1Pnaf8he2Tl+DIGW7VLgxiEG81ivD7CbCEP0reZQkCfjwobZi7W2SSzXC
         g1tEdDqbqG/K0qBvRCDbksKXiZrNVwAQ+Z9d8q8fbdER6LKNBftf6IE4TS1yZwUGntC5
         oNmcVT3pvh5EqS+FGKTfw0eCwvBHFaW/X+D8AsqfBdDz7S1UaPc6GD4GQ03tml0/w00h
         4cqg==
X-Forwarded-Encrypted: i=1; AJvYcCVIYwtYoPcyzIKFSoXoTlANsAweFKS2ijKkzkV5Ip/d/vWJRl2v4rPEKw36h3GqWXQbIOl4VX1f6yi9gQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJIG6+wBHMFMyav6ux7a09P/SY65sKm8MrRTUOp+kqM9v36b5l
	TYt8G6xosA/N3vlyAmkYD0yOyfR2MY9MMojBEjDEU4difpEzopPI+wmyG9hdIRK6OBUfmEm/r2q
	wqL/cIUDLGuhubFIgNFDvW6/b4k9+qL4R
X-Google-Smtp-Source: AGHT+IHA3V3Z/+WLVZlhVvJt5Ls1583QiP3dkdawaIsOXLjr7NYnfApMcV+SfGMQYJRWOeHXsOyei/Au7lzN
X-Received: by 2002:a05:6870:b628:b0:277:e1e8:a085 with SMTP id 586e51a60fabf-2892c330c99mr309696fac.23.1729204288839;
        Thu, 17 Oct 2024 15:31:28 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2892afdda33sm16477fac.39.2024.10.17.15.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 15:31:28 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0320734029E;
	Thu, 17 Oct 2024 16:31:27 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id E7821E413D0; Thu, 17 Oct 2024 16:31:26 -0600 (MDT)
Date: Thu, 17 Oct 2024 16:31:26 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH V6 8/8] ublk: support provide io buffer
Message-ID: <ZxGQPgvfquLw8AgP@dev-ushankar.dev.purestorage.com>
References: <20240912104933.1875409-1-ming.lei@redhat.com>
 <20240912104933.1875409-9-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912104933.1875409-9-ming.lei@redhat.com>

On Thu, Sep 12, 2024 at 06:49:28PM +0800, Ming Lei wrote:
> +static int ublk_provide_io_buf(struct io_uring_cmd *cmd,
> +		struct ublk_queue *ubq, int tag)
> +{
> +	struct ublk_device *ub = cmd->file->private_data;
> +	struct ublk_rq_data *data;
> +	struct request *req;
> +
> +	if (!ub)
> +		return -EPERM;
> +
> +	req = __ublk_check_and_get_req(ub, ubq, tag, 0);
> +	if (!req)
> +		return -EINVAL;
> +
> +	pr_devel("%s: qid %d tag %u request bytes %u\n",
> +			__func__, tag, ubq->q_id, blk_rq_bytes(req));
> +
> +	data = blk_mq_rq_to_pdu(req);
> +
> +	/*
> +	 * io_uring guarantees that the callback will be called after
> +	 * the provided buffer is consumed, and it is automatic removal
> +	 * before this uring command is freed.
> +	 *
> +	 * This request won't be completed unless the callback is called,
> +	 * so ublk module won't be unloaded too.
> +	 */
> +	return io_uring_cmd_provide_kbuf(cmd, data->buf);
> +}

We did some testing with this patchset and saw some panics due to
grp_kbuf_ack being a garbage value. Turns out that's because we forgot
to set the UBLK_F_SUPPORT_ZERO_COPY flag on the device. But it looks
like the UBLK_IO_PROVIDE_IO_BUF command is still allowed for such
devices. Should this function test that the device has zero copy
configured and fail if it doesn't?


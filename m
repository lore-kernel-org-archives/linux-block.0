Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A31DF738
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906234; cv=none; b=F6e9rk1aVzENCCDMto5VvAyEShxAz7xl4hyiMocoISNbePJqVqYxFXY3D5Hy4hI8llawKR0u9qatrl/gomXrwjWk5nhbRZ3OBr2dn9pbrxD5LoStA1jQPdeVV3eT08YWlIyjdrx1Mn54Hn9yLkIUyaRF0FSnqJakqxqWNUrEhno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906234; c=relaxed/simple;
	bh=gwhIT01Rty6D3qESQCpRlUMDB3Aw6oKB5NyfMA+odNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3RIVFOAD9K9TcsBwZGFPrgUAuvKaBCRxshTz9EgsFFQACE28pb2sUCmIcjGgVcoTYyN7hFqM6X6rYx6ZsNqruc92q/FqqW5qM6VCpIQRecob9KTtDDoUKPskzdvBZS/vRgUwNNVPAPayoFgcIkh3qiwBlQpSFKV7k2yJz3t8Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Bhd48pl+; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Bhd48pl+"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83aae6aba1aso239012939f.2
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2024 07:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730906232; x=1731511032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fU6iZ4qpfSFQA/Yqv1SRdLVGe0meMYepxYwkN5DksAw=;
        b=Bhd48pl+5YsJCXxDhXIhuKJ4St9fstzYCGhEPMRsO3AvwJMLrlj5NyGMIEMCkXQkMI
         t71EVGTXr9bhBqmnHmCZerDGZHsFb9hC9SlzmfwAIN5hcwCcMUesNxNetzN+mBvPXzLK
         5Hbpr3Dimy1zlrJgTvyUpre/GRQo4t2dAiasnrHdbhE0oB2gTMGR7OR9F7mMmNzF/rDo
         Iuol7UNzn7aw0qGLkX1iuznv7Rb/HxsMMSnDdHM59v9MGuiSppUyBWDS4SZQYZpHRn5o
         7C2l51IbWR86JT/KY911iNmexYP6xjr4jrZeO91NXaHual0oqaNX9fPWycnDuQ2/xYxR
         sbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906232; x=1731511032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fU6iZ4qpfSFQA/Yqv1SRdLVGe0meMYepxYwkN5DksAw=;
        b=fRAFIB6n0JP9adWKfyqdj1+9WgEHsNwwxefLsLc64IeF3T4euzw6TI3lgcyWalbVCc
         X9q4IBxEcoxry3NZpXV/nvOh8JWnZi/O+7tMA1evunU+CPLLq8jjMqcKVWUyg1PBT3O4
         5b8irTnRJEojElCFWTWkXbPZp7Rbr+0Yp9AtOPZZe0VTqvLRObpusL6UpcnNH5qri9/h
         ZFRlk4AQsKut/93FxYAgGp3fMQTNqQkzjrdFppPYAqDBscbSD3vodaD+t0SiobMiIII+
         0Fw47RyvB5ROnpelggEQ8Xw8xFS2Z8rh78CLe6NNEH2FOXBco83MpddKnR3SU3q2MgCp
         n5/Q==
X-Gm-Message-State: AOJu0Yw4nFTKWMqbnvAt2R+p+AZiQD+0ThGZD8AlJRlMNEoP/OMQs9q9
	bbOcWxMHWUKIGRgDQRJIoDGfLt/yfo3HoodIBwOiEgMkXoL+65X56snfKsnRavEr3GAdG1UGwD0
	/8zE=
X-Google-Smtp-Source: AGHT+IGgE8xdpIjMmnXO4QOkmSW2OCnqnEdZE8DQuVNanaXpoLOG/fPE8oOW4EjfaTFY84uZIDez1Q==
X-Received: by 2002:a05:6602:2c05:b0:83b:47:8d5 with SMTP id ca18e2360f4ac-83b7190ab09mr2451131039f.3.1730906231712;
        Wed, 06 Nov 2024 07:17:11 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de049a4739sm2897084173.136.2024.11.06.07.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 07:17:11 -0800 (PST)
Message-ID: <8f2cb112-29bf-4aa1-8d5c-5291d9f634fc@kernel.dk>
Date: Wed, 6 Nov 2024 08:17:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 5/7] io_uring: support leased group buffer with
 REQ_F_GROUP_BUF
To: Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>,
 Akilesh Kailash <akailash@google.com>
References: <20241106122659.730712-1-ming.lei@redhat.com>
 <20241106122659.730712-6-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241106122659.730712-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 5:26 AM, Ming Lei wrote:
> @@ -670,6 +689,14 @@ struct io_kiocb {
>  		struct io_buffer_list	*buf_list;
>  
>  		struct io_rsrc_node	*buf_node;
> +
> +		/* valid IFF REQ_F_GROUP_BUF is set */
> +		union {
> +			/* store group buffer for group leader */
> +			const struct io_mapped_buf *grp_buf;
> +			/* for group member */
> +			bool	grp_buf_imported;
> +		};
>  	};

Just add a REQ_F flag for this.

> +/* For group member only */
> +static inline void io_req_mark_group_buf(struct io_kiocb *req, bool imported)
> +{
> +	req->grp_buf_imported = imported;
> +}
> +
> +/* For group member only */
> +static inline bool io_req_group_buf_imported(struct io_kiocb *req)
> +{
> +	return req->grp_buf_imported;
> +}

And kill these useless helpers, should just set or clear the above
mentioned REQ_F flag instead.

-- 
Jens Axboe

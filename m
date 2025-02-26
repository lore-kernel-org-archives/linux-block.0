Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7E229B18
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595725; cv=none; b=W9CsCSWHpIQXAxssZ+co3eKP5sLpLb0ywZhMG9jR80p/gZEWol2c7B2hSrtvMxyCAT+txFRZk3nCJAb9geqSc/3E7r21lP4NU1jnUy+Qhu5AzTW388dLUmAIS5xmf0CCZaQCXOLg/NZAEloNuTR1rpHF4fW5HFppCkvG2IZesg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595725; c=relaxed/simple;
	bh=sjc2QxmWTuIk6Ks+Nl3TvcQUZ93B5W0Id6yJv0HKyh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7wx95fyQOt6T5bL5FUZki0QFtlgGqjELz0A+YNNCK/jpeW8eyjCeGT+fat01aUbGz3RTR7w/iP8BOdLgT0Z9Rt/cFLYZ1lmLf8CwJdMTbN4sa/IkLKN/CRs3UGmu3JOX543X0gyYhiYHyUddaho20JgWRNBHi1iW3uZqqXBho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fVs0vjlf; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fVs0vjlf"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d3dd76a825so259945ab.2
        for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 10:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740595722; x=1741200522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29YldXHZZWIENyZLJKA3m9s10qkAwfthBjQ5H8hR+OE=;
        b=fVs0vjlfD2XtpaKApL1zNtdAC94Sdiun5OCQhJiWAsNGJieaes3/4Ftn5yiizyKIlb
         DUSZlnw+saJYPE17w+5GbGepWMPX3RnbheNNMTxlzfr/p18+L/Ak+yw22PGSLqZkPE7c
         ZrUFdVE/Gk1Z+OrTMu3E0bzzOBT2q0L4Q6kf9T1WPoQIRMtFyqG9rmRYwVdzyM/O1xkU
         Qd56E931qf+5796YKEAuAG1JoLB0Uan2GUEPBs1mT3itNYAjtkQIX5Pr0lLdW0GYfiOl
         1SWJP7W9IQyipVmQAmbom0n60L5V4Jyx7prU8TuMswP5BD1VJpYr4XcV05faoc+di0N0
         T25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740595722; x=1741200522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29YldXHZZWIENyZLJKA3m9s10qkAwfthBjQ5H8hR+OE=;
        b=McQ+twaGhhH9VI5feODfPbF3eWdqFOW0PLFMvXkvO3o6wx854ZOr/ta5cjfGNO9UBh
         HtCTlVXuCd8T29UbGbwD+OI7wUTp+CotgNDVMzVm47ZPCLoXtN19Fezr+TXjmPf8wYbk
         7psf9FzncOvdfSoVgP+AI78aUaiGFdvD72bGW7I+qh9KCt8hgh2xxvnIk2DRdnCJKxoM
         driAwS6UoLxXnG/aXqEtkCrgO98tt1LQnLlL4H82kRkkNZs2ScQg5FRu8SLoaunjbGRl
         Z546JfOQa0zGR85VkobFdp1XtmaXmpwLB9j5ZDUzxPd4DAiqvB0xoyGp7W2pyBLMPutE
         8B9w==
X-Forwarded-Encrypted: i=1; AJvYcCUyDswuGxj+Jaq88g6jMPBozzGaylvZjKiOBrjJ4nMBHQXKNMeU1sRYELtSmWANzVN/OMkA1rWRCjOu5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzS+YfY4XD6JgTwtebzYlyY7FyDp6iRyh4VXjXV+Li+d6HePNhJ
	I+ijfZiufucSmN1OoE7zEG1SbQo13NQzs+aQy104XgD52jdw+I5puJ1JchsWTWw=
X-Gm-Gg: ASbGncsJJPAOSiVzDdJf5brhr3ZFt9mwYsAquSb4AKH73Nri2jbLmxvTCrhSollIrM3
	zE+hp4Yyp6y/Y6GIZltzrmZDoz2nOGOW+V6MUyqdew6x1T52qNWSb3CrxhwAMBm1pOhi+O/twEU
	iso6mgvgMfpDB/xq9xm/H4Xg5Eiobmz4WjXyqXg7U7qjN3fvRTuNdPJQyxRqSCFJS4eFgKwMvz2
	X/XRqNjOVF7I1DN7XRpSpit1xPmQQTsyzc4KhaosJil96c0PpiZGGDOvVt6/Qd3EAhiqrSHV2x0
	4w2ke0kCypXCIwTvLlHk2Q==
X-Google-Smtp-Source: AGHT+IHf9KJaHriQv0Q3uxkEzFWxGYsTVqpO/qA/s9OvhP8CyXCH/BuNYJCZKyKUkYKaJLxbKZdjlg==
X-Received: by 2002:a05:6e02:1a6e:b0:3d3:d067:73ec with SMTP id e9e14a558f8ab-3d3d1f4ea2cmr38736525ab.11.1740595721727;
        Wed, 26 Feb 2025 10:48:41 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d3cffbaa16sm7134915ab.6.2025.02.26.10.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 10:48:41 -0800 (PST)
Message-ID: <e19190d0-fb60-45c0-aa3e-7d0b61e133ca@kernel.dk>
Date: Wed, 26 Feb 2025 11:48:40 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 6/6] io_uring: cache nodes and mapped buffers
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-7-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250226182102.2631321-7-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 11:21 AM, Keith Busch wrote:
> @@ -789,7 +856,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
>  	}
>  done:
>  	if (ret) {
> -		kvfree(imu);
> +		io_free_imu(ctx, imu);
>  		if (node)
>  			io_put_rsrc_node(ctx, node);
>  		node = ERR_PTR(ret);

'imu' can be NULL here in the error path, which this is. That was fine
before with kvfree(), but it'll bomb now. Best fix is probably just to
check for non-NULL before calling io_free_imu(), as other paths should
be fine.

-- 
Jens Axboe

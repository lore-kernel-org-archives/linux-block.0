Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57632853F1
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291731; cv=none; b=d3OrSjj9p+sHvaMjEet8Q2r0odnPwLPLk1hJ2iFOnk+vuEekldUfPrj8TSFPLrLuKjTbujDvFzFAx9n4Bts96df1QFYwtpqI+dCctkwgtLQHgEqMQWnz7Fce6bekQ3Q5vhvg7KJyMUEru4QhvFAIJhOp+/xBff6HnA3ZVzgU+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291731; c=relaxed/simple;
	bh=jszfLuW/H/2EKK4crSbbCgGqRnSPmtZnF6dfbueKSK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tW1+tq/Zzivl3w0r6MV8q2KYzawiPikCJemeZkWGY9je7XTR3RKPBavPQTlNbi0OekN2kaw/2V8Jc3XhLouBtZj9rRhpy8PKJ4Yba7HjL1mYb+jmghDbRElwNGWvM4DmhTXYzOExsXMAVBRom/xIPEIzgypksVmmV3unp2XdFIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=afAhqfeA; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="afAhqfeA"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d5e43e4725so2629045ab.1
        for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744291727; x=1744896527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+ZBTB58OM3FI7YWf7zo/tTC1AxPvyN7ZeDztmBCsZs=;
        b=afAhqfeAPANlgEb4M4yujlCTFdMRmEz36PjwRd56rRIF1kVcRA4IY51oPpbnMEFtWP
         ASAXnAHbYa+gWEMN49hBejiIvRNShyfOnWTsI0Wk0xKOi3Yp/DslHBeHJNfADLXuIJ8+
         f9m34orXxhPlsO8FTfEvlmFdQXr3+E5HZ+S+gHncvm2vrPh6ZpTFqmpjd4XhvDrX/IwS
         1QsR3lyXCCPzbTbnWKBNrjYBZiIrC9HsQ82N1DuT5Zj19BOBh5yIKitRFzITcxDHKYFp
         TgkdhdpzJnVEaUb7juMEMXNDuqi5Izwi4Dms+pDeUVTeyeJimsV7aF90viAcWWxv7KRq
         WeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744291727; x=1744896527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+ZBTB58OM3FI7YWf7zo/tTC1AxPvyN7ZeDztmBCsZs=;
        b=SpY0vpavnTHJA+QjYXquC6JuBX6GUmzPAC+i+0fc8A/0zlhRquSCdti8MKlYwtOsE8
         KKqAebfeH6s0iYvr2HjZb6Omt18KrVwOabc9tsWIDy+w1SKCiUvDwXnsts5RFRutTRVw
         hh6YIu7HtIX1pLgNk4EtRk83UPCFJSnx2sIQTpnlJUwX4A3qc1sUH0JdX1V0Hjbaw97A
         ANuZBC5nLlC6gyy0EwlLiD+sji0ldLE9fzQPYzyqPadwWN9/e8AsJl2+4yBbgCRH2Ddw
         yO11Qoj5BI/A24aTgAmg60iYTH18q53DjUDAMzHah36/5YSZfkhOtgkyORkpdkPqrg53
         KACQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ77O0lAilQFioTR5ACmu3pMBqWRbYlM3EOikauYtKwd6kcoOo0UUY//9mfhFb8OH4a5dVsQ3ZSF7LVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6loqeLiun/IFtcHhN71G/DST3tBk4NeFnrQnXnv+Mm6Kmvcxr
	Me3EMz1AZXNNYK/OLojE0YcJ++h0XsFK6rW+eGOzm+swFLXFQ9CxnPRe3aCzgACy7Xg1Z404tBO
	R
X-Gm-Gg: ASbGnct4joH6Wg7eqqsds0LRhnuJ4AO7bpY1MDGEPVXOjgT0E0Ckbfgxc2Rm/P6YU6T
	SRzwQbAn/I1oEONzCfzWiyyQZ96RAXzFRglWwYV7ir1YMHk5mJEkI0BlTo43BlkxgdEVT7nKpO9
	Q4isCqd02v179SrK+XeqYFZqYi5PNkMHaaOywZD85B/IE1/3qKiuyGDevPtoo4HRzD/OS6lQKBQ
	rha8hzL5ActxafAueqkrlpU3rmfK6+sqGViLKZWG5wiBVCjaGQnVCHa178thjBY1QFgMrwprpyj
	+sWZq4wXz1+vom93iJHXBbB0Hg90SUE/yOh7H0e0KwZPq88=
X-Google-Smtp-Source: AGHT+IGrfgscip7VoP6ovpvlhbCCLfsAqX/3XGPvvrVLGABQYarWnsWpJXrOtOSZKqObnV11CcLrnA==
X-Received: by 2002:a05:6e02:1a8b:b0:3d0:443d:a5c3 with SMTP id e9e14a558f8ab-3d7e46e077dmr29150305ab.3.1744291726849;
        Thu, 10 Apr 2025 06:28:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e0140dsm735573173.101.2025.04.10.06.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 06:28:46 -0700 (PDT)
Message-ID: <27498cf6-37a2-4ed3-9009-cbe63e86c5bd@kernel.dk>
Date: Thu, 10 Apr 2025 07:28:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ublk: Add UBLK_U_CMD_UPDATE_SIZE
To: Jared Holzman <jholzman@nvidia.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
References: <d90ff20a-b324-49b8-bc63-7d7a35afd1f6@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d90ff20a-b324-49b8-bc63-7d7a35afd1f6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/25 6:29 AM, Jared Holzman wrote:
> @@ -3052,6 +3053,22 @@ static int ublk_ctrl_get_features(struct io_uring_cmd *cmd)
>         return 0;
>  }
> 
> +static int ublk_ctrl_set_size(struct ublk_device *ub,
> +               struct io_uring_cmd *cmd)

Minor style nit, but that would fit on a single line, doesn't need to be
split in two.

> +{
> +       const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
> +       struct ublk_param_basic *p = &ub->params.basic;
> +       size_t new_size = (int)header->data[0];
> +       int ret = 0;
> +
> +       p->dev_sectors = new_size;
> +
> +       mutex_lock(&ub->mutex);
> +       set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
> +       mutex_unlock(&ub->mutex);
> +
> +       return ret;
> +}

Get rid of 'ret' here, it's entirely unused. In fact maybe just get rid
of the return value in the first place, as the function can't fail?

-- 
Jens Axboe

Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB032C924
	for <linux-block@vger.kernel.org>; Fri,  3 Apr 2026 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179842; cv=none; b=CwQv9NeTyD+7Tw/lU3ZQfbjQXndkuNK4kGxgr6E8/+8C2gFSo+W4iDg1KK06AdoqdPBEhsYbmTN4ZkkAK458vWx5UU514MPWH5+Dqc/fJTvEXZqYiPq0IiZZn0zdStfJW9jIhRMhF7WLuLCQ423RN3MS2NH6dCUU0lIpjPPZm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179842; c=relaxed/simple;
	bh=9ElDoh7W3XWnXyfGKpGj0PK1oQbCC4m+jiZymPd5qJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANcrsrXIuUBDHAodRNJpuX4KSxxh23tFem2A/2F23qLkBHzm0l7X73hZDsUvGnIxtJV8F8j4+zat8dUdPX+V29XcFkjYN1M0WZZaGwKuxKoZTYZ4CLLmwEBJnoYzv+WxWYblfLKMNMAn5Ikqt+lD89wdW8A9SQ25NAJLErFnSgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ILiufPqM; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ILiufPqM"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-46704177508so946921b6e.0
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 18:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775179838; x=1775784638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3AxyKUup9YdgXSTPgEMPKVeyVAoKV82S85oayH+6OY=;
        b=ILiufPqMuiGz6H+kXh9jKQEVD7CNH9wvcq6kBRCptFhonZEfWMXAOs6IAbq3iD/xQY
         H9YppZvRgM3pqTHjfOC4obA8EzdbLSY3t8svi4BHersbQv5TUtwrZhCTyGTWu+hGeCfW
         BsKerb/TwhWJFvuz7SQB4UdcRxbiv1smfDASl6h1lrSrnVAhw4AY9O3Vm1Rk7eJoNNwx
         S096kt15aHZc3xayLrh3Jl/evI78kwZDz12BLPQcaBwoDkoHzIEbeZalH92dVaukVFod
         nDyhCkhxGF8qNN8St63JrtAf2h1/GTjcOgcT2656cZk2r2TyLKq4RP5hqaEdCHO7xzu5
         1H+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775179838; x=1775784638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3AxyKUup9YdgXSTPgEMPKVeyVAoKV82S85oayH+6OY=;
        b=OK487VrludpZWCQFYZ6EAaRWgtGzkbnw03BFBS2b9JdOakArYNDInKI2tSgGLAuqPP
         PS+/C9RA5t6njz4KKb2l4BGABn8Yk3SVY0GQ6x7s8qQDpD4G7a8qm4i8AVh5qNb2Hh65
         TXlV+D/bk1eoq6d6dtLorjmYSgmeM5EEHNPPU9XH0/5JEdCoZcwHL6/FIZEI6ieohYrd
         BtvIN3JxzRD86Xu17cJBIzrFXLYenKaHLPNIWxXCp6ZCMrpf80RNc6quvmK9yNsZNOn0
         YQKexI3T9q+9Vg/UHf2UpjcvC2N/54QYPNg3Ct8X3Pv4BfgLWYYxyEMXUqmxq7QWs5ab
         ZGZg==
X-Forwarded-Encrypted: i=1; AJvYcCUIk02WZl4/ih+jjreQknZsn+EkVld9go7LjPl65UZHBVUAjdyhv/2PJmv4qEbs2DuvXu3MGMSx6O/1uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzxHjAbfotvMYou5DnW4KunjDdrDUcled4qQaQmDZzL6aHM/F
	jBKqX6p73adXBjJzPThIVVs4KxGM5c08VkutzXog+yOGxLjX6kR37QA06nnUVc0DlOA=
X-Gm-Gg: ATEYQzwrIFSJl/HmNQNuJmQTnf0oPVQHLmiNsZaZEqGcID9XIRNzmsDKnC1Ut3BSkDk
	xkjA4YNTb5w2+aXUOQPA2QD3+ihzT+sEtVlpyekOeEuuLwsorhL6p4zdF4yykB8d1gWuJwciZMk
	GV6OnFrfgyv0WkRpjKM8p/Ji5R1vfTa2MB0plqcGzJj0rKaRgbf0VVn40eCHZ5Uo7UpftF21wnS
	nCCQL5iHJsNEWypAtoNOrM2Gp6d2ozjD5R0u3eEhXwQepjBZWwan7TKnLxpxov2P7WF2AYbJeKQ
	3BHHKVpfvCFwXVAJiirjhjhx0XNtxbluQkTnw11Ujp6CcYJX2kqZ9dNyiaJ2HTuAp6tE+QW59wg
	LLymg5yJdF76MJnmuaX5qeVdErpfaZRMn/3kKDfOTByrxjtzUDvtMvFj1rcDYx6sQJ3zj3vNMSv
	6ucscOt/q62OhZE8ru0ociWYQkFG7oefe7/MQUQQKC+h+WUnk3lIH0V9sxsSIq9FQog6yKpMnCj
	kvhTy7LaxF3khRWavNh
X-Received: by 2002:a05:6808:1508:b0:467:2926:1231 with SMTP id 5614622812f47-46efadbd14dmr792673b6e.33.1775179837699;
        Thu, 02 Apr 2026 18:30:37 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d92a552f2sm2740316b6e.11.2026.04.02.18.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 18:30:36 -0700 (PDT)
Message-ID: <ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
Date: Thu, 2 Apr 2026 19:30:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] DRBD 9 rework
To: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/27/26 4:38 PM, Christoph Böhmwalder wrote:
> As discussed (context: [0]), here is the first version of our DRBD 9
> rework series, intended for for-next via for-7.1/drbd.

Will you fixup the kerneldoc (nits) and the assigned-but-not-read
issues and send out a new version? Also looks this series doesn't
actually apply to for-7.1/block, patch 12 fails.

-- 
Jens Axboe


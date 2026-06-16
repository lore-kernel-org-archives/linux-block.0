Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899739A4B8
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781643089; cv=none; b=prEWb9kPWE5SLgkkLxzCrsLGsXeAsLqyhk0p9tTK2DlkizF52mtqJKV5sC/1SqvS75EcMwu6pWws6NojkFoQMRCrxw+LD1JD4CekSyk7oDKTbZilZ5UhYmt4JPJcNJahTArH/rs2Rlr1RBwGvWPdf619zkJwPp8eBdhtYyy+qb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781643089; c=relaxed/simple;
	bh=qqvgI8rvdQwsy+7G48Skg3XH+plfsX+hs9hWY2BSqmE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f9L2cvTgEE/WRhCfhpDWYPxuIe3cpI6/RjFgKQ0z7bXfW/Ag6sXAk+GiG5c55R2Hrj2nFq1tWF0y1RYU5FynoCuJeVYA/pw56XQk1B5tsUuDZrMdYUG3yKBde2iPZs2dcQKtXhyyZy+fw3qMwBLVDTxzLmdo9OxTrNkd49arYpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=i6yGth8K; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="i6yGth8K"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-69e46524711so3384193eaf.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781643085; x=1782247885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+dpE/j7xi29wlPNe1Z59Oj5BFfMHneb4BxvwGVl0lo=;
        b=i6yGth8K+xHjGLSGYjoW1pvgN+WCbhurXVJrkm8By1kzteQ7KOu2b0xx69lovX4dP5
         gMsawAaMZJPvwnUAR4cFYB/OS0F2HBE0qeWIkj+ElYjyG5oyTwx8/xbuwmHUfr/jeTUp
         qIwb9iOKCtSVWKyEWsYWaCraSJ2NxKkePwOO4Ntv5o2IrfFPP+30LwyNpRu4iq/CF+GF
         n28+Dq7x0Rvca7nwQybIcje51mJ+BbjxyuSX345gTdv8TMEhbTqIej4BpIv3Vsvl+Dse
         x55NGPD0TkjP2MFKhOG8twRkGETjOiQEZkteaJK0s+WmbEPsBrWRf7qyY8n/ZnqRK9sS
         Ejjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781643085; x=1782247885;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M+dpE/j7xi29wlPNe1Z59Oj5BFfMHneb4BxvwGVl0lo=;
        b=BbsXSMgHpI3u008CaEWz3Oo9/lDqyZwhLRUavJUjbPHS3HBECBfybjPXYfb3o581Y8
         7r3sIUBdG0+jgY8PdD7dffotvQB+EsUrlSpPhyQJtN0SY0+KIys4XNfAW9+f5ZcEgrrr
         mOjEA03H10KE+1v975sx+cSsbBanb/Qp50/1ohmhmOP9soy1OWhm94IbQViOcCCA7Ue2
         s94dwBKVoLdFzw/VEpXBaxToEh+NIV6ZKG6yd649wsANOHdvstXAU4Mih0fEk2JvxZEm
         eVJR2s1gIks0ocTE3hFsjKTc6TY+TRb3eJN8dryQS9S8NCJ0eLtT7NRjIAnLMy/qm5Fb
         POig==
X-Forwarded-Encrypted: i=1; AFNElJ8k1l2G2/yS3Ulth0R0afKR03sgDdjyE4AdfQJ3v3vzbj5XRAJhM5kcCwJXtTehkFQMo+GzZu5O5K9byg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvZyTYvFHwJSNo88XOv4OE27Ru5J0NAC44gdY5TUW9nzjXPHUM
	jUH0ULrKehjZRu/9wIc3U1lU80jj/u/kumCg+fBS1SucP8Rx21IiM+xHv3Fqhnf1Ofk=
X-Gm-Gg: Acq92OHuGQU4zozeN5UEHBZrEb7axNWjpRDgT0tpYOPiZq/JsxkPpeCrLaOy5n+KapX
	H8kGxgBywCAE+rEaCLvgkCdZSNmUvQ9FMEO+SZf9iuc5KcpGSvHOmYro8+zp7s2zj54Gn7htinv
	+m21/EJtGiCWOBX+MDXfEeRjilsQ8Jf84zNgdmaEaKXme4fu/nZrONGMvBF5Ix7INLHCLvqIEzF
	Qf67EpNQZdvpQwx+t6xGIOfSTL14m4rTd2HV8l4S+nLur3ljJ3unKxpQcrM0LJbC3L8VkxyvdAF
	7KZDvmf7yusR4kRhYGHEMOGsllmFqGvKEigITc8IFd6onB2TgEMYEZ7Zmj7o3Fb/yLzL1INmuN+
	QBgdhJ5Ixad0VhsNXdLTvlHrVgAIIp5lGElH8TqsBy88NQ1cHL1Xf9075mVq2DJqxSJxWwg1umb
	pUJ3pNjqZ2pUV3hxWk/zTNBXVq7hZia/cTBQEwS+4wxuKzmQWqs42w8dlTbx5wZb4tOFaypW7nk
	Poj
X-Received: by 2002:a05:6820:6ac8:b0:69e:33ef:4b9c with SMTP id 006d021491bc7-6a0b5e0e16cmr630112eaf.6.1781643085197;
        Tue, 16 Jun 2026 13:51:25 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4430900e368sm2887576fac.16.2026.06.16.13.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 13:51:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 Qu Wenruo <wqu@suse.com>
In-Reply-To: <cover.1781597506.git.wqu@suse.com>
References: <cover.1781597506.git.wqu@suse.com>
Subject: Re: (subset) [PATCH v4 0/3] btrfs: use IOMAP_DIO_BOUNCE flag
 instead of falling back to buffered IO
Message-Id: <178164308431.2260944.8317946373333928448.b4-ty@b4>
Date: Tue, 16 Jun 2026 14:51:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 16 Jun 2026 17:42:34 +0930, Qu Wenruo wrote:
> [CHANGELOG]
> v4:
> - Follow iomap/block layer code style to avoid lines over 80 chars
> 
> - Reject NOWAIT BOUNCE direct writes inside btrfs
>   The iomap code still allocates memory with GFP_KERNEL in other
>   locations.
>   For now just disable NOWAIT BOUNCE direct writes and let the caller
>   fall back to blocking mode.
> 
> [...]

Applied, thanks!

[1/3] block: revert the iov_iter after a short copy in bio_iov_iter_bounce_write()
      commit: b68d4979c88e31488970373f67ac79b4f6267008
[2/3] block: respect iov_iter::nofault flag in bio_iov_iter_bounce_write()
      commit: d5b58fbb2fd7ac25fcd7e1c14730f998a90b0322

Best regards,
-- 
Jens Axboe




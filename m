Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659D11FD4
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838561; cv=none; b=jWGmYUmRmAFMnUBDKYPbaf1oc7I0R8Ay+YGjQlaKLfGVlPFutfY9tlzZmM631o523gT8XaldAw8Zt3kGD1QROmmxMZNBi1c9c8t8XLhWYWu09I8OUgIRiC+Rc+qdokYhfbAyecSje4Da3DUMwx0sTFEZPL3a4Q2kDHjD41SuMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838561; c=relaxed/simple;
	bh=S3rcODDMrrQupTkBVPjAUXM5or/4osptMAJUWtAMh3A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BnF8hRrhKYDR58/mpBJ87K623VzWhNeY0tOoGsCSDuJaUZTknB4WDVXdVVZPAR8M+SM4x16zeiYnQ79oWS3E96eihqsjSb4T+u+vkwxbi+hJmTRY1c8Zd/8oNhdFkLTzX8uFuCeVCQ8cS0tyvkyoWFo9v6YPpwZOy+kNARRLd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=W4+Oy+Qs; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="W4+Oy+Qs"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4a456e44e01so1094860b6e.1
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 17:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838558; x=1787443358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I3GkNBRZtrMZ4DB/PioiPLQYVBEStKh+8Q/0lILcARg=;
        b=W4+Oy+Qsd/eMMZu7uYWv+MKZNHOsCCRXRh49Eh7UzpgcxMNgpAC1Oo/DwNkY5VIOox
         MAdjdHoFaC4jD6kHa5cK6KtS+9pEI08HFs19cpw5K6nYuavRChbBmi12LbjPKwWE5+wF
         sl06cKT94k+xh105ZEEg8Id9hlgslrVcg23Waj8XEcxGwGYvo+J+XR2ajg3xzMY7V9s2
         VtHy112mK4+gbb4giOKbmTJ4zqy9Z2wzNlGEbhCLM2MxybHolhw3/2aqNXxtcD+rFBih
         zmtJqjgAeDk8hdYUcLaUbRTSFIyc1Bae6Dx4CTtkfqw0RWvXvVwyJg2v+UzYKNWgH6Cq
         YljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838558; x=1787443358;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I3GkNBRZtrMZ4DB/PioiPLQYVBEStKh+8Q/0lILcARg=;
        b=W1/Q2T0eaeEt2AELhVfTI0EtCZvaeRyzR9FS2tz+8SpvJyQkk29j28oYmNhaAuUagK
         7RkE8TWGoE+vEfP1hh/OWYk5ymbyGMZrbFTnho3gQwhrbv2CnLRKCWnZHtnE+ncZ/1xO
         F2ZowJzHp5gyPghrLopGPXE04izfY+SrsismbIhGJ9MNxOhsa7znsClfI8wIp9HgGK5W
         xy/srhhKS+ozqZ1QLYVa+dcbcqd/id3W4+myZ/N7LEUEHt6MLZkVVg91V1RpcQgScXUe
         qKDs2qRmc9BwR3kuf+enx18DU3i90U+oOyRgQM04IJfS4BxnsnapxAgiFvQXdfGkRbjS
         hjvA==
X-Gm-Message-State: AOJu0Yxsh6jcdyXlFcBCQR07lsmz8/9S2KTgOAUf0qcCa7edG867qAf7
	DdLrFGJtiVYSRTFpZKrXeL2OP8pufxA4bBBDf5ccNdU50IQEETRyRJdGQ4u4iVINk6kjlIDOv2A
	YHCxsc6dcGg==
X-Gm-Gg: AR+sD13lveW1JJriio9izY9vvhDs04p0rLGBjrPTEhZqF8lNFofYDKQvkNYm0JexpBo
	FVlD0y52qT/8F/g+SWe5hQG5LxmMg9Xwm7tKPkaZYNVld5uq5y2okzsny2mUU1sY849S/b+zxkY
	eTTkgHm7HSxKHn8BoZH9tMbVwI6X9YJUUE8XTxuMZMWShbU8k1iwKG8iTk+pmKsXGmvkEaQaXrT
	Brqt8Xt8cfmSSlXauCCP2kfINQ2E4zbwCMZI9TmBAyujh/zWih4q1zDXXW2gVEXuOEFNtmaz4GR
	0Er2GQdt/kU+75wP+hvJ+C6lKEdZ8sYbhN8uHaJQw3K53UoXhax9VNfNFsd7OUUhDA7YuLvT9sL
	uFxj7FxvDt/BwJHrzd5n7GLY/2zb1Wlj/QaIdZME1EWJedqRzUu2pYutTH2iXxocmWOS4fihllN
	h56hV6c3b0SQ5B5QlYDdoswlS2q8+JsNiE4m51X2QV8UpuPtNoaQQkHQGebAI2JKZexwPZKJqei
	blwXLPNv4jbJjFRL43RkPYk+LLWPPEwAQxoVTtL4A==
X-Received: by 2002:a05:6808:1a1b:b0:495:f519:70f0 with SMTP id 5614622812f47-4b241e2adecmr13508967b6e.19.1786838558190;
        Sat, 15 Aug 2026 17:02:38 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:02:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tom.leiming@gmail.com, Yao Sang <sangyao@kylinos.cn>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260804125736.2011774-1-sangyao@kylinos.cn>
References: <20260804125736.2011774-1-sangyao@kylinos.cn>
Subject: Re: [PATCH] ublk: avoid teardown retry loop on xarray allocation
 failure
Message-Id: <178683855340.1984298.11749917980913499206.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:02:33 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 04 Aug 2026 20:57:36 +0800, Yao Sang wrote:
> __ublk_shmem_remove_ranges() removes matching maple tree ranges in
> batches, but first stores each range into a temporary xarray so that the
> pages can be unpinned after dropping the maple tree lock.
> 
> That temporary xarray is filled under the maple tree lock with
> xa_store(..., GFP_ATOMIC). If the store fails before mas_erase(), the
> current range is left in the tree and the helper returns false. The
> outer ublk_shmem_remove_ranges() loop then immediately retries the same
> range. While the atomic allocation keeps failing, the teardown path has
> no forward progress.
> 
> [...]

Applied, thanks!

[1/1] ublk: avoid teardown retry loop on xarray allocation failure
      commit: 4fd66a7f829f3f38f92a79081f0f2688aed644f0

Best regards,
-- 
Jens Axboe




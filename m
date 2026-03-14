Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC52C21773D
	for <linux-block@vger.kernel.org>; Sat, 14 Mar 2026 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773497695; cv=none; b=FgbGqqH8lDpKuTJaDmW1/0k5She7xPtpbpfbfSXS938cjalfwo6n206A+qz8pJdlVvPHV1lU6hp3F3WpMKgao8BLGYAcNlF5x6kHD6jbzOfb/UxwbFForwDvQiiobqB0/VR7hZoCKxCb2PgRJh+rzhqgrdAIn0euO/o8Ggzh0WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773497695; c=relaxed/simple;
	bh=qA1T8/DdNEiuIZOG0gpBqmok34KQn9M8Rp/3GcZyZ/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FRrk0fRE7bdx4sVXB7AsVwXL6pMTAzII/4AZ8Rsa9RjxZMB44nzvWLxOx87NYtCVRetXDl6cDNMPWT1wnm3GK8a01FBgTxSDK5emjqAsq8nUfPHnn/47SwoWLxVSdNUsEvhd8v05jvRYuJ5mST+f8Pfbik8AkWLm0pod01w9Uo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WK+bRvK3; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WK+bRvK3"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-67ba8095a87so1871820eaf.0
        for <linux-block@vger.kernel.org>; Sat, 14 Mar 2026 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773497692; x=1774102492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt8eyRMO9eCIU74N0VEG3b5oPzvF+7Gx61REVJy+8w4=;
        b=WK+bRvK3VjI5AhBBK3ehr3DxK9O2bUgbc0st3aAp8z0MACWsvI0273z33qeNG764+C
         4zw8XM2RmtX+NKG96kswLucWXQypDehwJAwlujVBJirjGmveRlzfFgrqSVfMMlJZ+Ae4
         6BwwHrbRPHM43XL2qsnl54rPTSQgF4hZNdqZB72jBKe3H0DeSOJxCl1m5V+e6m80puON
         bD4DKsQ9Wjar+Hp443IxVcfcZabSrvYDzWlcBdoV1vKtZjP0fXg1/rhkkVK/jdlxF8uR
         FawEPYglSijjAp+e3RuXL+tMoNh/AX2aqzKVMqccYdOIU7xNZNpiGUmd+3RZWHvhJwWJ
         jE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773497692; x=1774102492;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nt8eyRMO9eCIU74N0VEG3b5oPzvF+7Gx61REVJy+8w4=;
        b=JlL9K1uyg5aGtEvj9HGC++Ts51xx/yxEwHMbFTzsgYiEWrxHZKjQHi0TDO53o4HTAZ
         rfCkk+uWLKIjwKCXTGBc4zJZND7eYjrBvp4HYrJYNAPmJHZHGoJOHj4Nslt4Ns71NSFz
         On6vOOov8Fp1niaQEWBuTkII4MZg3ee1nwi8qCxUNAmTKS+HlxH6oheb732UKGfXMY79
         Gs6h+pNkZ9m1C5qyEwwrCtAH0EikPCe66/rclHyiBSZb1/5KzQW2+hP3KElICxCigKEA
         7sy3JW/xOiI4bv8LKoA8/KCmkNpTcYiAW6e/FQf+SHgpPX7QQRJ9ty0I9stbLhM3jHM4
         S6ww==
X-Forwarded-Encrypted: i=1; AJvYcCXBNh0vPE4zT0ddbBubUh6HqiBUyYtlW/2buHZF+4nTM8qR2m2pWQ93QfCqNtwbGS7Vn926pC+k9BUXfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfM5J+Q8MPGcd4UvvcfLq0dm6oZTIfYOnspH5LXuM7pXhssKL4
	F25jdjCSCV/UlzFWx7VL0f2r6QcH2QZYvOlcnKKuS30cMKcNXZBbjh9KWIdgoKjI29o=
X-Gm-Gg: ATEYQzwoP3FvQJ3nc+O25u4A1YEPAgZG7+CibIzPjfKg7HRtxqznc2NhXZL13u4KQU8
	jQVIk79WyKww32C/Sc+HMf/l7ghkoL1MjcybmffXnr86dy+2+I0RNgaE9VFxbQfU/+Bz4mcNinf
	KpEkeQWe6RZhzr/cLSby78923YBWtUy1NRZtwuv8egyFTMiDDjEnlOxu40aAj9T5Ia60XD1nQOC
	drvRDXB1ShbYei+NmlH7ZfKU3W1anLU+pN+/CwaA5UKL1vj6k092lsirYTMh9/P2Ks10WK1JFr0
	XAk6WG2MtVnRc89tgY0uiRbQ86pTnE9GJZZ+jcbAtwE/k+MlDbUSJpuOkZc0inuJHI0tn8ffIbc
	gFUMuv3a8u0z73PQJxkeZUMYgKRkM98IUzYD1kuIscCaB/lf4yBSEUCz+YBE0PZvg5bvFOBF++k
	HPC1rSiVOqewlM17XDipnN2RfK/fzrhtuUTmoOTV8QdeKOmGhBGnLtakiWkCpK/6Wr40HbnRiBN
	dtl
X-Received: by 2002:a05:6820:448e:b0:67b:d213:e64e with SMTP id 006d021491bc7-67bda9eafc2mr3409147eaf.34.1773497691817;
        Sat, 14 Mar 2026 07:14:51 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc91174fbsm6481556eaf.4.2026.03.14.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 07:14:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-nvme@lists-infradead.org, linux-block@vger.kernel.org, 
 Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, martin.petersen@oracle.com, csander@purestorage.com, 
 Keith Busch <kbusch@kernel.org>
In-Reply-To: <20260313144701.1221652-1-kbusch@meta.com>
References: <20260313144701.1221652-1-kbusch@meta.com>
Subject: Re: [PATCHv8 0/2] block for-7.1/integrity rebase for mem alignment
Message-Id: <177349768999.37164.10048861817413145882.b4-ty@kernel.dk>
Date: Sat, 14 Mar 2026 08:14:49 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 13 Mar 2026 07:46:59 -0700, Keith Busch wrote:
> This is the rebased version of the flexible t10 alignment feature on top
> of block's for-7.1/block-integrity branch to apply atop Christoph's
> fs-integrity:
> 
>   https://lore.kernel.org/linux-block/20260223132021.292832-1-hch@lst.de/
> 
> The only change from the previous version is to incorporate the function
> name changes and verify's status code return type that were introduced
> in the file system integrity support patch set.
> 
> [...]

Applied, thanks!

[0/2] block for-7.1/integrity rebase for mem alignment
      (no commit info)
[1/2] blk-integrity: support arbitrary buffer alignment
      (no commit info)
[2/2] ublk: report BLK_SPLIT_INTERVAL_CAPABLE
      (no commit info)

Best regards,
-- 
Jens Axboe




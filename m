Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794708467;
	b=rLyqQY/N8/WUV5bYv0sRcUVF+yPFlHn1XFQtKH0xfwj4BkuevVl+mT3139QaKZkajXnd
	 y910LhDV7YcsL1BqsgiUANIHdKxH1ue5VKk41xa1xjHDqQbSqTvbgvx+G8fDdPYlvt+gR
	 ZaOjqkpHAigL/An6ey8M6g3QTPXyomomR/TLVXv0bfo40/3JLoEBG6rWuLFqmUzBmcKKd
	 FY2qf5NQ7GqV3NhhWqDgRlCpPluxLAw1FYD0GsSz3zYXdZovkDf2Xzw+JoJDslq4Z4932
	 XAtzU7iTcFjNkQUX1XLP3V1N/15HbqZmz1p4OieAhR6HtavDw/6eZwpOLErMxPBF4+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794708467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rnqu5ao9YJwk94NMnB9wLTZ5Ww11Mzaq96WX6a9SCys=;
	b=hOtF8wu1BFygfVAsJw92dDrfYzJBsMdt9tGKEUG0Nt5JmL8i0moIVTWQKVkRq8rihUfh
	 DTRCiRK50qmzZ7d6p6rEkL5av6N4iaSlAb0IZ6nAuuGA5q8qzb04J6cYSigfrKz+uGRUI
	 Ig0Uf5UtpBRV5rsKFje4BDJce4Q/OlPasLyLbWUOIlfe9yVL3gPTIN8nFsDpgX86EfBvM
	 XWcUdNsZj2nnELQphPdug4VDechlEqj7QBdfAzsFMVGpBQDgXLzwwfbF0bIM3UdVoI01R
	 umecC/dfX4bOw7nnGb7Hp/VkF9QPv6KtAAf5tVk1SN9Rzqnv4Wy6+Yre9MR5jw3roZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLnlNQK8;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF193606A32C
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 02:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF193606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLnlNQK8
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-862b98b2e47so59211a34.2
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 18:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794708465; x=1795313265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rnqu5ao9YJwk94NMnB9wLTZ5Ww11Mzaq96WX6a9SCys=;
        b=hLnlNQK8veP334z+eVkUDAES3G1yQmoS+IwKg8o4QOrZ6P44r8AkjMZlynKd27RZbc
         p+nb1wVMj174+IPPxl8ZBp7Mmc5FGxR09y5xaFBVcsIF2IQaee1ma6hxIbz88svT+mr5
         SyMgE+EeIY8vD06U/mS1vcAuJz4LjrTAHL6vptfjVDeAtuat+fAIJPECALmQi7y9O38M
         BhwxmXVSzb7x5q4nPK3ol/34LXAE4t3yqVJf97ZATIecE+cbI1sOQjsLhYaURc6YgJuI
         vV/WeenOkKeTh4I3Vqb081WEucdnNXZ3sgcwyW30M3qGGscFejT1hmq2KswuO8nwqZgf
         2y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794708465; x=1795313265;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rnqu5ao9YJwk94NMnB9wLTZ5Ww11Mzaq96WX6a9SCys=;
        b=b5VnRiFPZsLQ0nH2jyMMPVHEmWDwZ6x4x1sMqClCODt8KjHm3pnMf6qqACdCIKA4Xr
         HqzZeX8daBJ9PkHi0b/rL1vv1zUhzx5MoNfXPa5h5GVpIp3nc2lSgFfheWth+ZFJNALp
         W8ithYrK953RSwdBFWwz6KLLhEdjEKAYQZV1kmsvhg7lzstTqTNAQXvzi8eG8DBIyrEy
         /pIsuopsCN6aP+5RfUZMJuDKLQv5gC56Gi+DegsUih5rpWalWtDNKMXa+tcZa1FJsVSD
         dsQR+nGRoD6hBcTPSGB0xsM9X6G/+DWXczM8CVYG8fRmcKLtM9+PCHl6i04zRl/lrkCq
         9EeQ==
X-Forwarded-Encrypted: i=1; AL+hErF7+IxMgcfSBJVM9sFDj2yVxmeCRxa6ywg4O2hPpO5IoETm/552KigPp14CIJajIzZec+baiAXHUTUJ3g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+puBAp07DxugTgsXWNs7q5HVduorjtxu2POisoyaf/NWCalqwV
	01rhGBFDVSzZd8+vYHLppqe9Xe8aUa1AGHHmiHxxn/nnxxTJyQQ2F712nCumVF/w
X-Gm-Gg: AYBFou0ljbqHMmmK33Sh/mjrlNk94WX6oADCv1uFNJuhAQiIEBPKjnbwueUbnTHgwEH
	VWhvMfUYnokh1CSIPiAeUrvMD/mzagOoKrg4odXK9RlMRs0ZiH0BaPNgqWC3/iyuLxia4ozaSYl
	dAj/rKcRqkqoIGw2X95WRCRp/iYqJQK2yWJAHbHJT2ntulg77jVkSgSswCyAAMTBx0y6DKDCWYg
	u8p3ANvfy4FDIHyGtACDfp+FfGP9qERFiF+VulvbhbuiTf0cfkyuyMTFXRaafzTz7slKX2HsTHe
	CooMskZ68xpDVt3eFqWWnvnrrv3IJglu3XF4BtOKTR7/MB66lvYuLOdSieBiBego9AGRuGc9BMh
	OX4B+kkdRJovZkp7nGK/cEH9wixHpKwxYLAUHtZ3Lw8Mh13POQRrx8Vve2UecCPZ4tr8PNgV6bd
	7li5U/H+b4WOv+5aEMfeq9CgHxugqmUvAlHibA2T+Tmquv8q9tboAGlXQgvbbaVOBMwFOwr5JCN
	j09EKzdE8YsVTkiiKM4Nk9qdCK45WdfNycGgU8/LFu3pWqiEkvEFXA+I1Tf3roCpzVr+DODMXqA
	QP16Z77g5EeYmEnH6SBa9X479YMwQK7l4CyPh7/61nwMUoKLtyHXCuik1UYH8e/xrqTgdqtOKL5
	IgsVGcRH0sgMTK3uz4hi1BDN/EeuaXHpt
X-Received: by 2002:a05:6830:4104:b0:822:527e:f653 with SMTP id 46e09a7af769-862898681aemr7487703a34.13.1794708465542;
        Sat, 14 Nov 2026 18:07:45 -0800 (PST)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862880a5298sm7113595a34.7.2026.11.14.18.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 18:07:44 -0800 (PST)
Date: Sat, 14 Nov 2026 20:07:35 -0600
From: Ming Lei <tom.leiming@gmail.com>
To: shao.mingyin@zte.com.cn
Cc: shuah@kernel.org, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] selftests: ublk: propagate stress worker failures
Message-ID: <avkT5yu3hJgi-YWb@fedora-laptop>
References: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
 <20261111225759742pwhACD8p_0GdXSYIk_Ob6@zte.com.cn>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111225759742pwhACD8p_0GdXSYIk_Ob6@zte.com.cn>

On Wed, Nov 11, 2026 at 10:57:59PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> The stress tests update ERR_CODE in background subshells and use a bare
> wait in the parent. A worker can therefore fail while the parent still
> prints PASS and exits successfully. Calling _show_result() from a worker
> also removes backing files shared with other workers.
> 
> Generalize the recovery PID collector and use it to wait for every stress
> worker in the parent. Return errors from the worker helpers, leave result
> reporting and cleanup to the parent, and reset the PID array after each
> batch. Keep failures ahead of skips when collecting worker exit statuses.
> 
> Fixes: bb2cabf23568 ("selftests: ublk: run stress tests in parallel")
> Reported-by: Ming Lei <tom.leiming@gmail.com>
> Link: https://lore.kernel.org/all/avJ0Vn9G7XhZv-XL@fedora-laptop/
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

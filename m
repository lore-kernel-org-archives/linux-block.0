Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5AA560ABB
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708111; cv=none; b=B6m0493x7KsxW9w8tf9C9aqA0Eaw+7iX/G2a6TeSBHNiPXTSmFPrahliIXtQEGUUuTSzsqmSZz/bO9PxroegLBMSd0Zsxcq5hZfloibNhSLnJajs6zUpqxmuAdDILgQbfThaRB5H7ndNBigcHR6bbLs4rkZ/5tvBxXJS4sHhNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708111; c=relaxed/simple;
	bh=Pk/5a+euc9+KQt8ccXqkIMO/jo2RiNiDERPo8DgohYI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=um+3ula6fQk+V3gSNM71lCbwOiOfc9Ra7g6nIvMnQjiXNbT2aZyKH3U5duGvaptTP7X/13dJZbe7Ondt5jOPL3+unz3cp/FeyR7ybeNkApDF+fL4zKeKwZE9EBZuluLx2VvNoJeW/sSRDnS3v2h1wp5+siqKh8IKq9HlOMgFEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=NkbobM+0; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="NkbobM+0"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e630052ebso5117127eec.0
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 11:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790708107; x=1791312907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1xCuwMi4zULdHjWYJYrQu1pRHUDSa8xNrh2/5Zv8/EY=;
        b=NkbobM+07HfXtRRdFmDCq+6BUrZMI2amUHi45B2+Lo6ixvMpQUjLwaP5QzyzdJSYI8
         u93VT7ryJzD1HwQnQIhMZDzEmBnd1y0/ur7WYsQHTdXoCwX5Ml8Qq2HyYaJPFi14aPMe
         6/ENM48DOKuXLRVMvXRfdoRe1aix0tgPbcfwG2PkHO9Eo+AgwzGaizSivVNkhLx++W7p
         eCHX4qZr2y7svYekjgZ8mWSFqJhCdwGqArICd1ef0bWFAXg/RnFi6wFrVVur8iZN/1d3
         8Ho/0sTKfmTGw48rVaJUlZhvv8VvDvy/V1u1aFaultc+TvgxPAsEPZeuTb8eRdatn6kc
         SXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790708107; x=1791312907;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1xCuwMi4zULdHjWYJYrQu1pRHUDSa8xNrh2/5Zv8/EY=;
        b=Qec0sDFX7V6Bljqh2m3p7uPBo408jymLoQ0cJbnArYACHTp6woPB1tOu8tjn6TMcl2
         Dbz9QISuzWVINuAtJg6tRYd15NRDFRq93KE3iM8892iBOU5k4SOZxEBTfFee5dwVCClL
         ve++Ut0ANV8bwJZ1ZeQ9MMtW6GeElRmzps8S9DkRbgJ8f7yVO/isESR6B5EMVPP7JGfg
         /55HxQjRnTDT3jGsG8m0uXZnyTMGGRgYbIWadTnAU6eQn/Slsv+ro171xuYZl3FbaE+O
         OXUK1ITFG6VXuSXqmqM0DU38QsrgMFoms8GpbUYvDlVd4UgLNsOBpZ+pu/q5XjC50mIR
         YNXg==
X-Forwarded-Encrypted: i=1; AKwUvByOOuqdTHvDn3YWmtznFUqiq1a8pIWgJjmvBquAsgDdvgz6EzBwkGTpNc9NK2E0JAzyPVT9gGaNIi+fHw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIz9TiCQ1sbPD8/NsxynJcc9NfIteQMdjCNnQ8euVIi2c+gM9Gk
	559PG4eOH92M1exLWpdJNpniqDuvxiY7kZyfe8v/cufnNVzAsf9rMUS44XL+UpFUoNw=
X-Gm-Gg: AYBFou0CqwXamAg1ehmxpvvwW7CoTsYb6z149NJ0z/8K3Zkkcj4+1KN69RoOOXKGcZu
	vK7xfOFI9TEwkFFBixrYRdwa1ODMGRQBN3/Jp23PwKxt1Jq+QbRserlszMIEOPNzyl2ooXlrZmF
	EoAZJwzTYKYL0HljFpW+rZ1c/412Z5iy2qxHrTG8JmGgw4rBbzKi6Ij7Qu0/MJp7Gqqhgu8ZNa5
	p1mWI1rP+4ZgMdIymqJAP1IxyJJYymyJZ+ufDQfhW1HYx2CksqFmF0SAvBZeslMo5w0imf4Vzz7
	BdXEMTmnzUHfOtdanKCzod95zvrrqFxv7rqcZKUhpZ4ATNEyAOVzrjAxFho3lVyN3Lxudf7TOYc
	vYKaVS1dEtorKlG+EcL389mprE4KHYuKBk7RmUSuQ/JXRUaAStMecW5zNGka3bvkn0R2Q9TpCYs
	QthHrBniFf92NODSzkJHMIw4WthOwQn8aAol0vC89WhpkipVJ2u8PrhnSMHMbl7Hg/HY216h7Ke
	I/kU+M535ikv5stXcphBMAkwUVkW5lrhCKBA48vEkSyb4KTJI95Tr5zOQE=
X-Received: by 2002:a05:7300:b087:b0:344:c316:3451 with SMTP id 5a478bee46e88-34c67da3736mr283778eec.35.1790708106614;
        Tue, 29 Sep 2026 11:55:06 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34c386b6bd9sm1106541eec.16.2026.09.29.11.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:55:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, 
 Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, virtualization@lists.linux.dev, 
 linux-block@vger.kernel.org
In-Reply-To: <20260918140641.2031075-2-cassel@kernel.org>
References: <20260918140641.2031075-2-cassel@kernel.org>
Subject: Re: [PATCH] virtio_blk: set the zone write granularity
Message-Id: <179070810551.1304703.14426485043749461550.b4-ty@b4>
Date: Tue, 29 Sep 2026 12:55:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 18 Sep 2026 16:06:42 +0200, Niklas Cassel wrote:
> virtblk_read_zoned_limits() reads the write granularity that the device
> reports in virtio_blk_zoned_characteristics and assigns it to the
> physical block size and to io_min, but never to the limit that is named
> after it. queue_limits.zone_write_granularity is left at zero, so
> blk_validate_zoned_limits() raises it to the logical block size:
> 
> 	if (lim->zone_write_granularity < lim->logical_block_size)
> 		lim->zone_write_granularity = lim->logical_block_size;
> 
> [...]

Applied, thanks!

[1/1] virtio_blk: set the zone write granularity
      commit: 684b413b5483f57c890c171b9400076a0143b918

Best regards,
-- 
Jens Axboe




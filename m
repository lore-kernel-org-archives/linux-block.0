Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260983;
	b=sVoiwOYZcGdZpL57T01UrOofNWvbFj5+389dnihuRADI7CbhtWb+/sSWIoOwxcpSIYEX
	 ohJ9uwJRqV9fDUQ97hH6ElYIDQFRDBwvJXoQYEw2ajJcp5aetEIwmvXhvLGggvHHvcB6g
	 mYTRuXnatfzuJWyoTwYCs0gxYw1vOLecmI8Bh+VLTbOrJZX4xQe7goQW+68zWfJHMgHKL
	 vU7gFNfPUYp8cyIPY3NuyDllGc7UvvZoAfDtArVGONInmL2UW75BhRsf2RHVTrq4xiPD3
	 SLyL+a7mn1RFCi+QFysgmoIgairzjRTMkLQbteMTHs/eylDu2E0teqcCAZSkuPkA3Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=/yGrwL4kadKURQ+8yKaETjBqyNejok2Cl0vxpAXk4aI=;
	b=EAghgnNtXyrb15eiFaPXperEMc4kPuo9bzKmrnNmlUVg6VSwfhoGZsqLcZSmetTMhEy9
	 I7EldKTHjV3SyhsF0qe3GiAeWkwg5FviWaOfEtfAp+92D9ljjroljnqt+c5HNiCuIdQCd
	 j6cZLuyvc7RNm+I7QA6hbvYSSeDhB7hjk1BumAh7+pKJMfzpA+aXnm+QS4N2cmcbbgBKp
	 eEVWg/5tSdzaBQFaqdM+0iFd857hcB1ZMuL3BHOhUVF0jbI5W5A82xmcLYTzilcwZK/4s
	 dSPdVJlqyR+Pi/sLn6vNdqjCymAIcWqjcfPSttQAocjgKZz8WKzJ3sE13j6KfTOst7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UHYiOT80;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D1606A31C
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 21:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC8D1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UHYiOT80
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b612fd74e1so489187b3a.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 13:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794260982; x=1794865782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/yGrwL4kadKURQ+8yKaETjBqyNejok2Cl0vxpAXk4aI=;
        b=UHYiOT8059IRh5T8AyiOMu3BRaahFoVfyqNHSaWysgJIe46todlqo+ot6NiVJLjyEU
         kkVpbdcUlIFX/gb+8hclkKRE+fwD+3eCB5e5aiqkhd0BfWw1NKCucG9OmGG3vjtnI+iY
         +0BsCHM2SWBy+3kI2/QN3j5XFfKJ8btLQaUY+GhZ7eQ+NfeND86AxrIjMom6AOu/64ue
         Ild89hI6HvmCcdIHyflYTrkT15hooCHvg/Sb7X+d0uNOhaqKg5Jows1svCn0BqGIodso
         pGWMQjOKfVHDReNyzqkJRC2LKOlw6QnDsZ7P3XDF0mhD7JYhzXILwpD2Fw8ytlsnPUli
         f/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260982; x=1794865782;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/yGrwL4kadKURQ+8yKaETjBqyNejok2Cl0vxpAXk4aI=;
        b=w5+6YbFWPHvzq/2bWxJHPHXElseawRyCj7M4kmkRB5UAf4FagqZnxcZWJ6ycL6A5Jw
         ycShMSdgDvzXVyP5ECcN7yi2gG7YEVADosuVBmnfC5nTWh1qIuzKqQti1tFNICz2B2gT
         bupKRW/pqEeDvzKTyuRWzGuGu3D8ZIuQG/n7qZa5aZp6KkyVSzHF9/t5cJ9Erh3GZG2z
         x+vJvMHBjPWRYnmv+2w3m8OaBWP3QMZt2eBIy6rh0xZfM5K5QMG04rCk2SkFtmBcORPc
         Tj4bDoxI2diga3WW3Z2pyqQzQMI8r9sI0cKF4mUdc/FDz0TaYomRfa5KbX0hW0XUxg2v
         yzqQ==
X-Gm-Message-State: APuU4Z/YxfdsOUYKSJD2OjrVWVWjtJHbxktK7JII4RyfYB6C64j1BUVh
	69jgsJe8Ps1FAC14p6mPdNnrL+JzQBdiFD+oZ5QtVGUM4g8dXP1fV56INu+yTl3L5crAPHTf09d
	sK7uCKLE=
X-Gm-Gg: AYBFou20gy6aAVK4oQmSWeLMsrE17tocvylGKEXacMy52hcD1PosCYrlfyoZ1OB3H30
	nEf/01KCXzL1b10H7hQSsfrFcJh7NtFHg+NqBqNnpNPCogTj00YgVlIs6xh5NFT647aQggILlIt
	L1sYFWzpwGX3x/75GoFh39VRHI4yfzi8vNuvt0SKVF1G940aFDbKLydtmFO/uwf2UaiqHOzHxFq
	Pq9BYOiiHTP7Sda7Vk9NYCBZ1RYCef2mEWdiBBvHcZQcp/nzaGmlVvfRPjLQRzQGrdT4dy6Hyse
	MTaLRJ82apT9lDR+SuQSAOeSU05rdxb49Nj33oSlKYVXOsBoExssWQrelPK3yMWyzbPLBIQzQJY
	A9k8Epf84du5KLFYzPLcVwU8QcU9vMEgYQ8skUxSbmpd36tVcCGkNGG6lGwyrsHJ1AvCUUFs5JT
	9CGC3nU8pscKpmefK0bsG2umHF3qRi0nxLe1Q2kxtm9+pN6rWeX+BanH6I92FwpSXo9HD2fRtJ0
	CBuKXyyW9uYioah9jb7e0AAhf14u7NxU4d36E+jOYXNMoAH5WPCqAM0d6C4+t/vFv4mSXnqcjpz
	Vs879RJq+bu4Kn7npjBJYNVTeGqSePfUJmcmVcQuRbRpyKo+4sL3W8iuuvk9X8DxHaDJ9U0NN4b
	5Ir6ZDHzlXEGf
X-Received: by 2002:a05:6a00:a83:b0:8b6:54c2:a760 with SMTP id d2e1a72fcca58-8ba852373fdmr889315b3a.13.1794260982075;
        Mon, 09 Nov 2026 13:49:42 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa1b2896sm129427b3a.17.2026.11.09.13.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:49:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260902183723.1584-1-phil@philpotter.co.uk>
References: <20260902183723.1584-1-phil@philpotter.co.uk>
Subject: Re: [PATCH 0/1] cdrom: patch for inclusion
Message-Id: <179426098008.155418.122225966967055817.b4-ty@b4>
Date: Mon, 09 Nov 2026 14:49:40 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 02 Sep 2026 19:37:22 +0100, Phillip Potter wrote:
> Please apply the following patch from Manuel Ebner, which fixes a typo
> in the CDROM standard documentation. It has also been reviewed by Randy
> Dunlap.
> 
> Many thanks in advance.
> 
> Regards,
> Phil
> 
> [...]

Applied, thanks!

[1/1] cdrom: fix brackets
      commit: aa7014f8d7565cfea117eac36a5de0a05eba65a4

Best regards,
-- 
Jens Axboe




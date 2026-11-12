Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481402;
	b=PjVOvwrWDNqcySeuzi0xlPAMISicN+z9Ly4hiQatn0ojjeA85FQEOJNGUYw+VfhOsULo
	 U6wHq1BGxI+uqzcRhyaPxZCIcx0XYyUi29ykVp1XmCr8a7u5R2OWqDwaFEvldbd/djNM6
	 iDtsCb9Ip1gSy1N4hjD3HAK5FFRf5KFojNsLrHs93ASBgqrn3kb9kD5LmNFGt0N2QDkZK
	 /kQBGtMMfyECbIbDAdDLa3QkmoEyuDN0z90MDfAhZ/Enn8HywFufBukUhel73EEvdqD1s
	 YS+xEiJzjv9Z3EbO6WU+lZ5e11moOZNiYQ9BnAclWAYITO0G6afAEdJtYFwO0AOlr7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vxUbqSaYvhE3NBiIJJTjM4BHgOZOReR7NzFQSOvhlQg=;
	b=bEgfrWcZGFxpS3rqq1mlJJXDN+xNJOXWuaSpVZBi1WS730BN2QXsNEqczscvaGMA5liD
	 LhfeEKZprhHmE52NkMHTkipk1zTNcWGfMzBU/dIB3rAnJKMB7X5VThE5EFCWlpFR6Nv1a
	 TbChdTM34uIKPtEHjUAQ9l8QepZ1Hd49iNbd+8mNOPpOrVzda9NmjWR5d5genslAQJrFm
	 CDK6oCYsO+dw0aS6Wwts4c4C0P42BaoQRNW6XzsqlG3NklGiNsMuMAXYN+HKgMIZv3dOE
	 IZjTymU5QblCT/0AkhrqoJhjSTR2/ZatlD0nqy/fiSOn7HOKhdyZ+wcxGeaZ8Om5sog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j4WpPLKS;
	arc=none smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE882606A323
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 11:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE882606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j4WpPLKS
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-675617e81f9so4303123d50.3
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 03:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794481401; x=1795086201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vxUbqSaYvhE3NBiIJJTjM4BHgOZOReR7NzFQSOvhlQg=;
        b=j4WpPLKSM/7Vdg2oT87cL7Z3ITYR8YL3O/rFnO34LHaybdj9WJ9u27kZR7mWooZvgR
         SHbtSnVXAn0VL9Wl7jSwN0grF+fT9/OlZVn4FLOCnPsDeEgtNgXJWA57dwZnNLONCloQ
         pbEiLJKUV2+UiG1E3uwGp/JfCjgTZe9oe2wWo61XW21HP6UgC4gYFNhl8qsFj4VcG86n
         QpRXs15pJBcoZOcggid+nUCPBa00Ebrze/m32y9EGkUWq/PrWztEieSblVO/bWtsYdwd
         B+G4tQLKjB1oPlEuQWdXrMnWQx4JtBM62m6J14omtgjQSHzVXrSsATUB/Fydl48mjclE
         Oivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794481401; x=1795086201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vxUbqSaYvhE3NBiIJJTjM4BHgOZOReR7NzFQSOvhlQg=;
        b=2eA+V/WOEEM9rNWL2nuh9urZa2t3ECIA60XDZeYDuQz5k+k0GZzHdp2BAAzWNmsaWG
         98oFPpsNHqoX2SQLBj2IfPVMCDS1PkNdbbsWY87vLdsSkCvbTj7RxPljGsm/JFPe8SS7
         13rGr9CMU9WpC0BnPwd/13+8+cnToKmjOZcW27wix1YrGn/blxxDJoly2byxJ92E+Pbg
         HdaM+JrhIdlyD6ob9eh3WieXxBaHyWcObg9TGlMUoKAZtG+EEKZOBrEtKaTnj0EG186b
         hy4QwktyX8PnGbicAK+BjOTeptYenWzNsfHJThHI4SXuMDhKsboJUy0E55dxLSEm8Jbg
         HmBQ==
X-Forwarded-Encrypted: i=1; AL+hErHwMZrM9NXoqfTYdNC62F+aUOTyQ601pg6BXxUrXbId6F0UYt4Xdk6i17QCrgoM8bYnqFojXyqvO0zDig==@vger.kernel.org
X-Gm-Message-State: APuU4Z+fPlFuzwVHCca5tIeYcEJmEu9SpYeLO69Vb4pzT3hoij03POwm
	N7Oae1Qge4mDwC3Hwn+MFTKsmmrbXtUKYkEGRPtmKQLFUhUvk+LNtf+a
X-Gm-Gg: AYBFou2LxXhrnsv10Pfi3sP5iLMqDGaDi3hT29JEWh0mvcX5GKdSBFgRgIl0HcLo9SJ
	5GDbMwnG8B1D038hC20yL/dLq6r+v0VQZOTGAd7TVlbMfdLQqJYGrPL7y3dYqWEBY86eXD9XCeG
	QUKMq9ABnjsMg6wXUA9pmtjuQ2xk2i++Vw83+GCyS/8NWs/RYxuLq1/KywP1rSvFOvLbnSB2jxq
	t8pCY4rcsccYBZJcyg+jrosqfhtnOvNKw2JceVa/G90w9P/M2iU3Vj2UGy3mHaAj6UTarlR+otH
	gfZ+JABvg230aO5/yd1sUqnN7W3ZRw2rsAuG2BJAfSSEVLMDBkRypHNLsHwYHzK2mutlx+hr6eU
	fs9QoD0RgrFFNwOfsBzKzRfu9kwdEWbUNDH8hrWCa+ofMqgkLHKARNTIMR+uSaYQplI12DzBD56
	ph+peK/EPQVkDjqaWbyhcv+//Fkt/euJzTcFK+lVtUGiHYAaoQqvRZumkCo1rsqVReC4W4zsDZA
	vZw3o1PXSyuhcBN+AM5RKNHrGlz/WVIiNOvlvV/00RISO0rojLRydfOv5FRHmXzSGBG9wB0zeXY
	HeKukG6uWRpI6DBvNxjO31RHTDDVxqsf0jBKQfu6XbdkxjTxcBlDJv7dBObyxrQ+bDJrVcFKu+Z
	Iq4IsAvn5
X-Received: by 2002:a05:690e:144f:b0:677:cf4d:a932 with SMTP id 956f58d0204a3-67c67fd80c1mr4309351d50.63.1794481399903;
        Thu, 12 Nov 2026 03:03:19 -0800 (PST)
Received: from fedora ([187.120.157.132])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589ea7acsm6965693d50.14.2026.11.12.03.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:03:19 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: bvanassche@acm.org
Cc: axboe@kernel.dk,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nbd@other.debian.org,
	syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com,
	trintaeoitogc@gmail.com
Subject: Re: [PATCH] nbd: fix circular lock dependency
Date: Thu, 12 Nov 2026 08:03:07 -0300
Message-ID: <20261112110307.261098-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <c2f4dbce-f8e0-4f04-8dee-3f8d413f4d0d@acm.org>
References: <c2f4dbce-f8e0-4f04-8dee-3f8d413f4d0d@acm.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> After tested, how can I mention this in my patch?
>
> If syzbot confirms the fix, you can either:
> - Add a "Tested-by: syzbot..." tag if syzkaller provides one, or
> - Mention it below the "---" separator in your patch (in the changelog/notes
>   section), e.g.:
>   Tested against syzbot reproducer via #syz test: <link-to-syzbot-result>
Unfortunately the syzbot test is temporarily disabled:
https://github.com/google/syzkaller/issues/8122

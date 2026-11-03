Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716292;
	b=qN80G9hyK+ihXM6oDKLkWy0HxUPW0EhsYSbmUdeEUCX/oy33noE3ImDch+Qmpwlvyhxo
	 2ZTo8Lsda0Nzkw6vqE/DeCymPFbYKGw06iIChxUBxQeSTSSV7fQdufTiTA/pi8XjuN2f8
	 ej9p61D+5D+y3oHaUqwB01m6d1UfPTzdW60E35V1sm+wC6RfyYHNCMhtyJgQZpm/CX2rT
	 KAyMYJFwWs1nx3IQ6v7jusbnTL/oWdtXCusttUvVb6UFcMUes48q4s3J9LNZoZSqjtBf8
	 xyXFD9/xPwnjtZPTE0gLbsNf2GrIKzk91+VUTm83qxzMO0IihCJlyCcVHiOr0Wt/tMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=HweYqYqFtvlMdM4mmRjwRm1SxxlbCRRRmS5HZO7XOfc=;
	b=kvIaCmjgkgHEeOCLBQbs6TQUoy51V3Jp/pdpYXiTD8EHV432YHrTivzRsnUdV3SGKF3+
	 /HbY0a1jncdcfRoKNFHgP/6KeLkcdhAmIx6CEuEf5ZOZmaxQH+cftwPA5IU6cFIyhCCf0
	 QVc559+hTBv/MEsTKn7YGCRCgIQVuSp+WUcUXAePtzkzyJteFi7YhtLisamMoErqC7mRJ
	 0+yvLbvZyNjz3+2xvPDY3jqWZsdTunZgi/5pnPNddn4BEF9guUAn92kGHWio4gJOOSvTv
	 y3xOZ9Vl7AOf2jvSpnznupLMovLV6aqc+1RtyrBdceArW5Bhq7L4tpQRFN+reDtQQkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LUaXPZaQ;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346AC606A32D
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 346AC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LUaXPZaQ
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1438d9363fbso738533c88.0
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716291; x=1794321091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HweYqYqFtvlMdM4mmRjwRm1SxxlbCRRRmS5HZO7XOfc=;
        b=LUaXPZaQKXIE0OQf2um0whKngyORef7HmHxnRlbChrnCjINyPyrOXw8dPS2KEdL4JG
         dGWmKS8vv6NDv7mjM+nSiTV7W/JQ3iUWyjae59KDoMR6E1ajHD+cA7uE3t7V6irXmc0p
         b+LbmLLLUkv2GQo8MH6Rzs6Jr8xBBVEAA6mq7EgoBjkA5rqp0GS1iAQqr7TmAQBwYLGY
         RwsHU8Ua47U9qgN7/62AN5M2e6J/Yhb6s9qVPTNLZ2XtwpmAPVo9kZf2Br6ZOGXuU//j
         B0m98F7MwHz/PM/el0PWEPImjl+wBWz3rcRV/eAdGUxqM2XGu7Pn0O1NSy0zkPNIt0B/
         Hgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716291; x=1794321091;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HweYqYqFtvlMdM4mmRjwRm1SxxlbCRRRmS5HZO7XOfc=;
        b=VOL05ap6Z+rKmI3cBuenYiO1tYZncNdzAv/AbIXaFW09ANx5u7rKxQxwZciAudXFYR
         w5OjCVq5tK9dtbbvDsXX8jPETyHl7Siyv2PpbH3oeztG8+ytlLhZmTrjSwqj+mKZvytd
         HnlTZTFP7BZS0T9Iou2KPyJTPzXzrNaXKSL96mbXbxqXPQYo/Qt+50Ox3363QywZzy1o
         w1SzvAmdbwIXeAOQU5xUxXwJ/BwCCWce0k56PGASulMNEZwcI+HU9xBxwx/MWYM0Gu4X
         Z/WJ59VG5ZES7mYF/pJUXOWxujaESplif8i+kKvtYOU7823t7Y4ICtu0zXtEQxKusFTY
         bSrw==
X-Forwarded-Encrypted: i=1; AKwUvBxtI6Gx+ALz4ymKipej8SZFEicPYDFfdqHd+EX5kEZTREic6JieF4HierPduuGhnOUxz680DMrNbV/8ag==@vger.kernel.org
X-Gm-Message-State: APuU4Z8PuwxZ7uiFiJdd9tdolIlAads0selS4CGMm6RWYQuzsQN7UF5l
	enaLo4H6Vnz3+oMIcs3UzIueoaJxHw6qOct9gS/CuwbvpZMFClPTNYLAdhJ9wCm/TQY=
X-Gm-Gg: AYBFou2Fy7fAlGaJjbXbl+wf+RXejMmLo78UgVTt+SHUMWFYQLn/ETgTvrDcjpBV02/
	86HrNgK3eYCoPTayMI0D0yCWRH6Ia8HsQ6SuD51/ZNC16iAvTqOf4OvZTqnPV2ac6FSFF7YtAZd
	DJdmM6EHfGpjT9mtknHLVxqqbEt3uphIOUD4KiNSd3N8l8DHOU8VFDJQKgP12VDofO9wrcy3jZE
	jBZ/inltGzC5O156MpbFiviJQEeBm++w/87ZgKkIwhMdJ7danH8TQiNNq9Tw0hCvF7btWMyTMcy
	4x0pC2DQdxQEi76cyORKKYf7vz/EmIuedhdgMNJDKdY4agPauf6egZ+fsFzSxgE8lOZWM2QdP00
	sxQs7gQ85eLAbd9ST6/Z/UQAd1OXXx/vCkE0IDzx5VJaFuk8hejghdyHy5Wh0yvz+DN51lPpSHG
	7/JoXM7/othwcFdKIy8vAdeyCwSVaFXMsTVN99wV+PptlKbGA9C7jsLBEw3EDuY3R7gHjVOJiK4
	csgnBAqdAeQNvRU4Sdt0QMC8oDwIVnxzapU7al6g68uHjTWS/o43Ku1s9K8gtkRifBGZhbfxRH3
	MOKRj5CN1jUGW2P3U94JtABOmU6XyJGEUOvMdordxn6sagllj5tmXjfYqXFCu/Fnw5tfORdO+sn
	95JOBjv/rc0zc
X-Received: by 2002:a05:7022:ec2:b0:19f:cc98:f603 with SMTP id a92af1059eb24-1a9420e4a4emr27202884c88.1.1793716291137;
        Tue, 03 Nov 2026 06:31:31 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Niklas Cassel <cassel@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
In-Reply-To: <20261022092158.2248831-5-cassel@kernel.org>
References: <20261022092158.2248831-5-cassel@kernel.org>
Subject: Re: [PATCH v2 0/3] null_blk: zone resource management fixes
Message-Id: <179371628963.3691261.1823421280119738589.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:29 -0700
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


On Thu, 22 Oct 2026 11:21:59 +0200, Niklas Cassel wrote:
> Patch 1 fixes writing, opening and finishing a closed zone when both the
> open and the active zone limits are reached: null_blk fails the request
> instead of closing an implicitly open zone, as ZBC-3 and NVMe ZNS
> require.
> 
> Patch 2 fixes zone_readonly and zone_offline, which can close an
> unrelated zone, or leak the closed zone count.
> 
> [...]

Applied, thanks!

[1/3] null_blk: fix opening closed zones at the active zone limit
      commit: 6f2b59737bf9cf3623719857ac149f0d431db109
[2/3] null_blk: don't finish zones to set them read-only or offline
      commit: 973bf587d79f061beffdd392e77012a07f25fcd6
[3/3] null_blk: clean up setting zones read-only or offline
      commit: 304b850e02fbbd72974a2bd0f88b0510f14867a9

Best regards,
-- 
Jens Axboe




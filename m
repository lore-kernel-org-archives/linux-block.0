Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E513E92A9
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809833; cv=none; b=m4TWlVlhePBGlbreMHT9K/o+TbKFe6QDIaT+9EmSlB9h7AGhNudMbhoBsyNaCIgrul7L6jU8E1DtxaETtLPEtoJtcnPf8WQcMjpyQQbdsOXBE3bHyTl2zVQBy8XC+YyzwSbVhWfj9jzEY+Mapefjioi1LT5cP2lmCj+z1OKTguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809833; c=relaxed/simple;
	bh=NAnpiWgfws9FS74DHuan7DMixthowGvqdCUnz10HlFk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hVU7oIIisOdjgQe0U5bzouYvFVVRCYE6/1h+YUACWpti+9wXzmHYpdlEJ0C5PsMuJ5RlE+LUGM4Dd99RNmk+N8ZSRkZ5naY4WjhJX5w5FbP7WHR4SWXZ3vdjdWxPouH7GE0ZzybKq99KyrsU8JffYBIsUndSgdAWByNfGdGOW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=h4u2CF3+; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="h4u2CF3+"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7ec1e9d3359so2816229a34.0
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 19:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785809831; x=1786414631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oo3PGqHrxJ5gYaBHeUEq5xU64gA83nu6jSpdwaT7fRE=;
        b=h4u2CF3+SrtENgypgv97Kg4XudQ5ob2lvbgilQ8W4pAf1cHEOLF4nsy6OLwA0aSoQi
         vVGZLmkP5OcHefcSCS4HFHC+Sm3qz9dc8ctOpxQ+n3G4UpstJCCSROFhrLHmIcK1kcHX
         G+Vcc5apqCb0lMENtWTWROh7OSdmN7KnFH9d6w522e2g78h1hOmo2guYnruYLVnW893m
         RGOYcUgnMhyJImEKkjmD2WDGEh4wNQSBn/BoNRez176VqI1JAA5RtWLRVdQfl8v3deqr
         MzAcVwH4gKyymU+p8MjbKMQyDjwyPg+B22fzwN1IrITJNgLze6uhLA0jXoyfzua0IM4A
         gINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785809831; x=1786414631;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oo3PGqHrxJ5gYaBHeUEq5xU64gA83nu6jSpdwaT7fRE=;
        b=mpaE3XEtNxXcdMkwVAHSWd4infytPvIkzoq983DfLqoj65ULyku8iGvYR7k7lswEyv
         BDL12Pgl3nLqoTJSRmpkp8Y+WoL1AXcmGUs23TE1j2ybooP5OAXRHbVab7eHEz74E4j6
         06fz9fi8VzMESRzUSNXh4InCVnEYZTJkgrQvQYTuQ/UzbuCciJsoZUPIwdQXJX44VHUO
         VwuCy7eW83u7L++BD/sd7UpMoMX51SDeqzejZSVXCfvttha7mSzj172vw6sYnHeJ3cDm
         T86xIzEp/FBulMfUdj3Nl9Th2icIRpZuUir9fw8PyesivYPMKik7jHfyX+MruOERSHDX
         5FzA==
X-Forwarded-Encrypted: i=1; AHgh+RpUJrPMiSy726pR2mDIPFfUHJbRaxeqZGYAj54gA2fRSSIU9BMcwh0srDkYstfDAbFt58cKwH6SkWav3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKJ5MDR1Vnf++g5vI0xtdc1W7PEuGNZe97KIJHxCWWGo4oe+ZJ
	2nd8T4rxRS7C0+LceIdVcsacNOjCUQHbGWh4wwyLISQCLV1xtgH6lHHvK4ORrp0JwC0=
X-Gm-Gg: AR+sD13EWgYPCoSF3SnIfyobTfETXx0Fvzb21wDOTuF6rN2Fj7BznPR1Cb+RORnFLb7
	gTDa+yx6yACdnQGxH9rNPaSvnYcw3QeiiLRENisIIPhRGSPg/qyeSN8wFWEW0n2ajmnxvwakLgw
	njn+flfNHFKilDDm47l9uuBzIBYf3BNwCMFuQXmkk99JnPVfg7M3OPa2lMtUsdC5wpNhJSEGeJa
	heagNvgmvugttAAy78igHF96edBZeGU3uXs7gxUsoG8Px86bwcNmwh1jsMhpIr3r4FWfd2lHj00
	XWd5HjiMvWuDN8pk2ofyr9vYxN6N7oeRcxRVjqB0FViXJ5v1wuSiPZxMHzfl/xxuVSkh0WTeUYq
	XTyG/PKUf0XZDaNmt+KDDYLXzapo9R+YWgvCZqaHVKdaI5O1iNqz+r1xfmFdJ0P5jxwBzCQOZG9
	rxlsttdAQBsZQlinSClDVICQCDig6EqPlmYNrSTd2toObB7aOukIctfu6EJElEctJv5AB8n3tbp
	AJZmeCU1f9PHUfNqtaNTYg+ZzWc8ntjHKlIXIgYJQ==
X-Received: by 2002:a05:6830:3789:b0:7e6:ef2e:28a5 with SMTP id 46e09a7af769-7f196fe6ff3mr19369677a34.15.1785809830654;
        Mon, 03 Aug 2026 19:17:10 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a55asm8914812a34.13.2026.08.03.19.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:17:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, Yu Kuai <yukuai@kernel.org>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, zhengqixing@huawei.com, hch@lst.de, 
 yizhou.tang@shopee.com, yukuai@fygo.io, nilay@linux.ibm.com
In-Reply-To: <20260802112525.3933753-1-yukuai@kernel.org>
References: <20260802112525.3933753-1-yukuai@kernel.org>
Subject: Re: [PATCH v4 0/4] blk-cgroup: fix blkg list and policy data races
Message-Id: <178580982922.518281.16495429438409271117.b4-ty@b4>
Date: Mon, 03 Aug 2026 20:17:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 02 Aug 2026 19:25:16 +0800, Yu Kuai wrote:
> This set fix some problems that are reported long time ago with minimal changes,
> the blkcg_mutex refactor I'm working on can fix these problems as well, but it's
> complicated and may not land in this merge window. So I think this set should land
> in this merge window first.
> 
> Patch 1 protects blkg_destroy_all()'s q->blkg_list walk with
> blkcg_mutex.
> 
> [...]

Applied, thanks!

[1/4] blk-cgroup: protect q->blkg_list iteration in blkg_destroy_all() with blkcg_mutex
      (no commit info)
[2/4] blk-cgroup: fix race between policy activation and blkg destruction
      (no commit info)
[3/4] blk-cgroup: skip dying blkg in blkcg_activate_policy()
      (no commit info)
[4/4] blk-cgroup: factor policy pd teardown loop into helper
      (no commit info)

Best regards,
-- 
Jens Axboe




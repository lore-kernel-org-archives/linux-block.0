Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF63612F2
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232188; cv=none; b=b1DJphxIxX7/jO0PFzFHYh5yHKujzcvnSKpTKMh9IUk1+7rqj2/B4BVLqNrK+Lt4+8hwwNk9qHEjmv30aTzanLH6xxHQDTqg2CzI6pue//In9A+BjgwCaVRDuSM51lPlJfij8JPY0Nv9XP8sr73jK0IwsqWhnxomMRj9Jx31E/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232188; c=relaxed/simple;
	bh=ra0u739DCYCl3c40BI5aiE1MJ4c5O/zZ/bPxL6K1lpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRTWUasMqI+dSmi3zh9EfVOICLF/ugXZPnOVv/vTyHX4pUgBl810q/SLWwCz9zsjxG3X1aCpAokJEIxV+P6dT1Fki1arcA3zIt0KoZz4A+f+kwJhhBB8jtL/tTHDJSb3pWTFOhqz8xrTFP25N34wNRun79U2SI8tVT3mspZzSnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xb2czxL3; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xb2czxL3"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3e8819eda8bso2227563fac.3
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 07:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768232183; x=1768836983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06lsboNoB9F2+Ai0kYr9ObKsqCdi05wDUU2fe9TFvf8=;
        b=xb2czxL3CrQq7TAaEDPDmD5KBJusI7/JpZcFP/dv6EMMUqxvK7xC5g3T4qA+jNYVHf
         Q5/Km2fg6vpM9bvEl2fnTkm+IfOGNvWUFsC1ljqdNYCLKCvYOGEcj+qf5Tnlf/8aJMdX
         4U9ovOfAebU48JSansySPAvXnm3PMYRX73VIi0DTS7ZEpw90ekf7MCpmr8vxlP+bFpEF
         ahI6rN/UVKYHDBs1Otn2EqryIJmZDf9OejUXgbWDBxKCu2X5zrXBs2XJYoYs2RlDHom5
         iOKWPIfOMMVFfgaD2f5ji9sk4LM8fCb33hZYQCAaok5hgQl01JuTsWSAI/lpWk73DRms
         IwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232183; x=1768836983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06lsboNoB9F2+Ai0kYr9ObKsqCdi05wDUU2fe9TFvf8=;
        b=X0iTA99uSYyw48ebWSExlAB2aTPXQnca+jISP6Usv+i3TKHLbgtPPnWbO09w1xN6TU
         288sgkso88h5y0jAo/wsj9/kMeUyJ0JAz5blNL8CjzsXGZ3Xhhys0MoH3r6jhSlNU+ww
         DIlo0N3Dv1sJmk8Dkossnfn853/dAhXR/pQRFzoo91wxSQJ9+F1nm7A8I4/46Ga7xjhA
         nmZDjLQUr47CT3cKTwjdNLMLvZch8IDyf+fAtDBMQ1zH6HEdu0urkwv0qUFNaklPBJ07
         trTqZigkb0JSrr/GwCEvqs2cPpfFcOU3yDmdmphgbhz3vK5QWFOWjED1Jd1GGHSqk7um
         Jvvg==
X-Gm-Message-State: AOJu0YzOBesJW9LTbNyukYbJgt3lH+dRIXVUEBvxIRTTzL9KjX0S0TTd
	IgDrDofE6kOA8oLsRZ1EWGU2txyPrDC0s8IKbQkBKwVM+vVKC4YMmWjeZCRMp8nxZRs=
X-Gm-Gg: AY/fxX5klMvOvtcoS6HokR+/h43/psFtg4kpJCPoiSJRR0iE2T+tbOckLvGo7qr3XP1
	wO1yZXwX5YVv0YK6GFS9JAN5xoaW1M6ZtWjfDdDZzECRrNsKNlZcvqONOGQDXeoxzy6NovA29Sq
	GiL+H6Yq6lH0XW0L2/B2Sg7SgmUh8Yrz9GFJv88Ca1krS3g8d0RDtOFPSvpzJiqppKP3CIC25iQ
	1iCqpwtw8pzBRDlV1b4E/Y4i3v38wPj+zA0cfDMt44FcNTAJHvnbePxudaxbkhW0+d20ThZ8rk5
	p94e+bfs0pzSxIaobqIRsTvOkDrossFVHytMfCsNzxJj/mDuwapcbCCF+GtMCZP352BKprVcBNh
	6waZGXQMR2IpqEwZ1GFXG7daCi5r8RkkRvIK1iu+9wSBc3ytfFBKABsVdPpjWVNawWVttHAsW/t
	NWV0BlNHRH
X-Google-Smtp-Source: AGHT+IG5ZpxgZ7/rV/aD2rNG4KGnPr3neXhKNkt61+Q9bgZ0iJjyjPMJv6tnJi+G9E149EfEKQ6JDQ==
X-Received: by 2002:a05:6871:2b22:b0:3f5:4172:1d with SMTP id 586e51a60fabf-3ffc0bb26e4mr8217122fac.58.1768232182992;
        Mon, 12 Jan 2026 07:36:22 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa5072427sm12061510fac.12.2026.01.12.07.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 07:36:22 -0800 (PST)
Message-ID: <72e8bf7d-f4fd-42ec-890e-f4ff5aa3d314@kernel.dk>
Date: Mon, 12 Jan 2026 08:36:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Samsung] bsg-lib.c patch for double-free error fix.
To: jonghwi.rha@samsung.com
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>, =?UTF-8?B?6rmA7KCV7YOc?=
 <jt1217.kim@samsung.com>, =?UTF-8?B?7KCV7Zic7Jew?= <hyeon.chung@samsung.com>
References: <CGME20260112094010epcms2p518c5eb5408f90ceb7ef5739a0fbf7f65@epcms2p5>
 <1591680112.4972876.1768210810254@v8mail-kr2-6.v8mail-kr2.knoxportal-kr-prod-blue.svc.cluster.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1591680112.4972876.1768210810254@v8mail-kr2-6.v8mail-kr2.knoxportal-kr-prod-blue.svc.cluster.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Please don't send patches as attachments, and particularly with html
emails as they will just get dropped from the list. And it makes it
impossible to reply to as well, as you then need to save and read the
patch separately and import it into an email...

> Change-Id: Iadb96f8736f8d9d9aae7b4a831c2a286ff59c520

What is this?

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 9ceb5d0832f5..635b3b988f92 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -215,7 +215,7 @@ static int bsg_map_buffer(struct bsg_buffer *buf, struct request *req)
 
 	BUG_ON(!req->nr_phys_segments);
 
-	buf->sg_list = kmalloc(sz, GFP_KERNEL);
+	buf->sg_list = kzalloc(sz, GFP_KERNEL);
 	if (!buf->sg_list)
 		return -ENOMEM;
 	sg_init_table(buf->sg_list, req->nr_phys_segments);

How does this make a difference, when sg_init_table() explicitly sets it
all to 0?

-- 
Jens Axboe

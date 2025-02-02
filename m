Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60D21922FB
	for <linux-block@vger.kernel.org>; Sun,  2 Feb 2025 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738527753; cv=none; b=AE4kAoUvtGMbad4FsmeweCN5P025PsMxyPz6bBLCKKd+mR1vcasmLqSXMHBzbFIxCxifwgDMxEwnBAvqIqXQn/iANUqyCkyut4J2/DCU1hXDwqt/tpHpPUy4ife8TWdttTkF0lnm1d+i0Y0Kol1mmbQMhtQB9v5zntHySBFyQf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738527753; c=relaxed/simple;
	bh=X9K9Q1+9BO/6T2Eh4+15ZctzVmAxNe5f1TUbVq6NN8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ma4tcF1ZXJ+OvE2fOfUgQl1ovMK6P8ounG3vS//vhAvGx2VPdS0K+UstPShEyWBUVYM0Xy455PpqMwJlxEib4hQ+EqZ1crWn34YxCGzLolN/Dg7u/3bbauH0R0S+8Cczjq4wdPHlaA1z0/sIU0qVQkDHv0a87VItdMes0oVhjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KJPh4+Yo; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KJPh4+Yo"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-851c4f1fb18so87641339f.2
        for <linux-block@vger.kernel.org>; Sun, 02 Feb 2025 12:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738527750; x=1739132550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3g+m8stdINBWKHvUA9tWQRvbHUhD3fkIbHGDP+GJloE=;
        b=KJPh4+YoKREnjz74tFSCuBNNfpaJcdVNpqjUh/Zl3T2fVE8G6KRNSG41sQVT3j51oJ
         xXO8xawST4EGNygiaWhZd3dL4v1FE6LWBPIdVIT5d5bFTkzn9FGEZzGHlixHylQh4q1d
         TtErAdPoSDFrf8hWWJWpnbaxGKmO/sRz0hJvr59o7XYrhZi/3r7SGJ/sU9xZiB8x60nw
         Q33jn/AdbreZ2Lqvg48DoWmp8Vuj4XbEnre8i/Pu5oHYgWAtzsEQThpJWhC/FtAscDAS
         DAHVqKz9xfEJOpFAHfMVbaFXJrQSJjKsihqNtRktOg/A9ADEmPk0rakL4XhvT3jtPA++
         fY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738527750; x=1739132550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3g+m8stdINBWKHvUA9tWQRvbHUhD3fkIbHGDP+GJloE=;
        b=cAGH1TDcjooJZjxkOsfJUed1wCisTR/wBhVLHI7lyEohGQTlLAgAG/3zqqXXoxGKX6
         3L3ZYjl5Sn8MCCd/1tLz3/pOuN4jWQdS90Hpc89Pm1L20N5vVYzhhTrIea2oksSxzrAl
         K8T1tg2BKRbIrWCP9LxJaWfQ3Q4hXMNeeChSf4PFMsf4pLDCn/1kafrM8tQ8fJ3fWnbx
         FrsTTmAEq5V7cgiRhQ4JIUifRuCNcDorGLKSyhHmmh4Lk+4m+B9AdgWDzROIRt2Qm6tJ
         5g1kkZiORDYuI7OVYVII+Mo6tyvkU6EgrTxhSaFA5aLTdckZbkEkiIuAHBlPHbTE9bbo
         u7jA==
X-Forwarded-Encrypted: i=1; AJvYcCU7aDYB0yUV5cGmtuaxLaxVHs+FlD81zWTn5tsVmj3SUFtDa5RCYiYke/uD/NYME+k6+E+0pBRtnrzmrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpm8u7DXZoXHmF+TfrRAgWs5yISnuL6SvfoHROArxZ3eCo2ram
	kwWEER9JxkUIOl+nAmeGNPJtoYJDnWV8yDzexP2sW0M6OyJITMhHKMZB3r/J9Ug=
X-Gm-Gg: ASbGncu5RCmzS/pLpwLePnvL2e0j/NZI6BDsLcjiYSbXGETH6qJJf5gNpob8uX8Nd4i
	+NJpmmGMuaw0bbBLGV8Ym/GWw14LCG99dtdmoim3bC3iZxVb9bvPNAmWjZD4sKdngnDSoH883Bi
	O+C1xY2T7iQ/Wr3HBM/M1XY3Ix0KVDN+ZNvXkt+/bEKtP+2TM4AO+OYsuuoRuARZe7oXczJVXF7
	5pHdrRay2EkQFLbS/atK5581KdCDh89GKoLInQ7taK04SFcFfKCxncsQK1+uXCKDQEzJoOdUit5
	f6bGaQNYTB5x
X-Google-Smtp-Source: AGHT+IFBeslJpzEmBM+/9hxQol1JOa95LtjP38SqN4G7Wrd1CKB6VYQ7ETypY9fvjl9B7xf34r0u6g==
X-Received: by 2002:a05:6602:3685:b0:843:e9c1:930b with SMTP id ca18e2360f4ac-85427e11a29mr2018349639f.14.1738527749893;
        Sun, 02 Feb 2025 12:22:29 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a16078a3sm202022439f.19.2025.02.02.12.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 12:22:29 -0800 (PST)
Message-ID: <4c191b67-21b3-48d0-b71f-cd738259df27@kernel.dk>
Date: Sun, 2 Feb 2025 13:22:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] general protection fault in bioset_exit (2)
To: syzbot <syzbot+76f13f2acac84df26aae@syzkaller.appspotmail.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <679fb3a5.050a0220.163cdc.0030.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <679fb3a5.050a0220.163cdc.0030.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz set subsystems: bcachefs
-- 
Jens Axboe


Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B8C21D3E2
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471073; cv=none; b=Hq1WD10xz5vgBs95WmrQ8fKB0kWP8BJX+B9Uj63j1M5EOMDNLWY81PESV7InHHObcvLwYe42ph5BHjkYrcVifrJhgfgkY68mHFi1axhyp2x36f6BBWrM96MfzrUwYSfaIv34c4AOuQsgid7t/1Nvprr6fcNsLExlI2Mvx8LVIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471073; c=relaxed/simple;
	bh=OI7l6kw84kPftYzUgMSHz8K2S2EqPW/MbkSGBhz2nxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rQOmbACmKIj8jl4nGk/RLnZbnj3TmbN/YMBh3IdupwN5+a6d1cK7bsmoGw0quPkanSdlCtsycFG+Yd9p1Rnexi/hChg0QBRcAUh/NsrU1xN/dVuKnMkqZ9aqpjCmbIC9xTABCg66AeoUqDel1PKYZnnEwJ6lJ3vnDJ0CRMYNdWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2lqnEPxu; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2lqnEPxu"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85afd2b9106so72338339f.0
        for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 04:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742471069; x=1743075869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQ3+Lj/XxgGdBJVKV09uokdBMEpKEm5w9n/+CnZEN8g=;
        b=2lqnEPxuKwtDC60Q53ZL33TUgt7nX3MRdEP7iMrrxQPBet3iVbBkFtrYQCXum8TOav
         tzb4ojUBZFmPT635DeD/0g1fp0Sq5NZ2WWw6yei7boVCNIacswq4ih5XszUSx0nZ8p7W
         i4qE42n5zORJBiyUOsDTqI5onP/dxLivi2fRKMHztLSkopM6u/yBuIQPp4amoKd5DpVZ
         I0i1S4mzPB1ijsQLOZViLMeLSLocYntc3Zm68qvwEYcs7jNPFIxmbQ1n0L6FQBuAuPHf
         G25kbnGdfoURtiOXj0XuYbG1gar6AZH0hMgFaZW0cQQ99DU3wM/djlb6BFkFy9hK2UOf
         cYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742471069; x=1743075869;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQ3+Lj/XxgGdBJVKV09uokdBMEpKEm5w9n/+CnZEN8g=;
        b=JFS5UuJBxFBJ/UvqBQfVcV07XtCCET4XYKoUlLwOstdnaQ37v1KzVlin+zKXmKCRB0
         S059Iw4v2RBAkdC4HoJsnYLll44dKX+tUJRBwg8/a7ruyQp481YwViqOkbZikxK7nvXX
         npa1UOHTnGzuLgCPP04lyQd0u+5vOnN+n+7tqazuMZ8RU8VpGle0xk33VUcZGPwmnkfX
         QYbKsEqW5k1wcQqvlV8Uj/AnpjBFZWeE2+xBQ1a1YvHQvuT66aMucEqOnLYpQGMIPDLQ
         hc3QmToyZ1aNTbWcvcrcWzmQHUmBt77xPBLFQ/SQG3EbpqPwhZGUbZHvGkpLDXEWKL3b
         nIUw==
X-Gm-Message-State: AOJu0Yxio6CKuVHvW4HjlzKVimsPuKalbeVAX0lChbF+iMWYkgGvvLTG
	s/kTwRPuZCyv0OXp7yLCNyp125XA0vHFOpnSMsJr9U/x/DXcS6tc00C6dS2kT1E=
X-Gm-Gg: ASbGncuogLun5C6cpp4acbDqM8o/VsYMAny7zyDIxiac7JSTSpz37e+CJFowu4yUnB8
	FB8WjF0xwQXUqrqalPvUlFWBiTGGY8gY14pMNJUmr4ZPjf9l0LzZaL5TG+ZbYdcNiqbLCVsFQYx
	XWvYNAN0YMXoxjzcjfjKDNBkfl4S1yskTCsll6m8D8z3tqtEGqjDq7FJS7xL6PDmtYIVEUyc2w6
	6GJoGHro/5/FihjCms6eYki6maoWeJsqnY//S611//0sbiDq/GoCLU/Er6dFcpaV5p6Kf08AEcd
	k/QFEBquhcgTUwNNylL53SuvAolA6EQo64zy+qAC1V5s3HA=
X-Google-Smtp-Source: AGHT+IF+7eZfn3mJkwOUinuP+SJparM3KHzrD8wivDc43HcW8DEx70sNsJeFLDntVtM6tIN4IcM3xA==
X-Received: by 2002:a05:6e02:1c0f:b0:3d0:237e:c29c with SMTP id e9e14a558f8ab-3d586b45206mr79245305ab.12.1742471069672;
        Thu, 20 Mar 2025 04:44:29 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263701ce0sm3639637173.25.2025.03.20.04.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:44:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Milan Broz <gmazyland@gmail.com>
Cc: hch@infradead.org, martin.petersen@oracle.com
In-Reply-To: <20250318154447.370786-1-gmazyland@gmail.com>
References: <yq1pliuoqek.fsf@ca-mkp.ca.oracle.com>
 <20250318154447.370786-1-gmazyland@gmail.com>
Subject: Re: [PATCH] docs: sysfs-block: Clarify integrity sysfs attributes
Message-Id: <174247106879.147043.16167825040453762925.b4-ty@kernel.dk>
Date: Thu, 20 Mar 2025 05:44:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 18 Mar 2025 16:44:47 +0100, Milan Broz wrote:
> The /sys/block/<disk>/integrity fields are historically set
> if T10 protection Information is enabled.
> 
> It is not set if some upper layer uses integrity metadata.
> Document it.
> 
> 
> [...]

Applied, thanks!

[1/1] docs: sysfs-block: Clarify integrity sysfs attributes
      commit: fc22b34e95ce0a294c797c397a9db671e6ff4448

Best regards,
-- 
Jens Axboe




Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB352116E0
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 02:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765247695; cv=none; b=fgK/aLU6yuKlfC2N6LhIgcn57akHthwjJg0VFMwZcntPrXINMoK7jTZO+QjNEHBT2ZQt3UjRwbP9KdekNleNxnn0THL4czBhRwgl7sJA+I18e1//8hk1dh50ZJCvY244nZpNEEdtGvGaya6Hn8vDu6kJmFDFz+Z97Fci12FXZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765247695; c=relaxed/simple;
	bh=D1qe9QxZc1y7IfeQIhOayFG6wfoZbwxoFo1dimDjOC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ETy95jjE/NEKm0sVB24Bxct3W/hTwLx5C9pAHS3m+E2F4sXsdDEi9ihvrsGESAWfRB6Lhe70SGhu4gThFwS3qniGRz5RTNxEGwiLWyclyXTaTApbE6CrzFhqgR4YQAFgJahNNrFQFzrwrXQA2KpQknc+GPevhJhi+mUUmTH8AKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Yr+hf+qG; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Yr+hf+qG"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee0084fd98so45022581cf.3
        for <linux-block@vger.kernel.org>; Mon, 08 Dec 2025 18:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765247691; x=1765852491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p6ig5W13xMPnGDgNI694CGGmeysBXYprvNLllElgnD0=;
        b=Yr+hf+qGk9N2fZt9VPuPs920jPJueFB4UYb1zjC90DRl3x8DDocA86WuMaIPs22yY2
         418tN4LivJNkJ+PTYbtyM6wsU993Ut/pM8d87cmXsUSqk/1LNzU0PCQ7aSGlPaMyf6ou
         R0u3H8R9YClRt0q/hTjeCLqtcjvKiJpveWv/F8WKAA5s/syA26sQYn4UeE/rL/jjuirk
         6r/r84qjpPdwXqLO5D27oXH/Dn0hSWdjuGkA0G1fSpqVqu0yN4ueBWK5AS5KacuH0fIW
         NqCuqKIJ763Lv07Sv+n65K8NflAgXoynPRMV10napYYBeXzuQbD4FOVfv+VoLO4zOisX
         7hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765247691; x=1765852491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6ig5W13xMPnGDgNI694CGGmeysBXYprvNLllElgnD0=;
        b=tA2OovaOiwSJ40Zb0YSo1vcMjZoGIOExsGBmZucyQJ96kpCZt62FyK1zbaTmnaUY6F
         zY9br3Jug/H2lxP8NcE8vvTCS23f6Xq/V7v7F+VcMWx6DBWUypFuLUcS5BC7Hfv02SdX
         /G3JOAyicFcurO5d/LPpwKBS4qZxQ1LRZ+anORY5GmkNEL8MBF6sU5yEKpQgqMwkiITT
         URMXpONbqdUpNXskjy1pPVnV5y1ayzZqCLrn4mtQjERuHNchYn1fs4ZSlUEjaN8iasg+
         U72nLjyHFjwfSKiREoAoSNV0IIEYcHkoGmaiquLLHnGi8JV7usq4U5l6FPmj7DgEwX9Q
         RiIw==
X-Forwarded-Encrypted: i=1; AJvYcCX+voTW94rec3KzPWvH3Cx608O8j1Mnms7cWYJ5wJag54DTdvcUqIdpj/p++FH5r5wZirbG1axVRW2Dyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLaMeKultgt+LxU8S91BmHtGG+DcPiTuSRUyg3LgNQAl4zb6UD
	kV0MNH1Ca7yba98e1CDUZq/VjmUV2lVRRD5jq3kMgmBNSkLmJRne4CBhiTGsbFqPLR8=
X-Gm-Gg: ASbGncuvz0xGPryVrZEvou7sjdsmsa4LtfpFEKeJo8wOjMnEoROwFVRmC0xRwEeORyl
	KcR8pWbs/lKPBp12NDrV6EHt/0oGRk9exZXGJ48SmBEHRPW0KrAuhi9W+Cqi4Duq1gwxQzktKS9
	kqiK5KxTMmK0Domxg0vgN1THxLdULUuuc4gNjYjEgM8wtEZRw0nX/Y7ozUfkSvZoGeQ6cpCPp8E
	XoFnWqrHfzOPz68R/7vK6NVSJTDVUFmD3wRZj2Ifv9UZtONFgCHI2e0vlnQR+xd3zpp3a+5L4vj
	wO4J00YN2SJE6Rle8TjU3hMxJiPiMkezpZL0DgnWoDcIjH6eyKkGpY6kKf09W39almA0I6tFYv4
	FuDA8Lemddcm5P+tlD+sXV/WXo++kvr4AGOIJUmFJ6y1oNsPT1wdkYEKKEvJubu2JYQigRH6RG2
	XfVwioiy8j5S+e14Tt/tG/pqmheuZ3b+FFaJ9jFbqKI/qtSjRb+g==
X-Google-Smtp-Source: AGHT+IHQSYe7kopP1IoRJir+DdHVJz16nisZ1u91ed+xdLHkJADfLhiky43ODU3BAQgCBEBqo/IOBw==
X-Received: by 2002:a05:622a:424c:b0:4ee:208a:fbec with SMTP id d75a77b69052e-4f03ff209femr160608081cf.66.1765247691409;
        Mon, 08 Dec 2025 18:34:51 -0800 (PST)
Received: from [172.19.130.138] ([216.250.198.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b627a87e55sm1195823985a.38.2025.12.08.18.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 18:34:50 -0800 (PST)
Message-ID: <2b3ab249-3be7-4eab-9416-a120d7ee1760@kernel.dk>
Date: Mon, 8 Dec 2025 19:34:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] general protection fault in blk_update_request
To: syzbot <syzbot+1d38eedcb25a3b5686a7@syzkaller.appspotmail.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67256f23.050a0220.35b515.017e.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <67256f23.050a0220.35b515.017e.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz set subsystems: jfs

-- 
Jens Axboe


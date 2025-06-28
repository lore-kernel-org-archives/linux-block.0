Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85172110
	for <linux-block@vger.kernel.org>; Sat, 28 Jun 2025 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122016; cv=none; b=gQG0Ih+VinsgbEPcib6IkQJR2ZoCk2na/9AzH/UogQ3cc55peWFmhzFXnNc7cy78350Mw2qqJ5PG1/6JgpjOx/3XVdxCSa4OUzkPCPAymIq4px/KOHH9oVLi9K5NfKsW5uUiqhRp4BynKXN+DwRiFztA0qz8x0+8AolnlDh8RSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122016; c=relaxed/simple;
	bh=i1UYqUWS1z5l8oNI6qpQNzVExHkcCqMY5wUZt+lKj8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PTeOLusvkPyJNWlOv+HrQUfQ08LZ44tn8tMrxcDCa9i2tlUKXj6+x8X6gIU//+nPyLox03xfkrO5aNLH8hbfkyMX/64l2CTCTl/ro0X/K4Bk/FS3V0RyAlJwYTHYVbko2+wZ1cFHzt6H18CkipxVv6rqVPDsXkrkJ1Hz6ocPoe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IWll6KOj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IWll6KOj"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73c17c770a7so1207410b3a.2
        for <linux-block@vger.kernel.org>; Sat, 28 Jun 2025 07:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751122012; x=1751726812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8sn7IgmRQhFHxLfJi8TyjOMjvLUVC1oE7kwQq0V43jE=;
        b=IWll6KOjypwTQRQPwW/NxfJtgNEh0Ms92U6m91kfKvXzzKZsholz43qlaaj3F7vzRZ
         NqC1gQHGmvuM6YPmscUwcQOP0x2P/mCym9ApyrgsgrPGbe5koO4UcERIw8vHJisDmhqM
         sSmlgl+CPfKw7+cyRdo1NWBMjgeLlnfW+kz7PjetYZpV3rfar0MF14S/kXAlPlkD9sKl
         +nojjLiJJnr4UVruAqADC2CZbF5Pr97aQ2cHyEpGkzvJFNsnET614G+Anl2oM1Jown76
         Kmo1rY55vzqF4F8GSGmSGGXIHg49rPDLjVoNqhO5+syk3y1lVQXwKm64iI33Q/0bDIhS
         tjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751122012; x=1751726812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sn7IgmRQhFHxLfJi8TyjOMjvLUVC1oE7kwQq0V43jE=;
        b=gI3J9JXejIUGcya8thnquSB5DUP2AKACA3mf2HeE12NCpiY4ZWkHu6Tx5Fjoxv4Mm3
         3oDGX6lIAPdOu4c2h3PnJ8BFsDmdFu1kSm2oBmmaBR6q7x0gsOc6YcswDUWHfBWUhfkb
         LFQYQCo+mDSg8zfC2iw8fIu05h9LbzKIR6Spr4NL6jfzcpYZKfZexBEE4eqe6N6/lj+p
         GGsz0Q+HryL2XjbYaa6CFY9l5zKqpDkSuXbCh/+klCHXBlUN41ueX06ZdMsypNWbrvz4
         Ql0/8r4vEOesynimDPllscHp9K5t38p/SeajPuNJ+OM7LftFFn1LcBIPj+BZfTATABz4
         Y2Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUzY0U4fb1wLpEUiq9IwqVrBftGE7METj9SAYlLKOT+4H0oP0KgccxiH9eNGV8GZ8tZKM6BWJD7KS9qJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfNS+nIAf7Gcp1OUUhhsR5dtmyIqRypE/OvH2bw9M77Hvjcm8t
	b8kZfbikQdhofiXj1Drdz5MI8DkgOWi9/f2hRpiaNq3yj+iQ4vlyFpG9U9D7PwoPL9c=
X-Gm-Gg: ASbGnctQijGw6F17FsKjDqTIB6kr0QLVKCHXxTEB2USuGcos8VhDysfefgBjp3s+FtO
	Ggyk6/bospU+tB+MbVnOOzt37Sqt+H1opAVQqG6a5abTqXGpIJDXPMuTjGH/aF3vDi/3FRqZoiS
	3rm9rNkWB8G+WW1NhvtC8HlIJ6r+Vw0U1nJMUmAEe3aecOJbw/Vu+1hNRGmRAu82+Bs7glL91ll
	XBWalRvZmo9jkIgInPfWfAJgDN6pZ7RjhdDlyZTQ9Da/XyW9qxnSEbWQ+cgNMKNlFp8tGi/lN8N
	wwIGmNImOHfdBYiszqnivfolBkzoE+0kGUIs1xhK+sfT133gt2zqoODNNA==
X-Google-Smtp-Source: AGHT+IFJV7pYGQw7CBrSvBpWA+A+ePLIgqs+nEiHSfpTqKPfMD3FdnSJUodSG9FnstBtN2S4iDXH4A==
X-Received: by 2002:a05:6a21:38a:b0:21f:419f:9019 with SMTP id adf61e73a8af0-220a158ea9emr10109650637.21.1751122011872;
        Sat, 28 Jun 2025 07:46:51 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31db000sm3804378a12.65.2025.06.28.07.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 07:46:50 -0700 (PDT)
Message-ID: <04e8973d-b591-4cc9-9c2c-52caa8889a2d@kernel.dk>
Date: Sat, 28 Jun 2025 08:46:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] WARNING in bdev_count_inflight_rw
To: syzbot <syzbot+f37a847571460b5ac3e4@syzkaller.appspotmail.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <685f5298.a70a0220.2f4de1.0006.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <685f5298.a70a0220.2f4de1.0006.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix:  block: fix false warning in bdev_count_inflight_rw()

-- 
Jens Axboe

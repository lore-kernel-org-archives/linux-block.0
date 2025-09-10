Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E550A921
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522392; cv=none; b=PyKQDPWdlXKuY6nCWXX/4PNASSl1x7u3NNwmiP3bgi5TtpaUuOnEACGkxRN/WWv/98DTrHNyokLVwKxnXLMDDUSKcdppF6CfG2UA+5MODbCWWj9iZe96lJy/O2yRlWVOANPKVhsMXjLHnM4VpYp2Cjiy+3YqLQV7SJ7TQ5mv7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522392; c=relaxed/simple;
	bh=hbjFWc/M1u0JtUeGDfraCyEfZ1LuYrMt6ic+SN3g7Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apMiKpZ4prchOG3ZcKjdn4pT40ovEaRkBpu6892K4DnHSVZuroyzc75BaauQcfVnafsGemrQ37gdDmPCHdBYfE6odog+IeE+Mv/S9QD1qhHWiqZZPi8lYphOEC6LMliM1DfFoy4rgA3Gg0dDxFkzeYV+W9dxzy+TFZCdR5GPbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RHS/O7Wp; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RHS/O7Wp"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-417661ecbb1so10623135ab.2
        for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757522387; x=1758127187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=RHS/O7WpW2bKu3dkD3GuvUB5YTGA6gb7LyRfu04M+JBfGeQSuhkT/9v/nk/R+dCoyX
         mZsi1sKflT/XdZwHcNBieE1AylK3Qix8qUwrzhYZBj750TLxjVeOdcOWZXYvcj2GenBj
         MSoClkJ/PsF+80kRfPRItEj7Tm8QePGqSzJ+QsmXJFA9doy+ahyquicL0MG8caYp2OlB
         12byJ3aQN9mNWsdieeNi/AazOX86gv6oqRz8IP9rkgCUTTxmZp3BM2oUxPZN3vW0lahe
         xvDFzSbVRTFzXeitmxBk2z2OUGa+MHihFvw3YurqqUNqs94s3BNYsz99KAOAQOFDWNFA
         OV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757522387; x=1758127187;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=V85MGgUTW5GkDEl/qywD7pAIi2fvHZyt7U+vDxl2sj5KH4fGUw+qxnjSr/R3tBgqxV
         BOcykoWI+kf0Iihx8AZazlfyv2pVmgpSs5HqRtJ850uNFZKAh4wKdEj+uz8xbcB9yrUb
         2il4k/rfaQHoR4Lnvdm5ahDsc7msQo9v1LarAbY6dsa/U33gsRBl3NcdlUMGQ4vs6iRs
         Sie6vr3DYVPrWNlM4FiO3RB5Mb1Yy05UYPvBRbOKVgYFviFCA10st4C0QJnOb8pa/X0U
         3vRbX6DR+LczWszCP1o3nKbvzh0Tg4+DZZvz8/0Vf1N/iW42kRlCsbKtcMTAnzPNE0e5
         4sZA==
X-Forwarded-Encrypted: i=1; AJvYcCW5wl5QIKcfsXZ1f/d7hC25YY0wjlpDQSa3Ft+9I7xUPLxB8wrDq40mElYQKrm8qleKv1TgbdnKkjnBIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/YotICNS/IkHPzL4shikh8Ces5ClaR2aQyPMDcX+aJ62/hKZr
	IHpk7uIxR/AZ73ajbS/r2THT5ydX3pa3wGoiV1Onj0/c+6vWLWfCSNeToj32eVilVos=
X-Gm-Gg: ASbGncvTXhqoa4c7pSIF/kR7xT99pX3gTMEO3oOaNCAu5pSN0jo7UKn5ziF3hrCAYie
	DAMN9pAi52QX0LKvXiiXH0/cVkVgVBmqWn9UbHszNEA7AvdU37ZZ6yPwLW/4qOXJkKatPWRnN3Z
	DFVirUTh8msKkfna0n5vBAjfuevfPJot38mQObQfzW+2pmXCt3Y20u1e9URJt3t/pmVUnZSMmIO
	8A3xEayrjdDHRlfbKSoCdPVfSODsyBBIiu/IFU+LX8f81S8I2S6UrGcQlS7t9BDvsGoFBotyX5R
	0m4ugLKffwVAF/IbJqKSR8Hw1Pl0X6i6MpRyJ4+esnd/3FOEs408goHEKUmsgdpHLaiSJJuEQV2
	emsdcZl7bWgwc6dCIsgY=
X-Google-Smtp-Source: AGHT+IEb5WYlYRXj9KAGrUB6b6ycfigzKegEaHb0jkZarvr/Z/Q5oCi/e4o3PHKyP6WP+mXNVGSbxw==
X-Received: by 2002:a05:6e02:1a69:b0:3fd:1d2e:2e5f with SMTP id e9e14a558f8ab-3fd86264465mr231635655ab.21.1757522387509;
        Wed, 10 Sep 2025 09:39:47 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-417c8f03f9csm8607825ab.43.2025.09.10.09.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 09:39:47 -0700 (PDT)
Message-ID: <a2d770aa-737b-43f5-8d1e-0c139c09dc0c@kernel.dk>
Date: Wed, 10 Sep 2025 10:39:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/32] block: use extensible_ioctl_valid()
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
 Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>,
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, netdev@vger.kernel.org
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-3-4dd56e7359d8@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250910-work-namespace-v1-3-4dd56e7359d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

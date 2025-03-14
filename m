Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106CA202C4A
	for <linux-block@vger.kernel.org>; Fri, 14 Mar 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968740; cv=none; b=kg9Oq6Ewgkw+07kbKN8BSx7fNKEzuJSQSIqsyXoapjgA25mPPMhbkIQGEh5UQwW7aZFU1CY+N17SbfT3muSI8ioKwJ9TcetbcHOB9+L7gX6aQXC+GZkBHbCvoWpKkyVgJ4elzqEYo3J0LdnQiYSPwzkEC3EhyVqJrzVvAiQXHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968740; c=relaxed/simple;
	bh=GNGZmwPcddODPXkCRrFCIKz5PWUUxPy0cQCbahA2sYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=todY4ah7XGtTEI/K3R/XLKzLupwRCbFgOnI4aLFAUg9Icv2yWqTwGwDO1Zw3cPHZzNY46YRWP+71Nwm6odkxc163R47g/zAItcnDaywF21RA4igbZmknFFYrzvKV6yskAvTdzGAFLZDicF+oZGr7LXPUiTIq4ouDYTrevXWPhLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w3XewBDe; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w3XewBDe"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85ad83ba141so219018339f.2
        for <linux-block@vger.kernel.org>; Fri, 14 Mar 2025 09:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741968737; x=1742573537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xMzfs0jYY4csV89MSJ/OMaI03krp0RNdkDetjqic1GU=;
        b=w3XewBDeB68wgyWgCFJb1GtUxcXtSKvq8j23gYLzuMIPkhOmCqPnwp6C05k/iO2ZV2
         8FIPThD3Tl2S3Slo22fxw+V2H//xbisnZYVRtYRvEvbu5mXvYpkSSHgV2UT84oG3Dvba
         qKzRUJFwxDY7uSHdP7uSQaNzscaA8h5bMlFR/5BX5XaSIWLXJoV2GpvMMoHezkmOOveR
         gPjS11r6YlPG9Af5YcJwesMOLkQC8PbqBnP9fahTBF969Zj61//F3IQFZsIeGaITV9GT
         6WzMA4rVryLvMOhZSBddhKoMnrN8TKYpfIcZS+xbOoDrQ1TRFVCFequSPzlfs6Y/WffA
         hogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741968737; x=1742573537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMzfs0jYY4csV89MSJ/OMaI03krp0RNdkDetjqic1GU=;
        b=IC4G6OCir0aaaiZczXpfExtf9SDTTYjwAudoAasdjvs0l5ouplUEnCVqb9lMIMCi65
         T7M2ChnL8gkRR9h1lQQ6yoARqHzDokBeE/BKE1TROJQinKtSFzcsfn+eTSeiQSxZ7UHK
         mBbNiJ2xVAC47Jy4Rz4GymIzzqncpWpZHuOrY7IKCggdgYWjK94b5dKMRLCcXWA1yE71
         Jw7Fx1oOAkuu8bT0SDP0sVN14Tk4zLw9a1+15TyUXUjtaEEje+pXRDdTQE7SPfTHWXrW
         OjAPY7k8lWh6EdhJVmQfmCOrgbTq0IIdzpUMO45vSM6DP4S+BOMMS2exGIUVabp/fzZ6
         s00A==
X-Forwarded-Encrypted: i=1; AJvYcCVPk6hmG82+ldEBze0cYyY5hsNJbjaFMHqfoyiNohKphVbAKm/SAuCu+GeBuzwMOUvgWJ3gFqUTSO0gbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1nWQ1cimx3dWZZwAiI6+xsOqwgxPiQ21sa9cXYeGk0wrmM8A7
	7h9RPD1J2Dn7vxYB6hWNftnZ3QF+i0FT4Y3NbDwUaWOuqg7o4KRFxIOr6CoRkAY=
X-Gm-Gg: ASbGncs8dbQGfL8pbXCCHLcrm2tieCuous1pCICz/CilbycuMK8l6w6lEJRlFFyMZ2S
	pvSqMrP+tiwTOK7NYxzrf0eddJFWKQUIqoAD8QlVWmn0AU/5q1A27rT3IxqXSX7WvErc/FituT+
	PoVBQ5ubdJGUwxXDJia4r28VFsq7cw5BMR+lKfaCvXu4LcV9eXcvRH5iLL9qMPqlxWquH8LAO5Q
	jMQ2FMgN8pZ/PSiv215gl/tB1WpddsNJqep1yelO+80rpeA+O2cKDMQrucenX35x/JFUa27/3ZB
	B3S52D2qA6Yiu/5n1M8Cwd5GqEpdHYPd1HQFp6NdAQ==
X-Google-Smtp-Source: AGHT+IEFSlMNNqYd6DH3/lMsOtUEO9WQr4nhtNK3zx0waU/c/6VX6Gx9mcQQA04Ym+gA7eGRqL+pHA==
X-Received: by 2002:a05:6602:3788:b0:85b:3b30:9aa6 with SMTP id ca18e2360f4ac-85dc4788b31mr284923939f.2.1741968737009;
        Fri, 14 Mar 2025 09:12:17 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f26362f34fsm921344173.0.2025.03.14.09.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 09:12:16 -0700 (PDT)
Message-ID: <7280eaea-db6a-4431-92d8-0aa5fe66768c@kernel.dk>
Date: Fri, 14 Mar 2025 10:12:15 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] WARNING in bioset_exit
To: syzbot <syzbot+4b6dfa650582fe3f8827@syzkaller.appspotmail.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67d45312.050a0220.14e108.0046.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <67d45312.050a0220.14e108.0046.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz set subsystems: bcachefs

-- 
Jens Axboe


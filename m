Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A136B364EB2
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480330; cv=none; b=ZhNY0bM69NK3ZON5rgj+7MDpo2KoZ0hZ/ffbkE7uYDLUCJjIIgPCZh8j4dQ0HXUHsxCaPGGNkZ0TUUXLGTlVIvFjnzsJQg1H4Br1352drK+AnuqMxyXgxBReUN+IxwWA2iBq6ounEeUW0CdD43ljXXS8MmzGI3M77Uh/BLE9/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480330; c=relaxed/simple;
	bh=LKlyepiZ1xBo3OLl3+L71PymWBmoJ6ZZ+iCHvSi+9Kk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OCu2s8aNzOSc+imbYqhyAFD6VI/iSf/kmZKb3bMuv2cVmY+K7Ip073v3aJMd+/r7rV6ba7OgCfbHNAfhMqaOn5EcDpOTRY5OvrG21pyr6YMncHkJL9y+ZoLSul0g5ol4CvAlfia7Jlf7jZodve08H19sJ4LtJ14cye8y1xLQoyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EzvTd30F; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EzvTd30F"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-4331709968fso21352075ab.2
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763480327; x=1764085127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk+dWrEHZ8xiUyOigj+khv6Ve9ARkbQqjXrYOG8LpNQ=;
        b=EzvTd30FJmnO2qAiz2t98BYGJKTYE2PXYc6Ie4kBkHSfhysTunIBI1dmllZKN9VVNc
         Ij9sbv3w83BxucJe8R7cLT2wZwx10GzF12yO26dYV6jv/zGWE2C/wQdLs1UgIy284IAA
         Xg6CLH+L4TGiitZAOIA8cBKUAw1OTDLxEp/rCOdV+Z1NeoI8tFhue082kRYTDbPWYWi7
         ONwqpilFORVUeRnttjsNuW2i7KApypuIvjsGCjsBR62GuaQ4+RBjfyOawPUt6E7pFlgL
         ElnKYCjwwqV7zjYWcFTfvfWE8alUa9JB8DRDykiRAcWLPlN+v3Xi+Yeege3gDVTpMm31
         UpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480327; x=1764085127;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kk+dWrEHZ8xiUyOigj+khv6Ve9ARkbQqjXrYOG8LpNQ=;
        b=JCk8GicGaxgo3jVbf/VRUaf+eP1l2N9bt8y1eqZgn35EuA043Pg7j4VDoCUaWcNf86
         1MYNIIAwhXC3lEeYB6DJrgT27Rsf0kcOQLb9koQT3DPXxpo42ydv8uzM6s0gJtWj4GkE
         miA1XVdz/bGBOnIueumoRyV53QwZ579pJM0s5Ru90kmUwVchswfItl4Rf2BkXTNIfGkd
         HxmVbIZ+WU9hhQ5ypxFTTOrVnq1dzaT1Da5InEa+JEDa+EZTIn9m++lZQaOT5C4Gn+Ap
         8dS1pFE+8iTNq6jneZSyIbDKE/9IHRN0UqXWfq2mDpAK3566U1L0vmLCUQfH09GL1q7Q
         Z6wA==
X-Gm-Message-State: AOJu0Yx8fo03gYlYwfEsyDACR9+AUbdAkt6KKrMmHvAl7IeDN2nPs2F8
	c/Dem/5q1B/awfJHqZechuHVFCBBu7Iz7aKFYlzDNCnXMJ+eXCSS6F+1VjHPXfOYGM8=
X-Gm-Gg: ASbGncs3WHanQbi9yu1b9IKuKbpOiaR1ON2aoYjphZVSQZv0wqt7kKgzXOOuLZmP7/m
	jGP+OM0wO8BbZjTJg9V2a/EWfKiTd3NCdlI03eb1YN/5CCbEnygAZ+CgY9CqBAVl2Y0Ekcpq1D9
	5bjQjY/zTYk7266vcLcxkR+8mYUw3NZpCglvqAGK0kGSy5NbaHyis+ZEZQvgkTOjJCO/cCJmBb4
	IBM6QY7cfi+IoTjuC3Xhcxjq9mkRLHmBn0oPQQISIF2OjzjiDaxKdI9PvnTXylngzDhkqCqNClG
	vPkD+GAA8a72DCUWVEDLtdurnAJhLRVV47gl2ThcZIsOLh709rbtdcz95hqT/rNIcs7o5fch/Rp
	B3A9NibVT6QrsImkDg/mUxFEsq33NRZ7QHLuzFjkmCchRzvj44eKH8NzTI02w81AcWIED55WTpf
	/FtcI=
X-Google-Smtp-Source: AGHT+IFCkQiOxk8u/uM09vf6LTdGDN7u8bS3/P34vpZNQ96/fqHjxpGUpfJQhv9RyPEhZ2SK6eYu7Q==
X-Received: by 2002:a05:6e02:1d83:b0:433:7b82:3077 with SMTP id e9e14a558f8ab-4348c8fc66fmr192959525ab.16.1763480326752;
        Tue, 18 Nov 2025 07:38:46 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434833e94f1sm83498515ab.10.2025.11.18.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:38:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251114210409.3123309-1-bvanassche@acm.org>
References: <20251114210409.3123309-1-bvanassche@acm.org>
Subject: Re: [PATCH v6 0/2] Fix a recently introduced deadlock
Message-Id: <176348032581.300553.12545744076716200996.b4-ty@kernel.dk>
Date: Tue, 18 Nov 2025 08:38:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 14 Nov 2025 13:04:05 -0800, Bart Van Assche wrote:
> This patch series fixes a recently introduced deadlock triggered by modifying
> request queue sysfs attributes if the dm-multipath queue_if_no_path attribute
> is set. Please consider this patch series for the next merge window.
> 
> Thanks,
> 
> Bart.
> 
> [...]

Applied, thanks!

[1/2] fs: Add the __data_racy annotation to backing_dev_info.ra_pages
      commit: 335a0927a9ccc2694b8d6f61b656597af2784df5
[2/2] block: Remove queue freezing from several sysfs store callbacks
      commit: 77148836a0876c9573555c966104808de33e1332

Best regards,
-- 
Jens Axboe




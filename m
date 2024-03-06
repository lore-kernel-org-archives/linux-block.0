Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18416135A41
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739324; cv=none; b=Q5yBdRSi5DljLBwCxXKRolC7zNIVvs0Z/BCc4XjS1zddnHtJDWNhJP5tR6JMwvLL0DdPjukh5q6AhHY/KgQglT9Kt0DyHCr6HiwzJfBajrj+hanRFwz9m/1/IRb5B+3SnLVxFVcaRBpLIijp9ka/c4vpPXeVFLFosVnNoRmaukQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739324; c=relaxed/simple;
	bh=rZpxuwz3LtTU5NHXBZeKwLPaPRSDpUa9gidInfsm+Dg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WasFXmAUX0Q99dJ/I1G/5BLROwvSiOviUAu26xt17yqDdLRzFACXgFZbRPZRF+jCUnRKu+1ruD0G9NmTKoVogTECnoX+xlInU6KvxCCY/ZY3c9xU/VNOe5Asuv0xIOM/qt0Swp8LCmSgZ/SU9kj0ckREtr/gdjEGeypF7qVYtcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H5SUS/g+; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H5SUS/g+"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3652ab8766cso2353105ab.0
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 07:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709739322; x=1710344122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPnOpQ+uVuzgVW6jQ9U/EyPoqkoAsFyQMeCbhRPBdV0=;
        b=H5SUS/g+FiFJM5MtNcX+d8FPTHSB1Fp/3jc89NuGJ7aTdzCbTkdFyXlrRWXi3aFJqF
         pOl0wXQeToNrA8UjTLjEN6ZLkjc1yiuAxpOavbUpycphsZmMOi8oehYo1embiwnEFkjS
         8Sacs3942EMWPtcNMtmVHNecu4qsfDdftD+zudtglM1fNQnh+I1/6p3vvq1Rlba72fvC
         ukxpXHLGEBrW54Nor/kYl4IiMRGsiYY8zzyUoIGglJUadBAtvv2+Gc1w216LzWqt17tV
         W8eEbeDc3+N/d2y3LilWHsl3NJf5KSgJR5n866joUVahq0IfisUgmwrkH5PKc5y3t7oT
         7XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739322; x=1710344122;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPnOpQ+uVuzgVW6jQ9U/EyPoqkoAsFyQMeCbhRPBdV0=;
        b=JIInvvKAqSLPm5Wjt54ZHs8402HbY/JQb33oWTujvlW3MDTG4WmFTp3zr5/DQuyElz
         XRfDHIVwkwC66IDedy0TBvLF9C8mawyWrmJWkORl43uBdAhrVzuhIEsfKmNwCECMfTf+
         V+MhM52LqcIN4DFHJ0rbF6w39XE8Rf+XxHTg7HXD3iP7Rfib3fKzyFE8D7GvAZwz3cpz
         50D56eJ2CRCdffDc7aeuv/atw3k1RoFlOl08jGsZwVelgdqvtkmBpX0w8RA2QhvMWVCh
         81bKEpTd5XgKw0KiWEm+NnJqzeN/fnm05v6HKkU7gnAUvhF4guJQ9CAS9h9okxJIFdKL
         +GJA==
X-Gm-Message-State: AOJu0YywlFqd2QkTcAiFf3sOyhuFA3e1sPHAEp34WP1ckqFuIdYuZEaA
	TO+Bphzx/5ue3eevJ85LiPvvAu731E7VSDP4YzIYBwzZTwcphVadeJOsE6p1v9M=
X-Google-Smtp-Source: AGHT+IHyoCbyv7XAo5hqqIlsB6w5AWsYnu1/UcFdT85mx4kpoOSiwoFaZeyodXeNK3tjPnmdQP+04A==
X-Received: by 2002:a05:6e02:219e:b0:365:5dbd:ba43 with SMTP id j30-20020a056e02219e00b003655dbdba43mr3895559ila.1.1709739322355;
        Wed, 06 Mar 2024 07:35:22 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b003660612cf73sm324467ilq.49.2024.03.06.07.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:35:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240305-class_cleanup-block-v1-1-130bb27b9c72@marliere.net>
References: <20240305-class_cleanup-block-v1-1-130bb27b9c72@marliere.net>
Subject: Re: [PATCH] block: make block_class constant
Message-Id: <170973932052.23995.16086522563288140276.b4-ty@kernel.dk>
Date: Wed, 06 Mar 2024 08:35:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 05 Mar 2024 16:32:16 -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the block_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> 
> [...]

Applied, thanks!

[1/1] block: make block_class constant
      commit: f8c7511db009d42e2c24e48eeb04e3f1b67ab209

Best regards,
-- 
Jens Axboe




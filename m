Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21415684
	for <linux-block@vger.kernel.org>; Sat, 22 Feb 2025 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183186; cv=none; b=f7APb9/oBaYdmR4eSu+gYjOlDSK5XsrRxqagWmompqePpexWGGIxD5w8mAh0j2vjjRixScUtSqzlmU+ZoRnklrUB1WbIncxDVrgINjSQbOUuSp4J0kusjshBI79uUZaKw9nRn5l8Vm2IndBfLR/+IPZdIWTYwnrNgFjgNXyQMkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183186; c=relaxed/simple;
	bh=51yncecrfj0RsMPvBHqMPp58DR3VmCsbq0CeL73I5lE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R5sq3KAapmfVrA5qyphbgikMnqWpFFhXIoaWUtkKmaIMo3MRHSDecm7/3wtmaC7K6GaNdG5D3o7eNXrOK2W4rBai9RqPESlimgwR7jn0vVRSYZgSWiDTp4qgrit/TyQDE56b2Cmc8VmOWbAtfqV7TJIDyJLneyWD527Crw3up+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OHXfJPE0; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OHXfJPE0"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d2b3811513so10321765ab.1
        for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 16:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740183182; x=1740787982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsufKr0NGP3tYvsFVv0EO/2yZiZEnUNT84I1RxYAoyM=;
        b=OHXfJPE0LlToVRPlme+GzfHuTUe8byvdNZxm9x0O7BvfagIwPNGSx/4l1psKSGvoNv
         pXaJyb49NII7hiQxCIKJTx1YvVmrne2KlbQX/RqK5izMbKwrKI2/9GBUQEC+TwyoAmrR
         N2wtrR+m6onpIGxT2QtaEDpukz4cU17UU+U1X9Ivi52JeUtHTZB5Lc4J9X9frdOJMXyX
         SKsMajYx8j9wzplr07W6NmU4sRkPyw6UZEmzIyefPpHRIrZDAuZu1LT+rbn4/6RV+1mP
         ylpXf38934eS1J1RBAz+dQMKMojXl3/ST1wkHwcczOgTLHx5ISJdAIdEmNjRSTYEfTED
         U9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740183182; x=1740787982;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsufKr0NGP3tYvsFVv0EO/2yZiZEnUNT84I1RxYAoyM=;
        b=Ojp5DXKxj5bPgGlKnsoGQHxxSzO414w34/PINwnj4p8VCOfAbKIy96eUWK4Vw7gNwk
         KD2icTQS7HiE8UnqSURylp6vgeCOQeZ7NCz7eQEGQIkUlyMjSlBYE25WSwyvzke7ekd+
         7lD62tgIexN3axFzTcgD1kVJt26VTN5vQj/ESUhrhhJWfgKD9WooPDG8o9LO/psLKYuC
         nkNRpjYjJxRZKEfLlJFUeDEDTHF85Fmck76MBnz8nO9MCAECc65hQTFT6IBqmesJmBPe
         C+Z0wQ4F3k5dCtPKNQQehi5L7Wjcef75iBmA9Q9fYHsd7491/My7wF0/zc3ydYQ5fPcj
         VB3A==
X-Gm-Message-State: AOJu0Yyy6ZXr9BsW8i1ajd5CYRDkcUKwRdJGD6htxmWxo70EtfXTD009
	FXFEaI2NXB/4G9n718RCIZRdI7pS3UmDxysfCTkF9IqvaaTDfmc9q591MLEHzt3WG5HRbeDG294
	7
X-Gm-Gg: ASbGnctDn1L0LC7tsEyEzcgWGSJS1hp4RB2nl/4Kx1VrE7FaHAqjWLsm69YuXucdDOP
	o0bBviSwtaH/i03A0cf82mjXvp7zatvOnKVmORB7p+aiMIlE32GNd6pXFSSEgWNZkfGQyh/rtKf
	tTjgCGntj/OMoEyorbKENGb4HnxzE2c0nVpmKxB3nhFLNvdB3Vl1ki8AgUv9enDvuIJrzuHzvIs
	NG8ok1VcdDwaogFpOjxb8SRzRoJKHIE9LqzEYyq9Xk7zVxMYPX04c6CSvFYqVSinmiMbU+6amaD
	LwvLj11XBS0e5tXrng==
X-Google-Smtp-Source: AGHT+IEUUpAfwedrwX8Z7yqaUa0AGKI0ihxBNgw80Nems7KCQtXMFtFcx2HmpwlG19S5/FlE2ikssQ==
X-Received: by 2002:a05:6e02:3dc4:b0:3cf:b2ca:39b7 with SMTP id e9e14a558f8ab-3d2cacb0022mr52274585ab.3.1740183182418;
        Fri, 21 Feb 2025 16:13:02 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d2bc19dbe3sm13388665ab.9.2025.02.21.16.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 16:13:01 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250219205328.28462-2-thorsten.blum@linux.dev>
References: <20250219205328.28462-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] block: Remove commented out code
Message-Id: <174018318140.1822587.9741571517838734087.b4-ty@kernel.dk>
Date: Fri, 21 Feb 2025 17:13:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Wed, 19 Feb 2025 21:53:25 +0100, Thorsten Blum wrote:
> Remove commented out code.
> 
> 

Applied, thanks!

[1/1] block: Remove commented out code
      commit: 8985c4298733a56d38c11948dc3b1dd24f4fcd6b

Best regards,
-- 
Jens Axboe




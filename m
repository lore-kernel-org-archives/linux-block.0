Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A998021C19F
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997619; cv=none; b=Izg4m8o9+xFq1nR4+8XeGQKHn5j4ldIGXaSaOBXPVzW5bmme5ND18fgeMWFjpqfpRO/qkqSt0MxpEQ1/a0mXmteXYJJscrtxAHZoou4bapiwwIYzI7u+fr6p6SnC1jLn3xnPyBCtqLqCUd53JicBqIwgNN0eo9ObfDjF1qwu4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997619; c=relaxed/simple;
	bh=UtBv0aeoJSL1jBusVGKSnn9luAbvSMV72LX8N498vKs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KxrOZXd08hMhJYjZVnqVri3LW4dXTjQ6eLiUH3Om2WU0irEsNKZ1IOnN3q/lXOTXkdT4WnEGNFICjB+bXOiURP8wY4YQ3cSZjqZaT2iu/TpPKVSjiviOIt4SPtlvQgBBImK4xUJhZ4ndnZUl+EgwFL0WKLWkX2nWBc29GFE/PXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q1WNK59e; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q1WNK59e"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ddb4a7ac19so17818915ab.3
        for <linux-block@vger.kernel.org>; Tue, 08 Jul 2025 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751997616; x=1752602416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTaZVsYCFHrHcx2ton4bjQXkjChOR0CFYCOoEbLvagw=;
        b=Q1WNK59eClXXPZblj2cHuShtpaR6IYwJiuVdzXzD0Ix9kgGYRvOrn64GLtvBFltq7/
         diphc5JPb2UzMpZKixudWZDEFGMJfGA+kZHcS+4IINWlPM/VqdQW2ODOscriZHlti1sV
         SQUQAzp4oTPeqUdYLTXCsUwGNn6mnRwpc08K8fmu0O+Lumsahg8NrvASWDQspn6zQ41S
         kFKZvrpHKh2LTyp930gh/be6GgwUlcDb8Jjdn5xVt5TmPnxcNiLFSUe6nw5uoTaNYNT8
         xkYNwBnnzY5GHgO5rp5/Zg8I8gB6TZjvgStRLJGwEPaxYKVQnT2xrPuQmofLJweMaBJV
         02UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997616; x=1752602416;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTaZVsYCFHrHcx2ton4bjQXkjChOR0CFYCOoEbLvagw=;
        b=K3XPC4+TahiVYk0AhJsj/pGcPAfkTKcpzZLRZ8/yxwztseHeb5pr1GTYKk8C4RjDXR
         PlMJDRRm/hMB2PFPKIVx05EcEwoa24DInHJEAWFUbZaW8z21uOE95AwA3HkleA3vzdAG
         xvQT9g9J7TFYLeqhtKQAN/uUE+hb+vAtW5Eg6csxmfj84i7NNxDBmzUpLjPcOm2IDqbO
         wydS2BayIAmo4db5ZO1tGG4qzIJEvx2SMuwRUR3nqgLs5ufVUfQVkh0LeIUz3DM2z6Pv
         OfDQwHldSV1MwJ7+Tr4n22UU2Vw7S+57KslzhKEAfyR/WYz4Lr60P20ydRc5He9oMy1a
         lwtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYPWkwPnCx7NalU/xcKFiTwrcNl8yPOeqUqHV9fQTc0OldTWVef5ZBYn4BG3k9CPa9daqQncKSVq4XgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YybxSN+Vd5DxyZlptU+NeeVW5kS1+5GeMsUT3bP9UTbZg+VON6S
	1TaIIiKqar4P30T3hadFE3mYGiMckN2nLgY0ihzaBz6Q4P4Ya81WF8v3oJatZQRm32mu1hixDXc
	jzPxZ
X-Gm-Gg: ASbGncukACWJKP+gEdisJeIlIshrBA2aERH0WBjWJy5tfi2q5KD8t9RnKsCFLjRLIae
	FnUinj5kBee0BuAIjRksdbprzOLGgOf94m0imV1OTVk0YcrBvIbxB1m8Xj4KFQhcVtz/XO0J8bc
	ZIjNjCSQYBUHqezabc28GeA78uOTSCS1/RE0wk6Q/72UPJnv5woddPTRizBPzLyqDbvPhFycB/b
	EFzxyIda+sP5zhRmitcRWUE2hnBNgh8x3y7/41+oj5rWSY9wi9TUinVUpXIG2ig6YAaULsiEED5
	s24Ksn9aj175guDvsi4F/MRrWHwmjOyFf5L/PeSPbxs3ddDNFvBt
X-Google-Smtp-Source: AGHT+IGf7DhyE6cPFBeAzzxZ7ZZkWyuGsVu+jmKXb2eDm4gaRTMXmMIKPbVUJim0L6HTPNaocIyEWQ==
X-Received: by 2002:a05:6e02:18cc:b0:3dd:d995:30ec with SMTP id e9e14a558f8ab-3e153a67248mr59069015ab.12.1751997616011;
        Tue, 08 Jul 2025 11:00:16 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b59c72bbsm2276958173.38.2025.07.08.11.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:00:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
 Sarah Newman <srn@prgmr.com>, Lars Ellenberg <lars@linbit.com>
In-Reply-To: <20250627095728.800688-1-christoph.boehmwalder@linbit.com>
References: <20250627095728.800688-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: add missing kref_get in handle_write_conflicts
Message-Id: <175199761446.1185853.16712742207654241158.b4-ty@kernel.dk>
Date: Tue, 08 Jul 2025 12:00:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-d7477


On Fri, 27 Jun 2025 11:57:28 +0200, Christoph Böhmwalder wrote:
> With `two-primaries` enabled, DRBD tries to detect "concurrent" writes
> and handle write conflicts, so that even if you write to the same sector
> simultaneously on both nodes, they end up with the identical data once
> the writes are completed.
> 
> In handling "superseeded" writes, we forgot a kref_get,
> resulting in a premature drbd_destroy_device and use after free,
> and further to kernel crashes with symptoms.
> 
> [...]

Applied, thanks!

[1/1] drbd: add missing kref_get in handle_write_conflicts
      commit: 00c9c9628b49e368d140cfa61d7df9b8922ec2a8

Best regards,
-- 
Jens Axboe




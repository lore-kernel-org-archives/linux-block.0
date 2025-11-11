Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FB9331215
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875382; cv=none; b=aYLxJ/anx75G+vMKnb7P4fCmnu3AlbQgGe4qqomaGjI2TJYQbKG/JZvrKB1+G8NPXbWP0E0LtmcqYtUQUS2QYBLuYMgLu8VEfEVU/oz9G0J7J1jxpKbAHx8suH6k37JSb82ZYWg16XNhQ158k3gmqSsAs9nrvm4gBf/sHCf908s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875382; c=relaxed/simple;
	bh=fkLEpn5IW5RtBAfwB9p4yqA4T0FYBWk5L4CdUP0OFB0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MAl5byyrXYqrIl/b01fDr5iFqOFNcZDsr3JdWKQk/HaMF9BBcq/781XUa/4+hJ0dBqX16VlPz39dIBZ95MsXVuKp7tyvarQdPsLCqPY1uTHZKOzUaixs3jD8HTiDRvcvp2TON+jcOknVL4lR3rST2O4ppkEhs5MkiXTUc3ExWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=R+KWEfLM; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="R+KWEfLM"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-4337076ae3fso15960665ab.1
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 07:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762875378; x=1763480178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMIoGR4xeNbxvWJ8AeyNEhi+trRuU0DC7MBoEsb8APk=;
        b=R+KWEfLMnI09xgPw7gY3DKPEP1DWkILxwFnirWm9RPqw1VDwXAtka2bNQ5dRWv7EHf
         Pf1Rn9iQ3sOH8eMkZWLk0ET+wX2QsSBZsEEfecFbPrV6nRvWbIqgI/D21NsB1VYI/AsR
         Im1A5VcSenp33eC79MpUI2BaKmFN9PBU0AwaJGHpVcDEhkeuTBDJ4cVgTr9znx4NOQXj
         fpAasaeBvbVyKoWc8HW80KYlK1cMW8DdBHcGbb+mscltuZuaUetUVFGQWAT1EjB8kXYe
         qAk2dRY6+6l9ohlUUJ0aRnEcmnJ6/J70VqODek/WQIg7+xO8JuS/Uy6HSbWt3HqSnBc4
         91zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762875378; x=1763480178;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZMIoGR4xeNbxvWJ8AeyNEhi+trRuU0DC7MBoEsb8APk=;
        b=we6HVDTJumSm7nfIX6R5mDe4uFUH86QoCQpRhsKAcefjxWh3bt/ludK0pH8z8QDj0S
         ZluEkKZvmNnmYl2sBKcu2dx8KiNunAuQcIAY1dExLBfp0tzQbmGXHj/MnF466e0a3arb
         8G1SSBak/O8EeTymc+kUp1eRFkr0YADiyRFUG4oSdC0Xzlz5XkCeJsF+2ON2O4VW21xl
         1IQ/Y3/C9Zd59Xo2k/FTuzAfEXUnNjnVw1/NtQmZeYakF8e7fKOppYPZ75MEWm3qbTnI
         Q9ZDAxrQl+obxuKLe4Gdbe/9PjU/pbBxG/EpWVh4NJOCh4R9Jx6tY7AIfnQhGNXDVma7
         Gf3A==
X-Gm-Message-State: AOJu0Yxsd0SXSikVBw0fhdSe60dL3m7gcqcfIJPRfuYszsPxK0lFCq0u
	dnE6V2k7NVK4PTdDdvPk+cJQUzbM9hQ/sYCeju6vgxBrYK4EZRJndnPO2OiD2xdwZOc=
X-Gm-Gg: ASbGncvSa5EOJw8YrsPKRoBXWXXNKy+An5HI5GI+dv7RK0nTl7FZ0g/04uFiN9PuMfi
	2OmRHUERCmwDel+qxCvpDY78G6/li2OoP1ajKBae9vP8PUUhRsAhXvh+1dj3iRCWzAiQ+1b5Nl5
	WdKgFxpStaE8dFDyiigW5UNC2Pbvl+m7fOJyR5XG2Kq996y4Tn1iOqG3WTWmNL/UgeDJMLCuQfl
	jy/7bMpw6Qw23JPjKb31EhG6CEBEOyiJsmZlXOqN3o7vtm4M9oNZSc4Vkd6oL/pvrcdR4B2Y+db
	LZ+ozZLNPHLUYU9e9yNgkNUugkzDR3e4qomdIbwrKKALtby8c4oWNKXD7y9F4CtXf/RSp9QWSAB
	svkcPK1Apr297u7SHWm2neTZMQhH6K0pupsPwiCChETmAK6ZMa9J1uFtqggxvHuB8Ab14j+1nKX
	3TqmU=
X-Google-Smtp-Source: AGHT+IGWXNwRfF8x6SN//ASxy+zY6uK9f9sb7lB0geZ6oANWguOWXvE/LHmFtJAroSn1950bEcUcyw==
X-Received: by 2002:a92:cbc5:0:b0:433:77ee:1e3c with SMTP id e9e14a558f8ab-43377ee1f62mr114637665ab.2.1762875378624;
        Tue, 11 Nov 2025 07:36:18 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7aaf59b2asm3288173.6.2025.11.11.07.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:36:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, hch@lst.de, Keith Busch <kbusch@meta.com>
Cc: yukuai@fnnas.com, Keith Busch <kbusch@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>
In-Reply-To: <20251111140620.2606536-1-kbusch@meta.com>
References: <20251111140620.2606536-1-kbusch@meta.com>
Subject: Re: [PATCH] block: fix merging data-less bios
Message-Id: <176287537700.179777.7442841246937619442.b4-ty@kernel.dk>
Date: Tue, 11 Nov 2025 08:36:17 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 11 Nov 2025 06:06:20 -0800, Keith Busch wrote:
> The data segment gaps the block layer tracks doesn't apply to bio's that
> don't have data. Skip calculating this to fix a NULL pointer access.
> 
> 

Applied, thanks!

[1/1] block: fix merging data-less bios
      commit: fd9ecd005252b595fd02ff7fcc4056251027404d

Best regards,
-- 
Jens Axboe




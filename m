Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172B14D6EE
	for <linux-block@vger.kernel.org>; Tue, 23 Jul 2024 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741453; cv=none; b=T+wy4dDKl6csCgmL9We4EsZEPyw964sHHZhuEx2QSD7rAbia8PHhHDhoEmhNMbzhNkLDZDfXtc/CYmJ5/O6ByVmOTUN5FBqyLO1qXMFNx5Mw44OAlGeMFIOXAM9N+KpxP9Yt80wS5x7HfIPJg4QclsHKZYLdz/M+CbxeWF1u83E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741453; c=relaxed/simple;
	bh=mjxfhNWSDEtrj0+ZM4ZinQDzjr3OdStCoz4kzstLYFk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gv5F4Bdv8gkSTdRbD3K5co2c+KGVnoc86QARRmn+cHbD1ZoSiKc48VHMl19o4deQZwZmMehFvnwOVoNsokc12uI1GXA6bL8ibQknaXi80Oja0gQKU43BYTkibvXBxZx6DD7Ab5+3lZzyGkY3hB5I/H1zJO3wecGPpICERuKtnok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fWxhmD6y; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fWxhmD6y"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cd46049d2bso259017a91.3
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2024 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721741450; x=1722346250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqlR1BIutPkgOwMCyULXWeyxag7BhJk90RFsq6PrQZo=;
        b=fWxhmD6yDBR1vYuMmy01EgxXRAoa5HPs70nfgAbdkgzYq94B8SMJAnwlhkXAhOzl3f
         S5PyjphumEvwN0bRlwKbLBjnQuJehQda+38lFxyktv3c1i5ukaatQV8vFOjixvQCUYlH
         CTnZd6jWupTdhd1xcco8TJ+3bt8NCMpgYaaec7YrehoMR1Gqg1M6zXu/bGFOdIB5VZVg
         3YsAOnbTRfZGAFDh/JJt68W8oD95bgLl1AH+feLyjzpVSbFpZ7IpfjUVRDkHhGk90XUE
         RtS9K4fvIeR59smFnQfAgwH59Uk/KxHGSptzZe245KVUxuHdQYdzzodNcG3to8skneP3
         taGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721741450; x=1722346250;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqlR1BIutPkgOwMCyULXWeyxag7BhJk90RFsq6PrQZo=;
        b=mSHX1c78BYdryPyRrP8Sq5ireo0ptOxJO6LbdygJjjnY+cLBE09W2yyfAajvTkoaUu
         T7FSZEYkMT8C3MZ4YH+mfmcuSvQ0JkMAI6HDrRM7rNmh78CkkvGe/KSOTObLpzge8V2b
         W6LFuxrL3DMmUartXh5AGndQSwnly5pRaaqm8LTaclAo1xd1MnxXdzS/aFRKDp4bL9e9
         EB4fmGT9XzDhnIV3HTOHBayr+4dbKUODoD653CE+goJ8OaDsSJzYalXXyCYqzE+/EJxi
         UpfL5exC1H9mc/Rf2lgaTCNXpF5+coklxdKVe0DLs5Cca0AxKVvbs40bYfcxytuYji3J
         X5aA==
X-Forwarded-Encrypted: i=1; AJvYcCVf0nYdIhaH5AGE4bKtfMjLYBdL+ew5HONirgqepAV1h6RGn7vx8eOryDIJP2QrVrKLCVK00dAnryx5Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtYyvLfY51SiT3Uyyckvm1gXJuv8ZlwHrvl9S/671HZaiu1Tb
	cfOTpWl5RRk8EUMkjq9Injpz48k1GEvG/yq2dzbF8FSOXKJisRY/UEdScEheCsFKVGk52GvowNH
	0CGw=
X-Google-Smtp-Source: AGHT+IHDM+Qmjw2gX4WFG+25cSaQly4nclkewYqx2IYKX4yl9o3sdW7TdNziDSTE7eR/4EF9vuEw/A==
X-Received: by 2002:a17:90b:494:b0:2cd:1e0d:a4c8 with SMTP id 98e67ed59e1d1-2cd1e0da5ffmr7298722a91.3.1721741449707;
        Tue, 23 Jul 2024 06:30:49 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cd8cfb85c0sm1553157a91.0.2024.07.23.06.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 06:30:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: davem@davemloft.net, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, 
 ceph-devel@vger.kernel.org, Ofir Gal <ofir.gal@volumez.com>
Cc: dhowells@redhat.com, edumazet@google.com, kuba@kernel.org, 
 pabeni@redhat.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
 philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
In-Reply-To: <20240718084515.3833733-1-ofir.gal@volumez.com>
References: <20240718084515.3833733-1-ofir.gal@volumez.com>
Subject: Re: [PATCH v5 0/3] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
Message-Id: <172174144805.171126.5886411285955173900.b4-ty@kernel.dk>
Date: Tue, 23 Jul 2024 07:30:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Thu, 18 Jul 2024 11:45:11 +0300, Ofir Gal wrote:
> skb_splice_from_iter() warns on !sendpage_ok() which results in nvme-tcp
> data transfer failure. This warning leads to hanging IO.
> 
> nvme-tcp using sendpage_ok() to check the first page of an iterator in
> order to disable MSG_SPLICE_PAGES. The iterator can represent a list of
> contiguous pages.
> 
> [...]

Applied, thanks!

[1/3] net: introduce helper sendpages_ok()
      commit: 80b272a6f50b2a76f7d2c71a5c097c56d103a9ed
[2/3] nvme-tcp: use sendpages_ok() instead of sendpage_ok()
      commit: 41669803e5001f674083c9c176a4749eb1abbe29
[3/3] drbd: use sendpages_ok() instead of sendpage_ok()
      commit: e601087934f178a9a9ae8f5a3938b4aa76379ea1

Best regards,
-- 
Jens Axboe




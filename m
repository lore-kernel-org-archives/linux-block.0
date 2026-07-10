Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7C3DBD49
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687774; cv=none; b=Gy+HKLBag1w3UJKINCTnxUJx+jZKXP1aPc2vuDmGFjgeijhjogwzUknkCjTiaUgs6oiHQ5KeYP2kPjUqGc2csiJelOrjIrsU9WOxcJqQ2WKwv41qLq7bn9T2d8Uj/xAciTgAUJs+RKnbFxXzVazAISjm/FeQW7jOOSaUp5/ceOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687774; c=relaxed/simple;
	bh=MLaWTq33ww3mlpoMm/tS4SgQKiyXWclFHjIed6CrxkQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CWAdPaOjqJVO7KprfPbSlxFGHID/JaNOyg54T04r9/u6TBALLytyjfS1jyJB+MBdgr76+S4L85/zLXPZ1NdEl/5N8t+HrLUumKsDK78SM9MUGPfcN66R2ij+e40Bpq2neNWJjcLV4q/8MRCAzrRaSSxCL/vgO+4vOB70d8FsoPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=BFYx/Ef8; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="BFYx/Ef8"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7eb545db3afso557222a34.0
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 05:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1783687770; x=1784292570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PIPFqgbIUKyllKjaqWMtW74odvC0/oH+Xj63BOSJ31k=;
        b=BFYx/Ef8PJq58uMbi4MZEgXc7CRkId2Y8xvHqtmHT+h477SVmbBfVA32PP8mx3rGSk
         TGfh41YkTsTKnv6mqzvOSOmi5wxnOde3pn8ZGIlf8sYVhaEW2nvb79S8K0iNDqX+5Z+M
         mtBqL1p1psTLcKaCh6WIH7SqX67xiEwKlh1kZ3Goj3VPH3HlX/0IJ1X51Ueko2l6OsAH
         27dHBt7q7u12FfOTs/iizNBwoKkx+pElprY58iwnPedfpvDc6ZozlXuWiqPZ8GSh5qrk
         WfDz3tybVOpMZBwfnDywFcd4EAdQd7oW2iwoTiZp5YJ7rmb6haAZJnHNpzJPGc022/pK
         Qm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783687770; x=1784292570;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PIPFqgbIUKyllKjaqWMtW74odvC0/oH+Xj63BOSJ31k=;
        b=JNl1+f8AIB3zlFN2cPpWVbZrwCSi/1Rto+OWKZsnBhdKg2c2b0FTt9k+UrdOXgKZ/O
         zjHASVZrX0Imk9CKYmlo3TZSp4lvF5vX6G/p/zMZ5koeLTeFokzHo9yqpdQVrrn2V/Jn
         aqORbPuYql6qaml2jgOOwhhpbwapqYgrJd5UJ2iKtp1KfcGtlIlfyCPi9FwZ4eH78ixp
         w2ZkVSWoNgaicNKuP8nqzZUIKoqKHG5PZaUJXvFcEjbUix3Lag7uYIWY4uZmxoDq5mb2
         NShCB6ROj9Fo8OdP5rEmLU7abWoYvpLyO6xj+SI7D1B+kaB1bBMFlR1IicLF4oc5qA7m
         jfxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9umJww7T40JHpeuNSd9RMXC+cSQg2KqB33RfaJWueruVWD86plC/cQGmmqipAHDDnkWIsyjbYxKDaARw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5GCVI++C/bRQvQBpc5R85m5rbKiupwbqZEJBoXy1SshNVn0L
	AsHiNTLwnptLz3JfIZWUgTBEk2dUYlyybnxaIAPprcJ6zbm6r+4Q4QkMeEcogF+fojw=
X-Gm-Gg: AfdE7cnEESxm7hZG7FkWXW/Ro4XHJVDaW1c/syhJ94jUhi31T9TbRH+LD+10L5r3TIi
	OJxZt6/VN7lGyb7jL2Mc1n6oWN28+3UALImJTbKNdDXb9m7WAK5n7L5/oHyqYW0yA7+OLnu1iB+
	NdB56jpNMXhqKRcYQzB6tB7Tg6hZN9tCgNCnPuZTRKymSqd+I6eaAN6F3/Xrs/bn9QoIv6gjm/V
	qe4MEyOf2vtgcyayCztg7QgW19V4ipXbIIVTZAM3WXCdTHWLyaO5E6dLhbwJKdDdstOyXX8LdWJ
	tdmD19Ef8CdL02VbIZZftzuWjXUYkOk+LFxt7kuBWK+WkUX5+MiFHxmNzRB0gzqR3MBXcXUBcXz
	0HyB4BGCtc//YA1UdC8RTAtm4wxW0m3nscVNgD9nPkV7Y0aQtTY3NYgCvD4H/qK8iWS/yUsiZrB
	b1QJFRABB1Gob8O2pFbjY/Ae3Dri/r8V+UY37dxQVrQ2mqYFA969Wb9QPKND9W+RueiA==
X-Received: by 2002:a05:6830:374c:b0:7e6:fdea:7aee with SMTP id 46e09a7af769-7ebcff9c7cbmr7993794a34.24.1783687770495;
        Fri, 10 Jul 2026 05:49:30 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f27besm6229648a34.25.2026.07.10.05.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 05:49:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Juergen Gross <jgross@suse.com>, Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 xen-devel@lists.xenproject.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260709100853.7489-1-doruk@0sec.ai>
References: <20260709100853.7489-1-doruk@0sec.ai>
Subject: Re: [PATCH v2] xen-blkfront: fix double completion of split
 requests on resume
Message-Id: <178368776865.253806.8102253484028119931.b4-ty@b4>
Date: Fri, 10 Jul 2026 06:49:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 09 Jul 2026 12:08:53 +0200, Doruk Tan Ozturk wrote:
> When a block request is too large for a single ring entry and the
> backend does not support indirect descriptors, blkfront splits it across
> two ring requests. This only happens when the frontend runs on a
> 64K-page kernel (e.g. arm64): there, even a single-page request may not
> fit in one ring slot and must be split. blkif_ring_get_request() is
> called twice and both shadow slots (shadow[id] and shadow[extra_id])
> point at the *same* struct request, linked through associated_id.
> 
> [...]

Applied, thanks!

[1/1] xen-blkfront: fix double completion of split requests on resume
      commit: 5d72720365f973e2c21fa99505b627521de66c25

Best regards,
-- 
Jens Axboe




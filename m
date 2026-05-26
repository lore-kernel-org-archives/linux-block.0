Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EBC3C9889
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813462; cv=none; b=pqbyfDW3XBYt/TKWjTNEknVtn0HpKy7bVvqaquURGAJajTRk29DD4jxTcaTRkyZPCOScDifU20XfEa4Z0qW6jBh9z08CZloUSaRO9dTJu3P0LlnlyNNDy3FTuGJ/lnU8BK4Ln+ujs9Zq5PeNy8I9q8H/rqE71RqmOjn1xP3Erho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813462; c=relaxed/simple;
	bh=bnP3tFRMS23GmLS0MpUmKjed3snyikCPiyZUssBohHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h4oZq+wfU4JgBt4SjBpBBrgGNxGK5De8gRKWaJumuQCf6dM5+SgtyNQd1aKPSXYTnfCehAx5+eP3u+752GepxiSMrHELiIGyITyYuT7o8xo6mrtH6fkTfn9Q9vGb1bTTAvC0qRhn57Dfk/3iLQOAuFFvUe1Q06eUV7GNH2umXcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=vdarUU1/; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="vdarUU1/"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479ef2b78f3so9794977b6e.2
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779813457; x=1780418257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsVDC4asTVFD0okC/p0uKE8RNudEd8u1DxK0D/0fYTo=;
        b=vdarUU1/sPNm5Eyfj35+dN5W+YXfikohPvDuLbCN6ODcc1iHfnJRK6Dbcy4rmM54cA
         xtWrRcRifP2I1P9tUeM/02IXlCQ7pqwLlIj1c8lk1S3ovL8Uq1xVYfuDEf94VQ7Cajvf
         euAMvrV0yUBs459PmHrK5TQ0f2QhIsiVKmxD7z3bKFwhwCFbI4RW0Y+84WdKRPfbnzME
         JIatOZot9nnSMa7MsGtrlO1fiMi5FGpAyWuujHWHN9CZFOqxWUTGNaKUUA7XOBVITJbY
         oKxBRqGLEv7O0tN/QdvROB7a5HK+wsMxFgySMpKjz16SwZ5bHcK8mY8HUu8UZaWeCTTH
         HnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813457; x=1780418257;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CsVDC4asTVFD0okC/p0uKE8RNudEd8u1DxK0D/0fYTo=;
        b=j8u1WEg4BLBXBxCGplQs6G5C6497h0WUNOTwCyUHjjGLM6357YdUOVreNGm/f1RBrX
         WDpL2GkLuJ3celrq1/vxivfL4RDxgBmkqnHQKaJe0XF1aZxVOTmyoWlX8JBU8tsJUC4+
         M84Nh3Y6TXNZYvxPNaKilHz6qtIRhcYwQfAO6vslHDJKExLI4ko+SaJzaa5snJ2JM61G
         Z8rs10aDHPGEfMnlrY2TWVdm0wNwI0TmP3UvnM9c3246BnvDI6Uy6X85aOys8p2TauOG
         8Ln+/IUk7OWJ8aagUX0ZgyRUr0oLzW2OPNNr6/gXoOByX9OsM9x3L8UyyZJg+jTEYU6g
         410g==
X-Forwarded-Encrypted: i=1; AFNElJ8gsUdOrvVQMyZ4U3nQAVJ9AzTbCPc5Cfl0tEnVqXoaEBntuhHvmJhlXxLB0Uthhv1xcDOzNbUx0Dmylg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfb9x3cCb7icNqvblqXXZHy44WZR2LPbd4aZ1XwbnoptQ8BgmL
	y+LA+QwnXbwot7M7zbzY1ryZmtIxQCkglWm/ZutYXo+WDY2ptzbTJr8ze8IBZjnQmuA=
X-Gm-Gg: Acq92OHJDBvYt567YBGd/+SrspCUzmL4nglfKVKRB4fNemr0KD+Uo+v5qmANF8lyEzD
	syQHZupCVO6hWWH6ntmhcvi4TQNs9u4mXzmcLu1UXq7s2Dgzph0tkmERJTSt2EJfDzsyA3yZYzC
	voSYEV85n1SnryMZGPWELnS+EplxXuENfE/Rjsw9fwn0cD72T82zG/m1KNkY/OxJ5eEMNWUIclK
	QLmuGJQVbh2SZeIuqog6gwXwos8PEKvf9yd8h7MmIQBPE0Efp4wuiqRgLZx/aff0PqgHBrsX5jX
	MPY8qzAx3HqSUECkzfoL82jLFfs728NEmWqlIM3V/w+KLwxy2FLE0XoIgkin2cutVqV0qLe8RA4
	xYzVebTeZI7dXMpjZwpI7CVPtW+cQ7nIIetxBUeRu3/hKbGR6PCyRFBF1nZlXtwqkq9XKYMZbbM
	lA1zOwQvxqBic+6ZbaQo0OxwRtRtU3LZN39GMp4uUxH8x221e/Ge5VLIW1nZv1aCwpDfF2AqJcI
	vE5q21I5JWnPQ==
X-Received: by 2002:a4a:e910:0:b0:69d:dda8:43e0 with SMTP id 006d021491bc7-69ddda8464bmr836597eaf.17.1779813457369;
        Tue, 26 May 2026 09:37:37 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639fd7adsm13561265fac.14.2026.05.26.09.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:37:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: Thomas Fourier <fourier.thomas@gmail.com>, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260525162531.1406677-1-dbgh9129@gmail.com>
References: <20260525162531.1406677-1-dbgh9129@gmail.com>
Subject: Re: [PATCH v1] mtip32xx: fix use-after-free on service thread
 failure
Message-Id: <177981345006.464267.16444932758655645781.b4-ty@b4>
Date: Tue, 26 May 2026 10:37:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 25 May 2026 12:25:31 -0400, Yuho Choi wrote:
> If service thread creation fails after device_add_disk() succeeds,
> mtip_block_initialize() calls del_gendisk() and then falls through to
> put_disk(). Since mtip32xx uses .free_disk to free struct driver_data,
> put_disk() can release dd on the added-disk path.
> 
> The same unwind then continues to use dd for blk_mq_free_tag_set() and
> mtip_hw_exit(), and mtip_pci_probe() can later free dd again. This can
> cause a use-after-free and double free.
> 
> [...]

Applied, thanks!

[1/1] mtip32xx: fix use-after-free on service thread failure
      commit: 6b24446bee489e90f7ea843fbc0473393c73cbf9

Best regards,
-- 
Jens Axboe




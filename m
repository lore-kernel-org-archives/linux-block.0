Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCFA3D6CA7
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468931; cv=none; b=HU6TMs8Wd9JcD6g+DGSE6kqHVyZYBcIRWcBePnexe4g/RM8moVqIjQGpEHsgXyPULVILJia7iTmN9PfRj9cOzYoNExhhKR/v59hXNfOo2SQOcTdtYtY8AzRjGd87rO+fItuluaRb7f/eDYdEsFwe2sySkfiyUuG+V6uwQRta9eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468931; c=relaxed/simple;
	bh=BGuC68CLmB1SVFvczWbyrIU6Bc5rf9fZJH2bS3MQMHI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gCM3Rx8L2oEDJkqITjXGRBKFmbql7C4WKoP0uQLEzJ6DOtaCYyqy7Fxen0oQrel7UlOZ5v/szS7oGG/ek7q8JGF94cZdiEXJc2h7MPFKeINk0QN5I1XL5QS1uWfLz7HAKuu1spt+cTwivTjcMalAM8zI1H4ypCQK9fj/Uul/3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=z6hO99cd; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="z6hO99cd"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a07f66f4eso636256d6.1
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2026 08:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772468929; x=1773073729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFzqtz+4o+wkuTLBVGWs4qOxtJBCidXh4xumrLbORk8=;
        b=z6hO99cdcJOq0i/xSmjipUccijHturQn5aFgL0jzdqBeG9HVAtGtz0Jz0CO90/RzJL
         x6zY35ClS7QhEUgJOkacgIvR3FVKazhJutdY++pszmp7ITYjPBZUCTgHZRbnMZxZuLeT
         gx41bqkg0GbyoT4tCtXKNlT8Zl3W1mu3RdldqtgB4wUx0EkjMKH1NxELOXV8/pxojWJw
         zis1kF2lnqMKcJSGoPaFQa8Li7wIXrmQAm3apXtQW53rM6w6qVV4fbPSwfklg0vfKTAK
         VUq9Q6HAsFv6MqNRFoYdt3S2CciM8XT5xmmLaZx8JQ834RIQS9Kol+mzDgm9e5YlSkK0
         THAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468929; x=1773073729;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uFzqtz+4o+wkuTLBVGWs4qOxtJBCidXh4xumrLbORk8=;
        b=ePg7nstOtJRVW9/dmGu2sRclcMYYb8PUIpsP1YjFGbXuvL02l4xElZwd5SAiErhXkK
         xJO4Pv7hoe1/mIZtZg0epASk2cHa8PiLjwmPnp6PwW41ZxvrOEj2UXQAaTrEQeU0Xdtx
         e8MVxrVeo4CwCihE97pPrLt7UxGxeYPTkFc0cQPQ3qOmrE7GKjtQcumxC2BkBk42Bjst
         eGuy02GZpj9WjV9LrY7KVsT6e03nlBvDn2pXFYS0l15Klc8L0liSwx967lDTyzCCfU5u
         DerW7JkCPh9oOp9X0A9HV3tf1zWRJ7fGnsGE5kPJ852ZzR8COcxGFhdHvv/68RliPirb
         BMBg==
X-Gm-Message-State: AOJu0YyC0jKu9m8um/3O6J1IUifUMZxTpz36x8NUw/+NFEfj70+HIVjO
	5p3Lz2EfZtBORAy5JFZXjiu+9D6qX+mF2GWJTc0W3ONZxbuuYA/oDs1autuu5GHg6ak=
X-Gm-Gg: ATEYQzx4+EOsfRD4b2ith+IHAu+g9N+knzTf0HlP82pMZ44DXouTCZBvI66Zwh08mdT
	8tAjnptiDj5hzWMmRlfXWtHATxSM6duqWsx68RYG7pLwTc7zqz4NfCnQM8UfQuUmUOm3XDhp5SH
	vZOJIpiUgk5P3L5b8Vp2Ux4kMeT6qHK9vD9FfBFs8PS6W3io21tafIMwycm7Q23G+OMHIm+nnFc
	Lm1CGEtK+kRWC/fJ+bw3ZaWuJG6td+a2vfOa1qlUQOCjS0M6zZOjzjG1+f8K8Rp0c9lmo40rJMf
	UVNbvuTgRYD2PGGQ/sfFcW8rMItK96UuEF6/13NJGAkjfZ03xJdo29UWqNdD9U49rOsvIAmQwF0
	MmAHEg6+YfZF3pqXv/7DOCRJe/4VXvG3WjHvP9xKpxPIfKmzfZ0GHmOxKJom32E18l4klsheqT+
	DKx0oKNznvK7DC5l9h7UD5uh2idq9AmfA/1bLTP49hFRzRtxuPiuaPmRE6uaXBJ+JzinFFaaDMI
	IyBjEQ5G12biA==
X-Received: by 2002:a05:6214:492:b0:895:4b25:4a18 with SMTP id 6a1803df08f44-899d1e3bcefmr186138576d6.34.1772468928818;
        Mon, 02 Mar 2026 08:28:48 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a04849cb3sm9035126d6.6.2026.03.02.08.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:28:48 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, ming.lei@redhat.com, yi.zhang@redhat.com, yukuai@fnnas.com, 
 shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
In-Reply-To: <20260301125951.582690-1-nilay@linux.ibm.com>
References: <20260301125951.582690-1-nilay@linux.ibm.com>
Subject: Re: [PATCHv2] block: break pcpu_alloc_mutex dependency on
 freeze_lock
Message-Id: <177246892733.112159.6862640478581828526.b4-ty@kernel.dk>
Date: Mon, 02 Mar 2026 09:28:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 01 Mar 2026 18:29:43 +0530, Nilay Shroff wrote:
> While nr_hw_update allocates tagset tags it acquires ->pcpu_alloc_mutex
> after ->freeze_lock is acquired or queue is frozen. This potentially
> creates a circular dependency involving ->fs_reclaim if reclaim is
> triggered simultaneously in a code path which first acquires ->pcpu_
> alloc_mutex. As the queue is already frozen while nr_hw_queue update
> allocates tagsets, the reclaim can't forward progress and thus it could
> cause a potential deadlock as reported in lockdep splat[1].
> 
> [...]

Applied, thanks!

[1/1] block: break pcpu_alloc_mutex dependency on freeze_lock
      commit: 539d1b47e935e8384977dd7e5cec370c08b7a644

Best regards,
-- 
Jens Axboe




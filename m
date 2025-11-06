Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B529F29B8FE
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471818; cv=none; b=UgCb9OcG2QIEsbV+nChaugTlZzkePcSDimTPtnuMsWC2men0+9WWudXH16CZmfTX5FEbBS2iGg7M0cjs00O88wrIBirsV51crx2FRxjN68blB3bwhbK+KsDpg+Y5XDkfqDdQUUgPta04VkxfkKr4F8m1V+vjfJj5kXy8Waz5EqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471818; c=relaxed/simple;
	bh=XttH6bEjgzPogTf18cX2gc7lJg5MOLJ9NTDi4ezhatw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QUXssW8XXgcEmvfb821ldi1XN/g6VBwcZK2A3GxJs/xdkHiGgnz+qDx32+ZVXcYrf8XDv72OcLTtgI5esJK/I2c2SQhOUjrk/4aQ0E03QtrzKBD+/H+CH9YjYSftKy1fgguWK2e08VXokLwDALYGXnzsR5ZB9S0TSvBXgaqg4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rLC7Tx+3; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rLC7Tx+3"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-87bb66dd224so2204076d6.3
        for <linux-block@vger.kernel.org>; Thu, 06 Nov 2025 15:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762471815; x=1763076615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXinoBcTxtS52m+IzLGsdwHv2TM5PAs1jR17DNC2beA=;
        b=rLC7Tx+3KAKyh5/T/IBhHMMCiwz+4fOWZ+tXAPdFLKHovNCINCEyqn2gf79VUhydvY
         MEDdoKFT4eOuhT8/0FZy+sVjuIFICRYIE+WIZsifVxYSclPsJfY1MS+PIVWOLYYn/W1Y
         d9iTXObI//VpVUQFzLZgJEm1tTUwaVT8NZXfi7o+P69+lAe/QYuXqih2z5tlj+iK6G0a
         76FG8701+QzxYy8Zacpp7PNgzhb0RckKNvJGO1IgRjyzWexOK8h6hxqMioHzRLI5nq2h
         ydGM+WgEWloGcxgtdDU91u+JWe1ejH0sJ1pwTOgjCYfB19bRUZSCMwEWMc1X1gjG7m0S
         mYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471815; x=1763076615;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UXinoBcTxtS52m+IzLGsdwHv2TM5PAs1jR17DNC2beA=;
        b=K3fZE8/IJnLBQTpwIB6mM+MkPIwlSSkoCjpeXSC0OPje+5Qu4opTAO6HJhnUFD/Fpd
         aGNwNNniDgulbliZWPi3xZqFY5pyiNpP31kx6bzlp/A3vmZAx/92HQg4pYeWQgegpB+2
         12g1pqk7p73xitMTTc0UujRs3x5bgzeF1p4Bx09oicZDF1umiTht3hTCcDu2wiX+P5WZ
         UykrTK9tQhUQS8w9J35F5S5rV6rMfCpUMVebD5zQzjDqCcItbMImeT1GoYMbmOresesi
         ZNxgFph1FKl3cIGpQfbPYx+pR0WVtP2rLjRDnPCnxxvPonOTkOgPH7IurzSt0XxvCfgV
         rp1g==
X-Gm-Message-State: AOJu0YyPSp9zR5cbx9KuS7LyLR29ap+O1Zt5pMeaNzpmZN/EWDjjHszD
	8FHgvuapIUk5rdzQ+5EkTxlMroZVyqfqS0oNk38LwVEpFJzkBI+QExxhsrZfPcEKlyoQXeKALOd
	irQCv
X-Gm-Gg: ASbGncuKHiiSQ7zi3CRdqwPmlevAHXbUXEjG3zDRhkO/Ar48Q6qelLoNahRcDxYAMqU
	UJdnbu1kzeI84wPoeAltZV1YqfHBbooiN1cKW5glm8TXbmnRSfpfYGFn1vubdSRlOtp7GGVuBaG
	s82Jo287sL8aKzfDoU0bKshrtIewf7J6UAI5PYdzT8CYdxuFhQpQpR28cmspCGtqCOKqVCD+cUB
	vmX+WfmJQlMKI178bi2tGfjABA4X4XhRcaEfAN4esIqJ2Kz24z7XdBq8455bAr7BERNomBVP4Zd
	R1nnrjzaZmPqzjkQulhqUIaurQ7dwiV2kuCdvQGnruhW4uq3LL++9D8yr7++OrbWBTv8/SJDkDU
	KgWjS8uy+8QCVPH7sMlz8fi/2fKvA4oW4cQIVLeSM9cmUX1Ya5BH3v5nkqUhsy6U7t/pKL9IVJM
	qoQppX4g==
X-Google-Smtp-Source: AGHT+IHG98YpD795nCxVP6q79c0VGkLLfFSu0GjOHYdCxfd+mtZ99KDHEQeKAM3HtFsJtKcZSkYBTg==
X-Received: by 2002:a05:6214:e8e:b0:880:4a42:289f with SMTP id 6a1803df08f44-8817678e120mr18833176d6.61.1762471815585;
        Thu, 06 Nov 2025 15:30:15 -0800 (PST)
Received: from [127.0.0.1] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a37f10sm27786316d6.54.2025.11.06.15.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:30:12 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, hch@lst.de, dlemoal@kernel.org, 
 hans.holmberg@wdc.com, Keith Busch <kbusch@meta.com>
Cc: Keith Busch <kbusch@kernel.org>
In-Reply-To: <20251106015447.1372926-1-kbusch@meta.com>
References: <20251106015447.1372926-1-kbusch@meta.com>
Subject: Re: [PATCHv2 0/4] null_blk: relaxed memory alignments
Message-Id: <176247181201.292880.14454396855406847978.b4-ty@kernel.dk>
Date: Thu, 06 Nov 2025 16:30:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 05 Nov 2025 17:54:43 -0800, Keith Busch wrote:
> The direct-io can work with arbitrary memory alignemnts, based on what
> the block device's queue limits report. This series enhances the
> null_blk driver by removing the software limitations that required
> block size memory and length alignment.
> 
> Note, funny thing I noticed: this patch could allow null_blk to use
> byte aligned memory, but the queue limits doesn't have a way to express
> that. The smallest we can set the mask is 1, meaning 2-byte alignment,
> because setting the mask to 0 is overridden by the default 511 mask. I'm
> pretty sure at least some drivers are depending on the default, so can't
> really change that.
> 
> [...]

Applied, thanks!

[1/4] null_blk: simplify copy_from_nullb
      commit: 1165d20f4d1abba59ff2f032df271605ad49c255
[2/4] null_blk: consistently use blk_status_t
      commit: 845928381963c61a537b932b6b3f494ce0ccea2d
[3/4] null_blk: single kmap per bio segment
      commit: 262a3dd04e729386bececffeb095d31f7a9c43d5
[4/4] null_blk: allow byte aligned memory offsets
      commit: 3451cf34f51bb70c24413abb20b423e64486161b

Best regards,
-- 
Jens Axboe




Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0154C62A
	for <linux-block@vger.kernel.org>; Sat, 24 Feb 2024 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708804139; cv=none; b=gaiVow45m7TWdY5cSP+I2Aj893dDWB088W3a8BqjjvemNFVm1+u3Kwd0fl8+Z5vrJ1D8H7b5jwsgqRLnm7pwFz2EsYO5IGbRDfy0nE0uJLv2JRzYyv+RL2haKSlVUAudCwPlVqLcjmfeUYJ2/cHCA2Ane/piE0MV4VunDq3yoVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708804139; c=relaxed/simple;
	bh=hc8yjEEtea8usu5qomUbyQ4G8NEtu29D02NQxrExvMk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sDqxbs58JO5fSUNFz/KmhDp+dJ+zSXKhRnQJtUsxh485F+WmnAXJyq3kmR1VpCEZtL5SukFcBjIq7+fzhB7hLlstU0augz8bMYGEqgq/oNhqTChpYuuyegHUad78gaElKLJZKqXy4n9LOknoS0qKPZVhRbqqF6vgvP95jZYxEKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Kg5rrFu4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Kg5rrFu4"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-58962bf3f89so691253a12.0
        for <linux-block@vger.kernel.org>; Sat, 24 Feb 2024 11:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708804136; x=1709408936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HI+Exdzy5hzdAFvi+HKq0NywESzq2Gp60MQfNaJQ50=;
        b=Kg5rrFu4QRHIkhm1Ri2Zi7ScXCbd55sPdTNJHxZi1wKFtlS+clcROHEP574pGGhe/A
         mLfAd63JCTpxmQ/lvqSsLBeCmmdgXD1uAN8jbR5k6GLJEgqn4Ki//k7CKzIGpOgv1oXQ
         pxkXOhaTMnpQB2LRp9YumsJbRoYPBMCZhMsv2RKIBiWyUfMJ2kJCIl7jKSSxMtN7qKRp
         ocTsb8uNUNidnYYWUwqNKoVPdjHdRwigsMqEJUEpPHpxeShZdIHdFW5AWTghZbH7Bcge
         +FTWLQP/JGj8eADbunoJcR/1xAAqeUlZu7Obd6nbsrNcB5s1/PT7VjiRnw0nB+/V4kuf
         hUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708804136; x=1709408936;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HI+Exdzy5hzdAFvi+HKq0NywESzq2Gp60MQfNaJQ50=;
        b=GqbG0u8cPw/Yyw+v3YmsSU3P5VCPn/HWBqscow4dx2GwUP3djeEB+wJhttVJAMT4TH
         9qLZ6qtkJ1Y1Nz/qbPTxkXdhw8A0L8UUCE6hKX/vD8PWw8Wuu9MgUg23aLFYrOrk9Qyh
         9KADvKUW4Jo7sFRAYMcTzAfHBH8/kJF2bxQpa/1PqFA8PnxZZMUT39xnGVjKQVJZ8Wkb
         tXft4qbmPse0Iz1/ex3IDrcTTCFOh7u0xZn+O6vfUhjKJmmRJwjIfstONQJ76hriuUOV
         vbrcC1SaAdmkT1t+Edj5Y8z/oSbGCu2uZ3FaHqqGGAIyHufa5T9yOoNR/pd3FABnP+Sb
         Y3yw==
X-Gm-Message-State: AOJu0YxYVuLVZKBZBYvMwsxkz+zSneDCvGhsrZZWM++MYmbPHBK+c/uf
	+GJ58unNdPf20a73Ww3gePMe0DSdDsGYaMLGzU+18FL/2V+2teJxt+zgWzq4S/402Fj6Qvq5ZAe
	I
X-Google-Smtp-Source: AGHT+IHznaZHhyFYrEFuVlODjzzNL9bB8TFiwaEwOgAbkYI/ELBvftBoAVpWfzKO6q8S8cXmvC7d4Q==
X-Received: by 2002:a17:902:8d85:b0:1db:3ee6:e432 with SMTP id v5-20020a1709028d8500b001db3ee6e432mr3553918plo.3.1708804135793;
        Sat, 24 Feb 2024 11:48:55 -0800 (PST)
Received: from [127.0.0.1] ([2600:380:7472:2249:6d10:d981:9c6f:5d24])
        by smtp.gmail.com with ESMTPSA id jk23-20020a170903331700b001dc35d22081sm1345691plb.50.2024.02.24.11.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 11:48:55 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.org, ming.lei@redhat.com, nilay@linux.ibm.com, 
 chaitanyak@nvidia.com, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20240223155910.3622666-1-kbusch@meta.com>
References: <20240223155910.3622666-1-kbusch@meta.com>
Subject: Re: [PATCHv4 0/4] block: make long running operations killable
Message-Id: <170880413470.87395.815710230750676322.b4-ty@kernel.dk>
Date: Sat, 24 Feb 2024 12:48:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 23 Feb 2024 07:59:06 -0800, Keith Busch wrote:
> Changes from v3:
> 
>  Added reviewed and tested by tags
> 
>  More formatting cleanups in patch 2 (Christoph)
> 
>  A more descriptive name for the bio chain wait helper (Christoph)
> 
> [...]

Applied, thanks!

[1/4] block: blkdev_issue_secure_erase loop style
      commit: 5affe497c346343ecc42e6095b60dafe15e1453e
[2/4] block: cleanup __blkdev_issue_write_zeroes
      commit: 76a27e1b53b94b5a23c221434146fda3e9d8d8e0
[3/4] block: io wait hang check helper
      commit: 0eb4db4706603db09644ec3bc9bb0d63ea5d326c
[4/4] blk-lib: check for kill signal
      commit: 8a08c5fd89b447a7de7eb293a7a274c46b932ba2

Best regards,
-- 
Jens Axboe




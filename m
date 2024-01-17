Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61323250E8
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526262; cv=none; b=igXij2uOJzwGpdDjyOcccfOS8wgFcHW4DMqQgUV3qzGEjG1Pkdr4xbyollHoWzYklRnaIF3aGHngOI2+9XqJDr5WxRNr0wtRNamM1aF6iNjsDwV796rnMbjFwU87zTKUXnV85KIVQZaOxXEy49u0ljVj9gz2Xx5Rx7NIt15N7K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526262; c=relaxed/simple;
	bh=Z9S2zmPIP2pOjE0zkpNpk06T0GzEQd7sNOcKhQ6U4+Q=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer; b=RwVq5n1tJqcoBWXRqzBm5BHa+42Jx56WWkxpebPilm54iQQvW0NcY+QQN6O0cWXqZfmh8GV+u6tJEedJ8i4lknYnTU8ByHccNHSfYidhArkEMjihb6mye1uKDI4K7F3tavenRC2IlBIcvI5fnu3fF/7MibXlKWnpMdLJCDstTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KoiBJo9I; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KoiBJo9I"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36191ee7be4so2133165ab.0
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 13:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705526260; x=1706131060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUtaJHaFz5g9X8efOPmknzBLjxvid/VXgFFlAtjSCR4=;
        b=KoiBJo9INF8YRYwkyZ8m9L22+DUNZYg4pNingB5HxUP/j36jgnNHlXpxwbdX54j/TY
         2NOeWCjFEuLETdHFVPfkQjOkSwyWaEJ22ZQQd1fL3BnebwZvD4ySR2Dad3Ze5gGKgjmf
         lT0ik1tECL3B0woF/km+vQAw/tFSWrJoGzUGqTIuyHDAtXq05E0EVEwm5W8tte9mnBYn
         7HAndutTrpmKAJPEGxke5mbams6Eqm4mWRE9cE0+rluzhyY655WDVrOG0u96QWLjaQOg
         7ktmxlZNFrnOkKkZXjU6a+b1RtP3Mk3T9gR6/YHbD+Ix0pcqYmwjgzxJJDcGj88LhpKa
         iu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705526260; x=1706131060;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUtaJHaFz5g9X8efOPmknzBLjxvid/VXgFFlAtjSCR4=;
        b=NYkxSfYV6wAd/kpKwE0YPbRLgb4al06CNZJcSokq1stk67o5YsaEEYwVCghZp7wRYO
         xtm5U2ARlDIM+ir6uXXZ/DSaS5Wd3Zzlr3TdSzyP5n2nha6JEw41W9llslIVrmfQ3cvI
         r4pb6Kd7/nxURmW3MhUv0dTn0X0VhqyFUoUH8mSOFmbRzxhiWmSmDNdAyhcNXSmg+1lx
         Z+KwI1gG+O/CyTTEOn9vtvqjK8e0vDFjm5874Y/tSIrWZE32ogmZA9QNGXGD/7qA3L8N
         sx5TVTWPio4ftF+RW7t7+tOgjv4aPDNDmzKGSXHprI7Wxf9WQhC/sIiPBIxJ+SWn3gfY
         JX4w==
X-Gm-Message-State: AOJu0YxP96UvWgw7bZxHM7HqCieuL0B+EMQkYsgzikXQlbIUVlL93bym
	UxJ5NvMbt923iSsfwGJIQhUrglqjsH/1pQ==
X-Google-Smtp-Source: AGHT+IH+hr2Sg/M4xLCoLDnhDOs+urD0NDUq4b30quqexflX0lWOo13G4TicGUn1h+hiE95t3U8paQ==
X-Received: by 2002:a6b:7e01:0:b0:7be:e328:5e3a with SMTP id i1-20020a6b7e01000000b007bee3285e3amr15468586iom.0.1705526260489;
        Wed, 17 Jan 2024 13:17:40 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o27-20020a02cc3b000000b0046eac0c0962sm432260jap.75.2024.01.17.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:17:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Gabriel Ryan <gabe@cs.columbia.edu>
In-Reply-To: <20240117203609.4122520-1-bvanassche@acm.org>
References: <20240117203609.4122520-1-bvanassche@acm.org>
Subject: Re: [PATCH] blk-mq: Remove the hctx 'run' debugfs attribute
Message-Id: <170552625981.758567.13088289174135483616.b4-ty@kernel.dk>
Date: Wed, 17 Jan 2024 14:17:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 17 Jan 2024 12:36:09 -0800, Bart Van Assche wrote:
> Nobody uses the debugfs hctx 'run' attribute. Hence remove this
> attribute and also the code that updates the corresponding member
> variable.
> 
> 

Applied, thanks!

[1/1] blk-mq: Remove the hctx 'run' debugfs attribute
      commit: 49e60333d743ae32db3bdde2f93bc818482dd741

Best regards,
-- 
Jens Axboe




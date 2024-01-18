Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E720B07
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591294; cv=none; b=nxykrIT7Gk3OwCVWLTgznMXDSukKyTimuc2yuVAZUQUQztb/waZRxKM0/NKk7qOGxikyXb4T2FmVcYHVKxvLcoXLVm7Kfl8rtlr3UFcmw8zHIjP2CLBwXWaV5/s7Kd6/EPb0JemsR+yIUTfZCUs4YcUN5KTBae79gWnGP7bNXv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591294; c=relaxed/simple;
	bh=nHY2H4qZ70M06IbJgXL+mh1dOxF31u6zQs+MBaMqFF8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer; b=AlbdB/oU7NtZ/OV1qWCV1cLVlCynfxoUd008y+mDR3EHMKOb302OzIw9t6vie5rK+IdOTWa3amolk0tK8dPjTOqLG/tiS5dRy0KmECNJwrIywl31259ryghes38zLbjr8mnk+rtVICWKQXwzQYPsIyBh6QoLPCp8tlnejDuc7pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3TKXrvdF; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3TKXrvdF"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36191ee7be4so3170955ab.0
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 07:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705591292; x=1706196092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Vj406VBQBP421CwVVlFdOXwBadhTGvoDsY699rjci0=;
        b=3TKXrvdFyERzadON9o3LeYSpPx1hRH243VMQEEo8GK5NVaBYt2n4wt60jCuDra0TNA
         eG0IlV2DIP0VwtRLm7uwudM2cI8Lci+ITHT9Ajf1d55pZ81cLHDYNAcWrjpB7H+krPES
         dM8FwgFqLWcy2DlpHv//zYAVGeLtLejqQA1V3TuENzgtU5MbXfXP5a8QZqv9n6ExM4ja
         qtqP3aNyrK1uvMbDYK2buxxtherrfJ8pskAnK1iAukEGVKOnYvuX/um6JxeL5FqMfhDQ
         MTIxJ+Z255cJkxrwIUioPxLR28AvpcWei8B0Y5GZhY7yZoqbr5/QjdCotLhU9kBV46HE
         5Uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705591292; x=1706196092;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Vj406VBQBP421CwVVlFdOXwBadhTGvoDsY699rjci0=;
        b=hLivGh95noyi+q+Eg++MGn5PFjEzpsiFHpf0QCP8vjpK8Pgyyh9SP3I8Tzaa8sgR3E
         fYtdvt8sFYMT+WZiuczeWWs4EYo1cIma3e+r0ZRytN/sO+aaw/haZg0NfKaNLYeJ3G/M
         mRdOrp13CWkmzp+hRsTMZyZiO7yqH3s4JQUhLU3WMclTxkOplkpv+Dr3p+Z5eQ46yElv
         aN2o7ZJPkLHGpsoOikOROsMXqv5gWKf2s8cURuYcnw6sg+MuKMB3Xsd+/EtrKHGJGIpI
         1GlUUpej1C1RBJUvRvYrFYweQVwEj0DhNHpOjzE95ahGotikHNRMlCOMY3+rR2Po7p7g
         ciWA==
X-Gm-Message-State: AOJu0YzkY3z0Ufx3CtG9bmZoK8CYZDosydHZDBv17K2LXP1JrOT6/aW0
	FCmil0prxmNFVzg3Hobt+KcCZMVvFuFCoC/JkmQJuwWEOOcZhj+fn/jGAcSPojY=
X-Google-Smtp-Source: AGHT+IFkkMB2jwGOsZvQjb8QBB5LeF/SJeIxo/NVxeAS7b9UoD+d0eANohhQtP3B1gjOGidA2wDYwg==
X-Received: by 2002:a5e:9747:0:b0:7bf:35d5:bd21 with SMTP id h7-20020a5e9747000000b007bf35d5bd21mr2142003ioq.1.1705591292064;
        Thu, 18 Jan 2024 07:21:32 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n26-20020a6b411a000000b007bf2dcd385bsm3129897ioa.5.2024.01.18.07.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:21:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, corbet@lwn.net, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <a86cfdc8-016f-40f1-8b58-0cb15d2a792c@arm.com>
References: <a86cfdc8-016f-40f1-8b58-0cb15d2a792c@arm.com>
Subject: Re: [PATCHv2] Documentation: block: ioprio: Update schedulers
Message-Id: <170559129037.861386.11416426652561854463.b4-ty@kernel.dk>
Date: Thu, 18 Jan 2024 08:21:30 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 18 Jan 2024 09:29:56 +0000, Christian Loehle wrote:
> This doc hasn't been touched in a while, in the meantime some
> new io schedulers were added (e.g. all of mq), some with ioprio
> support.
> 
> Also reword the introduction to remove reference to CFQ and the
> limitation that io priorities only work on reads, which is no longer
> true.
> 
> [...]

Applied, thanks!

[1/1] Documentation: block: ioprio: Update schedulers
      commit: b2e792ae883a0aa976d4176dfa7dc933263440ea

Best regards,
-- 
Jens Axboe




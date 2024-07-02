Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDCC15B995
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932337; cv=none; b=OH0NFICK7Nxj1BsZXHRpv+N/+ilNVYUgzIrWxkJLaPlnK2xL2uQ4AFV6RcLytS9fI8Axbd7iDr8nfKjieDaIVgYp6U0bNoeqap5/byobmct8ZowjDjReMXwCupCYZGsESTWIs6jCWxKQBJsMriRUUlCzFYUAkkePDam6/fS9HuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932337; c=relaxed/simple;
	bh=nbhLAnikyJsyO3UO/Jdya66pjvoJCEJ3TWMvR6Vsis8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WrHrtWjUpM8pG4Ae6SrQDb5BGfL6QwE7p+I8M3u+OLFER4QUp5/+HvjaJH9vbgGNiA4Gx4TSEcMwj57W5rtzQ3F0rUOO74V+xoaDudpO6e3Y8fpRDL/SpqJCIyrBH7HUrABDsfR2+UDkcmSlVmuHD//3sElZgr10QG3DgJGA3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hCcqVnBs; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hCcqVnBs"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d56102f134so209576b6e.1
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2024 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719932334; x=1720537134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLJvrCKp8MLcu/+RMIXBzlT9gAnXUofdIoGhevdTams=;
        b=hCcqVnBsdKTcbM7lQFPqC3y7fvSM0xdMpQHvaRVFraPjxL/9igZpk1a7ZHTv1l4GJj
         I4N9ynd0ReVfmvrpEYEKhO7ugclb5PWXMDVfBAef6ZWRBFP3gDZN1aFNKkcsqHhIQGJ6
         KeK5nwG7aUUQxXOZPPwJ1ag+OHTVijfaENIA1skbVv87IywgDO3/5BL7jUy8uGLu2xGr
         R0EJc5Mzx42Bl58HR8JQa8WGyeDlozzK8ZDXKHfNoGL7HdBNMYRY6ktLjE9uv9faQJW8
         KWSU6cCz1bUxkJy8zA6lL3zI9JuBIVqIbfkmWTbTXG138yqVTLpaOyUliv4GIZ/S1f39
         OdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932334; x=1720537134;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLJvrCKp8MLcu/+RMIXBzlT9gAnXUofdIoGhevdTams=;
        b=HBC+qJKd14kt4iCCnP+KtWZPzR0LLxuKlWrn4jFlGJLaQmucPvjYTuxbToYVTu5qxs
         15cDrlaFPFnheCCblyyRpJcfTsSo6fw09CakovcvG2EUnnzA70cwM4csKz4qvLRNdxQD
         YRqalBOLquMHImv78ZvQt8ErY1dQuScqH0xJeXHRRKyKj4IjIVtISaEpoe+veyFfxAk8
         rWsTmD+QG/nRhN7knHsE6k1y/hCvoe6VNwGPiIHtgxHoyJZFNLuT01j4Zl9uYEQXfNRZ
         7t7lyoEo/QFTIvc6LcV8/s4CkFrhWLKpGCvZla6UYoZuYKHIHaaL5D0JhLyC4p8dO+4Z
         /+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXB2Uf0SWdig4e21ytlcbQGEWfHAKu0O8HEqZXOvmMdKkQjzL07EYcpKnVDrH9c+dzy98FXgUBdZV2JJNi51USXgcMcbU1E4WKsQgk=
X-Gm-Message-State: AOJu0Yw7mSDPlV4CK2LQBZ7Lrp3a/e0973E40/FtotjiEsKbh4V3mh4c
	mv754tfCLWpc5+oa85WpjVMJF5eFEy1GIPF2D5R4rH+IRuPq/lrrN/ydmoR7iCxOajw4CjN9Bl+
	jZH8=
X-Google-Smtp-Source: AGHT+IEyS9oKtRMN8bwuH7h258UqecHYDZYqumNvgtOD1xV0BYd67tKCeRFF+kfE9D14plOte1qhsw==
X-Received: by 2002:a05:6808:210c:b0:3d6:303f:5989 with SMTP id 5614622812f47-3d6afcbd885mr9690375b6e.0.1719932334045;
        Tue, 02 Jul 2024 07:58:54 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62fb48ab1sm1698965b6e.54.2024.07.02.07.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:58:53 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: roger.pau@citrix.com, Christoph Hellwig <hch@lst.de>
Cc: jgross@suse.com, marmarek@invisiblethingslab.com, 
 xen-devel@lists.xenproject.org, linux-block@vger.kernel.org, 
 Rusty Bird <rustybird@net-c.com>
In-Reply-To: <20240625055238.7934-1-hch@lst.de>
References: <20240625055238.7934-1-hch@lst.de>
Subject: Re: [PATCH] xen-blkfront: fix sector_size propagation to the block
 layer
Message-Id: <171993233260.107674.762169022819526197.b4-ty@kernel.dk>
Date: Tue, 02 Jul 2024 08:58:52 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.0


On Tue, 25 Jun 2024 07:52:38 +0200, Christoph Hellwig wrote:
> Ensure that info->sector_size and info->physical_sector_size are set
> before the call to blkif_set_queue_limits by doing away with the
> local variables and arguments that propagate them.
> 
> Thanks to Marek Marczykowski-Górecki and Jürgen Groß for root causing
> the issue.
> 
> [...]

Applied, thanks!

[1/1] xen-blkfront: fix sector_size propagation to the block layer
      commit: 98d34c087249d39838874b83e17671e7d5eb1ca7

Best regards,
-- 
Jens Axboe




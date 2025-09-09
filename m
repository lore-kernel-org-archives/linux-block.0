Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667C7341678
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425093; cv=none; b=IPOzSis+T3zRHRDcf1kvoufv5YvzibxdAD0n96wr7GJJwmweuj0EE64BgC+1TE0FaiBAprvukSHye8JTkwUHPI4NLrFayvXdOOVE91lpsY/zCq3IN9y4hCpmMwgMtzpa+5hVE1GPSaunUMVPEMzEHA8x9rdWZ5/T3HMlgil9f5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425093; c=relaxed/simple;
	bh=gK874XdQA6U4stMJoJLH0Lg5VxXGBRxWxMsiQUN+SwI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jJZCYdZzO7gkpSLuH2XJ7CPWlWfG5FKV4lXfhYJSVzXslrjcdBJt5NxmvPPt7Cg0FD0rF6O1aK/oLwwaOy3Sb2hdWgzR8Z2h4+OYLMEXLj0chiEFWsd6tfj2DznHj0cF5V2bkB0W1j/xvOJVm442iSgRckaZnA/MhYktrlZjl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nx/+IL52; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nx/+IL52"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8876de33c86so342393439f.3
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757425090; x=1758029890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZuQ+E0F1WqIr3Cf2fQWKmsh7MoaopoToNCjwW361c0=;
        b=Nx/+IL52JXvi/g8s7izrGtzpkw/6/cv12hO83xrwCsRIv7myro87GwNsaEhF3rhLs+
         JSYpBJSbTHQPULQQZkCp0BmUXOj9Px/OGiksPE/XBBl/4+v0CnvveRtfpww9+/4g+7NC
         +QE7qLIXQ6GbxJzc+jov1Vsb199LUnTkjucAj/udOw9MENyGWMN3x3EdzYO+uT8+3b20
         Hu33DtpMqB4St02c/0b8HcUnDX3kyZtf30lfvVOQg0M9/yiQWBOUnwLUbzFIXOg73zCx
         tpeNcSBZRlngTJ3PGwYBv6LcsUekqI0b1OfM0Ik5+onEwmwCAN8wnxkuIjsVirLq7GCS
         QZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425090; x=1758029890;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZuQ+E0F1WqIr3Cf2fQWKmsh7MoaopoToNCjwW361c0=;
        b=Zec66ECboPkcxNoHJ/ZOSgk9cOT4jbzQJ3UPQLW0zFuzBkX7G33D1+oHQgSLb5aVTW
         L+dQXrAray1omQLmtTChS8WjJsVxcnHnUhCy/gHvA47RLxcKLaIhgYU/wWkhkHbFLL9U
         UnNaCIJHhSQdTseCTt9Dlab/n86k9N/7bGlbJchJaOGAn5xWkzuhs+P3At22/EFPV3WM
         DhqQiWiuDJq11XH8/zy6Of+Q11u7BSF2gDnqhl652UmtRTJ7rKvNAU8EeSOzGmM8hOrb
         khhfms1Zqpk94O0ux4nxQGcGLxlChPmhtBpwCXCrYvvDdaulWgFE0PSwRPboLywmL/oe
         D7CQ==
X-Gm-Message-State: AOJu0Yxw+l1ptctHRg7XHTMReQOz02ati3976d/KXOGQyD950BT1XB/r
	C0IRqww4Tk4OeCReD0bJxW/B27a1rV9061Sg9dvCUlhXIztJx4MCnfTJ/tH/UIHfFAJH7F6XiKz
	fxpCh
X-Gm-Gg: ASbGnctl9h5MoWIpsiiSaQ+wwjq1tVAOPqzPy0/mj4S/1sDzd0Gkl6nlEPwkLL+o9BW
	eenxW/iFm9TtWBuAheCxDc+tIfjBs3/iLg9RAMyzzYNo3PB9haXwRRHb17VAaM7F5+3UEm6/tGW
	BEEt35TGJgkLrA6nEDbjYc79Ybz09YDmv2OstcWsyiwOrDG53Og5O4JWkgh4CeA9079w3//0sFu
	NOFbCNVi7L0Sa1Lv/6HD+BRXZM1x+6PF6sC+nxNgacQslYl0P9KzxqkQGaOuV1VeCo8+kjYPoQE
	s97FaWSUe4B3pymg+SIf2Ed/cp2tn67hy1OUGPGUE9/PQJLaqVunfLk5c2Wxc+UyYslP1xYFZE+
	ggEjrRZxoRLp85g==
X-Google-Smtp-Source: AGHT+IGIPYXpVD0wJ7a7RLw1dwHTmVFa6LlUuAHQLARK6o01pOHkHgu1tkjHdAXvjQN2TXv3z2K9Nw==
X-Received: by 2002:a05:6602:6d8e:b0:88c:3adb:2825 with SMTP id ca18e2360f4ac-88c3adb2b1amr407196139f.6.1757425090432;
        Tue, 09 Sep 2025 06:38:10 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-889b504830csm265234239f.26.2025.09.09.06.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:38:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20250909123310.142688-1-ming.lei@redhat.com>
References: <20250909123310.142688-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: Document tags_srcu member in blk_mq_tag_set
 structure
Message-Id: <175742508976.77274.9298690626177411980.b4-ty@kernel.dk>
Date: Tue, 09 Sep 2025 07:38:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 09 Sep 2025 20:33:10 +0800, Ming Lei wrote:
> Add missing documentation for the tags_srcu member that was introduced
> to defer freeing of tags page_list to prevent use-after-free when
> iterating tags.
> 
> Fixes htmldocs warning:
> WARNING: include/linux/blk-mq.h:536 struct member 'tags_srcu' not described in 'blk_mq_tag_set'
> 
> [...]

Applied, thanks!

[1/1] blk-mq: Document tags_srcu member in blk_mq_tag_set structure
      commit: 199c9a8d26638845f509b76e3c176c27e7baafd7

Best regards,
-- 
Jens Axboe




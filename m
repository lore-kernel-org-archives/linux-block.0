Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794757376;
	b=KGXcY5CcoyAUu0vO/GVOwy9LdOH3C5rUaaroSc2chXuad/nz9YZ7JTZjeZNHMhfopxsM
	 Ae+uAFSlLHZ0wdApLjK2nRiLz5J9aPdJM9LHfZowvqxwFS2HkxkA2oVoD4ZbzW3Xk50N/
	 bOkGTAdJkvbkYDVEtU4MsT5ZXMdr9s8BwDIT6lBSvIIGJWqlttgDnczZm01aruhWOcht+
	 fRpTK3I9yw/7PNQ9YRHkYzhCveAa/S4u0WlLSpw92aUxKhtzVWzwvhaKYS+6PFwpRXp6H
	 r92eTkm3HqQO/HEEKHQG9PPr2dnCGzrcAE0SX7cDYi5TNr067EpJMFvanPRnkRgW18Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794757376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=DejR3krB2UUOuNcnZkNWRCdn92MbyftYbWjEZOleI5Y=;
	b=Ido2VVNp+lNocrvo5/I17+WQ+BIzT6cCMPUcB5sqnxvk/RNMOPuc4YdBoLSDnQe4JgdT
	 ZKaEXyBDa8UnxnEMIcz76/jaiVsw/FleJ6hgLuDuvfeudRjlv+JOLcg2cCoa+T1pPqkF7
	 G8qdA/h7Fwog2bHaLT6GqZyb63V/kn6ZZQkIBIYvDBr/X1b2Ii/8NGwYbyJC8W72luan1
	 nLMKEDtPnzG1F/t3+KtkbB+kqh96Ay8T6DS6qKbTugYG2CoKPNE9XxcXQ481lhUNyq+K0
	 49sLlU/H/8jFORRwrpR9d4nPJ6u2jlUCZh7WquhWsgCdPvL4uAhvJ7kwSeWu6I9trgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bqsx4zwI;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C6D606A330
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 15:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9C6D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bqsx4zwI
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36dbde64409so3890955eec.0
        for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 07:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794757375; x=1795362175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DejR3krB2UUOuNcnZkNWRCdn92MbyftYbWjEZOleI5Y=;
        b=Bqsx4zwIkginSB1+zS+iluuGCfsoh1lrWajyafASq7xICgRjN0kfnmGca15hg2kFDO
         zGLbMdOzRdMez5mqA7M6NRrW/2rPqwFQRH59SPER0s+ejRC3ZatkxI1kQhoF+C2f9eLs
         hTf8xRi9NdWyUvE9Hsl0gNkRYU5b1VXB+zpTf2a9FpwTTIFXT8dO577Krmi6HQs5l0UY
         gdYwSFY6GxIxcxenzWpXUdgNsVAS+GG/SAOH+YwLn4cIH8oMz99cTANdyFo+7A3V/CmP
         bQWbxa+vZv5LF+BswRa7OdGybOcMw2STtXJ0u3oEhiIyM+U9ssnyfUhDjfFk7rrQl9iD
         Z+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794757375; x=1795362175;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DejR3krB2UUOuNcnZkNWRCdn92MbyftYbWjEZOleI5Y=;
        b=Zs/k5z291mgiFXkQNjgC7w78ZOK7/fP4Xpl5X+iCxfgk+t7C0GKFyFzLg9hCRPxJef
         Glv0sshxMnL9abpUT00YcGJkemssHI5Hd6BRQYyb0MkdvEcjrcd9iLyjamaIGPE99/gk
         5Y2KOH8tRiTWvswFw2AMltkDlGfbOLljg48kcvMq87VPZt0xkzaFxc1j6TWGnLeb85hG
         KwcLSYHhwvn2LKxQri+YtdkCJAN+V8ZcvSGVOT7nU/nFfCagPf72NTEawApQtNoHhU4e
         0gIYLJut74eB+KJhqWNm72g1wt8KTxxtLjSYpddmOpkcikD0YsjpK3p3T32XOLBWP4ar
         7pkw==
X-Forwarded-Encrypted: i=1; AL+hErHp75mLSASqHTmiMS+KpvFeMK1GE8Yyt8zJrH+RvRr+xJ8a0AzkgUrlgnNHBfWVhTYzjP0Q38aTiaOYPA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+eMuYZLXLYVXQzTk2Sa5lH0YQ2YYIF9cB8J3tBo8P1q4mAk8LK
	T9KiD7ucxNTA+eu3FxJcKbtM/F0zXhMyv7BHL2EVx2jNLxkTxBFmgqfAzK6/MY/GXls=
X-Gm-Gg: AYBFou0dNVYZVVdMaW9QqE4Yi/teC2FIlZs5+DhxSz1JIhRY2q8bWab5TyVC6jWoTwp
	O9L+IbF3qSZnJqro3nID55nCajSit96mtra/CMX0MnOagpFy803QTxXdUYrXxZ5wkNv+kCPLtKx
	e/B1s4ozBu0lPkUWfA6rA2e4OVGmlOwbKOfDTS7LxXLk39p1gX2fmzLErgfF7JNzjhAqAE4gFrb
	T9tZrt5OQF7NHJURLvMTCVTFOgf5qpSDGJ2FaaKpcUmRdXkU3pDyFh0hPkz/MZMKdkyCGAaxYqO
	4y8I5IeLYWHCF0zDFZBXlpM2f7yDRTJh53q+rtTKaBlYsr3JkEo1XKJLPUFedkZE/yt7l5O50DP
	jSXlbFZdi4zlTAjbSm8PUiGF+vcjxhsjf9gsx3ldFt6KWx2eg+avOrleakN9bhc+T/roIQQ9M9+
	fnUAHJHU8YhP47mo0fpRZzc4fag3V11vT5OT8C8rh2ChLh9hD1X7ysMg90U5IyU7xFmHbvo1A9Z
	iQdyZ6Ob4vUYTqfhEuiFmFeU1LFAxPp2L5tIZYQTWDUZd12VcGakUa4RGfBOfIC8GTyKyqAIKf2
	ieMpkSL4iNXZHSquXJTsyMCli6/GfzyHxXMUR/rB4wRCZBiKMQ2fdZsOvqhgu5mhuiFwMjJDI72
	2yHSqxC5lI+M0
X-Received: by 2002:a05:693c:69d0:b0:36a:15ee:c20e with SMTP id 5a478bee46e88-379675fd90bmr8136632eec.33.1794757374739;
        Sun, 15 Nov 2026 07:42:54 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379558231eesm25665134eec.12.2026.11.15.07.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 07:42:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: tom.leiming@gmail.com, linux-block@vger.kernel.org, 
 shao.mingyin@zte.com.cn
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261115003352168cE_tyVxSyZV124AM31htL@zte.com.cn>
References: <20261115003352168cE_tyVxSyZV124AM31htL@zte.com.cn>
Subject: Re: [PATCH] ublk: dispatch the next fetch after a batch failure
Message-Id: <179475737404.32615.15503411123776192792.b4-ty@b4>
Date: Sun, 15 Nov 2026 08:42:54 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 15 Nov 2026 00:33:52 +0800, shao.mingyin@zte.com.cn wrote:
> When a batch fetch fails, for example because its provided-buffer group
> is empty, ublk_batch_dispatch() removes the failed fetch and returns.
> Pending I/O tags stay in evts_fifo even if another fetch with usable
> buffers is already queued. With no new I/O or fetch submission to select
> it, that fetch and the outstanding block requests cannot make progress.
> 
> Claim the next queued fetch under evts_lock before completing and freeing
> the failed one, then schedule its dispatch in the proper task context.
> Marking it active before dropping the lock also prevents cancellation
> from taking it before its task work is queued.
> 
> [...]

Applied, thanks!

[1/1] ublk: dispatch the next fetch after a batch failure
      commit: a6f37fb3f5747bb7cca5cd6630dfeea4435022a1

Best regards,
-- 
Jens Axboe




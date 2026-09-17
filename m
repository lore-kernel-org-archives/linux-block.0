Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F14F3ECC;
	Thu, 17 Sep 2026 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665515; cv=none; b=H2W31xfSeJCldsJBSxh9a/wumFZtnwI+yhGKZsR/qeTuRoqL10n6JMF9fAiZVP2uQpm4LAR/mCb9ud2ugg9VBV+I68K4My/Fzs1P86OAfYRzGV0jvyIw2HZqtMcFXui8t+uaYIgjJug/uczVimMM+r/yvtOW8QD8dI8V2jUavZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665515; c=relaxed/simple;
	bh=lk0SDPjUq8n+EkW8aP+t8iENWednLBKvqT3m1egQ16M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P8xXxD2J1+xsKjizm31xdUMGkKgfQv/qnhxC670jy5C5hJ6D8BP9e44D82swa9JbxFevcFJ07ybqbirxIhEW3XPVN41VpDRbYIBXl9+c7o728v7EcJcmESTkbYB+R9OrTpwzGqruOZO4cCCecVAOmQhyTAxN4NtfwEZZtAt/dxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzZ2yZkp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzZ2yZkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53CC1F00893;
	Thu, 17 Sep 2026 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789665514;
	bh=lk0SDPjUq8n+EkW8aP+t8iENWednLBKvqT3m1egQ16M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nzZ2yZkpiNXdm/rdS7AgJ/W1oQ5/Yzxg+QCWfjdB3JKpI6X58n4MiWC/iheshFMnr
	 x1P6DxS2l8gtw9dlpGoTEDYzfeo7S0NfFkhpnzErnd9OLg5yGkeN/1AGU1X/RTY67b
	 sTrs6NtAy2pHLogyQynOq/Vyobwu6zoJEpUBqYSvM0+Qz334Ym2jSaQFJvWpxsbSdv
	 jSNASBPJvBaj5rTIZVNxZFm/zqdweGjEmFWyrl581XkYapCBJOUNlmUJj4o8eAd0vX
	 iQARzPnCFesAp8uGDuXsGW4pMek/pJalTBK1wFsppDi19ZUEzye6a7dP0Ljq/KaaqD
	 f7JJ70S2Q29yw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Malte Wechter <maltewechter@gmail.com>, Boqun Feng <boqun@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Malte Wechter <maltewechter@gmail.com>
Subject: Re: [PATCH] rnull: configfs: add power to configfs features
In-Reply-To: <20260917-upstream-v7-3-rc3-v1-1-d0b620bf82c9@gmail.com>
References: <vspA5VSGRK2smvApi6HxKjwbOdC5xDyBIiK3BBM15J9CmbDQqwlg3zTY65NQeOzOWqle3sY-izGdKuXtqIMAWg==@protonmail.internalid>
 <20260917-upstream-v7-3-rc3-v1-1-d0b620bf82c9@gmail.com>
Date: Thu, 17 Sep 2026 19:18:13 +0200
Message-ID: <875x034x0q.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Malte Wechter" <maltewechter@gmail.com> writes:

> features displayed by configfs for rnull was inconsistent with the
> actual features available. This correctly exposes `power` as a feature,
> which is also consistent with the C null_blk driver.
>
> Signed-off-by: Malte Wechter <maltewechter@gmail.com>

Looks good, please add the Fixes: tag.


Best regards,
Andreas Hindborg




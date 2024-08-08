Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0AC189BA0;
	Thu,  8 Aug 2024 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107803; cv=none; b=kmu5dC9kfAW15BJ6Jn1fHOT5aNsuT0+2qQHVB5hm4t7NcZxH3IMf/teau/a2YH2SEjaodWMJo6JKQtWTEmF0TuOuX7Fhc4vChu16duy/G1c3K8318BJFD0WF/+4gy2V2viW9K4YpuuJ9CJlmGiwDiz7QM776n/V/kGmKt4TgaF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107803; c=relaxed/simple;
	bh=2ChP9h6uvmcLLnCbTjZZ0+YBvy42YPx8xhOigoYtrO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpiDyN1b7cpbTgf8EC/PNGeyO165d43Q6DQCU2LkpR3/4ZG2x26uoeyE4rs0EWwfns16TuYCq0kUDl817ob1Fw0S1tt6tl6VfIUbCnxOyd4qArmQd2COmrWEq4eUk+PxrJFRywdQvCc11X3wwGX5OIpINPxCCppYJ0BuvNCpErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VyArdnMf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cpHKDo6+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VyArdnMf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cpHKDo6+"
Date: Thu, 8 Aug 2024 11:03:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723107800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/1t1xXO8srYRXGtZtBYUSTKE21fIlSAdIBoEh9+Jk4=;
	b=VyArdnMfM6Ft0V5xk7epE8/UB0F3FKEMT70DZTJHylxo6VX/VTC5lxOw9lSlC83Mxz29Ni
	zJuW2+rb11RlCdasd/K5mnC0j56mZNgamBhlrh3xjC8NA9xTCDrMr7jkGqDNO+yQ3y6iwz
	EQoXnPxMxPaNKHY4OSFe6r7jKtWp9hg761ZJ6Fm7D5uKVJZ0DFtQKSraqk1zt0eRkzNuaD
	P2or1FxPG/HxRESGM9BPiBJZTWo3sC0+czBwlXyb6SwPmsjEcaaaZF12UxDjnoID/rbJNm
	2Nb2gj7ZBkxzv1iFZG49Vhvxcd1MTVnRurRxcwVIEgEgwCh7v44dgSyae7l7Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723107800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/1t1xXO8srYRXGtZtBYUSTKE21fIlSAdIBoEh9+Jk4=;
	b=cpHKDo6+t2vQgs76o3VqWotu/aNi1haMWUtVYkgaX7EB1szHkh8YkjWZZITyff+gtx3jkc
	1slHVbD2r/Jm6PDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Mike Galbraith <umgwanakikbuti@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v3 0/3] zram: Replace bit spinlocks with a spinlock_t.
Message-ID: <20240808090318.OYWITKyu@linutronix.de>
References: <20240705125058.1564001-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240705125058.1564001-1-bigeasy@linutronix.de>

On 2024-07-05 14:49:13 [+0200], To linux-block@vger.kernel.org wrote:
Hi,

> this is follow up to the previous posting, making the lock
> unconditionally. The original problem with bit spinlock is that it
> disabled preemption and the following operations (within the atomic
> section) perform operations that may sleep on PREEMPT_RT. Mike expressed
> that he would like to keep using zram on PREEMPT_RT.
>=20
> v2=E2=80=A6v3 https://lore.kernel.org/all/20240620153556.777272-1-bigeasy=
@linutronix.de/
>   - Do "size_t index" within the for loop.

Can this be applied, please? Or v2 ;)

Sebastian

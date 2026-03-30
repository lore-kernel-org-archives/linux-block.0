Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9B039EF23
	for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905096; cv=none; b=JQYkawOEbrFq+q+7uPEkmgfeXGugq5173iKchrNswPtH3940OFHtBQihB2nT2Lcew39ibeoaNuMm/5EFqovMmKBieajrJZR6dfH8BL4iNJpfbdaobSCfF9YkL9qF7tX9Cjh2e+gkMiWIryiUOp14Jkt3ktg3bZsvabihexHwWAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905096; c=relaxed/simple;
	bh=WuW4P7HIvCgTqUS/kR2NzM6J7queKF9TF23AviiY0qU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrix3Jrs5vmHv7syGOTYO2iqzDQx6LPCyLAg6zK4m2Y4MGBw0s4eTrQbIsMxk58BHzXvJOEhpOfY7c6Z/0TgNQQNAPdHegBHP7+kn+PDww4Mqw6m7+5RbR0TMfAMLI1Oo8sh1jio/cF9iTqOpD/ryix21Nva5WXw+umtMlcNqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKSgzPkU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKSgzPkU"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4873ce69ba9so14933365e9.2
        for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 14:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774905094; x=1775509894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jc4DvY2MQK88Yewja1MkoO8icKiZ2EexxdGEKN37R00=;
        b=HKSgzPkUR6Ga3XxtxRJ6sEmp/3MMmp6aTkjsQEWk0y4gALZwmd9xr3krRCXrMwXxse
         SAnra+o7+prT9bp/EEZSOqV3bMZNMr7qJfnAWtEkomsNbEnhZibtQ3Ukg6a/9JkvITAb
         NqYe+4o9dzvAlIg4W+dHyclzLtflLYFMRTrJNTNiVoEVJbhFq+a6FIIl0nKUGPp3oLlr
         quNk2tN+EMK3Al/+7Ck9WlZypk3bnMmIpaMFiahlCs7jgfDQVG4KA6BaRg1IzabcSQ4y
         6poTSoSeRzBSj+GJnlInp+DuSbhxKAifG+KfgnkgA8Cf4cEZVz/J2RT1Zgj87edQCu+o
         2r9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905094; x=1775509894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jc4DvY2MQK88Yewja1MkoO8icKiZ2EexxdGEKN37R00=;
        b=aSqpkCMxQQu/f/u6b4G1Kt/4NbQdPDvRpkfLtLSjd0Q+7gWlN0/aaSui8yFr5TJYyw
         apCS+VgAVV12/vwqI1/kKgyVg4CDRhxUVo5icgnYovJcr9QaV3IiOshABaED2NYwJ1WB
         KdjB1XztW87OTzel9BUcCsTm/bKQ9Tz044jY30FyOAejM91g+mXhlyRIvY+eVGHuKzUI
         AyjdYAvHbZ3LES5jXZlZRbaZoUwdK5kf/YHPWEkhp/MaChaq3wX7V5sEnK9HNcID+gns
         QQ6+SVInb5hc8ndoX21T+p/Xqlw3njvCJTWbf4zRVlJPwVAz/Xp40CJozxbk/e8rDWPz
         3JWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqFSXmzxWd5GYGjiyTMfHj1qnAV+TQBPg0z1P1zmbmGZDcwjFPd0zTMbDtFu6KB6BKu3cIwl8K7mYspg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9DwiF+2JC0eeTpZ1sOjZPBWuaTLody8ZxpHufPZPRFzHZe4+s
	zMh6NiUUG7yhbDrKNtaRswJCEcAhYTE02s9TJR0jYYR+C+v6rve0i7R1
X-Gm-Gg: ATEYQzxmbT+VC50mwaxUgEy/dV2U2PETebnc700WvCPNG1WCmcd/EGz8AAhEyq/pW6Z
	H979WeEZplcH8sYrcwRB4WyGfBqOoHF7XidfBU4u6WgVNXgiw8aKJ1IPZ3QvCaTh+VGuEfJQ6zp
	RMgB5t5NinNCW8nv5aCiEW7caf4OcUS66c8BhMydT8SxfTgcGgl0pX2wXNvbc42IVkorie30oxg
	yWLGQ7Vnguy7bKdcw0F7/VfZdURnOvJ84OALYus/7nC6qxjJkxdr01hcaJk6DJhUMdW76YKUqH+
	lilpkY34/6fAZnt8eBmxM1vGRf4nZRd+aBcKzJK4x3QmNWbs7EwHx8vOrEFK6i76hSbK1sOlfHN
	55ffD1S1zLfYN1i2VwJvWhjlHN0RGuQmfsvbwygENhA9VLdp6gZTAJSuAZ/26p6OuFqNk7YBRk9
	ZST5mAToxY7afU/G+ePUHBn5XLVd+XGGvjKkExANevTz7DKupT4sGRi4D3wzhy
X-Received: by 2002:a05:600c:1d1c:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-48727efacb3mr225543165e9.20.1774905093642;
        Mon, 30 Mar 2026 14:11:33 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887ad8d58fsm1787525e9.24.2026.03.30.14.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:11:33 -0700 (PDT)
Date: Mon, 30 Mar 2026 22:11:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/2] iov: Bypass usercopy hardening for
 copy_to_iter()
Message-ID: <20260330221132.1e1b1387@pumpkin>
In-Reply-To: <20260330-bypass-user-copy-v2-1-f236179e7fd6@oracle.com>
References: <20260330-bypass-user-copy-v2-0-f236179e7fd6@oracle.com>
	<20260330-bypass-user-copy-v2-1-f236179e7fd6@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 10:36:30 -0400
Chuck Lever <cel@kernel.org> wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Profiling NFSD under an iozone workload showed that hardened
> usercopy checks consume roughly 1.3% of CPU in the TCP receive
> path. The runtime check in check_object_size() validates that
> copy buffers reside in expected kernel memory regions (slab,
> stack, and non-text), which is meaningful when data crosses
> the user/kernel boundary but adds no value when both source
> and destination are kernel addresses.

I thought the purpose was to avoid accidental overwrites when
the allocated buffer was the wrong size.
This is pretty much likely to affect user copies as kernel ones.

OTOH the overhead for some socket paths is really horrid.
IIRC sendmsg/recvmsg does copies where the length depends on
whether it is a 64bit or compat system call.
These go through the full horrors of user copy hardening even
thought there is no way they can ever fail.
That is the 'control pane' copies - well before you get to
any actual data.

	David


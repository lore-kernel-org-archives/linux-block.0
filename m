Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686759;
	b=heTRD+6Yfsq4XYnbgyr1JE0coR7L7erkYYAEVIThBTHkSflneVosboTZhYEsPxzAtUK/
	 kowPvviTRw3UfaAko/84Lt12rR5bd4ESJ+PKh0OjHxoCuQj0rDtz4KQ2lfB98a9Wv8evx
	 gOHsc2mjzSaYNeC8TpfleUywZrsmQ3SVy3kAmtBMB3Q8YJqVwG8aB0N8RnvpVK7GxELm2
	 gQU/5fmR6GrxpQ46WzAxvNY9yrZbws0hW8kOm4KY8Ne+pVjJ1Cbr1HkgSaRDj2OuRg4fJ
	 HPmM43QY32hf45fz4+Cji2O1POnyjzLgzJgtyZ99N6Y1b2lzB/7H4e4dJaLQxnDqFDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
	b=ulQl9RqJ2JqmTNWSxlHKdj3yrhBCqQtmkR4GStwlwRyXuZ9x2ztMYy2h5lubj2koE+BK
	 gckjxR0jFOC+Ygi65utvm3Ta/9y42Jdn+VmJE4rxWVAIz+c4zcCCXiPugPnt/YxIvJ2zx
	 EaWrH6I8QP9f6h1DJCUdDRP+uR8q9f0uWEmA3/GwHVuvaLsgVGseAFKCpxxiBrSl3jZqz
	 dm9qiAbrh3e9agrm2B2snMhbHji57TmPuj4Ejhpo2BC8gjl/4hLr36XrTY8A2lAZQjsAo
	 wiyVL/6zIa3cfNC3xtqZ2TwuGOW1/hbqP8GgecTsY3e27NaTyXJJwTIvWe0OBhrgBAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=t4xxtvlP;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7509B606A32E
	for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 20:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7509B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=t4xxtvlP
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso835202a12.2
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686758; x=1795291558; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=t4xxtvlP4RAICjpBIWPIkESb6EJJVOcRd9+LEytv251d1ZQsfD2pYblwETMOf/zroc
         BDzAo5elUgpAiRA0oYEfExHYSjjGywxztBxThvGs665InMbo4S8LytfXKr2B4Cw2IX6x
         hCl30XcWjOl3zGKKK0Vny1KN9lt2zjyLiPz3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686758; x=1795291558;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=THShNmVyIlCQ+T6VeWpAdm1ayyiSjZ0CtP/U0pavI+4eFVxzx3/4Eh8hQkEKpX7NVE
         XCgbyFB3lsWyOOxi22+x5XrNu7phKTpke/pC2asUwXQF/Lw2LS3fPiA5cDcDVGjzyNgB
         emcuDBbE1tLomvlWLTEXqOEmLEyIRA5Si3WIsvD1/R/6a9ucmCQazHIqUJLUIi6dohBV
         1ZlHWRrSGk5VOFXl5qaUCnszLKIkh7TsYoPsRy/RHMVc9tJaN/vstqq1lwd4khJN7Wdx
         dFduM/Ckd/xEynXBa2NgyZxV+KH6/c7R0yvfkIG3XeWrwet2eXYF44JxT9kPM8ffMQSD
         FczA==
X-Forwarded-Encrypted: i=1; AL+hErGDeegpQEPDD9rj33OMyUTb0zeSLhKWw7epQOmdC5E9Rpi1PjhahT+bSa6/dUeaf7XaFZcMJbjWDXV7rw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8sQ6RlHlluLQUEPd2zIsbpqMMvPJDeqtspRhx3dNos3RX4gXZ6
	7flLbehqoSBkh00xmENHRn+7rAvUScC7NuzRBOtSHTi0IXaaVYYpnXTBHrD6/7P1d9s=
X-Gm-Gg: AYBFou1WmFoImVH426DWzJ306FAz0vg+Qp1P+R52zK2TN5aUzCVniMEizzzG289Aue0
	8QJQj3FZMCVnYiIbeGtdJUQ3Kd1Gtphc+1aptYggQKewSW8L2ybOUBOC/9/MFQtFKaojbk4cNTX
	MzGX2HtClGneexGiP17emO23xaoS7mVkrzpzBh3n4n5YnIYhsjnh4HiBXVE8mIZxtNssfn9meko
	nFxB+PTnm36kslFXL8m5ydWe/O9DLyQKfAzqaOkGFJh0RAQJ5Bvn4oPYnf78GmpFw1yJ7ygNlTN
	h7zcQGSLuuLd6ZqqHdFRjDuzKXhAJ3hpYtJFzprBfRSCubDi7X6tufrV0BHnKFbNuY/o0VSGog5
	ehUyzparXYQ9CFzgzVIXnAj8HU1i3h9K7ZODpaPCdOxeXTb8kclIWSvR43WdtNsdYhwkl+1b4kv
	D2AUakAihFxIg6T1qHD+ykfqRXpG3T/29RHL9BeyB/CyYJn6dRyYWmX2ZEXRUX6D18qFXPeMrJI
	vwZPIlVQAmEwvJiItd7SnRGo9kOJQ6cM884MvUPLglNvBrNx2/YSmcmEoaQYs1h5a6amv8hPUUy
	zstxCU6Sb/v5AHwX0su2cEQsy4+O7Qy9d4yNv/uugjzpLaeiYmc+UT98oKOdH9AxtUcsUXFN/gD
	NMVbVz3Xk2uJQEn3qqwrh4fyZfCebci/iKb/EAfiaByEz6VrRdU3qOgLFAw78GHVMJU9YIHCmbi
	ffDF8iJG8VFB9wMxiC+rCKzVgb1N6hbtjcOcYVJhd8VAZXPUMEWNxKeThD
X-Received: by 2002:a17:90b:3b8a:b0:3b0:9f53:e8a8 with SMTP id 98e67ed59e1d1-3b1b0b5f2c1mr6192503a91.52.1794686758572;
        Sat, 14 Nov 2026 12:05:58 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b266d873sm4654869a91.1.2026.11.14.12.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:57 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:55 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	Alexander Mikhalitsyn <alex@amutable.com>
Subject: Re: [PATCH RFC v2 17/42] securityfs: use fc_init_pseudo()
In-Reply-To: <20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120555.cbfaf8ab8a92fb25@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Christian Brauner writes:
>AppArmor puts a .null device node into securityfs but only ever opens
>it via dentry_open() which doesn't care about SB_I_NODEV.

Not a big deal, but userspace can see that node too, as
/sys/kernel/security/apparmor/.null. Opening it by path works in current
kernels and fails with EACCES after this patch. Now, I don't know of
anything that does that, but selinuxfs gets SB_I_NODEV cleared again in
the next patch for the same kind of node, so I think we should do the
same thing here. If not, it would be good to have a line in the
changelog saying that opening it by path is meant to stop working.

Once that's fixed, please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>

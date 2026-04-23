Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257EF3D6CA0
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916620; cv=none; b=o03vWlmpgkRCK5PFBvNbe3ia+B7mGc+2/vQROm9XFL1b8aRzKdGK3y19i5UC9UyeYQ+CZi4uLVTNWOUA8lK1z8BBhqsWL212Y9U0TJ+WWCLnIzy75PT4Maxu72vPrTpQxhKH2NV7+SSpX84FYNU3mdsWBRMhjJJwxZOLiSN7tzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916620; c=relaxed/simple;
	bh=a9AoCeQw2JwtXkhCFyTFgM24eWJEujRL6v97BzFui6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAZ9DZZu/8BSeNTE1fX0gxFCagdwnF5WXDjGA7U5NXUZ2qbcfdFKKFhw9+vwnJ1XUbUXUmV8q9P3UImSxR0vrLUQa+km6sYrk7D1xDiyFrVKLauG47TqjmJ1c3yFPon1uOizKPpsZ4VWKMuNas9yv6fg81+p2TbDR5QwlsVJz6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdE5LQiC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdE5LQiC"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so76367215e9.2
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 20:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776916616; x=1777521416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vq5oECfG3mPxzGMQdru72u3Y1jtdks29q83CtSo0t+k=;
        b=UdE5LQiCVZ1bY8DcbaInSSHfZpfozE6WK2id6KGhqLJEgWel/M/W6JHmQ90OC37tM3
         B+bitCzYblo6sIAWmm29q/PjG+jsD2lW0G6KBCvUmp+gcjjzNUn8zdVDQFqiKmccumus
         uRU4CrDlS7+7nFTPK1zMTv/G/gn/rnbZm2r1BgtkecTNF4EUCLsKoVxZXAViIXnNO25D
         Hwssju1qIwhOY+kNyiTo8BGLxsbG77F296Gle6Rpdrdp8V9CKwZnwsefipFkwOgSl5r+
         rqKNEceYrfibh9R5yBdB3xczXGszo32Valq5yaE4OhidSXNBC4xqCqDx8mNEZj8O+kGh
         cKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916616; x=1777521416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vq5oECfG3mPxzGMQdru72u3Y1jtdks29q83CtSo0t+k=;
        b=DprArW/vHvW/orDYG+fz6hz9CVhr5P9VgFbj0k0NoFF5ed9u91buHWLiVnNugmAy2Z
         cxvmqO5+aCFbpeZJHo7xZ4ks/gYFSF+BFL96uYeQDdk4Kp0zccTgnsOQdvAxpBzM4rw6
         zeX5pUHXbhRr7rzmuQlM+bv3zOSqoP8fkCuHft29zcC2EiN54O5LKsJfyEjbJrvrZ45V
         Sh7sS16Ckto8ZxhnLkFCWykBL9ths1me8zF4c7JmkViOt8nWwLNANTm4l1hb2EDZXN8m
         od0kIZoou5Y/W9nsjYC35DLpcpciUID7t5Wjt0nMQO4hm5sGv7lrFJ49gyPL5mbp/nKH
         4M4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+G/AIVQpcZHYtqwrOLU3oXkiGLNa92+5RUpZcXAxoOOkOGzfRZsqFS+WkmeOLljoJlg1E0yK+JjXJ38g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsTz+pK2WUo9t8N5S+B+52FSQmvf6GFg7eRGMoSEZoOlhBbMP9
	nLezPE+dhenenNhn1ZLK0BBVKqiaMOwTvCSyEzXfaC/7sSlSRnt2M7ZH
X-Gm-Gg: AeBDiev2HwATnRm+MZMaflshdJqSj+HLfVhK+ByMhqa6UhIdH9XssceCh9wVvOLyg6y
	zrX2MZ1vesPY76K7rHjU03m1CVAaRgVVWBKbMTTXuEde3Ld2+9Nt+TkdW2m/mYp59WHtxf8pQv2
	RUNJlRpWzrhSLpcBSh/r+TF+0+RXIYc2J+3AZmUHbdq69DwCYRAFQkcsotUeqQnbVjJoy2uRedC
	FwcFNkhrpkw8OcVbatLzbkaboXB3Bw9oc0sgxsQECC8LKp41V7Nl1lnD1AxdGWVFRN7zLfy0esy
	fetULIbsjHLKJLwa+e/8Cl6wCrvPFmz1go9fILiIQeLlHg/Q2uWpFwgogzKb9ygQ40a6EerKl6V
	QokBEOYSXurPYkuslsfQr/kl68sHTkNJlWV6vKS2gL7XxV5+uQRariJzNc4VHFi5fa1MdeM0qNA
	lZG5ezuVG4G7BstRiaJYh8NlHlm09BiZFIBnn3CkETQqZjDKyfC70yDkGmTt7ermLiVosymN4Ua
	ZzBtgeEx3FMsvyyRwo=
X-Received: by 2002:a05:600c:548c:b0:48a:568f:ae6b with SMTP id 5b1f17b1804b1-48a568fafcbmr131049955e9.7.1776916616367;
        Wed, 22 Apr 2026 20:56:56 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5c24d82asm38256265e9.7.2026.04.22.20.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 20:56:55 -0700 (PDT)
Date: Thu, 23 Apr 2026 11:56:49 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests: ublk: remove unused argument to _cleanup
Message-ID: <aemYgUX2B1z4Prbf@fedora>
References: <20260421200901.1528842-1-csander@purestorage.com>
 <20260421200901.1528842-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421200901.1528842-2-csander@purestorage.com>

On Tue, Apr 21, 2026 at 02:08:59PM -0600, Caleb Sander Mateos wrote:
> The _cleanup helper function doesn't take any arguments, so drop them
> from its callers.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming

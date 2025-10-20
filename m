Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D6298CD5
	for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978321; cv=none; b=SrpOD+jg/6vY/Mf4pq7ACa21BrqlKp2hrTinzMVpbVoAczTJ60YFsFj0E3IVo83yS2BbOZf3MsrnBajBCd9J49PF7Lj/eYKsAJnZOB2RyVCfUPV8ROVY7p9FW0fTRFdHBoaVu4TQv804Iv1iRqAOe3kngPJZVvgtoKMnYbB/5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978321; c=relaxed/simple;
	bh=bLir0TNzzLo0e9EKWvnHMo4rDRPT9YFUyDhBXMGTO3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dPCifpctUAskkdD3oIg1jVXn6MPCN/4nt8H9FV6o2DpfMVEKYrcp15SJj7rIETFy8wBMvF8+7t4yO/DypsCHETSZ2qBbNlRoR9yyqCY+NEYjCgsWZIpRcMTJ/dtnnD7q+dXUoUKkmb9L+/wvsVADyD5rn4g8VApSq4n2QgAP7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QPNQZUDI; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QPNQZUDI"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-9379a062ca8so192266339f.2
        for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760978316; x=1761583116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61GIboXxOs25s0evX1OKzmkcFyOeZT63Qc8gi5u7/jM=;
        b=QPNQZUDIZr5JFz7+OXN8sGezUaRXy/eFtW3lhRKsnc5h3eyuWkJR0PHISnZ7d1mSRs
         IJDnN06aYk7BORA0lxF692EWKD2MfU8F0vpBRetTQfAmlBW2r24w5vlXVlPEVjq4S2Cf
         orujHsTak8AaHV3ZHcP1p3S/qtdhmKtcrRAOzLPAMgDEZYjgwz+oBEMIsM8l/w/MA7kO
         kc8bjogUgp1EsBgDGizKaPg3XTXtuEP/37EPJX3e+bsSKIUHeCo+ip01GF6druDtuya2
         vZ9dJyUylxO7GbnNeR7t8zMfWe6RFOD8LeAtVN5P2GBDFDPy5plNE1qJ2c3sMVi+ocot
         ow5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760978316; x=1761583116;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61GIboXxOs25s0evX1OKzmkcFyOeZT63Qc8gi5u7/jM=;
        b=NR626QW+UagB23ioFdDQ4kHC86VA0lND6Gjk6KLWYbJgyq0yPdpMEyNwuMqzditbjH
         uJeYB03p7V61rDhPMHK4lLbg3cOZlid5haC3o9aaOGU+Q627zkfWw48922xffGTc+aod
         Y5/IAa1Wq8hx80Recw7qwjTErV5clY2nxR/2W7hCWNU+fQy3Vo7R07Via4oHTYz1Fkq6
         YkZAoFdptrSbQ7GRCbSzerwFyrlP9t9MMQUQ4I+MPErSUI8VYErpHoD4kCBa+8cKIXR6
         BTgcz3Aj6FM6V0Xum7x6GSf4lzIepe+h9LjN55+hYU9EDY6hKyQ+1Jw+xbNwCjM9U4jX
         xEVg==
X-Gm-Message-State: AOJu0YxDG0bNh6SBql2YY/yET1sN/juvuYXJqkofkgpShxm942e0VJfZ
	qySgemzB2UpG97x2XFeJnkM4s0eFagfjNGq7GQ1G0YYZGBLJDa34Lyrl8Cg+h1IHAJc=
X-Gm-Gg: ASbGncuMS/xc4KWuxec2nh+h7XEl1uOn6Qjlp+r/sX/OHYwLdkglXILlMKlfNxQjw4F
	yWLpMWAzBaNPNWaAoAtoKpM2VDJHu9y6LHuI9EhCQaoGT77Uw3pfdFuuvl/Pr5pYlOmMUEjcPgz
	VBB3EdUym9/2Z9WPAdKVoMO2PzaVzWl1AJ6y/dSblrZHIp48VEiWJBUSGMzFrtesZdk2oEXsEFE
	qiLaDgLKr10xvOY/7gPzxLrF/eisUv6cY3LHS2Kw4EprB+89ixLJSyfBVcDjY7Nb25Fd6XfZq07
	9JLhUbpvnFQJOO+asBJVdDWqTtNGOLhZuQKdmw+CtDKnAY8jIoGPSimibjDcxvsHYP/SjsZTl8p
	NMeRypyR/aqASnuPXlcOaR4aZ0O1zsd0cG6wlI1BxP+YDM1I9Tz12ewtElu0YVij302CU5tM5UP
	NNOA==
X-Google-Smtp-Source: AGHT+IEgP9MoSmwcT4IXjkDNqCrTHBFr78jjo89iNv/AbCf70/y5g8JWKMQdHYEnP0MCwavgamCqEQ==
X-Received: by 2002:a05:6e02:1689:b0:42d:876e:61bd with SMTP id e9e14a558f8ab-430c527fb41mr203189835ab.28.1760978316183;
        Mon, 20 Oct 2025 09:38:36 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a97909edsm3088855173.57.2025.10.20.09.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:38:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
 Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20251010080900.1680512-1-omosnace@redhat.com>
References: <20251010080900.1680512-1-omosnace@redhat.com>
Subject: Re: [PATCH v2] nbd: override creds to kernel when calling
 sock_{send,recv}msg()
Message-Id: <176097831454.27956.10406749282595384592.b4-ty@kernel.dk>
Date: Mon, 20 Oct 2025 10:38:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 10 Oct 2025 10:09:00 +0200, Ondrej Mosnacek wrote:
> sock_{send,recv}msg() internally calls security_socket_{send,recv}msg(),
> which does security checks (e.g. SELinux) for socket access against the
> current task. However, _sock_xmit() in drivers/block/nbd.c may be called
> indirectly from a userspace syscall, where the NBD socket access would
> be incorrectly checked against the calling userspace task (which simply
> tries to read/write a file that happens to reside on an NBD device).
> 
> [...]

Applied, thanks!

[1/1] nbd: override creds to kernel when calling sock_{send,recv}msg()
      commit: 81ccca31214e11ea2b537fd35d4f66d7cf46268e

Best regards,
-- 
Jens Axboe




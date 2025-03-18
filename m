Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE5620CCF5
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306649; cv=none; b=fZ0up5uEwoKl2FYv4f+Sgb8T8QkDoMurwBre2teJmvrDuGC9o+G3ItKT+4RbJooHj8gBtuIqKxg3Dijl65kwBAZ7F48C0VNFwue7Ab9qcQej1Yo6jAl04x2KYbK30kLDu2w31dNl/cykQDTQvZpQbo2ZYgQDcpD/w1bf7k0FLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306649; c=relaxed/simple;
	bh=4aOxNB5WTKxv+rx8MjQzRIUtwfdMxkkVXhHdM3W4Kpo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gxQdbnMFpmnQkdWoVRztY+NyVg9IVasqC2R+224Z64sFiq7ekTJCcd9wo1YPpABnbbpOFoQPhidQVs53/BfnubX/9NgabtotxVXrcNB13PI4rvs9TLyVzhoAyHdjaQZhaWOjLMh2PSyNxmmKIKjohsMRxhUYS4OmDTLjFjIDleI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WhSYO34+; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WhSYO34+"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85ae131983eso495832239f.0
        for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742306645; x=1742911445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMGHQtTjpATXcKpAY+aILWd++dsLjqc/A1aDkjcAEOU=;
        b=WhSYO34+RxDuk5Cb0pH9OGwXv4c8IYE0NsbgF30NZXhuY2Yk6TNCizUxscEDlsLU5a
         nqtLV9G2/Txe4xTBP81xoFNwqqlOXrVwLu2SNX/LRquZGx6x66JMuP9dlhGM+aax3oS1
         Q+XLRfSnfW6/cySHOv9gYcc2YwWw0xAu2mdAP+bGAugmG0lkSxhqz0hy2pf74q+6oXlR
         ZYjaBaoJKOI8qXbeglP1Wvh3DaSRmi5OOMhldazyA7+d7aVOjOv79fNbQX30y26KaOsd
         Hqq9VlFME9/a4AqbbvHF9bKOonJrgT8Zk67v3wZXHf/H/XySxsZjfkypAh+tPd3uIWW9
         kUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742306645; x=1742911445;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMGHQtTjpATXcKpAY+aILWd++dsLjqc/A1aDkjcAEOU=;
        b=n1aWhGMuLbPt8Jp/Gmh1rNu6RQ1jq0chpo+ncQXrAqy6Hqrmo3WdZWfLTu+dntbc2k
         8wle2m1qPrKyTA9k/CVC+EzpYMyTmDZ+pcVvegf2RwT4+W95I0qyayKkvOkhJrUlfrwI
         xtQhzjftn2dDV9pEqIBNRznSwlME5hHPt2CM7xKWWyENMaz8vE+xph8LC6uD+4X0Ie7h
         xVN1Aoi2jxEcbFxTvHNLYq9Fu+JPS203kn/t6Mk6JasWLlZBIeT1LdnANT9wZgabj5pA
         3Hpoi9JqWlOeOxdx42/gs9DNp9dSVYTKjWI5StelxM8u4gcWvjF5HSs8WFUkl9KnRt4t
         q4+Q==
X-Gm-Message-State: AOJu0YxGfwpSwY9xKC6tDNfC6ktV/SfxF7i4cpRzB37pf1M73esPEkjv
	0pFrrLj6+YcdWf5Owhs8NFDw9jpm85z1fbU/CQLcWHNz1HmHOwZhZ/wwzhoD4A68JtpiZrMx8fb
	L
X-Gm-Gg: ASbGncuVwr+SwYEjJ/awmCtxZNoSQOszsDglN5JtGmilV8r+LcKI2nzRtcnWpWvz/b3
	621u/Vj3F+2yFrpuc2gBznFKgn5gAtLeJND+r5I/n8lZ42Cmdl1UqCfysNF3Nus9ad2nD/CNOVF
	IyDD75bXbXNbD1NaeCy3mBu5wIvXRkMCSLNnsoPAsDVVDIKS/GhnpKbHPl9AXzWlMtFqTrIouuw
	/VmffeQ7AdLUy8sVXBOcXaBfqVu3tMadwmxvNLyjBNTfpJWCl9EQgaczHMFHXIt1DKVbYWOiZpq
	Hp5J0ozsAEwftEzgt/XQa153BLrz1GjMYRQo
X-Google-Smtp-Source: AGHT+IGyLAZLlLzRZKq9rB0/uawyPNOPfg0FKw8wNRz2lvnr2m1c37UO0VwOBzZmTa+Km7QfJvj/cw==
X-Received: by 2002:a05:6e02:144c:b0:3a7:88f2:cfa9 with SMTP id e9e14a558f8ab-3d483a19d2bmr167128455ab.11.1742306645510;
        Tue, 18 Mar 2025 07:04:05 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a72ce27sm33191525ab.44.2025.03.18.07.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:04:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Kun Hu <huk23@m.fudan.edu.cn>, 
 Jiaji Qin <jjtan24@m.fudan.edu.cn>
In-Reply-To: <20250318072955.3893805-1-ming.lei@redhat.com>
References: <20250318072955.3893805-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3] loop: move vfs_fsync() out of loop_update_dio()
Message-Id: <174230664461.126943.4120567520187908429.b4-ty@kernel.dk>
Date: Tue, 18 Mar 2025 08:04:04 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 18 Mar 2025 15:29:55 +0800, Ming Lei wrote:
> If vfs_flush() is called with queue frozen, the queue freeze lock may be
> connected with FS internal lock, and lockdep warning can be triggered
> because the queue freeze lock is connected with too many global or
> sub-system locks.
> 
> Fix the warning by moving vfs_fsync() out of loop_update_dio():
> 
> [...]

Applied, thanks!

[1/1] loop: move vfs_fsync() out of loop_update_dio()
      commit: 86947bdc28894520ed5aab0cf21b99ff0b659e07

Best regards,
-- 
Jens Axboe




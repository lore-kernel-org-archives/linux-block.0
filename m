Received: from sg-1-17.ptr.blmpb.com (sg-1-17.ptr.blmpb.com [118.26.132.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F476299928
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870706; cv=none; b=Jol+85RgFybXZBBqOoJl+aLnmTcD8/u5tZhsyEwmAZD0Ibqbd4AnyJwOE/QtdqJ8lajmKOxJWjfEFTo8CZY6mqkfhm/xVZ0QY6dnavc1nEKNjaQhO8aULfy2e1VHn0JC6UFbXjclEskiZIDeA/sVrf/O/esgYGQYBzP7KiFQesc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870706; c=relaxed/simple;
	bh=hte6wTXN+K2lQJ3M1CuSyBUcTWqdtWZxPAps/eNUiWI=;
	h=Subject:References:In-Reply-To:To:Content-Type:Date:Mime-Version:
	 Cc:From:Message-Id; b=s0vULuTTb9wl/HMmA5/cEVwOWl9URW8V7XA9I5bfHgnFzx7sZ5sL4x5diKDaP/1CCfxi2KhGl5P+MPFNqm4fmkTZQsd4SqtPgGJgx7diTgAVc/pRe6jRmLZ3U8ZumQy6io1BxndQ2Vgpp6ZDFgxv6uC29/ZzuPFm5p/mVMZPpgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=dAP5aXuL; arc=none smtp.client-ip=118.26.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="dAP5aXuL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762870697;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=jNKFeaSv7z/7xlBxzTYMq+YQ9ji/6YXaGeuLjRoCRGw=;
 b=dAP5aXuLMXO2a8/2exSayR3oLRz+lzfNz2mgCUQdc+OV/SamIPTFZiuq83yochUGJU+pKD
 Gr1rW7fFgCY4ZbzaF6HF9UpHmlcaPYAVjGKI0d1ryqW4musPpOjwzabGZAtsbWGtQxi/g5
 cOd86jwjWryJXki607KyYD8Nu0w+45QTMvpxQrf5XtzizCxE4PwXlec8fJ9XqeRZBiUSCa
 mo++QOpIsT9OmicNM4vREj5pa8CN910x9o9IAMECDbb0Rf8QCVzNgCJvUnK0HnfF7HO03a
 fJhsuRuH7/tcbe09pdrgT/6YASJE7vJ9zTMxjlCHCjBggUEiV8IX+kmasxxhIg==
Subject: Re: [PATCH] block: fix merging data-less bios
User-Agent: Mozilla Thunderbird
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Tue, 11 Nov 2025 22:18:14 +0800
X-Lms-Return-Path: <lba+2691345a7+42db54+vger.kernel.org+yukuai@fnnas.com>
References: <20251111140620.2606536-1-kbusch@meta.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251111140620.2606536-1-kbusch@meta.com>
To: "Keith Busch" <kbusch@meta.com>, <linux-block@vger.kernel.org>, 
	<axboe@kernel.dk>, <hch@lst.de>, <yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Nov 2025 22:18:12 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Cc: "Keith Busch" <kbusch@kernel.org>, 
	"Matthew Wilcox" <willy@infradead.org>
From: "Yu Kuai" <yukuai@fnnas.com>
Reply-To: yukuai@fnnas.com
Message-Id: <d9ab2932-aa4c-4e86-89ab-390a4797f982@fnnas.com>

=E5=9C=A8 2025/11/11 22:06, Keith Busch =E5=86=99=E9=81=93:

> The data segment gaps the block layer tracks doesn't apply to bio's that
> don't have data. Skip calculating this to fix a NULL pointer access.
>
> Fixes: 2f6b2565d43cdb5 ("block: accumulate memory segment gaps per bio")
> Reported-by: Matthew Wilcox<willy@infradead.org>
> Signed-off-by: Keith Busch<kbusch@kernel.org>
> ---
>   block/blk-merge.c | 3 +++
>   1 file changed, 3 insertions(+)

LGTM
Reviewed-by: Yu Kuai <yukuai@fnnas.com>

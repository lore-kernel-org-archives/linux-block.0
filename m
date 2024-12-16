Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067F1D5AC2
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382028; cv=none; b=YvlTorl+xDGG+PFdp0CNPowLHfGJepoSE24KLiEzW4Ufpp5UjqNX8JyGGdOFpKMiV0LZh1XfJ0gc1szYdJX9FCHkmIo8pEk0774ZVkNZXBiGgMKMQKotrdbe1X8c+dMXRtbF0ZVNsiF1sM/4YtVp8XSrxYoAY381Vk0nkgAx0sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382028; c=relaxed/simple;
	bh=LRs7wGGYzVwVoves4oaFGtrrNcE7+SmlrCyVRtRPdlY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lveKO4rBoRGANf1C/nn/RFsxlOAo7orkgjCOtOJZJIWXVE6+ljkVnAr+BGSvSbBj59ygOEzpcyw9sCh9blZsnbpjVwRSK55HOWFm7OFqPk0ewrJYYK0/HbRdwDpfQtVbdSHGxJEHKpmcYSTiZp3UqH3ugIKY9X64xNkfEr5jCIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kRVbkorN; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kRVbkorN"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844ee15d6f4so276255239f.1
        for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 12:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734382022; x=1734986822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=910zP/tEnvgCPqKPuZIVwHV5301LZHLlGOBRbqVhQEE=;
        b=kRVbkorNLNvgMXyoZNLmg2rGWTdCIVkn/MAtprqDS78ACcFWCOeHGSwz3Iz8FCOPyS
         xMkkgEsqcUas3ocFF7XgnFGnrTi05oqMoRT3slbStYAbQ7w58zElmtVhrGchw7zzBqBZ
         d9j20bfFGt95vQBxCsdWKPBHYNCE7WqvVNWgWl+tAGH0//Xk5k/gRVE85mSrSDdKmD0h
         5tCNDwIFmHPhErJ641ybtCzlkvpWayQTGSwv+7fgu31ZZtJNSs/aY+3qAQKK9jUgHRXN
         r006YJ4TSf0Tb0f2KmhSX2TNtfECgp27LoaMEn+WehfhdzHdTyDYz4wkSPIct1JEj8dB
         4V+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734382022; x=1734986822;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=910zP/tEnvgCPqKPuZIVwHV5301LZHLlGOBRbqVhQEE=;
        b=VsUit8SSZUo19xdK5Ok9OoAkaVrXMpOBO7b6XQqbuUraWOLZAXiBDh/jcN2zpx2vbk
         B2EDtszV3y8mjPU7zvyJBcKQFVI8xb696STZX+uyZqD0oZzAI6/Q+Gbg5fyi6bGs8uwI
         gVghNJmy/LiusN2DxTd+pEMpNKdi/yP/QTd5hRraWgtAAqSiief8183z3zjVOmkvNfAR
         RuCO9aYyVZB2i+XCGZrx5YnCOlzLPfnh/mQ3MuRpYsrytogtO8GefoiC7cc2xO96slSG
         2q06+mZdv4tKfiJPMcIAfLHQ8tQCNrO6dyDa1KzOvu2a7awV/nc/QZUQMuWkf+el4u7i
         DjNw==
X-Gm-Message-State: AOJu0Yxnw1TCcmDbixEozns9CeXgoX0rZQxoqnqcK06gMwy6mQpAaZ7k
	a2zRvTl0SnKLNqL13SoadY00aXFaBepJ4in3N23yWDwRZebkkPn+RgdjDnwyBhw=
X-Gm-Gg: ASbGncsmaBLSKjkI7sDtZCnzHZhKLgTxp0ovGZ9p5pFRJAL0GUtRvdQUJR4sBr7fb7X
	NkWEP6T+U16jws/uoK0wpb6/UCg1hRrWkMt6ujcbByZMNO+H0gb4AeTlu+v6f0VKuSYkiHZf+63
	hTjVr8slTYr29UXHd476DPhL1IVWxkR4yqNvovBZMWIrXF92y4FEhw46GAMWmfKkku2+mv+WoS8
	jglWKP+0FClpaxX+V22kVOkcUb0clhs8avJu4mCbB2Gf+c=
X-Google-Smtp-Source: AGHT+IHVh95co4d2D2QaGcJVyfK16ae6tg1twXZt2CBn/L6rRwbNIGVNbSvUMrZpb9bAYarBm0Vf2w==
X-Received: by 2002:a05:6602:14ca:b0:844:e06e:53c5 with SMTP id ca18e2360f4ac-844e88081f7mr1414543539f.8.1734382021961;
        Mon, 16 Dec 2024 12:47:01 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844f60fa61csm148480539f.0.2024.12.16.12.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:47:01 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
 Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241216160849.31739-1-willy@infradead.org>
References: <20241216160849.31739-1-willy@infradead.org>
Subject: Re: [PATCH] null_blk: Remove accesses to page->index
Message-Id: <173438202068.81026.16371906190673466442.b4-ty@kernel.dk>
Date: Mon, 16 Dec 2024 13:47:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Mon, 16 Dec 2024 16:08:47 +0000, Matthew Wilcox (Oracle) wrote:
> Use page->private to store the index instead of page->index.
> 
> 

Applied, thanks!

[1/1] null_blk: Remove accesses to page->index
      commit: aa3339c7e313c15ec0bedd276a2019478be064bb

Best regards,
-- 
Jens Axboe




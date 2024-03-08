Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07927250F3
	for <linux-block@vger.kernel.org>; Fri,  8 Mar 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915311; cv=none; b=HUMZQPJgq4Y3o9kxzx0+CbC35Fa67scs//Cu6rmsQOC+Xopx5OxUH8/dDhwqTVpfVJ06T/QCl3wKklD0eZACh+VPNDVvfybc8hS+ZQy8nmMbbVeARck4uzAxmj8xsPwtbBy67fvBqCEuLx2IL7XHNj/fPm0ug3M7YTikM261nAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915311; c=relaxed/simple;
	bh=ErBlvQ4p7bEI1tO6f3RNzP2jColJ5qtRK/xB0hKj+wA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QUsWenphmCz+J9okLBrxv1e+HQ6oAQlViMZ9pfU0gfrV5NrGQlM9M5gDdIZYM+wqxBi9AZLfb03/Hfyqax1x4fLqpFfv4vxlzoo/TK7/DjUtm/GcrEgGqHuKzCF1BPRITmwwsVdBsXw7RzLHyuDNeWLC7I0ntTZMu8wspazQukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kMj1BYxM; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kMj1BYxM"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3652ab8766cso1493165ab.0
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2024 08:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709915307; x=1710520107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ntjVS42ftlHHWlmoi41RrRrZrTufP6VSPkdlhkH8HQ=;
        b=kMj1BYxMoCIGVhZ8VANZ+OuLZkill0RwGWunOcI6otbS3ZgDFuqeOSKRtaNtbGUW2Q
         u40jautysbhxLBSuAxSrSJ0FCvqabMZdsatUvWMuJ1ai/ADVHN0Fe5VmgNhqsVdHWcNt
         J9jjo/EB2kGc6FQD2UAyLVS12xgEJ08NXcgZnbPNXINK8SlT/XQKSQfTztN1K13hXOug
         SpAIdy56n7ACUZVpAaWClm85Wqr7bLiKDc1yGJLObymK2TqzoU95ZSOONFx/1n8AXeYu
         qUPOa035FyFDw4klc4F9I7Lhx8aCf6xJQw+NUGRDsKQDvzgngOcDq1gnpsjA8N0NSzfD
         k0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709915307; x=1710520107;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ntjVS42ftlHHWlmoi41RrRrZrTufP6VSPkdlhkH8HQ=;
        b=NbEkbjMgwzl9GHNhdbpPWH1xfJXAdX4fpuZ7LR56JPxeLeNv91qufOpnhyk36hDaVW
         6rErzHuFNpuv61amQ8grcv+MXf3yS2v5mBHWTUj4arHJVuiG+BG8SgzQEN1NeFeGv+RV
         8JAcL3KUPDiiVkarXqjEioqbHws7Gomsv2e001xFBIoj0FmaepISSHhnrzCqASTOCZz2
         F+QbAl26fJd1gJYTFaNw7tqxvd0MnKBrjW6AAUCEQIA1XwwudjG8GjzDL2AN/EXUiWlM
         TlPhibFzZMj+mbXvKv4YX7JaAuHwnJeiOIa/HByGPVaLOV5FK6q5hLRaw2iObz35KXBj
         X2qg==
X-Gm-Message-State: AOJu0YzLytLwExS+XwNf+Aw1b8eg3eoRPAQsdpSkA6wFO/7VlsGcHuiL
	lgkvq832o+/Kq8Zh/93RxxN9KJLI8/YxUhvEqKje+5H1pK2NibnftBc7UOVTra2kBZZMoe66vwL
	r
X-Google-Smtp-Source: AGHT+IGlmv+Xfz3FSUnrE/HlafWHMeCSnKK5su+cTLXywqGsEs2DLcu+CsOsjfsNoD5ACHUT49tW0w==
X-Received: by 2002:a05:6602:4215:b0:7c8:814f:923b with SMTP id cb21-20020a056602421500b007c8814f923bmr2306902iob.1.1709915306647;
        Fri, 08 Mar 2024 08:28:26 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k22-20020a023356000000b00474f8940230sm2534947jak.11.2024.03.08.08.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 08:28:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-block@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <a00aea8201ea85ae726411bb0fb015ea026ff40a.1709886922.git.u.kleine-koenig@pengutronix.de>
References: <a00aea8201ea85ae726411bb0fb015ea026ff40a.1709886922.git.u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] block/swim: Convert to platform remove callback
 returning void
Message-Id: <170991530600.873480.10827635919569308902.b4-ty@kernel.dk>
Date: Fri, 08 Mar 2024 09:28:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 08 Mar 2024 09:51:04 +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> [...]

Applied, thanks!

[1/1] block/swim: Convert to platform remove callback returning void
      (no commit info)

Best regards,
-- 
Jens Axboe




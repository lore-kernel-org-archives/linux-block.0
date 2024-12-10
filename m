Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9637F21422C
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862290; cv=none; b=BsQw5IcTzFzW+BZ3xZU8DWekXVfG8k0VvxZUx6Kus8FRil0rEbAu/mZkwIZJwTu5FMGqHr8bIVEAGhmnmbPnT3Sr7oYlPDRWBb9WvtqutYpqJb5lNKIhpIqgI61932bkVb9jDWqvLA1xgPK21t5WI6fDKtUY6K3oeNvpPfLQPLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862290; c=relaxed/simple;
	bh=OjUDrTzFkxV8xSogins9C7+MzayhWkm9mYNApfos4iE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pFQFBS2NcAcKYeRPanjweErd9ubUfw3jzxPthGGfXNIybFFFMbNzYIgPV/27emCndBbV5dhKgRKwJ6vSEQXxRVSGTBBqjUaiWKQq4wessdVzbSVH7rqoy4lgIA0kgISP/ua29RNi98Ehu/fQtDo63NKDV6w/BmKFsxIutLoN/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QMMMCe5C; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QMMMCe5C"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eb7e725aa0so231719b6e.0
        for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 12:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733862286; x=1734467086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz7JV4e7nhtTLCyitE4tGv1i/S/7sfwY6uqrvo43keE=;
        b=QMMMCe5CegsJcdYEZREz9uhjsAa/tYpBOfURty77IJQyXx4dBJvppHgCitzt58mIAD
         7MPjiIZuDwXaVz+3SacjIPBKmluhL5uaJDRob5GYtbVoVvzgUeS2G/xixTRvnuifNaMn
         7JehQvvNVm4Ei0Dp0CjeaSF9ipzfhls/H5lehVeiO0UlVROAWFVOGZ6rMUPwoYnlDsUd
         ZsLeg3ZTf9iIBcfO8TtjRZkaYkO2eNnEBTu1kcuWWVb8GnUR+hX/b8VFgVxlGzV/jL9+
         ZikFhsD3EiFy8mdk1vNXSLnJ7yTfHqS4PxY8ss+AxfMbywemZ1sp43JSz+LPwyldXw0a
         NQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733862286; x=1734467086;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dz7JV4e7nhtTLCyitE4tGv1i/S/7sfwY6uqrvo43keE=;
        b=XUo5xaOk9jCvb/gERFPR2Kyja/4cFpoBaw6WKtqqhOz9i3JvS41nKktLxLyhNCulEW
         zXjgDok6Bp6CSdt0leMP8yjzAdWQDSr6efaw54l3lepFbo8Kn/13SpHa5+iIRdEgI7Ek
         n8VoSYacV+SsMVrIIdZ/7kzI4bm5hbwQBfndiLAYGUfNTL4Ct1dl+yjgD+DpisTNYRuU
         2jtrkN2xu5yEfJ88ihAQX4uMn40BSgDC7Gd5Pf10bjmo+q5dylm23BydYn/EKBWj34La
         mesy53A+t6qn2puIOhH6P+PYS04uqm/73cG729IFsO8EEEVdbdxJVM8No4yCwZa0B6/0
         SJjg==
X-Gm-Message-State: AOJu0YzlGYWx+ThsT8vD10iCSU0EBS8wO5n81EL4abvT06etbU8Ojxle
	9BWYFquz7q+CFyFiMr9V05DP8T95QWuKWzeyn2tvuLMGjkucKFWuuzthBFY5LHJxMU6vvZz/G0j
	o
X-Gm-Gg: ASbGncvdbfbFL3GewQBD2NmYmYBbbJ7jutvEAteCYQgRD03KvXMX7iD8mtVz6xWy8ho
	a8aulfmxJa3wvRrPoLbKqhJLvZD01aJEjUGLFxCd07vW8pJw/E0XgRWyNMvgOH8160ZPrQmHXpm
	rCCp/UoEmp7k0Gnz6UGZGo7mRNI/qIjpR/GpOYTeuGhDpAoRSy2OG65zTOUtwDkZFIH27YOw4bA
	okmo9MqA4MOcgnJVT8icdzAn0oZvnJaEFwVSwd/92rt
X-Google-Smtp-Source: AGHT+IHCFkLDK5vw13xHumY+LZl7gl7/7bb3anCD0gtOEMPH7vZQ2IMM8MPeCpyBD0IYuMVRr7FgEA==
X-Received: by 2002:a05:6870:d106:b0:29e:1e77:71a2 with SMTP id 586e51a60fabf-2a012bb502cmr240840fac.3.1733862286017;
        Tue, 10 Dec 2024 12:24:46 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f279223948sm2738866eaf.14.2024.12.10.12.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 12:24:45 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: LongPing Wei <weilongping@oppo.com>
Cc: linux-block@vger.kernel.org, bvanassche@google.com, dlemoal@kernel.org
In-Reply-To: <20241107020439.1644577-1-weilongping@oppo.com>
References: <20241107020439.1644577-1-weilongping@oppo.com>
Subject: Re: [PATCH v4] block: get wp_offset by bdev_offset_from_zone_start
Message-Id: <173386228506.539031.5085315548244677015.b4-ty@kernel.dk>
Date: Tue, 10 Dec 2024 13:24:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Thu, 07 Nov 2024 10:04:41 +0800, LongPing Wei wrote:
> Call bdev_offset_from_zone_start() instead of open-coding it.
> 
> 

Applied, thanks!

[1/1] block: get wp_offset by bdev_offset_from_zone_start
      commit: 790eb09e59709a1ffc1c64fe4aae2789120851b0

Best regards,
-- 
Jens Axboe




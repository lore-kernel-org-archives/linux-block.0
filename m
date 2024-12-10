Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605941A073F
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847464; cv=none; b=uSKl/b2SDWzDtEJ/L17Evuy4NpWgIJ795BfnvVSQpHlCjgxNHduXgnCYsLWRVzf8dJE1q9sBzvSQ+V5sEYdGWfJ3q2eyPTHEOXzOeM6jscQiCt33NGKzmPhsrDP04RTEtOAspqKhSYGZuO7syHmWeIKtL2fELWYd4r4xLJaw1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847464; c=relaxed/simple;
	bh=WFGbp/rJV46bRkoFg19L3FZC6MzfgqNyYAz3I0W4PEI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vvns7RJZwc+Q7hpmhlE4lZJENiCkA5atOyXAAuNV4aEfU6OgMd+djuWfTnxbDgQWLLlhBy3lOsxF9qLgIt+Brgerk3srRFvk9GIeIpx5Shc0iTjx8ncePucUpULyGO6J9wkYU+wYMYK2z3o7Wr5O87cHotRcPW+DctjoBXGG5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nka1w8jW; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nka1w8jW"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-29ff8053384so477122fac.3
        for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 08:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733847461; x=1734452261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtugL1GOMmkuSroetbFeNzVAId+uZTGj9FtiYpIZXco=;
        b=nka1w8jWniSf5XnKtkJrN8MeuMrQXTpFokDRq6p+sRt3Q/cV7g9lESNAR99PjJ26PU
         Au9afg/1qCRQV9nGfbp0m/K5VzuXaxNxlhWNfy1v6ebuoTSr8AtZVxxj5wBnrbBzPAOd
         P/G+5h/uEKIBiDHqIQR0UxUNLVQ6wx4HarJpf59eqeiDbKY+AQjC6GAvrtd65k/3zYhB
         OD3sT6CGpt5V1uAKorf5qSWPWf2ZzVNfAZQu+RqBIng4YAuE2UiEAXw0UBBEFgyv28Jo
         94UHUyNJ1NRwqYrT0H7pGjymEJOQBaSZLa8NAF4swczy5AJl9TfhYSpnNPUAvAvY+HdV
         mAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847461; x=1734452261;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtugL1GOMmkuSroetbFeNzVAId+uZTGj9FtiYpIZXco=;
        b=PZO2v9yZqC5dtAEDSKIQVPdNCqJfMZ1FwDuhwKT9TfIncQ4dC0ZYrqfUXepYF61c9I
         kQ5PmNYlwgRpsV1EPpgV2dud2ieAZ/I1OJLSZGOhdxVF0//B65N2391ryOkdmSQtUkiT
         DD/n4sZPWaW1sDRsmuAOqrslji8LfjyLSpEz2pmM9phez8jmu3QxUX6Dbz5B3ZEXU2wm
         1c6eW85Vh5OkROny1YPN/jUZl3+qIY6SaGuP1HlsX0XPSyPpOwUC4rRN+tK/WGr6PPWX
         pjKzAMpqgzOLcNvEsG0fRTOeeybkTpr0V42eM9f3LQw0gjN52FoipmsxKfxG2hYiqcnX
         jnLg==
X-Forwarded-Encrypted: i=1; AJvYcCVytn9P5mTm/GWqS+a7czPpKK7HOEyXBwPGr2MNPjuo3CgZcD8xiVc605/M3k9am94V7j6Te70tPk48JA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/rrIJOdDKcENGfpC1/iriQzj184gqKcGRE+o0lsdcNG6g7uc
	Jlk+FD5OX5ZUd1wH4YT4wKMkauUcNOonK8MPxsWnRmFggWPv7mqIg9y2NclfwOq7cHWmE4JVrvA
	L
X-Gm-Gg: ASbGncs9B0CI3pxUhLLq5xpHl/N0vRaR+6xKyANcFKZT4DUezVVrf/sXPjPeIyQcpkB
	dTtDo1vn6TVJgirN7bqttoILjvTnBc7sTtylPuredppGouHun/xDHLXymXeHdxG/7uVOt61nVku
	zCH1O88zRWsHjXqZopvQ3y+axcuXl0bAQMmz/hsRD0zcz2pyzWIOI8h4PY0NTQPYTPPa1gC1SJh
	w2uUsR28uKDYJDrStqqIg5gBfgq6yF/t8oUafzE8dwG
X-Google-Smtp-Source: AGHT+IGVY/C8GN4QT+IFfl31u/lE/DASrDNbbdZOWmsimrsPCEqJemJOZBakQcoij+eK/vXgBKsQPA==
X-Received: by 2002:a05:6871:358c:b0:29e:547f:e1e1 with SMTP id 586e51a60fabf-29f7389c541mr14202348fac.29.1733847461475;
        Tue, 10 Dec 2024 08:17:41 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f279324914sm2639115eaf.36.2024.12.10.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:17:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: colyli@kernel.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20241208115350.85103-1-colyli@kernel.org>
References: <20241208115350.85103-1-colyli@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: update Coly Li's email address
Message-Id: <173384746036.444526.10848476315219885523.b4-ty@kernel.dk>
Date: Tue, 10 Dec 2024 09:17:40 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Sun, 08 Dec 2024 19:53:50 +0800, colyli@kernel.org wrote:
> This patch updates Coly Li's email addres to colyli@kernel.org.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: update Coly Li's email address
      commit: 6f604b59c2841168131523e25f5e36afa17306f4

Best regards,
-- 
Jens Axboe




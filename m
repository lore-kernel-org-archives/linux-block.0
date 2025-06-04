Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B54B3D6D
	for <linux-block@vger.kernel.org>; Wed,  4 Jun 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749003614; cv=none; b=faWM2B7hzIebm6n30vVmGl761kmegP3SUb+cevAvlfPkA7auIwtnSQAlc2h6FBvtipexNYRC6LLS0FDw1fQ3N/m/eQcw3Gst/rGcvq/5OO7XDmE6RUs6Vt/DViEUrZIo39O8U3tZPG3s21+j2hRJ+gxcmlERCYJy9Rrfw5HJ6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749003614; c=relaxed/simple;
	bh=aqRzIH4YZmOMMcRlcaEeuvd9lr4Eg/uYOhHtEzdtK8o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tvbxeSf5tp2CkX7fji9bZU8QO57N7Vy5p0soHVUmn0yRi4yDNE2afwTYcxJoUfOac9H3mGfGX1d0BBjDzqFs5sAX3ATl68oxIZ0oLAfSaTJu9FHCbmOYmk9NsTQNKD0giOVZ+8fTiza5muc+pCsvAP6gNPXAmIJu0H5Q1TRE9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0cItEXK8; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0cItEXK8"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3da82c6c5d4so51510335ab.1
        for <linux-block@vger.kernel.org>; Tue, 03 Jun 2025 19:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749003611; x=1749608411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qejrTtwV/N3l/netOhR9CrpngsFpqe2KTsbhYRzMHf0=;
        b=0cItEXK8PFZ1VIm2GTZ2G7kXuONWELnJxtCCA/TZB7XlNkbwYcDxns9uXGcwi3H9nQ
         3bcvzomnOoYbpNjx7L5B4W/3Tl97+85+vtSmxt1fQmVHVsx5aMJXFpsCupofjGVUwrKk
         UiFuNWCmjJUi8Ky6zuqa8OT+euSseRwXgWiEAyJq3lvHHetkzOTAM77e2lrhEyNUJrAC
         7MBKns5SkGNAKuk69JZgHhPGzfV2FJsfLveY7XZLFZjlLQEIB2koYX2j04D8ZKyWHmsD
         kKgopRbIyruqOztETeZptuqjqrr9pHEu7+l4rfeuUsMc0NqIGeJIcyNb/RSocA+pOPkZ
         qYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749003611; x=1749608411;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qejrTtwV/N3l/netOhR9CrpngsFpqe2KTsbhYRzMHf0=;
        b=bGunl1e3ETFKIOB/QXpl+I8J+k2tzvNEsJQ9Hsr3raJuh8J5aL8gj+jHl49qjI0jmn
         0AAnR3DUQ4bjwZ9cQ03i/RBkqlGguOEO0yU5Orj4WVGlX4KwTjIjZqLZBn35XnuOQOU8
         HMNPe0DQcLlCyaF0gtRd8A36F0zebFr/5LRe4GF45JfYFfIPF0q88i4Fq5nOAjp+3TaB
         9ey8NfPDUPNZSDMMOr0LIbRBAOtQwLC9R3GKwIAfNnHMTXaJ90Unfr9kOlcZXcYGqZC+
         Q4KkyWfm2+dyI0LS5s0Q/2+SKxF/W0WYn1C3RJXnrO9vOY+HcBNGX2WG3S/vEdXPyI5M
         j1UA==
X-Gm-Message-State: AOJu0YypF0cBUm+AhmK5Y+lYt2nA0z0z/xugj+sl8qlTQk5Skc/ig4hG
	m+jpIPSAynwrydr/yse8npMiFD6Cwwrr/y8TwIiYGk6d+/11dPIKQ2FtSe/qPzQW1n+3ldzB3ZB
	q5Lpd
X-Gm-Gg: ASbGncuWZ8gzQ4i1b+F+NojOi0ovANoUdxjCAAZtMql2OOFpvHQMybVvRA1WzkUZSc/
	mRNicRAlcrm8o7GLvdWaw+o0Lz2QHE8uZWOkjOjYBt8slQnMYNiBwRSG5b7epO66eeD7R6GTe7P
	XWdkXlIYeMkeqtVlJ1n9DQnjMzDYweBpIDnPl0TM8IkFw9FJN8t5xi4U8JCY/ngm2VlK2fAtte4
	uH+dWRzKHwLnORgX1lZMNSqx3RwURnlKym3K+ZHHxWycdL+Rbey/fnuF2LsRE0AEHqusCSr2+QX
	iFqHvTfKLo0IqmyB1w3B0GitkrzITBF10JsVY8c4ZcoeHCYvLTONKQ==
X-Google-Smtp-Source: AGHT+IG0g/LKKvwE+q0o5yidPMzs2yIX6t0WlWWtUgIsIU2EQk6Leb9umH6a08mNT2boXGRAuOfyJQ==
X-Received: by 2002:a05:6e02:3193:b0:3da:71c7:5c7f with SMTP id e9e14a558f8ab-3ddbedf6e64mr14260415ab.15.1749003611511;
        Tue, 03 Jun 2025 19:20:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd935a7ad0sm30334405ab.66.2025.06.03.19.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 19:20:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250603-ublk_init_fail-v1-1-87c91486230e@purestorage.com>
References: <20250603-ublk_init_fail-v1-1-87c91486230e@purestorage.com>
Subject: Re: [PATCH] selftests: ublk: kublk: improve behavior on init
 failure
Message-Id: <174900361050.109618.15847979671218890744.b4-ty@kernel.dk>
Date: Tue, 03 Jun 2025 20:20:10 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 03 Jun 2025 17:38:33 -0600, Uday Shankar wrote:
> Some failure modes are handled poorly by kublk. For example, if ublk_drv
> is built as a module but not currently loaded into the kernel, ./kublk
> add ... just hangs forever. This happens because in this case (and a few
> others), the worker process does not notify its parent (via a write to
> the shared eventfd) that it has tried and failed to initialize, so the
> parent hangs forever. Fix this by ensuring that we always notify the
> parent process of any initialization failure, and have the parent print
> a (not very descriptive) log line when this happens.
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: kublk: improve behavior on init failure
      commit: a2f4c1ae163b815dc81e3cab97c3149fdc6639e3

Best regards,
-- 
Jens Axboe




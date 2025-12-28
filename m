Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1569378F26
	for <linux-block@vger.kernel.org>; Sun, 28 Dec 2025 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766939154; cv=none; b=Mh0n5AaQpslztYhwQ66H4R2d7K24+QLoZtcPO7uSfH8mdMFIm9I/FNoZBrrERcAavPfzjvIxVOVoL3EufZlKRDY+18wzYolKbdzNtBp8w3Zc4h9bQWPQNf5t4VTOpf+qXCEiCatxDRvZWSL2e0xvT40YHx8ecnRCi+E2gUoT3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766939154; c=relaxed/simple;
	bh=MFgIQ8PlYATsRqpNqyNAs70Upnr6lqIlFTSO84rS09k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mbwaLo0PUyvwuVvN1gZsk5o+8X+JML57NLwYqz3Fh+46/eSXzHJArHaUg/iyFkqoOz+EY8plnToRquFQ3APnn1zUvafH6IOHECAzv5mwOi5ChZ9trzwJyFEGZOKs4hEQUsdWdQjy9vNeDXqL9wWLipA5/ki47dyarvPVAiYHqMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1RDuziFA; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1RDuziFA"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3f13043e2fdso2751956fac.1
        for <linux-block@vger.kernel.org>; Sun, 28 Dec 2025 08:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766939150; x=1767543950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iD1j5TeOaHU0S0q9fIx8lJvFGn5dIoSWnv6HF+tTfHE=;
        b=1RDuziFAtyjtoRVwvgsGUnNu0u1TzGbw5YAtfecexbTfWI35dTrySYEDtnyYRUtFmO
         oRlOoMBuaMh1N966jht+K6g+XDRMSFROU3Fw4045Uvba10PgCUDcsaRMySmNAxEqDG4f
         XkdoHoyD/7dRsnyHrzLkA7y5iksvdkrS5US3yBD1p2wRWsfGkmc/Gc19WUVaDDgsIPKd
         k64bulb+Xo6O0RsUZIzZt9BiM2iUaqUCzeG8YZZzNWcRvzIqY7FvQyEn5uOIqE6pWVpJ
         rMH0QXK5jZ8n2okDaH1AKS82ToaJiwKCSpg9I7YjrSfKo1+fYDLy/ba5BG2qM4RFvySh
         NFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766939150; x=1767543950;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iD1j5TeOaHU0S0q9fIx8lJvFGn5dIoSWnv6HF+tTfHE=;
        b=BWXuLpjIO2hbDXy3m+qdDLbDr8NbuKtfeiACOt3poRJPwQpvayTHnr8PyN12HoXUca
         uP7wQD+3A1LuMreTAWA1rA8pyfSdZOPSN9xDW/JYxAeKSR8eFThnHV1lZ3AnKhR/Ldby
         OtYJdH64TfiyNU1XfOqVuulTI7ZtNt+tMfDIP4BjmFEUyeVfay2Sp0R15bPqnWhzJxLJ
         ZR2R3RiOcCP/39+YOPP6pzPoBJhWAfGSeIy7cEhEfZPOxD+I5qolL3Boo0T9m9LmWGdc
         Vbl0aBN3pTgaQTmz+G+a7T601TdqsyZQIBJV5qV54bivCMo2uaGLTTXRVv5oSqQE8koy
         oEtg==
X-Gm-Message-State: AOJu0Ywtr0JpfQVqOuTPjKsU9bTi8IjQYUq8cFXmLkBhNn6CWYhTBZst
	i//aUF2pzSbrUjnZH7I0nfdg+UJZx5rZgLk7+fcsmD8Q20nkfib8+bkKlF0JBIO7OXE=
X-Gm-Gg: AY/fxX4BuVLUnvQN2ARZ7ZFs+qZ72dVkHceGa9oom6jodRffFcoDxjpVBb4EKscEura
	Tcw1V7d3voJQDTqg1gwQzCuVbb15F+KRTY/LsTVX0RytvR1PsClMqx1qKKt0eS/nqrU2brm2DQt
	ZgZl0iI1VyCuff8sDqL+hZ70MFkisRQ1h0/neXR9n+8wpwyODGitZK6X5DPHttzC/uQtNeEVcXr
	7Fhgg94//gWD4XdrzQFC3E3mF88/tBWZRodA4J1eFbSHW9V0dsWIokdjz6bWECQd1GqqsJK/tJB
	AUMJ3twD20OgHAFteUrhr8JrPm7NEuGpqzG2+cfeZtot5zqSvPl+F8isKAZ68ZeUtE8amdGPRco
	3PxefbqzcRNd0atdMjkgnE7a20EqAz+m7LKIkCLx+kRACE/QVbIhpFy+oSdZYRc2Bl04Y+8mgcq
	ULgeQ=
X-Google-Smtp-Source: AGHT+IEcncA+NzbiqC6PD6Fi7L90LvUXW/N9cJT9nbZvPgjCbOHybaypavX3jGkWfEPY6EWt8B5ePQ==
X-Received: by 2002:a05:6870:f714:b0:3e7:eee7:948f with SMTP id 586e51a60fabf-3fda5611093mr13422893fac.9.1766939149983;
        Sun, 28 Dec 2025 08:25:49 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaab65749sm17251902fac.11.2025.12.28.08.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 08:25:48 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>, Yoav Cohen <yoav@nvidia.com>
In-Reply-To: <20251223032744.1927434-1-ming.lei@redhat.com>
References: <20251223032744.1927434-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/3] ublk: scan partition in async way
Message-Id: <176693914766.195283.16906151653466699321.b4-ty@kernel.dk>
Date: Sun, 28 Dec 2025 09:25:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 23 Dec 2025 11:27:39 +0800, Ming Lei wrote:
> The 1st patch scans partition in async way, so IO hang during partition
> scan can be covered by current error handling code.
> 
> The 2nd patch adds one test for verifying if hang from scanning partition
> can be avoided.
> 
> The last patch fixes one selftest/ublk rebuild depending issue.
> 
> [...]

Applied, thanks!

[1/3] ublk: scan partition in async way
      commit: 7fc4da6a304bdcd3de14fc946dc2c19437a9cc5a
[2/3] selftests/ublk: add test for async partition scan
      commit: 60cf863720308ab89ce2fdafea7fcb2cefd9c144
[3/3] selftests/ublk: fix Makefile to rebuild on header changes
      commit: a2ce133969175d36d708b7c76536b375d0522e53

Best regards,
-- 
Jens Axboe




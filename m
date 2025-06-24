Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F624A061
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776703; cv=none; b=TFihmtKXZU+27TnV7JRCp6ATLCG5NvXlAyIRKs4CV4giZ0Rjfwt7OXb79sSj42tchswi0zScOhwtW8Ak8zMRnHye7+vOlN1f0gXCmqFIpqB8Kirmh0Q1MqliFaNuZjt9mgSW1O5UxbDrDJynmPz8pm6s1Lg+rilfFhdTMDDgfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776703; c=relaxed/simple;
	bh=9OKO6BDx2IMt/zmfSUV0ohxKy/gloikZpQsoqXzWc24=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O0D79/K/ALFvijHi+HQp/sCLgoi8vDctEk2PVoTu/Kd+dbqtFyVXumm2F9yFrjuKcGVR7C+aMsM0s+4FoyJ1dn+r9CwwNp4Xzgnv1iqPCtK2cLM0znoh0KR+gIgpzVTe7pv2ClY8WFZrEQbbxk5BOqmlD79bytrbWY3NPbd8XYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VxY9lexh; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VxY9lexh"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b31d8dd18cbso687568a12.3
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 07:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750776701; x=1751381501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKBpAEgjMRRMgJIPmMH9OybSrIc+zODRWtXV0gOOoM0=;
        b=VxY9lexhNOadkDCtR4VHh0SZ1aWbgugTdN7boPLzK4KlFtZTnCUf31ncWITMYv03Ph
         6dYM62jKhmZ+yATIVGKo401k2Cjp+JqMMEoSuJu8mWymd8n/BOInH9iCSpxnLKUaBPvg
         LJqriuDz/XLoT4f3Tp/jFkShoulcP7ky4PLPBRa5SGCchMmv6wjWx471dhSNMTv/Tipx
         26yEiTimkD1GEuqjaqyRVKfPbQC88Rrlp1bxfpmrkm8EK2mCbmev2ElGjEFQdwofjjH6
         IYHN86bFHjsUBAStt//22byarrkadUg8RxKlWkqmFdvobjORNNMBOD56k61rKHyPW1Wf
         2T/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750776701; x=1751381501;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKBpAEgjMRRMgJIPmMH9OybSrIc+zODRWtXV0gOOoM0=;
        b=JdmZDPFt9qnmr5LaXwTmvhmwhcg/dJilCpkVFFMCmng1pB0Aft+2gQhOmaCB1nYaiI
         mdKJl3ouyipLnaXBHTrKbkeyhvB6+c0fZadpNSA/9Xm0lT5OQ8zvLobtsX7PFixGH9LI
         FhtlcDKUuRJOynebUJuQmsF926EMiZT2kFL8QKZvi6fLA0jWtxftGogY3VYGIC2257tB
         og5u4m2wKdQUbmtTmgHSR2CfDV4sMIpUACfZLRxQjkgDXtF4FkvZOl3zXQAD7W6VxTXo
         phFA8bDTA5lGT/5lkgZfgCFKLbqeGREtWed1doBof+uV1Hy5l4AO3owpAXvBsjBtOyRx
         xecQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5NonG5wJ5vdBUmN04kZnMlu+hXN3YPqK3FDsjTGm0UWzpv/jbu+VlqDavXyGXBMb4iqitocetTZcHmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPHQTAP9ZagzmdmcEJXkypV916sOcS3IY1PoBT5IdS1QW5Y0wT
	PEOmf9zGK1nADbSG6HwoIrySm0B8RYDzEo9HB/ub1ge6ViincNxzl8PoWNof7dHMviE=
X-Gm-Gg: ASbGncu/VyP7HAOXSiPybsM6F0Wk3kqjZVBoi6o3y9bqJUYxaEyZZUEEP0HcARZbuZS
	E50BzUl7ANP67/lNeILTTNZnN8oZwLXqL/ymBVdWxpJQ7FiJ+1Ak2iDApkTMozMl6J2B4ryWj3P
	7W/HR431vj5j6BpZ8hUKunE5aVAmM3IP+atvrdX5lhqGZoBQyUIEBt0hqiY8SyIboF3q8KL02RV
	4ePG3qCJaQzDB30uVFxZverq+PYzeck/6EWwIZXQrEgqvBHBNcKiv2A0P7gLLcYM05Dj9Rnbk2Z
	UTNq+zL27jE0v+3ZOC+fz3Iy8JeLMPIab9n9e3XtYyJTbOfGctZIAQ==
X-Google-Smtp-Source: AGHT+IH9g7UwNzUmYqNzcBMkeoifKor3akGE6R+oyeKg6dqY1DgcLWxDTqF/fdwAjctOxQqHqKy3kw==
X-Received: by 2002:a05:6a00:2789:b0:742:a91d:b2f5 with SMTP id d2e1a72fcca58-7490d6089e3mr22801763b3a.13.1750776700860;
        Tue, 24 Jun 2025 07:51:40 -0700 (PDT)
Received: from [127.0.0.1] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c887378csm2040731b3a.178.2025.06.24.07.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:51:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250621162842.337452-1-csander@purestorage.com>
References: <20250621162842.337452-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: fix narrowing warnings in UAPI header
Message-Id: <175077669906.72735.6561579879572890372.b4-ty@kernel.dk>
Date: Tue, 24 Jun 2025 08:51:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Sat, 21 Jun 2025 10:28:41 -0600, Caleb Sander Mateos wrote:
> When a C++ file compiled with -Wc++11-narrowing includes the UAPI header
> linux/ublk_cmd.h, ublk_sqe_addr_to_auto_buf_reg()'s assignments of u64
> values to u8, u16, and u32 fields result in compiler warnings. Add
> explicit casts to the intended types to avoid these warnings. Drop the
> unnecessary bitmasks.
> 
> 
> [...]

Applied, thanks!

[1/1] ublk: fix narrowing warnings in UAPI header
      commit: 03912ca894e4e5d6499bc57e9f10dda9f0965c1d

Best regards,
-- 
Jens Axboe




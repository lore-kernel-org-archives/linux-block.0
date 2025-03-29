Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEED21C5F25
	for <linux-block@vger.kernel.org>; Sat, 29 Mar 2025 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743249467; cv=none; b=YdggA/1Su5XDjGf3qSN3xtC0N9NewsrRmh0FCeo0p4rS8SAXXe5Vp/3aOnkopxs9lQqtIzHoCF9HjgnNgU4kDpI6PvwOSpZm7sX5RGjbGLw73PAfj6MU8oWctWmg2WXctGHJURW9ht7q94jmfRlX/uafVrNASVCjD5Ku/B3flZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743249467; c=relaxed/simple;
	bh=gAeX4mYSCbs5F65smwF8qHZGNb5IzGI1zY2vATp7M+E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a1dLqvmj+e7thYf4gTTFBbfsiQkKzbGAI3277I5+FTp9v7aKfBo+ZYF4dZj0Woa9YJ/z1xbmoGRlYa2h8TBb5M/3D+mBE03BWXIKbI5zLxEjiJ6XQP0qzAEClnyomGWQkrf0PY0EX2yUN34UztM3CQYCoKPuXsDm1u9BlG6akKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cqVKj5ul; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cqVKj5ul"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85ad83ba141so303021539f.2
        for <linux-block@vger.kernel.org>; Sat, 29 Mar 2025 04:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743249465; x=1743854265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/g/89MFbZnpWepoRDZCsMQzXVPoAx1wXngDzMRDo6M=;
        b=cqVKj5ululBWNWrNL6eAXyAIEtcYk3w8/C4YQS+P7p2fCiZ+seD+AfEMZ/bPlq6Ggd
         j8IEk7g6TR8T5bfqGmKtWvI5hcSPCshMLEVEvP+CqBDaPFhmeOO2hkYcJaaEp6D21u9k
         gv2JyaLj0aa/fZbZqn1NtmHRQPedHaqcLAC76paCJ2l1ljcAlxNO3q6L4kLqkZCABaj2
         pvd00gXwGVzdCFtcZaGKtDRPYqo1qTvqFQpMlc+bVA7oNCaqH+954j1va74f01MzhS6i
         20QOYMOi+Uh+mrdhrBQfLqSVfVP5Mbcr3O71LzBgNR8l+SecIvYz4KuLsz51dQbyRTdT
         JnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743249465; x=1743854265;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/g/89MFbZnpWepoRDZCsMQzXVPoAx1wXngDzMRDo6M=;
        b=athqdxufJP45q4SFvazHr84ZCLt250+DvboiUrm7Wf/Qjot4c02YQz28QQ1Yn72lBc
         B1CW+VoVw/fTlIriTEv13igLAT8UePsBlEbpZ4VgzjMjGz5fxGUjQHHuVN6R5ZqxQzLN
         m+Evw98dlOF7UzcPyW+BLX35dpewhEhpu3kuvXhqZ2HJOPfs1de2cTp4BM/KX2LtR5hQ
         IbLIUNI3SIxL+FhBBKIMKXsWlLgT3jbe7X1Y86AJj+xwWkFoMBlQXDsoyv7ZSvoUsQM8
         tSUELWR027pvGm773gr8CeMFkI5/1lmm7Gn1Kv9n/tx75uP+Drofi9MgpxRfsd+eLpUn
         WPvA==
X-Gm-Message-State: AOJu0Yzd8SUkgxHpUZfcJdyrGUkle9iwuw21q4OM9lKqKbTfxnvSjDyr
	ojr/WW4lK22PWiD1tNCzkv1B/XBPMaNns+DWLKo5q9zZKCysi3j6ojbtwdX8+UE=
X-Gm-Gg: ASbGncsLnYxzcu6LyX7Q3KPBR9VUASi5kHcd2cqErwy3cBwtxvhQ98EWfZ4RyU4ytw/
	dpGjNzVbKyqo0Rfc604eNWwCH/rL3OOX17khoSHs/XMgTm6/5KliKGMk3DM/sk/FdpET3jnxmOU
	2RrwLAbSIAVDy6+jfBj614dYZwq515xkmEDLmtVNUzswYqjgdAg7bXwUbNktEM3X/ROkkRMQibc
	6MQqnyF1IJa3yEPPbHxmSnbHlmKptU6AbAuAzGXyfYXi3yPvY9eVsvq5TwIRecg3aheQCZ4Jvee
	UQn12UyNBnKV78D7IRgOxEMKmEo/mPd6ml+1
X-Google-Smtp-Source: AGHT+IG4lRvPyKFfryFcZpb4wMqvD6ztSnUsx1nVX25CHJ96sGhD3D2ZJtP9dRiKL1RUhV42vmjqpw==
X-Received: by 2002:a05:6e02:178f:b0:3d4:6ff4:2608 with SMTP id e9e14a558f8ab-3d5e092a622mr28591325ab.12.1743249465068;
        Sat, 29 Mar 2025 04:57:45 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d5d5a6345esm9616765ab.1.2025.03.29.04.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 04:57:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <20250328194230.2726862-1-csander@purestorage.com>
References: <20250328194230.2726862-1-csander@purestorage.com>
Subject: Re: [PATCH 0/2] ublk: specify io_cmd_buf pointer type
Message-Id: <174324946362.1614213.12674397297873310075.b4-ty@kernel.dk>
Date: Sat, 29 Mar 2025 05:57:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 28 Mar 2025 13:42:28 -0600, Caleb Sander Mateos wrote:
> io_cmd_buf points to an array of ublksrv_io_desc structs but its type is
> char *. Indexing the array requires an explicit multiplication and cast.
> The compiler also can't check the pointer types.
> 
> Change io_cmd_buf's type to struct ublksrv_io_desc * so it can be
> indexed directly and the compiler can type-check the code.
> 
> [...]

Applied, thanks!

[1/2] ublk: specify io_cmd_buf pointer type
      commit: 9a45714fc51321ea8f5e5567f70e06753a848f62
[2/2] selftests: ublk: specify io_cmd_buf pointer type
      commit: 25aaa81371e7db34ddb42c69ed4f6c5bc8de2afa

Best regards,
-- 
Jens Axboe




Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D9223A103
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779600; cv=none; b=j8+xGzAs0Cx3qfqRzzQDJzEI/FhT6Y4yBWw0AUa9jxL8uKIxMaHRoKe4MbwmwUSbehbDcUXMh0Wc4e/OzIs8W7aScaxZ09ihiSj5nfHyNqWBL2YcGnNL00Tv9WtpSQxe5bkrLj2A8h63b+LZjc0UL3IEJ4vQHzju0kPH+zYj3cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779600; c=relaxed/simple;
	bh=oLVWVS3aDWbUGRGwFz43EWOSnlhoAgNGz9bQDZwBxUM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QZ+a5QHkawubSy8/VQgy9ILY/liCwCG+36LoMw8AbxZuYeXowR6xgUdRNaFV8nRDoshe8mUhtYf3mAlb7yr9nVHRR0tEceIVrziDJ6MCFGtg2dL1/Vi8s4h0+4ruGOA8DQpHJ+S58gxoQjj9SZM0HFpNipu9VzddK1PR+pS3gxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PqTbUU+6; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PqTbUU+6"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a816cc9483so29133575ab.3
        for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 06:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736779597; x=1737384397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA3XuZUcsxz2VJKOnzZDbEDoiNe5aOSoYX7+SPjuhMs=;
        b=PqTbUU+685+U0iTwSse6C/0LKZX4dR/6oT1uZwSb/R8oGKVRder8Qgk7QK3h7e1TRS
         LpiiNz/AXdoagEYI4tNnY7wTcI4uGwge1gFSyrbcYBLm1cHgGFp7SeJWqfIpSOxcV9g7
         8aWz0m706qvEfOet7ciHsaSFkrcquO1dnfDtGj70Pqs5saET81puf+B3gaMCIBuQIMLu
         T98Ao9MaLrvMPbproOf3X9XT34pHVhFz2my1Ayf+fCETMsgRLJtEPH+RAsXuyN95kGo2
         XE24QROiMoe6k67JsfCcFCT91ZC8VWj0q/8EcR0kmxN0HLRRvrGS+Htejsh4JdTXz5Z9
         wV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779597; x=1737384397;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RA3XuZUcsxz2VJKOnzZDbEDoiNe5aOSoYX7+SPjuhMs=;
        b=vGfXyPcJkO7u0wF/bHlyXIAQVVL9EI5+bYbvVLC9JoGwBhGgDZyRpY2KiT8YlxWrkt
         v+iG7ZeKJo9tHvMPNVvLSSHVEQlEIFgVMC1JgHxxQS1e2XZ0oZu8kwD7dqxmvJ1YT3gd
         gUpONue0gYcOAVWG0gIEiRLctIUSY22sHEGFLF6/qqjrIsmPYY1KgjpLIl+n9/ODupAy
         +VOjtyi3N7IbMP1qemPkKzEXZ21e7UFRxEoaSgP7cMcLcAdbfnB2AFf8UOGO1GaJ8KZ9
         maa+46bnQ45a2/BtvtUuzhxhtIy/s/hJQ7/FXVo9wOnZmimgcc7LjnX83r6PGp7e/g3A
         IT6Q==
X-Gm-Message-State: AOJu0YzKO4HQiJUIvuQEsFD1e6Q2FXncx12POpMk2R4UIMcKiXPkQNFO
	x+qU//mOM1YirCNPTRbN1He4JSwHbQnTO3JTbDuZLDI/TT+iWIHIwYTOdUQndlJcvsguJKD9HJn
	1
X-Gm-Gg: ASbGncsSsp86i8+DJuyF4zZhIbhEwhZ94RqjgAF9kNruoPgnh6tKFGgPwKDQBn9YLpe
	o6GWzULZTLuVsr9k4vMHYBqmfeHmCpG8zG0jKUehrROHApGSvyU3S1E7oQ+e6fHsdDFmBqsey0V
	Pr58MUnG1hpJH3Wrst7hPY24ALm57bt62GmgTx8TEeMkidxy03AG+qQSEB6tbyr1B1ItNbJld+e
	iYzUzNuJM+/iauI68yTB0Yjx2L8PZ3HNNQN1SIGSSy9cgg=
X-Google-Smtp-Source: AGHT+IHa+TdSTDRBieysJQf9I1GsQ07SWRHmNbPAW3j2m0fkSZwFAzoyyTMnwpKlhpJ+sKNW10F5Xw==
X-Received: by 2002:a05:6e02:1f8a:b0:3a7:e528:6f1e with SMTP id e9e14a558f8ab-3ce3a8880c6mr161100605ab.11.1736779596982;
        Mon, 13 Jan 2025 06:46:36 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b7178d1sm2790840173.95.2025.01.13.06.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:46:36 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: josef@toxicpanda.com, nbd@other.debian.org, eblake@redhat.com, 
 vincent.chen@sifive.com, Leon Schuermann <leon@is.currently.online>, 
 Bart Van Assche <bvanassche@acm.org>, Kevin Wolf <kwolf@redhat.com>
In-Reply-To: <20241029011941.153037-1-ming.lei@redhat.com>
References: <20241029011941.153037-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3] nbd: fix partial sending
Message-Id: <173677959574.1124551.15074727765377070500.b4-ty@kernel.dk>
Date: Mon, 13 Jan 2025 07:46:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Tue, 29 Oct 2024 09:19:41 +0800, Ming Lei wrote:
> nbd driver sends request header and payload with multiple call of
> sock_sendmsg, and partial sending can't be avoided. However, nbd driver
> returns BLK_STS_RESOURCE to block core in this situation. This way causes
> one issue: request->tag may change in the next run of nbd_queue_rq(), but
> the original old tag has been sent as part of header cookie, this way
> confuses nbd driver reply handling, since the real request can't be
> retrieved any more with the obsolete old tag.
> 
> [...]

Applied, thanks!

[1/1] nbd: fix partial sending
      commit: 8337b029f788272f5273887ccefb8226404658ce

Best regards,
-- 
Jens Axboe




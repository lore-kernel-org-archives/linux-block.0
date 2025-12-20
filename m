Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840FD2D6407
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766262351; cv=none; b=uJfCYi1uxyJMTgaij1XPi3oMHYN/x1CzKpfwpV012TRBmPbLlJcZchTp4/7KUhg7Te9wbBS4MtNA8NiX+nE/r4TTNQm9MtdFuJNL4429gEKcCeY34jp0edV/uCwp8HSXfugbLf9I9Kg8u0M6xe8uxvAczSHt3TeVCqPUAh+eM48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766262351; c=relaxed/simple;
	bh=WYiBPoNN15TRawXbXQ89ngXqO29M2xbANzu1FZDc32w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YGC5yIWdt+7QBO4gpl4ZK7ECqx02PMnW1jQrc7lFMlpl1hgBvT5wCJZqNuO4OJs+0n3fhTOzRB/MfEpHrftiyCiU72jUDTsb4CT0BmopjiX42MfpNXzVKAjEcmV+aczamyMAw9cHuliF5qlmRqmfHP5TBs/rW5rAvBBbfumGnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bRWJHGeC; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bRWJHGeC"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c7bfba3996so1684342a34.0
        for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 12:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766262347; x=1766867147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/lgamY9SXCimSG62HLgmOca+s6T4w5UYIKxECAKLIo=;
        b=bRWJHGeC6n7pgXvYnYX83YRwPiY89ncCwAHgUi1qWKOKM7EnsQKVULSNMOjOiUmpcY
         TLfFRhTRTUP9BjciSaDjgznVaA9zhD+Pzi/T9j5SPE65KOXIijiwTMdETZvb/Q3i7O+k
         PIXDA1VgiW4/kULiXA/y8ryONImPQQCSi2F2a9TJRQHaiLT5YkbKODlK+RBv6kl4vQpD
         7njhRVcCR2NYsJeMVUucd/zHQ3lsFzDnJ9qthF2BNBpkJBq0yjgwU9+tel7iYKRqFef8
         jeF/3WK0QO6QBF8xLr+tVx08VkZgl0ReoBj4cD+iLEt4BPCxRwjIN/TpaZDF/bsqX4uI
         EkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766262347; x=1766867147;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H/lgamY9SXCimSG62HLgmOca+s6T4w5UYIKxECAKLIo=;
        b=HLyv88Ca+91+4e4R/K//NSELLtQ1nFKpIeh4qOgllva9XUH2ZZxABYTSMg2ATE7kGf
         iISUHJeDIOlij8fMUD29uPdZNCE8S0iVJ8rV5z+02firApyyOOwni2MwtheDft20bzjP
         Sx6DeQuAaDq27tmkuWMjAUPAvkZU8rLU7pfAHiEDcaDB8Gp6oP7jA8byAZ7GFUEEwfJy
         1bczLx1z4epSyfyRxa/BlaByfeuNiSy203/bUUt6wEIdIoO36jNj5l4Cnd2Q3WXinEU/
         ZUAHsm4kUfzugcHp+lkzVrIK2orBbmZoC7XEQLdz5OOzZZi5ydqA9uzao3UWxCwTTCT7
         90xg==
X-Forwarded-Encrypted: i=1; AJvYcCUDCNdUTFy5iqrPLcLterqgN/AJM9DWLTQ/T/KMeH4IfjTKV3ildHbLx4jrZV8s7mZ3jaD910Rpeq9vlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMzMHZ7z3tzTmNQSJK48gpt0ZyspojeFQ7Qu4zX/b2uMKJrJGp
	vFiPr8MNvyVPHT1/jjsTdrOLGFK5L5DfVnK0he9DUOSy0uRScjy0zv7EKq8QYrKgspk=
X-Gm-Gg: AY/fxX5OQZL+ckbL0HInllyxbIb4vh1wKhJkg2NZuduTlmuemAlbe9rSAqIi6vBb6hC
	PjEN8h1HKhbdEY5WTKWacILl36t6VJYYED3TMz7S9It5dLMTSXNGqMedvmg2DNfu0e3Ba6gu9Ju
	T2oNzQk9Hkm8hgpUAndqZ0dHxpaWTKdyE9UEdRnQT9oXEmPOK7mstqo9/g33FQ+vtatGCQtZVTT
	mCx1yYmrZnnt3SPzyG8qoQE/9tofSTLDvQGZXylfj2BQFGlg9FjMsJt5CZeyH0Zku+YMu/WckhU
	2zcNDNwBhvb3WiRrS632sNDJa6tWwN3tU0y6rntcLW6aPwzmppQJTu1p5ocvwrE3MV1ukTb8qzm
	LlBpOVS0iwBvVBaprobPZ8qoxZHGQ+nG68+h5Wz+Zc7xJ4D3+oq7u0BJRnf2JUtAcshBrgEaFk8
	bJmc4=
X-Google-Smtp-Source: AGHT+IFu2TOReZKWvA4ImfOcDfP76tmGhfg9TIAZOlwn1PwsJysVvxo/+zeCRv31OC5KYhiPkd1OwA==
X-Received: by 2002:a05:6830:6731:b0:7bb:7a28:51ba with SMTP id 46e09a7af769-7cc66a95465mr3361625a34.26.1766262346970;
        Sat, 20 Dec 2025 12:25:46 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc6673ccc2sm4240033a34.12.2025.12.20.12.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 12:25:45 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251213001950.2103303-1-csander@purestorage.com>
References: <20251213001950.2103303-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: clean up user copy references on ublk server
 exit
Message-Id: <176626234523.413702.6264984213970998907.b4-ty@kernel.dk>
Date: Sat, 20 Dec 2025 13:25:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 12 Dec 2025 17:19:49 -0700, Caleb Sander Mateos wrote:
> If a ublk server process releases a ublk char device file, any requests
> dispatched to the ublk server but not yet completed will retain a ref
> value of UBLK_REFCOUNT_INIT. Before commit e63d2228ef83 ("ublk: simplify
> aborting ublk request"), __ublk_fail_req() would decrement the reference
> count before completing the failed request. However, that commit
> optimized __ublk_fail_req() to call __ublk_complete_rq() directly
> without decrementing the request reference count.
> The leaked reference count incorrectly allows user copy and zero copy
> operations on the completed ublk request. It also triggers the
> WARN_ON_ONCE(refcount_read(&io->ref)) warnings in ublk_queue_reinit()
> and ublk_deinit_queue().
> Commit c5c5eb24ed61 ("ublk: avoid ublk_io_release() called after ublk
> char dev is closed") already fixed the issue for ublk devices using
> UBLK_F_SUPPORT_ZERO_COPY or UBLK_F_AUTO_BUF_REG. However, the reference
> count leak also affects UBLK_F_USER_COPY, the other reference-counted
> data copy mode. Fix the condition in ublk_check_and_reset_active_ref()
> to include all reference-counted data copy modes. This ensures that any
> ublk requests still owned by the ublk server when it exits have their
> reference counts reset to 0.
> 
> [...]

Applied, thanks!

[1/1] ublk: clean up user copy references on ublk server exit
      commit: daa24603d9f0808929514ee62ced30052ca7221c

Best regards,
-- 
Jens Axboe




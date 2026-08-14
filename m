Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F23515EE
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702531; cv=pass; b=uiSrU0gYvJfnNfODrpmvNvJxopgS9dCQyyKDD4gsKFqUDBkeACo5/lZLpuQeQhxmJzLx3TrvbBNcA6TNFV8AqDfqSfjBNRTfbBoD0OI16dTzW+pK5B6xuk/WqOT9DfETyc1PFwBOf85ZpRMjfKPZP2+/gnhLDlXjsPqUcOgvgwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702531; c=relaxed/simple;
	bh=kcqD2LBz28PigiZgtItz05HD6+kelhc5LWa7cOtVR3k=;
	h=In-Reply-To:Mime-Version:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsI031qVwCTNgS1HKbpUtIsJexiMJFGSdIlV3f8766RBFW+oAkZqgQWO3CJPX0tkaD/RpvzStjIhgDCGGSXZiRS+nOuu7dqFmSUoOPWcHgOKz3R0lEfRWfrRdamg48AVzYlzreoxyN388Dj3dlxaO05i4hWS4pzajJj1Xqv1j0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NuT5bd0S; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NuT5bd0S"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e041ea211so899454a91.0
        for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 03:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786702503; cv=none;
        d=google.com; s=arc-20260327;
        b=nUWgZskCTBhP5tNmPzQsakIKpzdbkUiajdZ0RVXKuryylpWCXbGnKE4RJEjG6Q6h70
         4/VRbPgXrg8Pay+9ZjB7lj1bH02Sf1L1O5gTY3CqZAol8JZKLhF39Hm4rN0P5qU/rOJ6
         +517L857vzkI3/MjvTo3KZqYb/3x77UuU+L1ICCpkFx0Tbi8wSmwfzjyAlaitQPQNZ1A
         Lz7HfvpbFP3qTjBSzHIzEeQUIWxCiX3LTdwrg52o5U8UtJJH4c63bO5cUnGUfnsXgxu7
         N8LpAoc199P1Q4vHPVe7aAFukeUWo5fy8YvbXxyPVJutBBqtqIkbp3pnhHQecanZf0JF
         JKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:mime-version
         :in-reply-to:dkim-signature;
        bh=kcqD2LBz28PigiZgtItz05HD6+kelhc5LWa7cOtVR3k=;
        fh=qwCrOrbarZlUR5Rd0ncRdvCwA63oHHI+J+Y+P9sfvM4=;
        b=d5h0vT6JNnZUxRR8WnhK9DK7QVnJOeQVVJb8BGKIo/g1A0hJN/7PNe/4yLYZJAXWgN
         PHk1ZP+zCacLlI6mbyu7jcfoUadWJR/v+ra7z8kNrtWTeQC7gB6zAUHIGletwWp7mKty
         /uopxyPAm+m2Gu4sXPzi5YAwUqJNcQ7Wnan12E9qZhtVgzaguW1Vjj2/R7dFXaDWQXrD
         xVODp3iKNT+hXeFSrG6QU22/nswEsnMISi5j8Yd46XGcx8wCg0oU2j0XaYy+aprZUe5B
         QDfsg+P1f9sxd1YLuRxe4MBxSESbKNKZEHRthXfQZyXnwGhIRE7wXf9nUJ09dEvaB3NV
         FwPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786702503; x=1787307303; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :mime-version:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kcqD2LBz28PigiZgtItz05HD6+kelhc5LWa7cOtVR3k=;
        b=NuT5bd0Sv3Ia7Q1EXkdfWj/fx2nRYGiBEZLBRUMbVYp+fHLIGrzB+VLjcUDVZuBCUr
         UlPRgGdU7HQ6G/MfLq57x08SaTcFK0NsHa+n5iiZaywjD1Ae+qU16q1u7BgqA/GXxcB8
         8C/5KAchnqsHlTwuJIVNX/p4ito7mXNJz0Lvv99kzr4qTUSAct15xqxmZKZt+c+Q9uvd
         G5CdVRviqjRapckdpEcdu6uYo4rWqFSFcAezCGMfKyw7loLjWvQMP/ZOd2qtCI0AF+md
         z+sHRM9j4kxeJgjofvMNXh7iox5C1Pf1qqQT+WETsaf1+9rQ0WCejJlWwyo4wNloEoJw
         5Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786702503; x=1787307303;
        h=content-type:cc:to:subject:message-id:date:from:references
         :mime-version:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kcqD2LBz28PigiZgtItz05HD6+kelhc5LWa7cOtVR3k=;
        b=pAW26jSCYtegiiqQpP6FBsE8Mu/z2gBkWYkgQS5UtMZR0CCLdXajx0VScEcvyHvfeC
         tJWMEl02jtpyH0HIDB97j71XD9FiZsaUnIuHXaHf4TS8IIa8XvvX10EOF1tHDSwJd7I/
         cT8sOJvF9O1DgIsvOkYB4x5Wg2zABN/z5ZVxl9pedzEvCGsEynZGlEz25xIGhnxmQeoz
         n1VZP7C0QUi8KN0YpUmXBIjHmcq6xl1qxz+KpmOh00WYZP+gymltLxSN2nngXqGz669r
         jUSXQ4mDHr1faPHhgWW8rOjaPtVxXam5dJUyMPOzIY6wNUtSn1ZGCqXpJmkyzke0iJzJ
         72Hw==
X-Gm-Message-State: AOJu0Yy6yrERVhfXdu1g+l5zLrl0gClHcuDYo0urH7OMtBQI2JXShy2v
	UrW0bNfsGavS2o2L3K0fkpziGGPpgNiMFsRdX6sCXiduShCUwhlYPuRkR3lCZgiKRja4eLOhdJ0
	iL9QnEuvCT5tda3C90A67qpb5eYwV1tb6SAsGr8fqoA==
X-Gm-Gg: AR+sD13fkU6mB9IRBflkRYGqk0ckUoqXxuENkH4kWSlelzVusQjcvCQfkMZiadygEU3
	A7ichD9LSSjPJbJDLXMaPVMB2zY8LlGa6jOOljv9G6m09zBXnYGzQK2ak6gb7Ab8swoMc9Dthf0
	0LocnXIu4uNewS/epQ/c+Cyz8tVqA6zS11+qC8fo4ggK5wbJbhDr1CYeCU2qef9jp9xULznwE9X
	4/RQ8NgUBcwdmsYxoAuZfw4YL7YxLOtkZ1q/RSTrmocgE8UUIRlTWcjd4DEhgYA4f5R1Rn0beHd
	iZ2l2ziuIh43n32O9q4nkKTbLOlnPs/6SggfUmt523I=
X-Received: by 2002:a17:90b:2248:b0:392:c80b:8eff with SMTP id
 98e67ed59e1d1-3933b87a743mr4376567a91.11.1786702502389; Fri, 14 Aug 2026
 03:15:02 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 14 Aug 2026 03:15:01 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 14 Aug 2026 03:15:01 -0700
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260805122930.57647-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260805122930.57647-1-yangerkun@huawei.com>
X-Original-From: Zhichao Huang <huangzhichao.1@bytedance.com>
From: Zhichao Huang <huangzhichao.1@bytedance.com>
Date: Fri, 14 Aug 2026 03:15:01 -0700
X-Gm-Features: AUfX_mxHJXAcDA4dpAkkajkjnuTH7E-evpPwbklipP85hLwaZXg6SHWDfCbuSwI
Message-ID: <CANUnaibYL+jqiMMKOpC6myS73WKYhog9ozEc2TG-AVe7LYLGBQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] nbd: eliminate queue freeze/unfreeze overhead in
 connection setup
To: Yang Erkun <yangerkun@huawei.com>, Jens Axboe <axboe@kernel.dk>, yukuai@kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hi Yang, Kuai, Jens,

I'm writing as another production user of exactly the workload this
series targets. We run AI sandboxes on Firecracker microVMs whose
rootfs is attached over NBD, and we launch many microVMs concurrently
on many-core hosts. We independently traced the same problem this
series fixes: the blk_mq_freeze_queue() calls on the connect path each
wait a full RCU grace period (~35-50ms on our many-core hosts), and
because many connects run concurrently at VM-create time these stack up
into a significant create tail-latency contributor. So this is a real,
independently-hit problem on our side, not a synthetic one -- thanks
for working on it.

FWIW I had separately narrowed it down to the same two spots (the
nbd_add_socket() freeze from b98e762e3d71 and the nbd_set_size() freeze
from 242a49e5c878) and was about to ask the list whether the add_socket
freeze could be conditionalized on the initial connect. Your approach
is cleaner: patch 2 removing the freeze's root cause by rejecting
NBD_SET_SOCK on an active device -- rather than relying on the
capacity==0 / bio_check_eod invariant to keep holding -- is exactly the
right way to make patch 4 safe, and patches 7-8 also cover the
blk_mq_update_nr_hw_queues() freeze in nbd_start_device() that I had
not addressed.

The whole direction has my strong support. If it's useful, I'm happy to
apply the series on our Firecracker + many-core setup and follow up with
a Tested-by and our create-latency numbers -- just let me know whether
that would help before it's applied.

Jens, as a second, independent production site hitting this: we'd
really like to see this land.

Thanks,
Zhichao Huang <huangzhichao.1@bytedance.com>

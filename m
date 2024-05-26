Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDDDC13B;
	Sun, 26 May 2024 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716725568; cv=none; b=pC2Q3CI8Amx7mvrFH3nYeyQzjyft1nLUecMaQvOF2sZqKGBrUcCxTOJoniEFzQoFExPs6yufu777pNgrGlcl2+qQbvCmPIz/dpvhcJaTCFK2rpMnMDAvVq9mJozdosgQ+RFx2KP+UeOeGO9jFH+6Eb8TfUnJ9u/yrOoYwStpZ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716725568; c=relaxed/simple;
	bh=ZMVFJSRS2yxYjeJpxLja6BCPls0KW8ksKZKmGSK3Sl4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SuG8MbCtEGEr8X5aquutVgwR1iBqy5IMX2QJ8NgmbdVQUJZZYpOxCQgxGFyceWvJ4OEICgWsNaPFhh0WY961rJRUcBSeMVolSqI29STC5iASeh3hl6VTAjcQhru+NJCKI4JwTRlzOxpksxu6kRLTCYuD2SJymWXUbxd56nRiMCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lM8VfTo3; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM8VfTo3"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f8d0a1e500so2012458a34.3;
        Sun, 26 May 2024 05:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716725566; x=1717330366; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YZMEk0MJ7v95mx9JD25KgC5mIBJ6kyKaibPLYwKl5lw=;
        b=lM8VfTo3iyuir28gy8/DY7LCGpMqL1+SuW0jggP62mpGyzh7Yy7e+9mkj07vNUyX8i
         hdUThvLzCFSuuT3HNKKFqrwof9NWYLpMCOaHqVkZpQTtveyBtWr0dWl2e42WHHNdczRG
         h1L5kJX9dyEsGMBdAC41nBTbLUYVtlkyuuw6f8JwNND2GGvH59vBI0HpBmuW51vEN7kI
         0FElWON3veHluuMxSCkN6aa0EPu03ytKtQSM2VQVjiwN5GcWR7PN8MEAI6/zpwUo07mV
         K6XPRlVpSI87H8DkEz999BwjWRmE6KLePW4My2cHBXe5pGHOIm5Q3RExwpW6lSzp20W7
         dK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716725566; x=1717330366;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZMEk0MJ7v95mx9JD25KgC5mIBJ6kyKaibPLYwKl5lw=;
        b=Qy2DYIAFdUOFbaI/FFT5bXXvLFuG0dnncWXE8F3gNPms1Ey7XXxh+w2+YWxtaAEhYp
         wz3LemS6Babb9yz6v9+HGLIQqdceOTCBzAHgTtiZ6zg58dXI7q8SsiLSpeSZK0l/sGdV
         qa0KYCkWTOct8Xx/qXBx/WXCQYdsi+LDH1JFsky7vmh2srytS0hEEAndvBkR5HEaCsvd
         3zbVd0Rt8ie9ZUc4sjX94jucrAb5a2Km/dakbyuZpwrQOvNfmIDVe9h6rpbQsc2o5aQW
         nfTK+D1LBaifr7uEGcx0xF9ykgo/pp3mL8eljyRyyyftHOq0oh42AAKSrYFwdAPQshyo
         GchA==
X-Forwarded-Encrypted: i=1; AJvYcCUPbvalsSk+9xmUCZ4XolKqSOouJsRcck4gtGdx7ftWP2gP+TzqIYTICPccr+dCpvwzCw64fy3jpxGV0InYoJ3GkyioaJrN
X-Gm-Message-State: AOJu0Yz3YBOkokLligGYxZ2276b/BJLI5UwRfVC9WciX29cdXZFwYG2j
	B9uINxfmwPt8vk4920LUxbaxjisiZl+W5qrGPOsS8OT83yRqTvEZqElAR6wD9+2IHAoRdcqlwAf
	njJFYAaDEtoLEnfjPEUUYZuGKGaajo6aDJDk=
X-Google-Smtp-Source: AGHT+IE1MDGE9QLtBK+sakiMMrwhyyPKERzoTeqoNJqSNZGTCFkYi0jLEa9juBszHLzTsLGXkA1ZJEME1kpVEJY/jbE=
X-Received: by 2002:a05:6870:fba9:b0:24c:afd5:1135 with SMTP id
 586e51a60fabf-24cafd5123dmr6721138fac.18.1716725565758; Sun, 26 May 2024
 05:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Rankin <rankincj@gmail.com>
Date: Sun, 26 May 2024 13:12:34 +0100
Message-ID: <CAK2bqV+2iAG8u9vVqYNFho8ccjE88LWwoksH+-7765g6X4CCDg@mail.gmail.com>
Subject: RE: [BUG] NPE with Linux 6.8.10 and Linux 6.8.11 SCSI optical drive.
To: linux-block@vger.kernel.org, Linux Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

FWW this is the output from faddr2line for Linux 6.8.11:

$ scripts/faddr2line --list vmlinux blk_try_enter_queue+0xc/0x75
blk_try_enter_queue+0xc/0x75:

__ref_is_percpu at include/linux/percpu-refcount.h:174 (discriminator 2)
 169          * READ_ONCE() is required when fetching it.
 170          *
 171          * The dependency ordering from the READ_ONCE() pairs
 172          * with smp_store_release() in __percpu_ref_switch_to_percpu().
 173          */
>174<        percpu_ptr = READ_ONCE(ref->percpu_count_ptr);
 175
 176         /*
 177          * Theoretically, the following could test just ATOMIC; however,
 178          * then we'd have to mask off DEAD separately as DEAD may be
 179          * visible without ATOMIC if we race with percpu_ref_kill().  DEAD

(inlined by) percpu_ref_tryget_live_rcu at
include/linux/percpu-refcount.h:282 (discriminator 2)
 277         unsigned long __percpu *percpu_count;
 278         bool ret = false;
 279
 280         WARN_ON_ONCE(!rcu_read_lock_held());
 281
>282<        if (likely(__ref_is_percpu(ref, &percpu_count))) {
 283             this_cpu_inc(*percpu_count);
 284             ret = true;
 285         } else if (!(ref->percpu_count_ptr & __PERCPU_REF_DEAD)) {
 286             ret = atomic_long_inc_not_zero(&ref->data->count);
 287         }

(inlined by) blk_try_enter_queue at block/blk.h:43 (discriminator 2)
 38     void submit_bio_noacct_nocheck(struct bio *bio);
 39
 40     static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
 41     {
 42         rcu_read_lock();
>43<        if (!percpu_ref_tryget_live_rcu(&q->q_usage_counter))
 44             goto fail;
 45
 46         /*
 47          * The code that increments the pm_only counter must ensure that the
 48          * counter is globally visible before the queue is unfrozen.

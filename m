Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1A63BB40
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765907853; cv=none; b=l+DQacjYPc0WF9ekrNYB24J56Y0O5g258wlaNm/63G/1WN2xDaZBFV3QCTbHduFjYDDxr3+Nge32H8wfkUuKm/CpkreQYcd15xiP4/v7Ov9iqd0rPjFK6rQAoSuL2BqcU1C2zt7o1NElNHu0aKETljk7vjpc2ofWfewO/hayij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765907853; c=relaxed/simple;
	bh=KBEJnz25kuRDr95wtUh1NJVQHDQ4WkqgL/hNEypwNAY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dQjGeAf4Mqs8T3h4VbH3TtRPfPbOXwYgNMk5W6O65cPWVKIF8FECJOTbYs+CLEYIWnb86rsCj4ZV417wZ5YWMMTCrOodayJhZCbup/95Et3VM3R1jvMWCQEjF2x7+jMOz56bAUDaTKLeS/BF9IRIF1ed5d4+VCnjDgFAqd3NlP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Fa/6A7PD; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Fa/6A7PD"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c7aee74dceso2019456a34.2
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 09:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765907848; x=1766512648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WKho9H78QLmw2kchGQF/SQwDA/V5m4vvZx4Dr6moF50=;
        b=Fa/6A7PDsplZEl0nAI/GG9txf0Eq3Ps9l8JLPpGJVVfQf2eOdWjtlVEEuhueDAJc3x
         Xncfb3ydBmKqNmFkWGP9UGWZ+j3XKM2395zSh9ViPk/Yk+SEMqiTGvjNwxXdxT1KTL+I
         o7nG0hPZw6+aaYUw2ddqbD+Fv9fiWfXIkBMthJlvzeqhNJFXdtvBpmRSgcTRnxmV3NB+
         aLdsmp45c3Yzys+NPLUSflvIZo30qdYembdsKGULFEHvwivbpzuqLorYernGx79XwYAq
         e80Jla63niGqzyMCB6KG0piisrQE5oK+2G6lJUOB3F2f/DqPIpBrJgDP0gdfudym2h0O
         iKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765907848; x=1766512648;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKho9H78QLmw2kchGQF/SQwDA/V5m4vvZx4Dr6moF50=;
        b=NwX2tI0mzCOKR2adP1h0ZbVpMlatlEMiQgDBs1P0gAzLUbvJz18MotmRcebOgMDUKo
         zUc0wMgtD4HKK9BaPDTxmkRVfEcTTcUDn138b7vdPGgGzuXfHDe3yfImg2oPyRPKvfez
         /YXuhFwT7rrvUXC9mqX+fxCy8VdWldfY3smUoPu9gfevSq9BGPtbmIESnGmLQAaayi4V
         LozDAQkj3WsAgSh/SIjC9zc6A0BcXcftojbq94VQizYm40X7QP6EVy88js5QjbYLIk54
         C1h1FtF2gHwiQgRvn9pN6PNccUseSYe2FiM3elXGqvDkZFT7IQHOoJEkqvRwe/WzkAvX
         h2ww==
X-Gm-Message-State: AOJu0YxUsyubXnvAHIVRyFQbC37Dcn2rUSuSqvZBMdJaI+pbmgmTPtEE
	gsYwiP0CchlLXOisGxI6GwCvRZA/ePsUnXko34mXJgZrVa3FzaV7MWZJZYYi7cjVZE8=
X-Gm-Gg: AY/fxX4nFwLADpD14qyv2Kf6E2GbxzHC8OaD0Q1YxPIsArW2Z6OH+cIzgErGBKz2c0a
	FqHMEzEX+ELuhAyEqVWpZPS42wu/jd//G2qhQiqdL8qwHAqiXkhzp5GZi5yNheN7VG2s89xOUTn
	+U074D+eeiwK4i+84Qi0/mQJzA8uzASB1AF48DMYyOjYWO99adUh0R8bTKueWmJJx+H+CN5aJLK
	Hj7cMTUXbR+xInyWHWJDFXdXckSnx65Eq3blTa5FPcy4JVjaom3b5M4faL3GjT+nUWmcHHOA0cA
	gjWDga7Hq+n4t/piHrRfkhGvk4gsbu8XFOLknDdpE2wurHfRQ6lyp21+ARSwuHmK4nb9MMD3uQt
	kX1CdS9XTi/ohLKUUzZkMmM+mU9kD5furvPwzrpnnvr/9oBMeBegmCLDwxKyBdt+c7tXYfI/Fzg
	VQ478UGgK1Ryp8ttA4zw==
X-Google-Smtp-Source: AGHT+IGxFmvR/WohyAuAXNikVTR3H9alSqIUgBqFvpV0wlN3kp04pnOSB8VcRsktPEX2uUrT3a6TuA==
X-Received: by 2002:a05:6830:4393:b0:7c7:5f8c:71a3 with SMTP id 46e09a7af769-7cae82ebb9fmr7863500a34.2.1765907847686;
        Tue, 16 Dec 2025 09:57:27 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cb13e0767fsm970434a34.27.2025.12.16.09.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 09:57:26 -0800 (PST)
Message-ID: <5e2038e1-efcf-4313-8a14-565b970370f2@kernel.dk>
Date: Tue, 16 Dec 2025 10:57:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] ublk: fix deadlock when reading partition table
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Caleb Sander Mateos
 <csander@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
References: <20251212143415.485359-1-ming.lei@redhat.com>
 <8dd3c141-3e92-44f3-91e2-2bf4827b36a4@kernel.dk> <aTzPUzyZ21lVOk1L@fedora>
 <93163617-11bb-4700-aca9-940c0df7429f@kernel.dk> <aUEeu9luJ9ZNvJzA@fedora>
 <6d40e8a0-14e9-45f4-bbea-360678524767@kernel.dk>
Content-Language: en-US
In-Reply-To: <6d40e8a0-14e9-45f4-bbea-360678524767@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 8:03 AM, Jens Axboe wrote:
>> The issue for ublk is actually triggered by something abnormal: submit AIO
>> & close(ublk disk) in client application, then fput() is called when the
>> submitted AIO is done, it will cause deferred fput handler to wq for any block
>> IO completed from irq handler.
> 
> My suggested logic is something ala this in bdev_release():
> 
> 	if (current->flags & PF_KTHREAD) {
> 		mutex_lock(&disk->open_mutex);
> 	} else {
> 		if (!mutex_trylock(&disk->open_mutex)) {
> 			deferred_put(file);
> 			return;
> 		}
> 	}
> 
> and that's about it.

I took a look at the bug report, and now it makes more sense to me -
this is an aio only issue, as it does fput() from ->bi_end_io() context.
That's pretty nasty, as you don't really know what context that might
be, both in terms of irq/bh state, but also in terms of locks. The
former fput() does work around.

Why isn't the fix something as simple as the below, with your comment
added on top? I'm not aware of anyone else that would do fput off
->bi_end_io, so we migt as well treat the source of the issue rather
than work around it in ublk. THAT makes a lot more sense to me.

diff --git a/fs/aio.c b/fs/aio.c
index 0a23a8c0717f..d34ae02c61c1 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1104,8 +1104,13 @@ static inline void iocb_destroy(struct aio_kiocb *iocb)
 {
 	if (iocb->ki_eventfd)
 		eventfd_ctx_put(iocb->ki_eventfd);
-	if (iocb->ki_filp)
+	if (iocb->ki_filp) {
+		unsigned long flags;
+
+		local_irq_save(flags);
 		fput(iocb->ki_filp);
+		local_irq_restore(flags);
+	}
 	percpu_ref_put(&iocb->ki_ctx->reqs);
 	kmem_cache_free(kiocb_cachep, iocb);
 }

-- 
Jens Axboe

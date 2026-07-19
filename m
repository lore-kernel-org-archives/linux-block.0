Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A762D9EE7
	for <linux-block@vger.kernel.org>; Sun, 19 Jul 2026 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477162; cv=none; b=TU8SLBeiCNcXusdq5G4GpsIc4oa2jY+jDxi91k13UUZ+zkppslWdLI/tC/RWrSJOJonTxM1/wm+2CvAJJZL/40gf9EJdmMExkOJ3lf3Q+IS9x/DaGZxN5vJi+7Jg/wTlWnvl9wk3T6TZrOx9kUXaAyq6ohb7QjgKrJ2qaQhRvK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477162; c=relaxed/simple;
	bh=IPntKLkEOzLvzwxcSGiD302RIanbdRbGDxuKARn4u7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=efYzA1b/DdhqTf868OVH8D7viUZh3jgh57svcoRl8Soe/QCN379RTlsnFYDWQSiFeWpeOmjGiCS8SZcJUBnJ17QpAUdB7SfM4a/VDrsHNCDv+jSwjTuh+EqFB/lxefkVmUPBebPi5hy1elRyewg/u5CCQWKbqecBGl0cW5ndJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=uWOYQ8bG; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="uWOYQ8bG"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6a3d9aded38so2549499eaf.1
        for <linux-block@vger.kernel.org>; Sun, 19 Jul 2026 09:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784477159; x=1785081959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/MvDZW/POLDcRoqoRMZWeqN9TSs71ndbA2gC5lGcHbc=;
        b=uWOYQ8bG82QAZGo3rGsmqYID2AA82Cc79StI+zvWaD/UEgIga9h8++LnKbdb5O9Qkj
         KlZP+5gb+zF5a9gq21mp8825DIJkl7O1xgVZVbrYNWVGNjDpqBcYu01ee6C3i009EvmY
         LrXHoWCC9sVU3Kw/9C9A4b/1FmjfDU7YM4MWod0V0pc+LprdNyhuxZL6tfsW4enqLoqb
         daVpuWFrZc/2ffNAPaSvszLKGJqk7ukkn39r8bz/Dh9OHs4oEPQqEQ5Lgxl0Mh2XdP4i
         gd7IQCWToQyp3WTtC4GaVWluWabJwq1I/2u6dGsvMzTCOUz65H+MQpGv2VZC89xwZG9g
         yEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784477159; x=1785081959;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MvDZW/POLDcRoqoRMZWeqN9TSs71ndbA2gC5lGcHbc=;
        b=JhupIEpuwjQAyrTmFNvt4hh0rmAV+lhHTfgYMbL4cOfRw8B7wgKwVUEZwHPcvXvMRo
         9qY7+Omff2jWPvlcalVbx1CeKUmPLKyJgxCKDm7IzelzTnPdjOLV7xADMYtJkWLwQegR
         NerhAQSvE9pNcZ2v5XIYpnnLochEVAt9IwnjVm8+put/ozdb3CfIoZ8gmwkeyBkr/7w3
         WXx+UFVvGatDw3ddsYwgUxZv6ZkY3l9io2klldj0MdqViA4FKkgDLd86a3cv5ZIjYUvf
         yYNHpxzblTH289DQKh1Rl7tjMN9hb04/8xa7bQgzfc+h91ZAVdcqQr8hWjs+aCiLzzmw
         L9aw==
X-Gm-Message-State: AOJu0Yzl2KlJ1GMyIaqjcO8Z4IDAGASDAI4SVY13erX10AqL3e2iE3se
	2apJbJ2EDjjcDE8uCEYapLZUDIUtPgTBrSderGKLiwowSDIGXpqxQsu3ir0kPxbFbhg=
X-Gm-Gg: AfdE7cmJTOfHuaqqp979NhRF0pIij3iPhrOU60lIDrorzuFqtAeuw9Pi1ic3JUkV1xt
	ZR3VsZUb25hgYngFb3QWaWUqwd5aRalJtYzM80VxplbjV1lM6BNNvBVMgCzN0E88Jf+46CR6cq3
	4G2mO9o0EvMQPaExbcvqQ59jr0c0ZbdhEn1ClfaJPLD0isGq2TfPCDYU/Y+IXGAzmhXIxzxpANK
	tLuL86nnwLPRGKbGUJ9bBXWhprPmDcydFp/AbdyNqPDlLFXpF628LhCLmXwP2Al4OBCpK5W+UBz
	bIGOQQ8wQ061aDtDxaY3kFHM4fBBVVm2263RuvTyMANhLt1Eeef2NAhpyDxqoHxuiitiE9/JIzL
	m2Y/clAfzidalEA3jCHrbxsbDH1QbTNRmx5xk62BAYfupxoZ3sFeIPQdRTrXcgB51oODERC+8uY
	En1sNeb1d0381o0zkLKSMjIli5RYKsZ+CegrNt0jOtmvhisn7nSgW1bUGKSerUxxl/
X-Received: by 2002:a05:6820:4df9:b0:6a1:818d:97da with SMTP id 006d021491bc7-6a521583b58mr5007205eaf.24.1784477158915;
        Sun, 19 Jul 2026 09:05:58 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edaf983632sm5994012a34.19.2026.07.19.09.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 09:05:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>, 
 George Salisbury <gsalisbury@apnic.net>, stable@vger.kernel.org
In-Reply-To: <20260719134540.120269-1-tom.leiming@gmail.com>
References: <20260719134540.120269-1-tom.leiming@gmail.com>
Subject: Re: [PATCH] ublk: wait on ublk_dev_ready() instead of
 ub->completion
Message-Id: <178447715664.1223836.10975749805730287423.b4-ty@b4>
Date: Sun, 19 Jul 2026 10:05:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 19 Jul 2026 08:45:40 -0500, Ming Lei wrote:
> ub->completion is only re-armed by a successful START_USER_RECOVERY. If
> the ublk server sends END_USER_RECOVERY without one - e.g. its START
> failed with -EBUSY and the error was ignored - the wait is satisfied by
> the stale completion of the previous recovery cycle, and the device is
> marked LIVE and the requeue list kicked while the FETCH stream is still
> running and ubq->canceling is still set. The kick redispatches a
> previously requeued request, __ublk_queue_rq_common() sees ->canceling
> and parks it again via __ublk_abort_rq(), and after the last FETCH
> clears ->canceling nothing ever kicks the requeue list again: the
> request is stranded there while holding its tag. If it is the flush
> machinery's flush_rq, every subsequent fsync piles up in uninterruptible
> sleep and teardown hangs on tag draining. This matches a report of a
> lost PREFLUSH with ext4 on top of ublk after daemon crash recovery.
> 
> [...]

Applied, thanks!

[1/1] ublk: wait on ublk_dev_ready() instead of ub->completion
      commit: 432a9b2780c0a01caf547bd1fc2fcf28aeb8d173

Best regards,
-- 
Jens Axboe




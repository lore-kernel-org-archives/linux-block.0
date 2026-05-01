Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5182E386C1B
	for <linux-block@vger.kernel.org>; Fri,  1 May 2026 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777631907; cv=none; b=h2KOIph3nUUvXHaCpdZTujkXshtrrf0WgTDwB5toajjwpDSYn1svOnAAcyIfaNg+N4BadAhJgwp4bt+3UHimomFpLaq1nKP12k8fgB6EVVFCJ+qiqBrrXuLtYdHZaskvw5gQsBlpPdRlkuXD/omOND/6It9ExtZlclI8W9ObGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777631907; c=relaxed/simple;
	bh=jRPXjGGpQVuH3sghMD/Z6pbvRWudGdQe+8i9Gc1JSYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dC+pA2g6dq+WV8B/xPgPOoUcTHw3pMnPRglJeBaL+g/nhwj1xHIwCC3a4U63Uh0t8YyrRQA8UmHL5msWt5CMA8yzMRNB2LNeqNSQIP9S4L0JjJHSk5sgGR8P+R93oLhNaKw2SOSkyexuhe9BMk61vmpha1RQtgmBQxEHtWchz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=mVqk/VOL; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="mVqk/VOL"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dcdaf06498so1312593a34.2
        for <linux-block@vger.kernel.org>; Fri, 01 May 2026 03:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777631904; x=1778236704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8IJBDmG1+elat2lBHUqCV3uHYQ31NaOJOVIp3DENrw=;
        b=mVqk/VOLkbFSV/sU3ybVC1TrBgcOPqOFq7GbLIZ/13chT1OEa2FELCyMP9nLjDH0Im
         hQrWBp5wHXvkR/L4kjAnU6VNwIbPlTngNlUo/CujC/ObaTDFNTOeIfzml6ScZErvQEyD
         JFy/rxMzs9HWHei1PzYaM7kuV3A7y324Zsy8DUh9W3kA1FNnSp3AoNLDttgoVvBasteq
         eJbCTQvu7nL14caCr7CXR1251r9jA4p9BkaNEw8XwZQ6LU4QtsF2o8gztKx7VpzqLA3h
         Sfhh4n5fMhjFsWgKeiV2ng766/zjrMnBEMV00J7v7cFvaCuLE5tFeM623WW3vQFiiBKv
         VmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777631904; x=1778236704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8IJBDmG1+elat2lBHUqCV3uHYQ31NaOJOVIp3DENrw=;
        b=okU8YMoF1tYpPMC60vXrAkftt1IeqabqCjypq/j53zblAkqo7gYEhcHawbJJ4Vp0Q4
         rVnXo8BYTiZFv5NK75I09YYU5YAV8Ul/5Xv2g4bcajbL3/9XhEqzXJqE8R5QlLh6BkAu
         YE3VRz6G7IG4ko4qYO1RysaPbb8p+IvmICXtx6RwcIcdmMXZ8T9wAE5mJz7zUuTHGMw+
         FkuyOOMgWzJ1rfDsjy4YgEXM/4UsV2wulXsuSgIWU8Kt02Ab1X3418ap9tkRUr2UrCY8
         10YaoVDPcXIV8JdezIqh0NbkJhI6xO7FkL1gDk53I8jA7bzNqe2vG4rE4u3KGs+b5mbW
         Wa8w==
X-Gm-Message-State: AOJu0YxUIxOs+v5aDbkaptoPZ7J9pgOx7ZNBOOZ1pL1OG/g+hSeF02P/
	Pt6s494Ddvo33XOcN3DG2i5PHwaGtRJC+RCs3Xe1vKjIOSm2jl7/8WzsFrVITAnhcLk=
X-Gm-Gg: AeBDiesl0BH3y51EQ9Yk5J2jXjayMCq7IrjFFeEY2QfAm8ZKQkfo0BaRVh1j/oXCPzq
	qZz78YipWvo6hd+m31Yez2p4ZSQZIHvN9CjTlj6PPuTFEJl+pOwBNWBlz2+qV+tL+2XaaFu8Qgx
	UwY3PLe9cj/39ZjNlOgLTy9yKW96/7plgCMaEjInAkKOfSFiSzPo25u+hWZQWtV/IgllYCM5Wf7
	qfLs+r/h8mAppjaLQ4uWDPfZ5h1Wg5r+SqNtVpd9zGhTyQxl+JdTOMCBgEq1niwv6a4WTTMSR4v
	fmwW4fB2KOrdY9q+502D7M7pszkD4/JlGrsgJwnh4ksib/2HFmNY6r4uSCGGOSk2WQ826boA7RW
	25mPqZs9VwbOGdEDQOtIKf+CsNimAQEVeix2QkyJMNfeTdDXcbCwwdk9cMFLWOsh2ukp6aY/HT3
	zaJfBs0G4vOEQwfFoP+0GLMb46gwx+LiLJyO6iTFHuWTIKq1jPO1x+s8NWJuNqys5zqwuUiSvLq
	7qM8wreBDZ1R2doUbAO
X-Received: by 2002:a05:6830:6689:b0:7d9:f50f:96ad with SMTP id 46e09a7af769-7deba2ec97dmr3890417a34.24.1777631904154;
        Fri, 01 May 2026 03:38:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ded1915908sm1192560a34.14.2026.05.01.03.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 03:38:23 -0700 (PDT)
Message-ID: <c97fe4d3-9b48-4793-a008-4fbf7e72f5b0@kernel.dk>
Date: Fri, 1 May 2026 04:38:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: reject FETCH from non-userspace context
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block@vger.kernel.org, Caleb Sander Mateos
 <csander@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
References: <20260501085216.905401-1-tom.leiming@gmail.com>
 <9efbd035-b40e-4155-8382-b42acff75a9e@kernel.dk> <afSCOu40SoLXQpwK@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <afSCOu40SoLXQpwK@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/26 4:36 AM, Ming Lei wrote:
> On Fri, May 01, 2026 at 04:34:11AM -0600, Jens Axboe wrote:
>> On 5/1/26 2:52 AM, Ming Lei wrote:
>>> __ublk_fetch() sets io->task to current, which is later checked
>>> against io_uring_cmd_get_task() in ublk_uring_cmd_cancel_fn().
>>> With REQ_F_FORCE_ASYNC, the FETCH uring_cmd can be issued from
>>> task work, which can be run from io_uring's fallback workqueue,
>>> causing a task mismatch and triggering the WARN in cancel_fn.
>>>
>>> Reject FETCH if current is not a real userspace task, and it is
>>> reasonable for failing it in case of io_uring fallback.
>>
>> I think this should be caught in ublk_ch_uring_cmd_cb(), which
>> should not hit ublk_ch_uring_cmd_local() if tw.cancel is true.
>> fallback work should just be terminated, not be issued.
> 
> Yeah, that is definitely better, will take it in V2.

Something like this, totally untested. Caveat: probably worth checking
the other tw paths in ublk as well!

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8e5f3738c203..d10460d29e4a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3496,8 +3496,10 @@ static void ublk_ch_uring_cmd_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 {
 	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
 	struct io_uring_cmd *cmd = io_uring_cmd_from_tw(tw_req);
-	int ret = ublk_ch_uring_cmd_local(cmd, issue_flags);
+	int ret = -ECANCELED;
 
+	if (!tw.cancel)
+		ret = ublk_ch_uring_cmd_local(cmd, issue_flags);
 	if (ret != -EIOCBQUEUED)
 		io_uring_cmd_done(cmd, ret, issue_flags);
 }

-- 
Jens Axboe

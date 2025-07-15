Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D4128A1C4
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588438; cv=none; b=CbE3ZEayEFJD9a0D3TxrRf6R8HahhWJuQH9Pz46VECSTejTC8Qr6vuYJiL7HAFBr5IehW2DvvheEZdOxofRiwe8ZhDzWc4/bu6MTcbl2FAXT58Ym3yy2Cg5fyAvQudfhJMfVuYGtqdRd78/7T1nPYwkL5DlM9HyPBhswAlJLL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588438; c=relaxed/simple;
	bh=V3YR1iTGQ2Ru+i8n6izVNk6vkK3NbluH1R4Y1M9dJi8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FfNFpO5MT4PZcVWrsQIV56aFPCyTM/AqALgWciWQ2Cmo5twBeiWIG8s2J1lKODMPTduJvu97JicsikujPDlUgAi/24c41bceGK//6loYDsHOW7rSjTCTzZqYwoUj2dF1cDmbtwihaQYhSN2wh++3lC1Be8oY2xHPUzeyhGxcm6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gYvjWoaJ; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gYvjWoaJ"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ddda0a8ba2so41723285ab.0
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752588434; x=1753193234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPIVucBBo0F5UgA65beRdS748DARJInAr1/pEyhO2rU=;
        b=gYvjWoaJdtRKk2l3+WiCoBCcZFJFBuHeDoVe7kcKmtXCvXwlmFpJKnaQDmlRMixexI
         MbXZ8eYZdmRHPPU6RV4Xsw8FABusg/uuaVw2ykv7o8hTI0YDqCwVD+gqUm8SLxyxiUE3
         5CA394nwF/YW+DYbHtKMwwIviijdRIXTVfu7gLnEDwWtjjnP+jt4WXgEExtExl0KYISN
         zv6r0Kvp4244wnMAN11BXD/wOhTwZ51kdmaSkUMQai02Bcjp887tjy5IUtnKCYWMrbIm
         sFy8wHw/jFku/8DWZMHDS0ge/XMeTirXw6DQfXkY46R9A4NwpOcrfRCBRxuFVMU6eQQ1
         vQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588434; x=1753193234;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPIVucBBo0F5UgA65beRdS748DARJInAr1/pEyhO2rU=;
        b=bQaPAkV7SGrUo+qslnefQF+wnWpkNEYB53Yk05vS6Ey9FCqYCH0E1FHqT+zWRF0hlv
         JE1vwpGoS6cLvWW39NqLR2DoL4Fz0CciltE2C4GTzBr73WQyuonpOUMYqk6uaFqUu1qm
         V4uD0RMpo2NKEJN52qFdqxcQAr2n2G/57ujJOgzxeo2ryoDCye4pHZSH+91iDlG+sGu1
         RXMkiVODXClCsDIHuFi5sCZzTfLGI46f7VzRXR/NnmIfInjvByg0T2wZyEkAxDNNaDHK
         zV0V2+2OM4snOJEEnfv31rB2bPFkVq1I4r89Sbr6uo+raGiAdcPz9kZK6ys4RrhPEyvs
         SKAA==
X-Gm-Message-State: AOJu0YzitNamj7O0Zoi32pFo3wmwH2w+vIGjE7vNZqNdR95IDI1Aq67N
	cqGrUtr60M7JruqTDD8Fv2+vhLKAZUo+pJQJurPib6rpIF6tSFDc2EuXzdqncc/6/8BJdkGn93S
	jbRUc
X-Gm-Gg: ASbGncuQf5aYErTx8KcwxrAWOmR6i1+mgTxjZgZqlP4M+bFEcOi/E/0MWbZlqEuRCcI
	4KCoP1xsHGVpNnpz0WA9HxYJP06Zcyn1ZXjElgu92mxQ0byxhcm5tLIgmWrgszl5XsT68WwFHBC
	NAfLyhH+OwHxny2HDTlgguGfFF9Eg6UTe6mPy41x9kAQI/Zp87dW/XD8/bct+PxPHFSYpMtvRm4
	hjIDp9LJTBkMlW8znbrpA7Zly/Jxq8pybiv6MibJv8zkw9wAq1f7jFozrDa+crRkANgzCFWh8dY
	OxdX8fOoU+0XipQaSurdEFuJIBC0xtmLqg7eX6t9Bx4vmd+5L4L611667WP2Yr96t86q5xMylbG
	NVOJ4lIiTFW4f87QMaYf2Q34o
X-Google-Smtp-Source: AGHT+IELMufTPYW2AVXInptdbv+F0dBzIpHsoTM/wgyaWoxVrDHXhqPh+kI9ssAkJJ73VjBtTL3ZOg==
X-Received: by 2002:a05:6e02:12e4:b0:3d8:2085:a188 with SMTP id e9e14a558f8ab-3e279164b71mr27190135ab.1.1752588434423;
        Tue, 15 Jul 2025 07:07:14 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556535f2asm2573263173.1.2025.07.15.07.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 07:07:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20250713143415.2857561-1-ming.lei@redhat.com>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3 00/17] ublk: cleanup for supporting batch IO command
Message-Id: <175258843369.163854.2410311515898096607.b4-ty@kernel.dk>
Date: Tue, 15 Jul 2025 08:07:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sun, 13 Jul 2025 22:33:55 +0800, Ming Lei wrote:
> The 1st 9 patches cleans ublk driver, and prepare for supporting
> batch IO command which needs per-io lock.
> 
> The others are selftest cleanup, and prepare for supporting arbitrary
> task context & ublk queue combination, which will be allowed with
> batch IO feature.
> 
> [...]

Applied, thanks!

[01/17] ublk: validate ublk server pid
        commit: c2c8089f325ed703fd5123b39e2dece1dd605904
[02/17] ublk: look up ublk task via its pid in timeout handler
        commit: dd7a8507319e22141fa2e107d81cba18a4007d92
[03/17] ublk: move fake timeout logic into __ublk_complete_rq()
        commit: 7074feeca41d09713d70e619a34d9e7b4e219f8c
[04/17] ublk: let ublk_fill_io_cmd() cover more things
        commit: 07bc706431799e7cf5209e8afdd8071d400266e7
[05/17] ublk: avoid to pass `struct ublksrv_io_cmd *` to ublk_commit_and_fetch()
        commit: 7ebdba87cf2a248aad10aff6b5fb1ca7c6b0add7
[06/17] ublk: move auto buffer register handling into one dedicated helper
        commit: 52460dda3a775a73f226312b43c0a0211e8665ea
[07/17] ublk: store auto buffer register data into `struct ublk_io`
        commit: 21bb9facb1e78c50cf8bd5a51571fb8cbec3fb9d
[08/17] ublk: add helper ublk_check_fetch_buf()
        commit: 3446583f81fc3b98dddaac15b37d9c4ff2b569af
[09/17] ublk: remove ublk_commit_and_fetch()
        commit: b749965edda8fcf0fd3e188c56845e991eaa63c9
[10/17] ublk: pass 'const struct ublk_io *' to ublk_[un]map_io()
        commit: ef92541d99c1c1319e5254d5f5380959962abb87
[11/17] selftests: ublk: remove `tag` parameter of ->tgt_io_done()
        commit: b36c73251aaec6c9941b5493637a9007d0a56616
[12/17] selftests: ublk: pass 'ublk_thread *' to ->queue_io() and ->tgt_io_done()
        commit: e0054835bf6850245e17417fdbe80e232737e537
[13/17] selftests: ublk: pass 'ublk_thread *' to more common helpers
        commit: 92dda98424feebb5f9b9135e30219342b80791b3
[14/17] selftests: ublk: remove ublk queue self-defined flags
        commit: c3a6d48f86da1df277ef4f95f147a7f7f5cd6f44
[15/17] selftests: ublk: improve flags naming
        commit: a66f89017673881e85e65a460cfdec35da4f07f2
[16/17] selftests: ublk: add helper ublk_handle_uring_cmd() for handle ublk command
        commit: c1dc9b0d9e48380c868acd338c8912ebb7d75f0a
[17/17] selftests: ublk: add utils.h
        commit: e56828f4df139b49cb837198ef8f3d2f13db65cb

Best regards,
-- 
Jens Axboe




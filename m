Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B850310647
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185171; cv=none; b=in8fqgPmlw7iefYp+wC7hWKsZp31T7gtFcVTPOErHD79DYXvaPmAzwo4dN1ZmOYLq7kRhchLxSRxsBaVbaf5v0rLVMbnR9jMwDmRZwWFk7XPOXfIpoBAD98yjj8GX3PsmEAdiOxgh9d4DXUNrH1LPhP2eM6E/aEjyIoeu++IX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185171; c=relaxed/simple;
	bh=iOhZNFS3DWBIorVzgk9aggWgAqralyJiWSgu4ZhT9Vo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jJZRFEohfokyCPEmud01mtZMhwu7oorAmtie8+0FzX/b4HZCwDz/5CC07WG3EG2FWlfS9Rucmj82rfw5M+YoG34GQWHVmuL0RbMq2h5Rm8imBhL/jw/kL3riIWN47W0qR3H1XRTIPCIOxQNqIzjPachGcOR7Gda9CYWEE8X31U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TNhKpfpH; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TNhKpfpH"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-9444425cedcso467582839f.1
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 07:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762185166; x=1762789966; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGvMXdBJ9DLI+AY953PPZ3In2Ox2jM4bGQMRN+7vp+s=;
        b=TNhKpfpHW0VOAipudj8aG2stRaZ85yGxOpjg/E29UcZInyew8K+9SAlgkAP+xSLm0+
         Zo7CtEdafB8nFP5Sj2MicBmzp23c+DfZCU5nDMzqI738W0aYlrp5eFm82rp1Eh0ZtJQ4
         yDKMrL2pJBRg2Ts7csi5diplCxY769c8XUJLvVBWfQ+M2nSRtzAyYejMT4bA/Q4ye4oC
         lB4QLCUpAiPzSLUJ0TWDppea/nOqFZ/LuoIK6lDKnSC2LTqVmLYNzVSP8Y+ox6zdbjt3
         Hk8KL0vshTlt2IfE8vLPvz6uzhjNBBuvzlD+bllQmlwdIoKVEPWfu0J0msepkxakTvTw
         QXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185166; x=1762789966;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nGvMXdBJ9DLI+AY953PPZ3In2Ox2jM4bGQMRN+7vp+s=;
        b=C0XN5CLk7GKC7S3ou7LYm+JVIZNo6qTz9n0jx0ZiqmdmyHASjEpRvUS6P5cYJpzmjD
         B6QWOM7mJ/f3APnCGWFYF0g+EpH5YSFjVEKJF/a8+Pqj8OJ+1kz8rITzxcJo5fDc5lKD
         xWb6wzHXis9vSnCwFmo4kDEHLj/AyDSWc2iJa8KtgFzYx+/przo3wu7Trl7vGNeyplIs
         hC+EqX3s0kBfbSQRJVQujnL39rcmeYtjdozVINUJyc2yGXdiVU23bzCUoGsS9Jg8dw3G
         pyqyzRpDStMbzxQk/yEEchWc+W2/rJ8TDBe6Irm+DdgcUgSjkAKKWLsyK1TX/Z2/yP2C
         AfeQ==
X-Gm-Message-State: AOJu0Yz7//N70ckQkP21yiLGhqYM4zQKkR2Kw4Bx4233hPg0fIw8dFCH
	uPad6qPWSju+EIsWrQz4jezWo23l4fC/qnHkqpK8q6xGVX3seX5qqsysUrGgHLU/Z0pvx1q8xa5
	n4UDH
X-Gm-Gg: ASbGncuP02PWYB6bCUTuDo4ZP20kXdhPi9jrD6CODKDdxr1ONBfU0xWCbUBYP9jAnwb
	TBYI4d1bBVZa3o50CwC/Y83YKGWrQm0LNeb7s3Ptece/mckgQuX1DA0/TZ1LLJeUBpTdBLnWFYP
	sE2CyOGBFWnZyA5NeuNk8ZeoS37J6rI/lBksilRZ9ccKwyz763YwQ20x+RCf1yZa2SlA6Bba6nZ
	9wpy9roE/vyoNbWAe6X0TZHCMplCewIdcqtEnSsPeQ1DPYTPG1mWuSPqwDaPgYupJ75OTKePvWN
	MtcV87PFfYVSKOZai0PuzA9LMWaXaoofvoKAlTZAnNkqNdj8fDcZdrzm2V1RvJeW0KMW7rIz/Tk
	8mygjhuZHs0ZJWZ+YoF3BEZKjcLF/yksJDRtqREvHiyG7XhZL4faS1znWQgdPMntOZl8FaUQYTZ
	bo3rfgJlo=
X-Google-Smtp-Source: AGHT+IFe53hbxPtEzbNlDKqNnN3WoxOdQDr+sD25BzduaZg6vLPVHT5ao6R5UjxcVe8NJ69a5tXk3g==
X-Received: by 2002:a05:6e02:3313:b0:433:2882:dafe with SMTP id e9e14a558f8ab-4332882dc7fmr85327465ab.9.1762185166581;
        Mon, 03 Nov 2025 07:52:46 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7225ad929sm280517173.14.2025.11.03.07.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:52:45 -0800 (PST)
Message-ID: <d2752a68-929c-46e5-b2b4-e85ac3e6d138@kernel.dk>
Date: Mon, 3 Nov 2025 08:52:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: John Garry <john.g.garry@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] MAINTAINERS: correct git location for block layer tree
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As part of a recent move go exclusively listing git.kernel.org trees
for the block and io_uring development, the "BLOCK LAYER" entry wasn't
updated as it already used git.kernel.org. However, outside of just
moving from git.kernel.dk to git.kernel.org, the "block" part of the
trees was also dropped, as the tree serves both block and io_uring
development trees.

Fix up the "BLOCK LAYER" entry so they all use the same tree.

Reported-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/MAINTAINERS b/MAINTAINERS
index 0554bf05b426..b986f4635b7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4362,7 +4362,7 @@ BLOCK LAYER
 M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-block@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
 F:	Documentation/ABI/stable/sysfs-block
 F:	Documentation/block/
 F:	block/

-- 
Jens Axboe


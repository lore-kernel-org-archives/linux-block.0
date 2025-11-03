Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245953112BC
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184117; cv=none; b=u17gcUNYwySXVTrKAHxh47DxLs3aWK94UkDh8A31PqmyNoBzJV5SYIslN0YW/DgDNE/so9PJvtd8Bz7hn9MNjNOyKcVyMpXGvHtwfFnJD8uAvrBGgtY3vTfTZRgbp5yCl54Fkvp5xuwBnUyW6qONLvDiICjan1e2DN4+cSJE+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184117; c=relaxed/simple;
	bh=Q/7KSfCt9B8YNSUdE+mhLVwRE6bImpKQOHCd3aRxcmQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E3+waRrBYD9b7xo1nSd6wdD8KsEd1gTFXLvL2L8p+4KLDsYSNcZacruDAEnSv9IZw5dW5GjFW3GNPnRWgGlNIVtM5BVg/Jr+QZmYoqWejA2btWSS28VGKgVvkqF9oYUW0kLf6+boU5B/lauueIytrAc1g2RM3X3ua7vR5sqkVtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SpGVeMXI; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SpGVeMXI"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-4331e9cb748so6502495ab.1
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 07:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762184114; x=1762788914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTjdEFNLv9QOO30a19cBVfIB/VrJFuCp5x6+pJ4o2kw=;
        b=SpGVeMXIYeYmL8MSopYMNxPXfW1aqEwF5Jjk5nHfEmX6bA0fk0AWPjhhAGOHsv3FFY
         F2x/u7nyXTF8HlV3Bb/Do5T3ZGwPE87MWhDVdx7YBla3RSzs21PeKbOTcXK377MMubOY
         TIMVC+IA2Yem3bcWQIOeeFXvE0+q2cTGUHTF2Ur/I8viq4brW/sI5Y+iDik0/UmEVyJT
         /IXJ0VGsBbevpllhAM8YbcT7iQEbF0+Q5sEzhTo53Z9OvzahWbva7IcGNIGmeHubqoAY
         S4a/scG5Ihvpt3Uk6D85Lg0QvEUDAeIOh028rYn/NN3nhW1YX1yNi0Dmj7+GOSOu4LFX
         Sg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184114; x=1762788914;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTjdEFNLv9QOO30a19cBVfIB/VrJFuCp5x6+pJ4o2kw=;
        b=Bfyc/MAdEYqbz3gFfLoIBS8wDUVtFy3ArAvUormfKq0uyb9qmxsknoBKRfcuKgZzAA
         nsZp9/0785/s4eE2/Kyv1CPCzKEPb5gaWKDVni65LH6XZmOaFb4GVh+Ng2wp1CbTUq5r
         aF62abLtvOSKscMqsvzoHqchgjEmbJp5Dwkb2E/nIWsclbxAE9Xuco41kiTy0sYXj3WB
         Ckr3u3Uao+jgyxXFVHeBg4UZ1Saw1Guj2GUtIqtxVyBz6vagIGgEH82kBajwFGeIJ8Xu
         NUot9tLExev+5esOPKH/48sxVW3fOo+Ir3rdRBmnAvtlZzS6f1UHzVURw+sMtIviiZWU
         wHbA==
X-Gm-Message-State: AOJu0YygoTPU0gQFGPiUctimhIhAljQNX60FlHUSj/Yew/yWtBbb147a
	vIFxCc1/De3uuX1h7737ipxqUUqwQQ/XjaSF9L1L6HjeCCpYBL8VRknC+zDdxq85qlYD4DlT7KT
	2orei
X-Gm-Gg: ASbGncuIBZyNJibeFqDQ6gxYN1u/yxTAKKOvVyEMKvvJc126cU3N01d9SQSo60MtYsf
	9NXrMj3t1B3exz05k22bt7iJQM2Ckz5X2HAUrx2AnOQRIdKmHToxGXFBrpuzwz4i2HF3Gmp5x5y
	sfignNKUdbG2gUsp0r6hdTyhSBPwApsbbJWOdKencw9x7Q0uXPE1DWQXYZ0GnwzanEMt2PLbIAv
	ZaMmOBde+SiNznfCQDfF8DoTkDhZ9hsThSptM05CKMV3xnvE57pPBF0NymF9J5EJ/dlUlepqEKJ
	epHRSAvev7jvccNfJFxgwxNvwGNZPA9NkOJG2aSH0gIknq1a4ngDeR7nd6n/vDXChYAgZGygUk3
	OGCmaiJishYJLuheS17oyGh9ysPkMAw5j5B58miyPHlKdMJcJYgWmQcP7q8Iys8u+wZk=
X-Google-Smtp-Source: AGHT+IEfPaeBhc08yzORBGRG7GQgaoHwaYnzIH7k9NhCnoJt8LuQEqKDdWCFpLF03Ie0eOApb8BB1A==
X-Received: by 2002:a05:6e02:221c:b0:433:2dcb:db41 with SMTP id e9e14a558f8ab-4332dcbde8fmr61244285ab.10.1762184114106;
        Mon, 03 Nov 2025 07:35:14 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43335a9e6f1sm2798375ab.9.2025.11.03.07.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:35:13 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20251101133123.670052-1-ming.lei@redhat.com>
References: <20251101133123.670052-1-ming.lei@redhat.com>
Subject: Re: [PATCH V4 0/5] ublk: NUMA-aware memory allocation
Message-Id: <176218411310.7436.8916433606322971771.b4-ty@kernel.dk>
Date: Mon, 03 Nov 2025 08:35:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 01 Nov 2025 21:31:15 +0800, Ming Lei wrote:
> The 1st two patches implement ublk driver NUMA aware memory allocation.
> 
> The last two patches implement it for ublk selftest utility.
> 
> `taskset -c 0-31 ~/git/fio/t/io_uring -p0 -n16 -r 40 /dev/ublkb0` shows
> 5%~10% IOPS improvement on one AMD zen4 dual socket machine when creating
> ublk/null with 16 queues and AUTO_BUF_REG(zero copy).
> 
> [...]

Applied, thanks!

[1/5] ublk: reorder tag_set initialization before queue allocation
      commit: 011af85ccd871526df36988c7ff20ca375fb804d
[2/5] ublk: implement NUMA-aware memory allocation
      commit: 529d4d6327880e5c60f4e0def39b3faaa7954e54
[3/5] ublk: use struct_size() for allocation
      commit: c28ba6b6c51d090103800eb1c7679c32f6501dbc
[4/5] selftests: ublk: set CPU affinity before thread initialization
      commit: 0123bb91f464487cc1bbdcc515757dc723496a39
[5/5] selftests: ublk: make ublk_thread thread-local variable
      commit: 3f5b1169d2ab20ed14271654799121232b9eb9d7

Best regards,
-- 
Jens Axboe




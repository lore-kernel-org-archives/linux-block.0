Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA728FFF6
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873150; cv=none; b=Usg0UyAASSAYk27t3DdUBLCLu+DjqK0948NAxgeSGUPkOLVwxKxK5n9oS/jp/oSOgJuPFUtE0wjWdNmiKgN+6JCva833ohaS/+Q3Q7WEiFqLnQZ0pugyGLTwsoEHiO6FX9s8CYunUzDATfZevdjEIe7TrhTiOWpdhn3K0oYp0Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873150; c=relaxed/simple;
	bh=p4NcimrN2RPYbrdDS0aQ7vYMlnE7U1wMAL5BiS8FvCE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cS16SQSYux5CsHZ2y0k49kcgAslSlp09vjIouhtDvJ2P1rP2PNVSoS9v75ElKPJ4IhTVPruzSnJVkIiD772MFtsOoLVM7sNuuDlkZzMqICFz/u9AlFAKW6qgkOneLYMjgqgPKkUVsG8YwMx5qamyOoGUd8Kz/yGwvQeTamvxMbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FQKCeDhv; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FQKCeDhv"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-4337076ae3fso15726715ab.1
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 06:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762873147; x=1763477947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2l3/DAp/XMYRh6GYe6vQu+pHtDQHTp+dBAwA2D1Xpw=;
        b=FQKCeDhvNvp/aOjvtyPPiZSNzKMfF30ZHN70BdPZeR74DfMy27oLQb+apE+GG+FQsp
         /BwyVc3BNVvXW9acCYJlaoB8MuEPhtnRpgRJC7+M1V3axKTXSi2/KigO4DrDtqe431x9
         KNUPqzKpmRgUlIeBcCwpHgvemNZQCnp4iQWX3nCeeQfhIwaG7jRru2DbjDyuicvNZKvh
         AgeRaoSepUuPjAvk5KnGi6n87ePwozCxGNp2VTa4C5uYXGyd5YA64kmMxrJfPW89ftQ7
         KjWUg3ICt1VGldjDaJcgIIG2Tb2Y2RAd08+PW8eTg+eRS4YEe89R3yHCzx4Snzus6uPw
         zT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873147; x=1763477947;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2l3/DAp/XMYRh6GYe6vQu+pHtDQHTp+dBAwA2D1Xpw=;
        b=lDRxLesyRLQFM0PVWVJQbF9w7OX7gprHvubOWsi5X9C2U/dNHnwrs5Lcb1GDNmE4Qz
         FXUNUwVlQqc9GTncZlQrTmoajfDuZE7a3P6djJkyMYLoGr7fj9WtJmcxQSuxWKP3yfIs
         wkwnryWGF+5sbv3ACK1fxSqBL1M6JBJuMkUuV5o7pb0Qjf5mqaibMWIR6m4crkRCCaw8
         pK9FKjCOxWyQwD0QqXLFj8mBiPz1u24d3/5gMf1AXeyxKxfu5Ru6x8tUPsNBPdix2eaK
         I72Armjat8ynkx+ZLH+gzjxZsVMpbFhfAxhSXPkQ84+YiEnp1lX2FwI51pHNbDGV+0/D
         8A3g==
X-Gm-Message-State: AOJu0YzySjPpo1x6n6iTnn27Qyt9t0p8pcw1KWGLXgeCIQa4Fz5G3l0z
	Cgq+dQ+LqdkEx1uGiu0XmvaDr7uhgBUjoq/novozSCrAEdU9agNOz2vOWYC8yfTSRfEJaoW+4MR
	Y/Tdj
X-Gm-Gg: ASbGncueWECdIktASwIR7GQiCKSpD9NDr/UyqSDNQZWhWjZ1gEQ/ieBEhebjW5OULe6
	uP3/YAsjog5numVf0LqMhh3U0bJJ+rjhqBwWyO2uqIiCj6Ya9C/evSPkvskC2djrYGqtlLnCuCr
	cvCw/5ETJGSU5CLExXhG54ANkKS8IgcPqqbrziJ6O+aqk50XOm2hoYYMdV6rYn1y6aknvEKD9ia
	0a+Dbyow8wGfFE7UDn231hLB+NGZRrJsnMAXPKTSPcqtqAzIKJnM3m62Ta3b2ARnnL3P2P8RJKB
	HubUw1BSeplVfFKfh2eQRo+yRAzhHDk7LiEXNX8jlKzHpNoPir1WUhFlI4FcUU/v8o79skhQCEF
	E341MXEOTSWsBu65NUKbBWjoddJQTfc0i0qdt7VtqvzvmwIQP88rF6hMcFEWb49oZtSj+S54BeK
	MPwGQrPKhRdr0FTw==
X-Google-Smtp-Source: AGHT+IEmsNNjF5MhN82jjicIsOrc06hjWbFtIqHWBtmHjw3+ohFeEHE0nup7E1CkIcuK8C0lO9WCEA==
X-Received: by 2002:a05:6e02:1c23:b0:433:2fa2:a55d with SMTP id e9e14a558f8ab-43367de53edmr206093235ab.12.1762873146782;
        Tue, 11 Nov 2025 06:59:06 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b74695d420sm6036612173.46.2025.11.11.06.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:59:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251108221746.4159333-1-csander@purestorage.com>
References: <20251108221746.4159333-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: remove unnecessary checks in
 ublk_check_and_get_req()
Message-Id: <176287314577.174455.6127833224197613328.b4-ty@kernel.dk>
Date: Tue, 11 Nov 2025 07:59:05 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 08 Nov 2025 15:17:45 -0700, Caleb Sander Mateos wrote:
> ub = iocb->ki_filp->private_data cannot be NULL, as it's set in
> ublk_ch_open() before it returns succesfully. req->mq_hctx cannot be
> NULL as any inflight ublk request must belong to some queue. And
> req->mq_hctx->driver_data cannot be NULL as it's set to the ublk_queue
> pointer in ublk_init_hctx(). So drop the unnecessary checks.
> 
> 
> [...]

Applied, thanks!

[1/1] ublk: remove unnecessary checks in ublk_check_and_get_req()
      commit: 6b0a29933f688a284e8869da0f63a93acf893757

Best regards,
-- 
Jens Axboe




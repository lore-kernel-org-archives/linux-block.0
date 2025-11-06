Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934D347FD1
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762472027; cv=none; b=Xxy2pame4HM4wYpxEoN333ov1mn1MUHpo3FA8KBK9mw2XIdsaWcX5xj4u+09C0Varr9qbhRflvoxGWaO0mCOZdw7SuJ0OHxT5ZVAJFTe7LlqFstTk+jMSne0Wn9EBqtZV5mXRU5nD/qZRDteJ8WsdXtc7TWpde3xvJgq/aFBnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762472027; c=relaxed/simple;
	bh=E1ekq6cGetq/EM4Mk8jO06W5nqMewZh3FMKPQXLdf8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MvkgWot+ANA43iY9nRNAaEqA6FiiBMDwplpOD1q4lg4VRBrmNEDVWwQRdyPRdbSC56xV04jIng0tbCdobnRQEGl0PPJ7jOWzPDyxbxsfmg6xdxh/+CL68K2Y7h9p1DS1LQnVLRKtgry70t3hBm0FzT4iagCg7U2gMTPWS5WKsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qbHRGXLP; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qbHRGXLP"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88044caaa3eso2204976d6.3
        for <linux-block@vger.kernel.org>; Thu, 06 Nov 2025 15:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762472025; x=1763076825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRXXfNY9pyURNKfsdcnYJbg6hRyM80+iEOQucrkOHfk=;
        b=qbHRGXLPGgQ8EMicb4RfotIVWm9S9+3WYzIzq/+qE8cgZsps4FXiLO7ygi20vD1JPu
         OOnu39Pqjh23QNP0zK7MfdIHfYdqEs4aKRTLkP/pw1nB+iiJ704lpqzJ7IxCXAv5yNkp
         k3PUM5yxlT0D+dgJ8Cj5uxqe1TBDhc2Wtw6AX+Ynd7xWOBj9t6zIB6M/va9CvpCh7Xjd
         Sk6yfBSlPDXdBRSpXobeIFRR4u3IZ8mWyk7tsSuN4Q6bWivKHNsCANVPhWczekja/EY9
         dyqoisctGa44l1tVqMGtgRWc/Ke4ez5hTkWsk4ppHPu7Sgg0sF9/OYNGlpgsZMAMgc0e
         3ENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762472025; x=1763076825;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pRXXfNY9pyURNKfsdcnYJbg6hRyM80+iEOQucrkOHfk=;
        b=KkWJ9km+140d7/fPqY0aZyCfmNtR7opcf59MTX7SDPoqzLCqoZ+QuzR8HXerOYnuca
         Cxxa9XZ1IyYCuhDnUpIPaZdUPmdqKfl+bPh4bm7GB9hbEcATBWWvv78Lgugf537v67w8
         Ae3FCVjdhDymBLFwX3n+pVeRoU1qCMRbaYznp65hmqIkM4+u9eYW1VwvVhmUw1O5KEYY
         b4AL5MXaKNxFfJR/AAl7srDG4XOWbNpGQ/Zmf3lAWaZ+VniMkQRvKp8jSN/wIYNLyvfN
         RJbznkhUXW+lHjaA9YFzijQgNNeGg8+OG0Nc/0kB7OjP7pwQ9H6LAe5RPKsexsl5NMD2
         dAIA==
X-Forwarded-Encrypted: i=1; AJvYcCWWylqiaN5WvRsy8yLk0oc1/BpTZgEBaJjemnuTz+n31cab1+FokjRb8T+bS6bss4Hd3a2d17Fp2EOWyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG5c/Pkx2s/ORY07P4r5tDJ45KEKJkbc312tqjAi8Wju/AhXMv
	hXMrzlgnQMLDJngUbyJFwsMjyo+S7Rszvq/0DFLbO4wxXe3V4pLc/I4l5EHpInYEtBk=
X-Gm-Gg: ASbGncsadUQYspZj+pYTyS7MkKwuHNV6Gf+ueB4Jgz7rtRdDJVxbxS15k3lP85BDKY7
	iqdxsDMLu4Ql6WcjRk/7UKw1QlRuOoDSJMc6rJdZjglModL8REfYU3msye/lR/gXc2yVugSv4gA
	83nI/WtOwEtOyvA/8HhlkDYe3NsmaiD2zpi9J6LkW+RGT4ekY7a6xcBozcSoHr9ocWFB2N1qkpM
	uQ1vLxrZPqtAa1DeOFOKoI+kzrN2AhPdg+QcII3vGMROmmzkiRrdNBsxyd4W8MKAn2zMDN/Z+lL
	re964Fn8xEv4SSQL71xCBH9rzJOngEYadkbxaj0cgz8TFjEI/0pzGTuGuzOugiyKL76vcpuIIJ4
	vtGalkTMDcuEBBc1blvuppTeiJ6mvjAoWCtJFIFDcH6DJpSX3VYsaZVbwXYFq89O3mXJPVHM=
X-Google-Smtp-Source: AGHT+IEa/p1y28PH7vF+rUuXCk73+M+v/UzuRPpQS8qzH/lxCGdYQdwuZfTniyRJTftE0hYC6qkFUw==
X-Received: by 2002:ad4:5cad:0:b0:880:53b3:a9bd with SMTP id 6a1803df08f44-88167afcc3amr18286516d6.5.1762472024851;
        Thu, 06 Nov 2025 15:33:44 -0800 (PST)
Received: from [127.0.0.1] ([216.235.231.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880829c83edsm27627626d6.31.2025.11.06.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:33:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 pavan.kondeti@oss.qualcomm.com
In-Reply-To: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
Subject: Re: [PATCH] virtio_blk: NULL out vqs to avoid double free on
 failed resume
Message-Id: <176247202182.294230.13399520810544725524.b4-ty@kernel.dk>
Date: Thu, 06 Nov 2025 16:33:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 21 Oct 2025 19:07:56 +0800, Cong Zhang wrote:
> The vblk->vqs releases during freeze. If resume fails before vblk->vqs
> is allocated, later freeze/remove may attempt to free vqs again.
> Set vblk->vqs to NULL after freeing to avoid double free.
> 
> 

Applied, thanks!

[1/1] virtio_blk: NULL out vqs to avoid double free on failed resume
      commit: 0739c2c6a015604a7c01506bea28200a2cc2e08c

Best regards,
-- 
Jens Axboe




Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7263559CD
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051223; cv=none; b=i/E4TAbBXvg+dYYXMnic+jvsItrv//e3o+QPc175GlWWC54Sb9WwgFLL6Vhk8fm+TsSWiQ6A+1yG/+NmUMRRSlJZp9SK0Y1PCUYs++VIm26GUHGtyf9SJwNEfn/Cvki7VlyYtVOxM17d469rWgesGxVdHcGq04qozrV2z/DxQqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051223; c=relaxed/simple;
	bh=8cGpt1mnnD4Nd84oB3FjjbO1ZroPYw3Bi1pxnVfLhrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cupa2Q+Q9eLLwh9jahQfrbRUGvPl0OqepuWcsH8cYuRUorG9dHqV6AU7vUJr3yl74EAKEARxGNsfi3jPch3Fm55EIZRfsItRKD34NSP5DYTux0sLM89R05u0pmABKy9x+RBMkynT9D6objzk9fWFFzIrtssIh208uC49mk6cFyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QKi16B8U; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QKi16B8U"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-940d9772e28so43584339f.2
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 08:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763051220; x=1763656020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WV0XxB+XpXMsT65IEjX1Mg5hj1WPsVipB9m+jCtnpo=;
        b=QKi16B8U97BczHNWv3tbcTOdHFf4ULVB0kmAG6gLit+pmQT494KOsHR/EvXhrd13kP
         aa6YHaHouA/nXFKaY2PBj6WfEhFYozBy4Y0IFbVPifpHxICbXFCP63UHXUghMfrHid/C
         aK7bEMf/sERG90SKl1s49KH2Cu0nJS/pILsJEDH3I9gT6dSSrHa/zBbgGWXNXAmbVBhU
         k/aZfoAH/KwsswZotkt3D1oORlIRsk86D5ZHmofBQ0hWE7OXppXfTaOMdfswMnY8dEhC
         lqEkRWfsfEP+ucfHIHTZseCvCplEVWL5Sth8qS+w0xAfSYHn6p3Qu7+F3uGgVzwTuJa1
         bKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051220; x=1763656020;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+WV0XxB+XpXMsT65IEjX1Mg5hj1WPsVipB9m+jCtnpo=;
        b=R4oErzOcceCIp7uvip2MLdxS9FjJCbpTs8TTqYzVP/98CPdRZSFs4PdgWGtJf+AfOd
         H3QjYkg6wJZ4kw8uDgRkcLwe0v1cNul2T5Zk+DMNNbaJSQA/xF2K3SrIPlTeBpc7eK0A
         MX3VuPR2eqzb5hHnVw2ipNpuw2T0TTlnXeV1wqiNN45c+ffNjK9JArzjAAqkH6XWk7Q7
         /9axquIR8HLUl8Cg5YOnvf34Gd1cwJns8GcxE3KQ1lOc+Ba4dTkS8S7LPoYaT7+QcSIv
         WmU6nww/Vw75zgvM2b+jnyZkFzk4tCB3IAFOKlm9YxjS39jLSrbFKXjCbLPbdvz3yoA2
         TaIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV24BMADL8NclVOdybH0X3IebtMxkWuq8gKl2FE/UbPtb+Ls7UOhRT4PZJ/J35orwApbNfHWC2kL0ao0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyesWCQLPGJahhsANOn+DwdKxectFYwaCUmEO+S5rQWdpKM2pFR
	x+FXTgBItxYeLaQ3rBv203CB8YvPWat+0KqW8f087sPwfk9RVk/WATyYm3idlHTJin4=
X-Gm-Gg: ASbGncv3ooF3KP748V3tTRvP2i7kjDPdJ+voFo4HQ9US2ZOKJUu+u8ZkRKNg1ugZSRM
	alWsxTmSFfoKa6HR1xmvAHUjS0kQnUYvU8GD32I/z+7/dXKyZqECV71PmrSDNXWZrk+uojS4PQ6
	bo4ehFcd7BGlsvdXCK8Z6IiIk9CgoLaQD7tyY8J49+5237AE6XQ+AcC7QMc0iqJdGBL6nSRnl+h
	9dJhgGLSimI/+oz3/tpDFLao3hoAc7F6yPtMDrZH9xkdRua82JH5Vya2acu0DMRQ2eVBkUb+gln
	B+P2LSZrlL+J42XASttLN8NXj2gUqdFS3IjiC2Zql3UVz1AAtFMH8DGC/g7z+td9LRb5a71P5dg
	Px0lwQUarPvw1Wv66FL8YbS46YzpLWDuKGAlPeKkC56TwTYO6urLI3P/9QL1KlLK2vcQ=
X-Google-Smtp-Source: AGHT+IEfPEzNVUtSijTeS0YXmDIkYTXhI19QS5zHoA8Z8cIEgyRelQqFXKdqTDIpcP6BSYul/ZnQtw==
X-Received: by 2002:a05:6e02:318f:b0:433:6fe2:6b00 with SMTP id e9e14a558f8ab-4348c8648a5mr1678615ab.5.1763051219861;
        Thu, 13 Nov 2025 08:26:59 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434833c5357sm8641725ab.2.2025.11.13.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:26:59 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: colyli@fnnas.com
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20251113053630.54218-1-colyli@fnnas.com>
References: <20251113053630.54218-1-colyli@fnnas.com>
Subject: Re: [PATCH 0/9] bcache patches for Linux 6.19
Message-Id: <176305121881.129995.1450932700968780784.b4-ty@kernel.dk>
Date: Thu, 13 Nov 2025 09:26:58 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 13 Nov 2025 13:36:21 +0800, colyli@fnnas.com wrote:
> This is the first wave bcache patches for Linux 6.19.
> 
> The major change is from me, which is to remove useless discard
> interface and code for cache device (not the backing device). And the
> last patch about gc latency is a cooperative result from Robert Pang
> (Google), Mingzhe Zou (Easystack) and me, by inspired from their
> previous works, I compose the final version and Robert prvides positive
> benchmark result.
> 
> [...]

Applied, thanks!

[1/9] bcache: get rid of discard code from journal
      commit: 0c72e9fcc156caaf123a6291321bc9bd74cd1b61
[2/9] bcache: remove discard code from alloc.c
      commit: b4056afbd4b90f5bdbdc53cca2768f9b8872a2dd
[3/9] bcache: drop discard sysfs interface
      commit: 73a004f83cf024e785b74243ba9817a329423379
[4/9] bcache: remove discard sysfs interface document
      commit: 7bf90cd740bf87dd1692cf74d49bb1dc849dcd11
[5/9] bcache: reduce gc latency by processing less nodes and sleep less time
      commit: 70bc173ce06be90b026bb00ea175567c91f006e4
[6/9] bcache: remove redundant __GFP_NOWARN
      commit: 21194c44b6bdf50a27a0e065683d94bae16f69cb
[7/9] bcache: replace use of system_wq with system_percpu_wq
      commit: fd82071814d06c7b760fe8d90b932d8a66cffc63
[8/9] bcache: WQ_PERCPU added to alloc_workqueue users
      commit: c0c808214249c32a8961999e0779b953095b0074
[9/9] bcache: Avoid -Wflex-array-member-not-at-end warning
      commit: 699122b590ebbc450737eebde3ab8f5b871cc7f0

Best regards,
-- 
Jens Axboe




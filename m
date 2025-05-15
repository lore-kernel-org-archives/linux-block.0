Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50419D07E
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328168; cv=none; b=QII9ZUa4UcJDGddowL/X5MSHbF1kW44WPvvQnzqOltYUZpmY0rcbwSWrbI9/6zQqzRI3Dww+vvuO8C8p0xnjuyIOAWjTVir2ZzrIvIrbVe1BhpmoK1E/fsINnkuSknxdBfMVAXumHCC7/E4H+WFCoDHCBHpoEnzU4BeLie4dmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328168; c=relaxed/simple;
	bh=rTY2SIiSGVno6lDWP6D/gl62nh7vEUbCGOBEoLm4+nE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C0ZaKUGu+EzgoLB5S/LKXYxonMNkC792tbd1holsBag2MnRCtiBqf5MNnFZjkJim/6RhTJiLH/6tiQ5q9TlIODQvA4mm6dl3CbEsdgw9LyHeu9J2Vjdx0jOPtgxU0ytIg90BmR6fnEkFPxTq0TtfimkNryLm12+O8N3UV9Nu24w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pzp7J1ev; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pzp7J1ev"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8644aa73dfcso34465939f.0
        for <linux-block@vger.kernel.org>; Thu, 15 May 2025 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747328164; x=1747932964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vigVsJ2paaBct9UMm/ucPpQHoDJhZDbvTSf1xWx+3nM=;
        b=pzp7J1evxALMKa14fN4g2Cfahg8ajVtEDT3xFgSthetfcQxW9s+JUUvbOxjpXGK4nI
         LJ/qfvFktaWyVTKez5aH9lupRWn5lxIdFPZrQzyycmRx+U5St3onOk1hsvE2fhgWiKZY
         ovLVQG9LAU1Qc9epwDADqn//97RuV5l08id8aibSm8WYtvFE8KU9lC1Grm943FZ0BS0L
         SwfAoWMS/yjJUbvsvqHFCP+pXwhsxMSmbPCjRx1KLV2KDj8xvv9sDflK66cAUZ971WGo
         UIdqQmzlI2NfeH/ubjwgSttzHfWmmHG8vn/ElUIvuSJyWZYcliMRO9dw7hmV8upbIshp
         QHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747328164; x=1747932964;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vigVsJ2paaBct9UMm/ucPpQHoDJhZDbvTSf1xWx+3nM=;
        b=eo3fRg+s5ieFQkQbrxzpVBeq+wX+6mnZHdguOD0F29s6feWABoJ7sSu2+LOq0n31zo
         aVWu4OBYCoV+KW0+lNipn8SkZa8leRIX9tEl4cLBY+2+Ifv321PvZW0BQ4SsszlKXb3b
         shRfRN13xhPAJT6BlNeZzL68BC09243dWJMe6xNtGDSCdZtg9ElKCusO3b5U9yJorYvd
         5bJl367L4+XBARTC0grEeKW/ftHSb7PyU/87iooUXG9u3cwqEWSU/nBrPGW3hx/w0bOG
         Sf/0aduITXXQc9Er4b1ShYB/mCI539x+SXXlthJvxueK4DlXoWhdgm9bemG9+fzF1x8G
         Th5Q==
X-Gm-Message-State: AOJu0YzuCB6ou1ZveOmajKDtmuwkrcqpGNodwhadXiUO4qlXBUhrOGIC
	1UY9OHfN90E+Uan9b5EyN9vYMxdX8EbPRggqaNuDCqXYAeIv8AClQZAISokVxoWISRU=
X-Gm-Gg: ASbGncu6p0mFiq6X3MF/Xeb9Fu3MzgROPR/Xh/xcgBKQObmuQ7TP5/RXT4lte7tEsXg
	D3iVpFEuUNRJj/NoRa22PEKp2eBqnjJ2ux5BofSec0qxjqEl/XdvF5qVxis+ZIXiXhcKOpkninz
	pAb8Z84sDD3Y/9sGkj+Eh5A8ED09/y+6WWK8HG+UfmyjX2Q7jJvb25HGIkmjkxKw4ou2+pMaZFU
	ra9yby1HnfZnFBLvAGPsyRim6TwCo7loTEsXLhJOl+mDme66lzSUE55SfzCl11GApQREaHotDli
	Etkm4ffkyIjKVG7AO6zbdYtgVVVNPyTrrTusl3//2jw=
X-Google-Smtp-Source: AGHT+IHBJhKlIBVt75TarBzRVDhBretqc5fXY4fZ5Sb319A/frCdBLX/0RpV5W7OtdNiafaVghmC2A==
X-Received: by 2002:a05:6602:751c:b0:85b:3f8e:f186 with SMTP id ca18e2360f4ac-86a231afb14mr51097239f.6.1747328164604;
        Thu, 15 May 2025 09:56:04 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86a235bff42sm854839f.1.2025.05.15.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 09:56:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250515162601.77346-1-ming.lei@redhat.com>
References: <20250515162601.77346-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: fix dead loop when canceling io command
Message-Id: <174732816335.293460.11856059547949881875.b4-ty@kernel.dk>
Date: Thu, 15 May 2025 10:56:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 16 May 2025 00:26:01 +0800, Ming Lei wrote:
> Commit f40139fde527 ("ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd")
> adds request state check in ublk_cancel_cmd(), and if the request is
> started, skip canceling this uring_cmd.
> 
> However, the current uring_cmd may be in ACTIVE state, without block
> request coming to the uring command. Meantime, the cached request in
> tag_set.tags[tag] is recycled and has been delivered to ublk server,
> then this uring_cmd can't be canceled.
> 
> [...]

Applied, thanks!

[1/1] ublk: fix dead loop when canceling io command
      commit: dd24f87f65c957f30e605e44961d2fd53a44c780

Best regards,
-- 
Jens Axboe




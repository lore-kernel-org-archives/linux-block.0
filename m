Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688EC4534B3
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626118; cv=none; b=TJP1tccRvDwNkVFceUq1sAdT/t03cTpDRBwOVcpu3oQ7JsWMYHrIJ3KKAIVM85khrmnVjqSxhfi3ppUOGQdYWzr55Pta4Q7xGZ33HPGKX6GRmoGYbrauBhjPpr4RY9XaVB4VqHNZm3oE2887oqMp0RU6TVNLLUknQm6D3z5wNGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626118; c=relaxed/simple;
	bh=VhUZQAte8aV83CC83MOWOEkDvGSImT4hMTGNfFf5/RQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KSW9RSPWnvQVN4G3uOU+lAKXFRMXdY7CI+WmobltWAPDemvjCaojHTvGP6+i7cziBAwll+hFQgihgnNNJrAAi6fLqmPd2uMuKlSE3YRo57H6rjhraFN97zAm5K7gbdfjwb19aevmWoeV/AY6fZL0UsXTp8RuEusut/9uIzVtO9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=MCXXlCNf; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="MCXXlCNf"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43cce34c881so4098801fac.2
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781626115; x=1782230915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPQ+FKzahwKUrI+OpROn51ekPUQ+yBviGhjoCLiIV1w=;
        b=MCXXlCNf9Zqf9RzJH1gGtyJx0P0pnpZuASC0NBG5tAPPO40Rl1uJk2pFHEhdEhUfX4
         bqyUCJXwMmmHqWyVPx/+oliE3qVHcnOOYXMiGD6cfH42BV42HvktuCym3UMDiwoQnTm5
         GdR6ik1PWS5BA1BS9+Ws4FW+UwaML82fkaYcXmOPNn1OAngor3/uVNyWLXPQvPtwDnC9
         dk0SDgx8SK+z1v9KiIGNo1hPs112Ma+Uy2YYcUErJjmR1PEU7V1IGRsyZrauMQvPxUvy
         L9pg6Gsczi5S2WZ5F7g1WMt0Z8DNO/R1Fxr+wB/N3nlK1wuqSVdhXk1sQwebvw+aOlh2
         rOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626115; x=1782230915;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IPQ+FKzahwKUrI+OpROn51ekPUQ+yBviGhjoCLiIV1w=;
        b=Wtir4x+nJ9+1U4XgACMRn9/4n403Jck3VJ7gJ5jZhDvqw9VCHf0YDN8WZtA4Ku6GGY
         oZ446rVnrfLBKacdpEZrz9rul8HyDDJOChODrNJZqoz5pD1l9tLZXS5i30qf7mmA1kXo
         SMFj4ZYmRod01/XFWtAfyVD5z/IxahygEm3PJ6eUlz0JsGpjuYv5XESQnGhh7W8eFMkJ
         T9GsNYG3mSmE5iJCPZvykRcIoLleWt56VplcCe/IJiXTZQM17CMBliu5krfdZon1iH/4
         PzoBwfv2YUOCpzq+fCRPfGm+4Q1e6b7JT0hTW0l6xySH+Z4ni6Sp+kpMHeRS8iJXBk5l
         XUfA==
X-Gm-Message-State: AOJu0YxRtYgm0OEKTUdUu2b5vUj/7wOu7cn/VCM9oWz/wLEc5TxZ9Rx4
	khHTqGoo4MNdW9gX32v/uRZzg88orvyqrYI63zzv9wjoEBFEDY2V3aVbXcLQr0g5yzdbKR8IiY/
	yn0fS5po=
X-Gm-Gg: Acq92OHFjRYZoPjbzRQW8RagIUADMrHkPA50aPAT73CeN3XBZQjPRJn2luU9T97xl9T
	XU97Se0a1jkJo3E43V+BSjeAxxLGGjFRbL6O9lWa5aYh+4a86A9FS1DdJY5yG0ngFB/r2yUnNbP
	6M9kQsIWM3tuOM91pBMRT+I6jt3Rdcuk3U3DILC2HzwmmkGpTdALyDBzA6dta0x814k85W+Lx/9
	15C/ZK7cXOT7sOnXS45XFHFEWM0hhjN29+SqdnmoGfNNz3VV+X6eG/4p9QJZq4HjADgEvCw0Rem
	YeFrdn/+BEcHkYPIotZ9cOJC04tsMhJXl27QWsky/YGFVxxQKRsiFk9dFwqkiqMnDAFFsMRQjCQ
	5mC6jqZgXdV6yOueo9wpNnqnCksYxJ7+JDk1ArdXsbuJdktu7AxFze3HiWwutW7btErcvxGn/+K
	q56/TxdgCaGlptSAZLxKaDQtUNQIDRGOIHIluozsDUuYihJWKDTysoH+R5F+kDw0O/fEXqHY/be
	V8C
X-Received: by 2002:a05:6808:4f0d:b0:482:6617:d48c with SMTP id 5614622812f47-489429acabemr263716b6e.25.1781626115304;
        Tue, 16 Jun 2026 09:08:35 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875ddd9fd3sm4631101b6e.7.2026.06.16.09.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:08:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yitang Yang <yi1tang.yang@gmail.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260616155129.406057-1-yi1tang.yang@gmail.com>
References: <20260616155129.406057-1-yi1tang.yang@gmail.com>
Subject: Re: [PATCH] block: fix IORING_URING_CMD_REISSUE flags check in
 blkdev_uring_cmd
Message-Id: <178162611413.2191657.11211550111552677845.b4-ty@b4>
Date: Tue, 16 Jun 2026 10:08:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 16 Jun 2026 23:51:29 +0800, Yitang Yang wrote:
> blkdev_uring_cmd() checks IORING_URING_CMD_REISSUE to determine whether
> this is the first issue. However, this flag lives in cmd->flags instead
> of issue_flags.
> 
> Coincidentally, IO_URING_F_NONBLOCK shares bit 31 with
> IORING_URING_CMD_REISSUE. As a result, the SQE read was never performed,
> bic->len remained zero, and every BLOCK_URING_CMD_DISCARD failed with
> -EINVAL.
> 
> [...]

Applied, thanks!

[1/1] block: fix IORING_URING_CMD_REISSUE flags check in blkdev_uring_cmd
      commit: 4f919141be38ea2b1314e3a531b7b998eb64e8bc

Best regards,
-- 
Jens Axboe




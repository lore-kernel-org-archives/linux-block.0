Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B62421228
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848440; cv=none; b=F6hQNvh33DYBOv12xNahz3PnfIwvZ4C5atXB58H+4EOaJlg0X79pUNRqci963EoMUmvOt88WMmHc1Xtq7MNj7Lg9tEdIAt+u1YCSBG4Un24GExj1typ3Uq7ciafrbjQL+QrhEktL7XNtkhi3/w9PGR2jMhB2voSm66HEbZ9otE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848440; c=relaxed/simple;
	bh=1gcBWOrTOzOQV/Ehg06RxfoXmN13vDhe0cvi3LfVU9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bHOPMRZcR10CWYYG4vxPjTqLsqjdhyODH5FswsfA1QPPr+TCerPesWrYsPFRC/z52GHTUXMIXyjld+xzJBn7MJgSYAgGBJG3aJBnc+5A4HA9MemVBFrFeRTCfwHPRghaQKPe9Et/KFmhRbSLcm+P+xeC8T2lhX1BfK8YQtA+A6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=W3AAKI9A; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="W3AAKI9A"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-448b69cfc6dso4241769fac.3
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785848437; x=1786453237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EeesDTwPxGyABvFI6+fdkOe4CXYZC9PTOa9K6Xr2inM=;
        b=W3AAKI9AwaOZG27Qyd9OOk7AB9bsj0XbXx4nLI77dD6h9jQjLG0nxCq/VMe15pBzBf
         2fEtSHFVv34l08ojxcyQjO0X/bo4OEcrDOkWdPw4aEL5GljxgHvnbE53iMsFpGZyQiO6
         aa6pdICg0nfbhXn1/LbnSlxWT2Fyi9A1RswwvcWsd2bG/QF6RRQEmzLij/CGyfr1x9BR
         SJew6Q4nY6SRz4GydC14KWhF0XTOjrZbgyzi50mX/3pJLmmvv7q2u9cRWtuA6f9JoQfT
         rlx2+3/LLOTgsWrEGCnkbgwQN2hMQSACgyXvdAMFspa6WdqI5HAxHKkonWGsOugIqpMg
         twXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785848437; x=1786453237;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EeesDTwPxGyABvFI6+fdkOe4CXYZC9PTOa9K6Xr2inM=;
        b=rKcs9lHLzdaUyF/4deYdCGdm/8QUvmmqKkf0O9KKkrOfwCwFuOqbfovT6YtBo7leap
         sF1xtt+0I1tZeHr1ICl3RhPgKUkf5GxegZu4/5kRAE3aiecAUcYxXFVvk6ABawBUW/kB
         hc2HSK4O1tM/9KOF1uHUyJISygYCeV3vi3Qi2hC/7t4x9+eLF0JXkMQr1j+9g5EzqYPz
         fvYotclKQ1pyojU0xf2UopKSaAeAcWKX/VJBx8T7AK64hCHs21gG23n9PXLD1jvIdCdK
         ihuAQg/rn6Qrp++TPwH3Tmj93qbWSZ9hdbJsBveMBQrT0C0spqqOH7KNwMje2CqsaAfT
         kaEg==
X-Forwarded-Encrypted: i=1; AHgh+Rq8OEKd2AUS8WEVfpWQpOOZNcoahG49Rf91t9sDwHrl63q7iB6sppRwMRvx/sffd1GvFdanL9hJt2XdCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0xH10C+wenq9DF+tOdYboAbleAhIrIWWTP94ZdrOGlI57x0BH
	Cjc2nl9j5uu+P1yHd5QVji337huC9XuilyyL1YbDcDduHpkmPRnX1vTkREIeWXUixKuNWI3sKrR
	WwWzLOVaIFg==
X-Gm-Gg: AR+sD11ec4bIUb0nhTfjcygGb1RQ8DuFZLS39xmDBhKmCKd8dpRU5BBYV4NHNSdiboc
	fUVEGxeLgfjQm8tPWO/AGDC14xBnVqFRIQnDcv21Zm9pZEGl8MkA+61jn+Hzncmgj5cVgNZjAL6
	ZRT0JX/2YrhHKreXqYIlR9tJfLg0J5nRVzbdydT1p7hwsyWDjPuEuuQaRsyOseE3eAmV0KU8nq9
	Jd27R7wTZfGn8FIi7ZudMJYuiqqA0JHfnNf1Haum3bE1FEryqJ8a8+hRvmXaQmMPnlMNIPBOkRK
	4QVfeA2+GS7VlGA35EVQC4E2fPCPDUjuGWMHfPnU7E930k1IBdGMQRyn4TpFZPyze7EQelVJoNN
	rB9lGlQOnG+ZWHi1DGfQ83V5C2iyvuGVxHiBxlEu2AVUPMP1IqrCEcLG02K07lUSzVHiwuu2wwm
	ocbF6vDEf4hB7AQM9BROSyLAFC73byrQ3k+JuAy7M8vp/lMFWAjjV0uPB24cq2t4cKle0uP+cYV
	xh9cpMu22mjjpUq8+TzGJ1bJ9ek9TsYii9H1A962Q==
X-Received: by 2002:a4a:e90d:0:b0:6ae:4be6:64ee with SMTP id 006d021491bc7-6ae4be6684amr15265579eaf.34.1785848437457;
        Tue, 04 Aug 2026 06:00:37 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae93d61482sm61530eaf.7.2026.08.04.06.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:00:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, raoxu <raoxu@uniontech.com>
Cc: hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <B39E5FD81D1A07F4+20260804023403.939767-1-raoxu@uniontech.com>
References: <B39E5FD81D1A07F4+20260804023403.939767-1-raoxu@uniontech.com>
Subject: Re: [PATCH v2] zloop: truncate finished zones to zone capacity
Message-Id: <178584843575.926496.3812961471455510787.b4-ty@b4>
Date: Tue, 04 Aug 2026 07:00:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 04 Aug 2026 10:34:03 +0800, raoxu wrote:
> The size of a sequential zone backing file records the amount of data
> written and is used to restore the zone state. A backing file whose size
> is equal to the zone capacity is restored as a full zone, while a file
> larger than the zone capacity is rejected as invalid.
> 
> However, zloop_finish_zone() currently truncates the backing file to the
> zone size. For devices with a reduced zone capacity, finishing a zone
> therefore creates a backing file larger than the zone capacity. After the
> device is removed and later re-added, that zone file is rejected instead
> of being restored as a full zone.
> 
> [...]

Applied, thanks!

[1/1] zloop: truncate finished zones to zone capacity
      commit: 72e67c118642634c25465db0c8bcfa54c4ce086c

Best regards,
-- 
Jens Axboe




Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC030FC2B
	for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226075; cv=none; b=MPLuq26ZxJywB2GR61ApUXV/mhCNWSDbDQE6bqWI6pdWo03jU35V6WnDK9nMpHR9dG4puduocVhbiuNOgnzaf0rFXVGmEQCFvehAb53SX51oBJdh+wf1FrVRA4PEJaug1FHw5bjC73MEX4Psg/gz1QK/rHJpX6sGJ0D5W6rPA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226075; c=relaxed/simple;
	bh=JEDKsB+0vxmL/ouuAFgu2eU3JiXMhyVprA4z1ejIepE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z5+AehmjTVLuAnLA0moyIMk5YvGtRRcjZpIZTIw1FZvtUgnuDRc/4iQbZPiJ8psa0eJIuJ3q4RUVZDzgY71Bm9aj3xs7AElJ3zfB5HkrVvRkLWA8YZZL5G8X+DYLtXav7+c6JiQB954DY+hj4518rMFZ515byhbj42DDZ47ffpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=h3AMC3pN; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="h3AMC3pN"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ea8b3a64c1so16340035ab.0
        for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 09:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756226070; x=1756830870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/cjvUBr/J9NL3y09c7zmhpXo81NHiBvjaERJhNYUEw=;
        b=h3AMC3pNijEpubOOxNV154NUfUtVRQ1/nyj+S3bQNuSpSXTT1/6d8r3ITICu07pYlD
         rWynkjaExZcUXA5tdq9Uwcj+JknV9HU3Qsmvbzg/R71EXrh++F3rPtlHhkVsurFTMplT
         YsQRitIKly0lgyMTcS114fbV6SRSizB6naAgJuCqCROhYaoTUnE2RKnWDbUHlTdMcuTM
         ypMk+PGmxPQcdurUkLgV5WigsgxbhChgTlXnHN4YPYJHJfsrnIskVpHMChffUd1/eLrP
         aHiw5qlXYoXGYXJ+8rY7S2Z+Og0sdxquuI0qspXdEIxvmOWhpQhX3+BT0hM3RgjBJ1Kl
         Xm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226070; x=1756830870;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/cjvUBr/J9NL3y09c7zmhpXo81NHiBvjaERJhNYUEw=;
        b=K2aZpLVtC5YEMdumRV/+ThASIWxS9T+wQE9eTJrChYEX+M5OeMQweAtbf5aOu8zeAC
         +N+AFeipGYWUXU6sT2tprAyj667ywUjRlMBsKX4D19GHirO4RMtBmikgCPs5yAzrg2op
         q2B++tnYiiBnRLwO8sStVd8gEaCvMMxBNUotF45ILeHoYX9zOiL6eb7MWDe26egeEhdq
         2jXwsyWjy0/7dl33IHqq9uXwLSKLjXXWS4zOP8DKvKb8FrpUJJ2QqYhC6uPWuDxShVvE
         RD3o9UFJ9n4GEPTUVeF7PGQdgTsmrvhzq5xYygwLS7rmOypqfQNVQgiJ+7SxImtmNlWq
         5w2A==
X-Gm-Message-State: AOJu0YxdDi/0y7/QHWcRyKFcMB+CeXpAHdmmURgFsUl6lfme14zop48F
	Wq0ZywNOS3FIe0rCTIvupRghhA+SukM3Wn4FB46OveVWhohOQZxiEdc2y7M8cUCNtHXAyGH4OQ4
	F4OmQ
X-Gm-Gg: ASbGncsUS4a5Z6foZaMOSIOx5lAkJGrNzDG2TvdbvDLIoamoERzgV2A9F+bhD5fdhmV
	3Jf57GviOEnsUy4fbJJYd+HwV3Vba9etPL9mGw3iqJOUWiAsI883fDeKNr79wnn1jER/WEnErUw
	OUOLyRXCYqhRf9lyrDKZzdRzBUaY2OU03czZPgnz7XJ5rhDILbJBa3ad/QsO+Al0B9dpdiqN8gA
	yC+DoxTDpngyR14ujysaymwn3eb7LaHHKmB0jCkYvimtkevGrev1bM7Ns4Ym2r1YDvgcp+1e9GK
	a3Tg+gExyWZ3cEtFCzOlAa88i1gQvxOFEcLg0qmerk5zMc1CVDDSuumwOzMckai/GquLPfYFunL
	85ivRA1u8yTfrXg==
X-Google-Smtp-Source: AGHT+IHiMrbUMGQS0T9yXBOtKjSzX0HApEauW4j4F92W5wtXBFx7N7AtfJQpj9E/zapCHoywUTBtQQ==
X-Received: by 2002:a05:6e02:198c:b0:3ef:2fe3:9a08 with SMTP id e9e14a558f8ab-3ef2ff2dd13mr22243295ab.28.1756226069407;
        Tue, 26 Aug 2025 09:34:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4e457cc9sm72679405ab.34.2025.08.26.09.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:34:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: ming.lei@redhat.com, yukuai1@huaweicloud.com, hch@lst.de, 
 venkat88@linux.ibm.com, gjoyce@ibm.com
In-Reply-To: <20250826163128.1952394-1-nilay@linux.ibm.com>
References: <20250826163128.1952394-1-nilay@linux.ibm.com>
Subject: Re: [PATCH] block: validate QoS before calling __rq_qos_done_bio()
Message-Id: <175622606847.70049.13136831917327617637.b4-ty@kernel.dk>
Date: Tue, 26 Aug 2025 10:34:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 26 Aug 2025 22:00:32 +0530, Nilay Shroff wrote:
> If a bio has BIO_QOS_xxx set, it doesn't guarantee that q->rq_qos is
> also present at-least for stacked block devices. For instance, in case
> of NVMe when multipath is enabled, the bottom device may have QoS
> enabled but top device doesn't. So always validate QoS is enabled and
> q->rq_qos is present before calling __rq_qos_done_bio().
> 
> 
> [...]

Applied, thanks!

[1/1] block: validate QoS before calling __rq_qos_done_bio()
      commit: e3ef9445cd9d90e43de0bd3cd55d437773dfd139

Best regards,
-- 
Jens Axboe




Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939233ADBE
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961169; cv=none; b=rcjhhCHF5mq+aM1UcFqbYXOXLX6R+8Wp6CaT3BRdG6mnEl4KnV2oimIEM3ohboelOVTFsvkZlkpgptidqbySKYN2IISUnpeinHd2YPM6jiXJq8zDK1G4/wuXMaBc/s9zFkTaRJjSG8kenzzt3EPvni9kIOVXGk3ELDvfUNVEb8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961169; c=relaxed/simple;
	bh=S3HgcwMVfZzHMTxf+gvcGSq00lyXdOZbvgaMm4vD83o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DKUz+njwD2boBzkj0YOXBPztTGkBoRkjUK7Vso+RPOc0PabE1f9ec0ysJUhVjKrB6dkLQsqVfXHU041G7x5hmTKArX69DQ+7+70rsnLPZ3t27/fZt+yFNvRUjsuxul/yKriUgg4F80hQ5CFLD2gCwyD6l12RiShz9ChrEaQLjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NcTzJJW8; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NcTzJJW8"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-9486354dcb2so39250439f.3
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 07:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762961166; x=1763565966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhfi1JuTKDb5v2cN/vHFWbcXiiQnvSefPdXao0zAnOY=;
        b=NcTzJJW8E+vnpv11RdlXvQwsYjKBfehfdIvWaAuqYYPm27trHhUDveoz1LcA+jXz+c
         1ntL8ZYWSWumBBn0BmUzHIt6veD7TY/yCjcQTQwIph8CVSyXFkrtdI7anglVp/nOzFzm
         RLSCTreqNnfVssrbnHPjZC6J+RP0ZSpKwSC98EUHDTkmjZr35EJR/cfh4eLX9L/66sDE
         g1YvLmqiNegpzRy3iWSfp0LvXWrJoAO15A8VE3jgPEEmJsuavFsrBLEOXAbp8buXEyU0
         n/6BMCGaQekJQa9oY1iUxeGRcnRQ9OWrHf0Pea/aNyIGMJgrCk0y0wnY6wwqP13WSY5D
         7KNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762961166; x=1763565966;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uhfi1JuTKDb5v2cN/vHFWbcXiiQnvSefPdXao0zAnOY=;
        b=GdJh+8FOJ78Tvh19htAFWClmBnPVbtp3yaiQEpumUS42labZJtLOxPymi1/33fa12N
         9o8ZmNvt3sdIiI2pRfSlnlzL1e44o2NBHExKKtDvJQkRDVfJhZRoirbW77UWthszfsXX
         R3GFuPg4WVBgxDUGgV+EmU8bsRkQXC38MBGhq/6yWyY1HgZcro0Vj0PLmknu7YyiqTFw
         JHypmBPYb1RwcEWamLPLbY+5boXLoZYAeSpA8aVTjP76/2lteNyT+WsFpaosXOjltyhU
         2wZAX5y1hajN0H3CpmZSHBQtQq4nujMFg7Upo/DgC8YtXRoYIePZew6AJpQbljLTYdWp
         BErw==
X-Gm-Message-State: AOJu0YyMF/fDTEA1Ycqkov4hjcBkIQmW/yXzbeTG8/dCGlY63BaQ8kHt
	dM0UFiVzypdBxqzKctMKqMjimWh65FN21nsQarocm2Mc7D5GGIk7vGXEvI7DkfgLZF0=
X-Gm-Gg: ASbGncsebfCH5sbhWP5oycG0HfPtD0PnakbGdWmmifLGPJoWpJapAA4shVFvLpjMITN
	Bv9whcFnNHkKfi4E76QlXF+NiwAEhL3rO0sI22UtAWZtCkTxAnuhoNQX72/LTwmhOY+L9/wbDMH
	+aqR5WNecg/foO85A6GBRWbCGEhueAaUQJk5TUYZFZObohSlckbVn8W82wA4pvfVZ+TbIsKWC9J
	riijKSZ8P6zM6WsopSdRvM/dg8gJllaKi67Ycdd4KTCLff9hRThy3ycHTagxnLbg8iRo2KgdZzE
	1I9y1Y6zaQMxkKfKspX3b0V1/0UmHSOnzm7MUc85v6HMHC0ItJ95JAHv1mU50vs7NzmmemXonmU
	UV6hFveWUawwIKvvfrS2as2/Wc7ruWUM8aJNGyOVjhxyahosMTiDk2HVdH5Yl3bfvio3u
X-Google-Smtp-Source: AGHT+IGqo/ElyNGaDcWY1T7XkvUdBijvAO9psWKrSyA4l0qa2YEYORSe/5hiqsBqgoiwFhOiCOknzQ==
X-Received: by 2002:a05:6e02:3388:b0:433:7c86:74ec with SMTP id e9e14a558f8ab-43473dcf6a8mr41773375ab.23.1762961163853;
        Wed, 12 Nov 2025 07:26:03 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43473398d5dsm11421195ab.27.2025.11.12.07.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:26:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Chaitanya Kulkarni <kch@nvidia.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251111191530.1268875-1-csander@purestorage.com>
References: <20251111191530.1268875-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/rsrc: don't use blk_rq_nr_phys_segments() as
 number of bvecs
Message-Id: <176296116216.24001.10740596505863921319.b4-ty@kernel.dk>
Date: Wed, 12 Nov 2025 08:26:02 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 11 Nov 2025 12:15:29 -0700, Caleb Sander Mateos wrote:
> io_buffer_register_bvec() currently uses blk_rq_nr_phys_segments() as
> the number of bvecs in the request. However, bvecs may be split into
> multiple segments depending on the queue limits. Thus, the number of
> segments may overestimate the number of bvecs. For ublk devices, the
> only current users of io_buffer_register_bvec(), virt_boundary_mask,
> seg_boundary_mask, max_segments, and max_segment_size can all be set
> arbitrarily by the ublk server process.
> Set imu->nr_bvecs based on the number of bvecs the rq_for_each_bvec()
> loop actually yields. However, continue using blk_rq_nr_phys_segments()
> as an upper bound on the number of bvecs when allocating imu to avoid
> needing to iterate the bvecs a second time.
> 
> [...]

Applied, thanks!

[1/1] io_uring/rsrc: don't use blk_rq_nr_phys_segments() as number of bvecs
      commit: 2d0e88f3fd1dcb37072d499c36162baf5b009d41

Best regards,
-- 
Jens Axboe




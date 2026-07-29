Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D434746C8
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324234; cv=none; b=nME11s5Iy76hBQBgzw+6fYva51RalaV3ZdMFyYSyjiFfanwxfsl8orucQGWR6eiZrOxhbARHgwZ0VDX4ch/u43CdiMivo/jIRkoilKvLxHSJeA+1qBLl3I5AouTMXzGuMlQN+dyl32ACsWS2A4zAE4pUQXQglDkz7ITDikrbqEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324234; c=relaxed/simple;
	bh=AS7xis1subjMmcpKDCeIM5W+gE5LtmML6ycbo7N01SE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wyh4dA9spC+TnAEQOscqRH0cZCw16rkUz3mjjiCqXK0ta4X0nnMZIvrkZYXSgjLCP8MU5jpaLY1Sdt4bcBogfGsdOxL+wQhAh/9eXKdudT3gwK6vNof4HVgkyLMBl+JdZhIeIXoVqkU2v9YxETIGJAllpQDh3LI9wzhNxYYXud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=MgOw9wJO; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="MgOw9wJO"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c2b2c9eccso5558721cf.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 04:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785324230; x=1785929030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dB+7/oQwJJufIkrffkclEaWLXIsbNym3Q34Uk29y19o=;
        b=MgOw9wJOh9iJYzn2N/aZgv5vgNM9AWMiigOnQ2S3nDax/lSdQFiUY81gloZT5aZ96q
         p0y5iZY2D5ZSpV+fC5G4gHLoMj6nm5tkobxLUwhsIAvPZ6LjXXhyqaf1maimG6QhhGTX
         koZtuHUj4Pv8pSIqxZiwa04yIU+2AaPp5R4X0Sci90ZrSiYT6yfLqEm5EOupsY+DNKUi
         qLSxd1lgi4Qw0P3sjxKp/SccRdT77LAR0GYx5oh7EeEdNsbCBNaCfADD2elpMNqJJgia
         KpjN2fvJiRaGIEDeH4eUhg8eqt24s/3H/ERKf1G7MUPU4YBbXMWQPcTp/ibx6p6Bgny5
         yUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785324230; x=1785929030;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dB+7/oQwJJufIkrffkclEaWLXIsbNym3Q34Uk29y19o=;
        b=mHbi32jS3x8tgvluWltRPwdYGXrLDqsyRjZeMh5SoG4ATkgmqxEmCEJIGb86KdhOu+
         6OK9TQAYsab29QsG6YpfU7AYzaWkIQSdS4p1lP24GOSiAJW4mmAFbXx19fPdKNZDftDQ
         b2C9BXpTDpypcJBFHIMekYFu8IMsjJEt92wd0eHy/ThF073CCd/agzaSUzJgSZYjhgq8
         zQgHB3yw8O8xD68nkdlqr9akyJG4bgUzl/I5Abff+WMYZRiEzdOpmIzwj9KyNKn1dYzq
         /tJL+vAIluiJOqXrKSR57EWselihy69P0WpDyrLxa2DFWzKiRjwuF5vS4nebm2IhlMNX
         q2+A==
X-Forwarded-Encrypted: i=1; AHgh+Ropf2tXOz9jR3TIKkMwRDsTQBE3nhiHgWjWaPwZCmHp1eCEaUewkOkkSFqte+Me1DikOhNtgcB+6/ZlpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQP/QBMYnuEtG8WYW5SJoW8IQBS54vKm7uzuFLYoLxTV4onqya
	4GPGv3mwIyG/cWIPbXQxynlRyIANfvWTTaKBoIPGhxYAd38I9elSjYt9LrDrDNfiOVw=
X-Gm-Gg: AR+sD110qkuZf9WtJ8kzJpIdB2rfkDyKr3/QD4i32v1G/QE8T+7QuhiKq5vFaTHvHyT
	hjls89Mjey6ozRIet8DRGW3DPZwbNsufp5unCg9Q7HKfpDhMPT0BVKyLZ7g+uKoj6xR+zgywsdZ
	YUrHXoxd5uCPmJKSlLWJJp1m+EcJQ7ReB5ms9EmNPn+iAqrilh8uzRjKku9xYkeJrl/9N+7zJI2
	JltF2gNay7/8tCrixI/VrsntjRBfsiuRrwc1Euv8oOGqphBPqiJsobI0+mbBL7+dkIK0AZ7aGNN
	K+eUKLAsrFfUl5JUd9pZ+XQgyQF9DgiDpaIZhAS3oCnzwOdTRuRQ74gkoAYcLHh3Vc2vpgjyiHT
	JiD0zGfuGOWV8OrWPro2G998qTqoo/NarAMmgapHNHYuSNdX/DhuxPA4aoMfRSUj3I7171alaGt
	9ighuPGUH9gUkZFeLhs9mYkYgiYpaIS71z2Uxl/god9kgtgnl3fs8ngvNt/2zTvGxoGNbtvNBvt
	npfLPFiRDnN6B65sy7n5xYAhPgk3R22M8ainvniHrw=
X-Received: by 2002:ac8:5dcd:0:b0:515:189c:e0f8 with SMTP id d75a77b69052e-529d709f79cmr54719331cf.17.1785324230042;
        Wed, 29 Jul 2026 04:23:50 -0700 (PDT)
Received: from [127.0.0.1] ([50.234.234.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2b63008sm16556611cf.10.2026.07.29.04.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 04:23:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Chao Shi <coshi036@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, 
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 Damien Le Moal <dlemoal@kernel.org>, Weidong Zhu <weizhu@fiu.edu>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260727201257.211635-1-coshi036@gmail.com>
References: <20260727201257.211635-1-coshi036@gmail.com>
Subject: Re: [PATCH] block: stop the timeout timer when releasing a never
 added disk
Message-Id: <178532422849.2568853.3142469605707392497.b4-ty@b4>
Date: Wed, 29 Jul 2026 05:23:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 27 Jul 2026 16:12:57 -0400, Chao Shi wrote:
> disk_release() undoes blk_mq_init_allocated_queue() for a disk whose
> probe failed before add_disk(), but it only calls blk_mq_exit_queue().
> Nothing there stops q->timeout, and that timer rolls forward: it stays
> pending until it next expires, not until the last request completes.
> So if the driver issued any I/O before adding the disk, the
> request_queue is freed while still linked into a timer wheel bucket.
> 
> [...]

Applied, thanks!

[1/1] block: stop the timeout timer when releasing a never added disk
      commit: 26cb8ebbfaf713c82e142d08828d4d765057633b

Best regards,
-- 
Jens Axboe




Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038403;
	b=guZtibWOKLfkUns304LoulzDPQ3kwdn0dT7NyMv0OWgGh4e471VbYW9BkM7xX0WEUlPy
	 qGM8cHULba77gZIQKvsMndhVcVLS0xc1x4gAAqh15EZw5iYa76zsERLh6eng0WIK2xBUF
	 qWH4LTDqbTFCjemFcWKWK7/rMRsMrDtEwIOWogGPaTxhn6/wwSZITTw6IMUawcXetdBYN
	 duyESzzK3ZWzVpkRbRf5E9nZVcPlugT9eVi8rVyx+WmQ9D8OfgEoEX7181W2sAnx8DF+t
	 HbmkC3aNaHCEIik0ezJTFcXqXjqDErW8J+yKnbcbT3Gez1zx94hpVijg67Or+ND/Wjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=j/PGXyV6/Wt6qi/8E7+ZLUzJWYcL7XXDLU8lYYkrrcM=;
	b=qU6Biy++VgQExo+MQur4egigbflrwTfFKsGO/VscrZhmnqOoCrGR/brMiAG/eQZFiq3g
	 /lFYxQa/ORsKIXtyCCijNTW1tchetnLFP+jG9k1jRDU4+HFJSGLF/ThO36QrvKpn6Ne7G
	 C0F1LELzXAo/I9npozkPxRHkUETq9SekNYaBUVFRNBimDb1sEQwY52Sn3xlHzD0Ktm74k
	 0vVCL7HkpZ9sLJPcRghWfOZW9mTb3OiKTA2c5zQwyielC8lXlUra+mLVq/+3uQqvrhK6I
	 RfZNNo1TVxf9R3O+ytKUKMF3EpMQInUViBzOvNXGezvVlCgnHdqFG8lrDqQguR4JysA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=OXZAXbFm;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B400606A326
	for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 18:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B400606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=OXZAXbFm
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-185fd3a4ca3so2716196c88.0
        for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 11:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1793038402; x=1793643202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j/PGXyV6/Wt6qi/8E7+ZLUzJWYcL7XXDLU8lYYkrrcM=;
        b=OXZAXbFmxu5N5tro2yRXp1EQltbtiVnGSO8vBdyCYgKSdgLXFmmaXw9j7eahoJEJYA
         dMwqGL80wIUv7bsjDO6wLee9Yvn7ZiqrFZROKvKeIRzd6ymmHBsRcPVsP/PhcrFcjknJ
         UWdfIv2ri1QY7PgLz7f9h5EmdMIZY4jHYRX7LJ/owzSYJvKGk7Su5hSq+eUs4k2vmZeL
         jVm3HuQuEodE5LCh6pqEInivyw9t6apxMVTiWWd7W9L1q5LaMqBtQjcJ6yDRkl4+BAMp
         OtC10QTQlyP1zdGZeT9M+4tphQhERT0Onu8ZpzfM+Jq4T82429meKUuFbUeAMZu+TEfg
         1Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793038402; x=1793643202;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j/PGXyV6/Wt6qi/8E7+ZLUzJWYcL7XXDLU8lYYkrrcM=;
        b=QNCEA0ffAxR6kNVUhQL0IngriYjrGMnF04I/qHVY9pZSxKcULRAubrC/UfH2M3U0wB
         YPenQBV0OBi/DyDG8ke20EmsLEolTDCiGdVqP0cuRw2re/zaxcmoLbk1VsiBSEXs8d5O
         mpiqPJtI7Vj9/uIgfzJu3BrVziCITR4QEJW3/dkq2IoVr8idtK5Vuz9LqYyB6UzkKc37
         BSDSlCydfCWCn5mTlS3UqRV1UdXW8NXfZwxhNqGibfT5I8HNQyocT+eDK281QRZe7HHh
         hr0aVnG2CkgrR/tr/R2RPzksU2mWvMhkSqO1i7U1ryXrr8axlF03sileoMQVXTv70vFA
         qNww==
X-Forwarded-Encrypted: i=1; AKwUvBxdwSrA979GtgWmWfdMbsBA9SkBj9nFAh/xFs14tlmtbRcby/YIdePlv3ivtSZy90ayFXiBaop8YT9mSw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1jzRW3GdHrvc65/jxY5TgYkLq/mk1yRGUZv/JU8oOl6GGO/Ie
	LshjMT4sqAtwJSa4yBrzLkqN91j7unaObL23+r7JTz4SDG1dpGa2MGE7L8xMMEUUBno=
X-Gm-Gg: AYBFou1jMbLU/tnhhq/kEI/ZCZ5G0sK9/s6Qu9j/+pi1RVv4V4pnLjog6ymlXcDVS/1
	fNz2aIPlS7JDagymsUmo5hSwCPPTxZSugfmwM/cC7rGitxxAYpcED3bA4nNHuu1ZC2GzSBenawf
	rxYrhhZRgl0CBzvN+7Bzip0z41V09zC5Uhn/2Y+VAnmtl92hILyJkQQE3xT7ma1L8wREEhZpHu8
	fssAV+btpIxE6iDKoOOpNDG5UNQL9DI5Y2/+3Uy1/PNIl4TKrd1nz3AimHxJzZHWYoW7KL8W8Ts
	Rf8AsrLSTYgM2FKa0LYHToRVs8uLSQOS6/DfRZH7ZiuZb2K0gsLvsaAy3rr8it2RYx8rdE8hVlM
	shXvzbZ++aR+4ts56SuPFk0xxO26COOpj36h+nUNsUmjH3XBXcATw0bnsK755qIKxpR0FU91G9P
	fg4b34Gz0tW/BNxLOitABZaB+NXz4xIj3pa57OkBH+yZdh/bsZMmANwBivu+BplcKYKoGuHhGY1
	twgajhvaKeam1HRqRhgjyGtBuk2Li0dl82NKjxU+h1/or7m5/FER/A5EBZ+WsIkDjXL2t4857Xn
	RgKTnqPXW+pyXYZonXK5OrtUM86+F3i5JM0DzEw=
X-Received: by 2002:a05:701a:ca07:b0:176:a225:e364 with SMTP id a92af1059eb24-199374f3d28mr11671343c88.35.1793038402460;
        Mon, 26 Oct 2026 11:13:22 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm23576455c88.8.2026.10.26.11.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:13:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: TJ Adams <tadamsjr@google.com>
Cc: "Christian A . Ehrhardt" <lk@c--e.de>, Christoph Hellwig <hch@lst.de>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260929160813.1599129-1-tadamsjr@google.com>
References: <20260929160813.1599129-1-tadamsjr@google.com>
Subject: Re: [PATCH] block: advance iterator after copy-in for
 SG_DXFER_TO_FROM_DEV
Message-Id: <179303840146.792754.17618533917461283198.b4-ty@b4>
Date: Mon, 26 Oct 2026 12:13:21 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 29 Sep 2026 09:08:13 -0700, TJ Adams wrote:
> When a passthrough request uses transfer direction SG_DXFER_TO_FROM_DEV,
> bio_copy_user_iov() sets up a temporary iterator iter2 with
> data_source = ITER_SOURCE to copy user data into the bio pages before
> execution.
> 
> bio_copy_from_iter(bio, &iter2) copies the data and advances iter2, but
> the original iter is never advanced. Consequently, iov_iter_count(&i)
> remains non-zero in the caller loop in blk_rq_map_user_iov():
> 
> [...]

Applied, thanks!

[1/1] block: advance iterator after copy-in for SG_DXFER_TO_FROM_DEV
      commit: 82e72ea18d0af724914c31a1f274c1aef452aad0

Best regards,
-- 
Jens Axboe




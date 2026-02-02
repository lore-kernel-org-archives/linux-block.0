Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E206C37AA7D
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045697; cv=none; b=RZRUzJXPXs7eGOGkiAtBcFshEtpubY++b4kWBkLfwlHdZ48/adLKaHkk6R8SGvUPCmZGui9yxr0ICp08peX3WgrMhpfKhH+pEcDo5ARHMEGWBGo+Z3Eaxq05LfbHC1SiSb7RHb8+QD0A51ihslXXbigF6N4+IkCl7QHF65hhoHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045697; c=relaxed/simple;
	bh=uO+4T3fuWqb8M3QIz1yAHGEDb4iRjZZjSOfSvx80ZrU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=quRyGHK6D3nlTqzXxtFl+6+t7g8lCW8jYQf/xBFqPTsPV6NkugXzfF93vFPwYv6OpEkf0BSIBH+xtZp0W9MeVcf8BrQxTsBZo1Bg9NderpHSODPs+n9oNlwSsoXcHV2dd28ffh7tWvqJI2wKmbRq7zbtPNxOBqHYOs2iGRNtkA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=20CAmb02; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="20CAmb02"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d1890f7ee4so2797143a34.0
        for <linux-block@vger.kernel.org>; Mon, 02 Feb 2026 07:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770045694; x=1770650494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ovE/qaqNL20eWEaFp0rTdSV9JiE4Qumn7UhysLX3dI=;
        b=20CAmb022dRbASeXDYLWAF8vfpr1JrJo1kwUit7+VuUhNOoSfXAfSMMRTTQuJ/xF5x
         2AQgcFH0vUuxI3SLjZ02yOjcgMtQkLI+3T9FKq8THZXGtrMgVOFBziZhoTFDXCN0qZUE
         H7bvMWmHvHu4aeUV3DVGeWZbxT3bSReGIlSARukX/qRZG0qU248yq2SKjqx7hhbJrPpJ
         pIgGdcjGqCm6Qt4ZxXigC4dONgtW4RkGt77FPbfip8mKUYT6iFjAjUQiB5YqvAwxvbWP
         acUuETFzHmnqb4IP4vkVQdSe8ROfxqYIuIybkqY9c7S5icA0gIih+WattzCr+yEzl253
         BkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770045694; x=1770650494;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ovE/qaqNL20eWEaFp0rTdSV9JiE4Qumn7UhysLX3dI=;
        b=ooBxLoJGQv2hKmWYqenmhyA5S7ccAFRxqhmGPBTJKikuwp6Nw8FHHGIykGvQmRkjXZ
         t2woxEz9T7cQFcyrRMWQJhyBmeqORAKXtJ5UgV+TpTUPSKJKTPRHMNiJaKyT3Hnnx0eN
         jqPc0OR9yfAg2NwYEXPDtdRKpgAxRsoRC10sywF24NwVoSePEIgAvGPkEmxo+C+mKghe
         NjAVqpJmgnc+SXP2rGF7GCoiCr3k4MjOkZxDELTZzSgGTPzOmi9Na+4x5GtMbnjdNmOz
         QWzRYKIvi3AKC+H+h1vJz/5NJ1WK5ECbD2qPhgj5ANaoPGjau95RRdfxqnCNC7+Wjdoz
         ysVg==
X-Gm-Message-State: AOJu0YwXn5jkWCu+m2KSpfgS8VEONNMwer2QPkq17Mf+HK1NyRx2Pfg2
	QxFU14UgGVYQw1I2Ybe2AWeozijVJOuAWsnPKIfXnUztDE62c2NSvfE1xRe2+xUfVaIjrBAcnIv
	RCY6O+wo=
X-Gm-Gg: AZuq6aLvmVsYGBj3bb8A09Ow7cLQtBxOVvCgCtrXCDxK/49xBS7B+vW8PIVZMRfn89d
	cY0euM+AroHF+n3exo/aEzDsZ2FeM9X8kugqqu9L41ocX9P7uY8d0YKmPMSy3147n16yp/3F+Kx
	w/eaZxrIEDtWhcW16S35bpHRTi5RMiHbYSHKE+Df4yTp4h983x9ku6FhJEaLk0gSzc9bwpWbb5C
	RgbfkJTdKEL/68FBwYfmvCyajWmGYE9y7VRea5OczxUfCsxd3X5ObPbgZNy2u0aTzLobOxvVHnS
	3wCro5jKCIVCDwIv2/YcpLB/4wHY5H89s5Y3A9ZUmWiAoEvhA5KuDvvgTgoKDpCoycIS+hHDiGm
	cS5BjexXwXZyTyfsktfZygO3zyBcYF+Vd16zHLRp84aY+WIKdI13/SYp8YVDONb9CWLHpFxICnF
	4ukC8HsdO3jEOvlqxe8bgAY8gnhwa6ypaDdHtb/HnYAQWldHl0QL7x2PEOR9P26m8c
X-Received: by 2002:a05:6830:6607:b0:7d1:586a:32a2 with SMTP id 46e09a7af769-7d1a51221a9mr6536159a34.0.1770045694521;
        Mon, 02 Feb 2026 07:21:34 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c7ffcbcsm10613171a34.24.2026.02.02.07.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 07:21:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai@fnnas.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>, 
 Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260202080523.3947504-1-yukuai@fnnas.com>
References: <20260202080523.3947504-1-yukuai@fnnas.com>
Subject: Re: [PATCH v9 0/8] blk-mq: fix possible deadlocks
Message-Id: <177004569337.1085433.15214183568484883142.b4-ty@kernel.dk>
Date: Mon, 02 Feb 2026 08:21:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 02 Feb 2026 16:05:15 +0800, Yu Kuai wrote:
> Fix deadlocks:
>  - patch 1-2, pcpu_alloc_mutex under q_usage_counter in blk-wbt;
>  - patch 3-8, debugfs_mutex under q_usage_counter;
> 
> Yu Kuai (8):
>   blk-wbt: factor out a helper wbt_set_lat()
>   blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under
>     q_usage_counter
>   blk-mq-debugfs: factor out a helper to register debugfs for all rq_qos
>   blk-rq-qos: fix possible debugfs_mutex deadlock
>   blk-mq-debugfs: make blk_mq_debugfs_register_rqos() static
>   blk-mq-debugfs: remove blk_mq_debugfs_unregister_rqos()
>   blk-mq-debugfs: add missing debugfs_mutex in
>     blk_mq_debugfs_register_hctxs()
>   blk-mq-debugfs: warn about possible deadlock
> 
> [...]

Applied, thanks!

[1/8] blk-wbt: factor out a helper wbt_set_lat()
      commit: 2751b90051a0211ed7c78f26eb2a9b7038804b9b
[2/8] blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under q_usage_counter
      commit: 41afaeeda5099d9cd07eaa7dc6c3d20c6f1dd9e9
[3/8] blk-mq-debugfs: factor out a helper to register debugfs for all rq_qos
      commit: 3f0bea9f3b9e7d9bdc3794103575168ef007d309
[4/8] blk-rq-qos: fix possible debugfs_mutex deadlock
      commit: 3c17a346ffc613615f48c6f1ed30cdf328bab805
[5/8] blk-mq-debugfs: make blk_mq_debugfs_register_rqos() static
      commit: 70bafa5e31ff979c4c38ac9838cc960a32c04f49
[6/8] blk-mq-debugfs: remove blk_mq_debugfs_unregister_rqos()
      commit: 5ae4b12ee6422a816efca4ede8411e4d5503b5ac
[7/8] blk-mq-debugfs: add missing debugfs_mutex in blk_mq_debugfs_register_hctxs()
      commit: 9d20fd6ce1ba9733cd5ac96fcab32faa9fc404dd
[8/8] blk-mq-debugfs: warn about possible deadlock
      commit: 65d466b6298470ce21ab21ebfdb51309d515737d

Best regards,
-- 
Jens Axboe




Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7015622576E
	for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764543394; cv=none; b=mkh6rLMz8wDffgWTR1Iap2t1I6M8rI7OMFZgcULUcd5eBY7q37HZUGGPYEIJjAcp5T5Y7yWvvNlgA6ehxsVbfiu+xp95Fs50oQL9GRX67U8UnLZ59tKf3EeuJaoCVSBzUSLGw28jLajkmk1zNA8zrnqyPZ6r1XJKKu9+B+UiR6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764543394; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A90l864Ezj3H/BnKKlVsAGgVSv22fxts/7MpZt3iXul6kyeZM1mmsjSxriSEZ40oMG+htWA/ZndYnDlFKtGkkYOUFXZWQ763naBvRoJkdVIUKCrKiDp8mHASug6Xu+cA0OMtfxPzPw66LK0zFit2S2b7cRQd4pIQ8inypm1wla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477563e28a3so23529055e9.1
        for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 14:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764543391; x=1765148191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=BoBnNGUiCZdxoguSq+L7P6zU4smW/IptOSjgEAV1qGMfczgMq4upfLFvwXJgPMNmZo
         MeTL5Frh13YldKOlpapgHPnBlXAnY8W7rV9ckGwGl5S7t4Jnv0z2K3mhZG4VnZKPtdXO
         3OoyFHoB6b8MaqeLijvmpGF8VANDDfT1n5tfMvdytZoQ6AxSXS53HAdKsv2ygsoqaM3k
         N2Aw8SjVmXpX6FKNLLWlHw673l1ZDrsj3bTGbxRG2o1CKatPq9icmszxgRt2I1yv57ZO
         nNWBE4sSKnRZHasLIF7q/bQcJWTbLzeGqn6O5B/6nzytpTacR1ELl6ZkO8mQ9Nr2oWZL
         Dtrw==
X-Forwarded-Encrypted: i=1; AJvYcCX//5Soq/SQTC5IARsACbh0s07tBjUDZrVYsgcKhx5XpAFlBdJZk6GQRihMjWuaZrz5ikMZD7PjvxZtFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPlxvEN8uJKm46KVLP2hitvH7iqwPVTD/FuT89BKvamJlPnMgm
	u2YITPr72lfeozjuacPDOhj146GrQ/yjOdOSXRbHmnkQphaeiXc9iblA
X-Gm-Gg: ASbGncvXKrlYZkyaK1OVJveJyfXHIscFRxaasBdIy4pt/51IhxSus/lroFxtHizZif5
	gEyYksaz32xzYr2s3sy7Xx7qxScHJpa3qxvTXlo6nWHkSbR7MUsWVHH8U0KWepl4hh59qDkmazo
	8hViEQOFm//sy1IRxIXlrGyrgNZhY8AyoAkBHSK3i+LqYjFJX7ylpjmRNKNmA5/4QsI8ETJ54xa
	f277v815+4rCOsAw5+r5d48HuvZdZJhdo+hwDC+upcaiCdUOnXWtYtE2yhAy3PBdJUiwfW3DQhZ
	N1jJNwLy+nKmP76OTbmdGllLfY/650wkZDSABTGye5WmwJvesfsvZClWc5xKuTjEIA9Kr7djVJ5
	xm/RlTNDJqn/m5oh+7erbcviyPPyruhzW3X+gf2meLTaPhoB+YEFJw/vqDzdNIYTrI49AtKMaP1
	prb6adVxygW7myuV+bLFpJyJuuXLYdZE/MvdY2c5y4
X-Google-Smtp-Source: AGHT+IF6boMOfrvVsz8rwHJepaN76f4KZPR55g+YUrBrfFSxA626ZDgFmDoBFAmK/Cu1G3WQQ0z5NQ==
X-Received: by 2002:a05:600c:35c6:b0:477:a219:cdc3 with SMTP id 5b1f17b1804b1-477c0513e47mr451409235e9.12.1764543390553;
        Sun, 30 Nov 2025 14:56:30 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1caae37esm22371708f8f.40.2025.11.30.14.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:56:29 -0800 (PST)
Message-ID: <9c0ba878-8e86-4e00-a2f7-3ae92a821819@grimberg.me>
Date: Mon, 1 Dec 2025 00:56:28 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Casey Chen <cachen@purestorage.com>,
 Vikas Manocha <vmanocha@purestorage.com>,
 Yuanyuan Zhong <yzhong@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251117202414.4071380-2-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251117202414.4071380-2-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

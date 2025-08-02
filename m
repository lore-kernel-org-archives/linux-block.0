Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137421607AB
	for <linux-block@vger.kernel.org>; Sat,  2 Aug 2025 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754159348; cv=none; b=rW89vDSebB7vSBjinF9ID/4M6pzj5iHRH4jeRIaig97gJH5KbPky8nLX4eOIGT/7j42QB96f6Xv9ro1Z93I+xFZ6fXR8335dov3MxSOp5zS7UVnk9QH+wtkRWLPTe4d2Gc1lvOVINf5nDt8YVblVeOqGXhluk47f7kfHT8Qr9/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754159348; c=relaxed/simple;
	bh=3/q/01Kw8ZveN5uXDk9WBkAJZZ1KBxTRWtEkSy58akk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAgXSDElazd59gc7s4FKKQvthxlMr9dCBl2ec0KD3g3/A+fsCJGkV1lPQ/+yo8cV93eIcIIGTTFKrK0dIQvIcqgleqDVh4WiqX/6apobFEuFnnUoTrDfxf/4lDm2YXFAIAyeW5bxBMsSguR6p5GzoiW7hKbnMvXlP8BFO1eJ9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=r9bTpO+r; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r9bTpO+r"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e3f378ea68so18438285ab.1
        for <linux-block@vger.kernel.org>; Sat, 02 Aug 2025 11:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754159345; x=1754764145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNX9aLZv+0xt24TKcFUGdswadUZaiXhs1rcuXTMzeRE=;
        b=r9bTpO+rlmCjP83VUENQ/7rO1uejZJpEJzHcOxCh8P7wwpqzzjKucKCYGdbylr8Tgm
         F/IydLvoaQ9TuusMwgVf/bWASdkKHp04xFAv238ZfcCDyXJ3NuR2TO53BQnSvUR8TLyq
         NRA773bXeHPWRhEGC/L11Y0kdB113QdNvWplNtYFgnI1zBBKpnlvX0W1xcNVOWjq9BOi
         yxlt3edmiMFBIjTk9Sv9gG6F3HjipUfHwfhxpMF6OVlo6i+H7Ezz+pej0mzUMqoiCoL/
         1E75fQIwHqAvg7jHD7X5G48R93rhWFT0xhatHYDGWS9XYf/okW2FYJom2Q4H82w5E+oV
         8k+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754159345; x=1754764145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNX9aLZv+0xt24TKcFUGdswadUZaiXhs1rcuXTMzeRE=;
        b=K6zytCcbKa9uamIXubNe3dPh5Cw9u8wS1gQQlQ3PMxUkSho/tyUzHDMtIkwoCQf5GL
         TeqQSOzMzZqwCCQ6r4N8nQKmRtypfTLGo7PShrPvfEOPBNyOyrJbQotv+khVwmJDunpd
         yMA0pEuauZaV6EcIH5M8SbTwrwY1VKt2IY/rvvFJuIa+CEV/VBohGPX1PLdLBrd110Ip
         WHfVf6gU1wSag9OCEzmwChwtTXp+wNstKuaFdTyrBQJHH2g8EulYSoinj2jJZ/fJcLpB
         yrvUMmWQ2VRg+Vq4+TEGdOaveeeoY1ogGaJ1p/IH9SMXjCoT/O4xtmY7zAo8GMQ4ScjC
         NPNA==
X-Forwarded-Encrypted: i=1; AJvYcCXpZKi5fIjKJa6OHlpqF0oLuTAKmP7FbI7jIYNxGVlSJhPZFO2rcNmbA+Zvl79t/J6MJYNw6TbHGM7s+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyC7hy8FSbgbrp1eWROda6BAbewcHmT5NL8jR22O7pyYixluVL7
	Gc7N+dL6xKdA5qgOsYflHoTa2r3sFXsrhQEyif/4lXc0EOP+rz9uFtOJq82KbKT4ZTU=
X-Gm-Gg: ASbGncvzLyNG3h1cmNaDZVvz+kSpf9s7gXi/1gp82hd1uGdOgS2vsXQFljNGtG45UWQ
	weBUOCs6MlxxBBYPoDT52hiwsExMJZ62i0S4pNhjBiktIejydzDZO/gfHOoNwR2kFc6HvoSy9yF
	JBn3Wpi99fYnf5UVZnWC6ffXBD1wu8RurIilGGxvdU2XN/bZFAZaHN0wgFMy8jOr4uT3OoXDSrq
	QtFVCNzjyu2f+5h2ZMIgovyymP+BhcbNZI6ugaJqhGK2Fa7nskGCYORzcHLR23UHVq20JqNE+gA
	gTtwLjEOL93hgvSfbdtlVbNHQMSL7NDT1WKeeqrmDp0chWwBkljTwZcQd9s5GS7MswvVyck0aQC
	v9L3EcI5Dh74QkiLVT6w=
X-Google-Smtp-Source: AGHT+IHzaRNmwiGxLkH3TF10AYT+bxSNgY6PreyIBTrPPO1rlkJwu3eRF/OPHdtrpwpBJs+xRUegPQ==
X-Received: by 2002:a05:6e02:351e:b0:3e3:e4b2:8a5f with SMTP id e9e14a558f8ab-3e416116edamr73477475ab.8.1754159345187;
        Sat, 02 Aug 2025 11:29:05 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55b1ac2esm2030318173.1.2025.08.02.11.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Aug 2025 11:29:04 -0700 (PDT)
Message-ID: <0c680f7d-f656-4e79-8e1e-b6f2e5155a80@kernel.dk>
Date: Sat, 2 Aug 2025 12:29:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-6.17-20250803
To: Yu Kuai <yukuai@kernel.org>, linux-block@vger.kernel.org,
 inux-raid@vger.kernel.org, song@kernel.org
Cc: yukuai3@huawei.com, yangerkun@huawei.com, yi.zhang@huawei.com,
 johnny.chenyi@huawei.com, xni@redhat.com, heming.zhao@suse.com,
 linan122@huawei.com
References: <20250802172507.7561-1-yukuai@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250802172507.7561-1-yukuai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/25 11:25 AM, Yu Kuai wrote:
> Hi, Jens
> 
> Please consider pulling following changes on your block-6.17 branch,
> this pull request contains:
> 
> - mddev null-ptr-dereference fix, by Erkun
> - md-cluster fail to remove the faulty disk regression fix, by Heming
> - minor cleanup, by Li Nan
> - mdadm lifetime regression fix reported by syzkaller, by Yu Kuai
> - experimental feature: introduce new lockless bitmap, by Yu Kuai

Why was this sent in so late? You're at least a week later sending in
big changes for the merge window, as we're already half way through it.
Generally anything big should land in my tree a week before the merge
window OPENS, not a week into it.

-- 
Jens Axboe

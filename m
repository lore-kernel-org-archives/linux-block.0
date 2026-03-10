Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFD840DFC9
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148297; cv=none; b=XHnpS66C8+Qxz8lJegCxBYlRsCje0+iOY8hoOgpHa6rHeIUJQOKrqkth80OdtcKj6+w/OVzZSW7FGn4VSmgUb7QgCVZm7XpIAs7KUvmGXlbmE+OqC+Gic+WzE/8BSaMle9Xf4ULlOzYgWN+tolNNqGKDfPFVXfUj7qqdsqANjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148297; c=relaxed/simple;
	bh=oHaTGbFlQjsbVR4UCP9mUtHvaQoCA2BMU6kgCmOsY4Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IECMtHa/8bBEMoOluF7N+J3raOLUPWyt1cnNeGk0xo9zi0jJZV397ak7CGETWXtcjmMyO/9bjuHWQYc4s8UTZjgBuDuglVTHXSc1+pNSPVK1J6Y8xuXk4vbpKZP4TZFbk5DOlXodVrnzjRFXDV/fguuicHXQ2gOhlX7gHjehKsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=p6mA6oeZ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="p6mA6oeZ"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-46701f2077cso1951378b6e.0
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 06:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773148294; x=1773753094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvUtZVR+FIPOoBFUXmYubmz+HUENbKUiEI5TF4zE/jI=;
        b=p6mA6oeZTZlR4znVW4I5vU20LIkxT4VKP/1stIymP3DoOizYpb6PMjTvuyOo2zB74K
         h/MJydmsP2aDHMOP4BFmMCwkZeYm8Jb4S4UkDVYbG+BB8D6HL02NKhN95qNV1SLYhlNJ
         6JgKXnvNOJVnuVbpG9GXvhBUqWcTizCeB2IBf/geew4qT4GOSP/bB6g9LX7PqoYXMWQ6
         fzx/SSLnqHmfPWDjshCHuFKvWSLegHHbLYVdQBC2OycXM5OU9H9Kpzy3zw+rRnZz1dBu
         Z3Q8yoMyfdcY/an/hdxFGGvVEwBliA95EeQlSb1eVEVr8XUIEIoV5NpfqDnbMJzTYlf7
         UrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148294; x=1773753094;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NvUtZVR+FIPOoBFUXmYubmz+HUENbKUiEI5TF4zE/jI=;
        b=sGkcNc4G/YuNBW9ixAY6/MxbL4LrYaknrGmVoqjLbsORbtm0BZuJM7n8QpgEuLrgkf
         gJa9F/Z+YoZCZm97H3wKL3ZkSzKVOJr/DPsNOEo0VZ+7ygT6cw4XgbQykZZ/goF8VctF
         WlB9xjHc3AvwHCO00nh4uHDY4Kb3AR5yhVaCo3glMalxwyeelsDpj2NYm7TIJL9euLxh
         Hpa6nu7I6vHP5N3zBJIxKokbwzAnbkwpIJLcnYLcilqSvIDx60x420zFz7DwmB3Ydbpf
         cZdlfGrEB32zPM//emPlUYZyNZgajgTzXeygxPUasNPfUFg7t40jhoKv1o5asxz60XcG
         QlkQ==
X-Gm-Message-State: AOJu0YwT+t85ss/EVfHUOkMMaJ66ca7d2zeGXgvcvPhFDtZUvLsnJLXG
	PQAKAq5bryR4Kb5Obuj/bp6Cc4W/haiBQeWI0Ksvs2r85dCIxG1tdoAxNItGMau6C10=
X-Gm-Gg: ATEYQzxzhEARehvYtQNMQew7+IZF7LYwBgeW2+z5SE6gEeVAdWyvwzYPyeWW4SJta2p
	fIYW2WzPMEhS9moUsQq1z5ljFJ4TcTfw1VqBBk1dHCK7FZ79jRgl9GSZCESUU23PUF+/uHHq7+g
	FhnN3jv0I1GyBuWPzMB9ORwAU6LlItUmjvHBcZgh58Iz+84/TLg5dzKR0V6LyIDekCQMxS5vxSc
	o15ZKw7vfd0P6B4Tio8HBb3+Ysg/zIZw4wMr8vqf0lgWAP4lAHvAtwqOCvgkyzYkMurHCRtHpSO
	6wDE6yHMXbdSCf6yHQWptu699O7398W51iLouZqkIZJRXQdYsDIvCt/vNI3v6oJ4q9Ois8YvcT2
	48BJfKZz68eZ4EN9BjLWon2PHWzNKu6E7pa8AXkJPCWETYrjagZI7DD3mupGsBtnGgxFmceOcc3
	NXWaE7rgXWveNHEiPi0oCkQOa8kgcoB6zzLOOFIzjxUuhQ5KSeJMzs3KQBbxmsDatqi0KLu7L8i
	3Dg
X-Received: by 2002:a05:6808:d53:b0:44d:9f05:7159 with SMTP id 5614622812f47-4671bff16d3mr1834384b6e.29.1773148294265;
        Tue, 10 Mar 2026 06:11:34 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfa96903sm7530612b6e.13.2026.03.10.06.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:11:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, wagi@monom.org, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20260226031243.87200-1-kch@nvidia.com>
References: <20260226031243.87200-1-kch@nvidia.com>
Subject: Re: [PATCH v2 0/2] blk/nvme: fix NULL deref in rq_qos_done_bio()
 on multipath failover
Message-Id: <177314829158.50843.17536784441934486414.b4-ty@kernel.dk>
Date: Tue, 10 Mar 2026 07:11:31 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 25 Feb 2026 19:12:41 -0800, Chaitanya Kulkarni wrote:
> When a bio is processed on a path's request queue with rq_qos enabled,
> it gets BIO_QOS_THROTTLED or BIO_QOS_MERGED flags set.  During NVMe
> multipath failover, nvme_failover_req() redirects the bio's bi_bdev to
> the multipath head's disk via bio_set_dev(), but the BIO_QOS flags are
> left intact.
> 
> This series moves bio queue transition code into blk_steal_bios()
> and adds a patch to clears BIO_QOS_THROTTLED and BIO_QOS_MERGED flags
> in blk_steal_bios().
> 
> [...]

Applied, thanks!

[1/2] block: move bio queue-transition flag fixups into blk_steal_bios()
      commit: b2c45ced591e6cf947560d2d290a51855926b774
[2/2] block: clear BIO_QOS flags in blk_steal_bios()
      commit: daa6c79858e9ca75c548452bf71db8a9e61bde42

Best regards,
-- 
Jens Axboe




Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5953353EE0
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829580; cv=none; b=TRCplmNcDq+RhAwc2k6kwzFQ4tXtRXhlwEsgDPcqbJB3fknF9yi7lAXlPIJNcWUdj/kjKmnrr7BEviHWm1zyLrr8QpojWDadLetjypfx4WWw+z9I/bdlqtlJwC8iJrC66F1XgJUD2EDpAzcbZOhU3HHAsgGj9/2hekdTi9AmEDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829580; c=relaxed/simple;
	bh=M0Cctw1sZx2TmWpOmnIR1/1mSmqMUhpdK8Ww3jtWb/8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VanCyxM4/AgK/LID70Twf92PA3sxyBj9JlEoN8/FGqhjHYiRbHf/oaJrVBS8BpbnaVAY5qKSG6oVzV0cUd3uCcXswIAgYuj6CcyIFWUP7fZvk1/dKqVWwbyUbeAxzFI/OR1xLsGCNsAdtLzNOOqnUmZpb2auO4yz/h4QfPWsdvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=J0hxaCmP; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="J0hxaCmP"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e55b95ba13so5825684a34.3
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779829577; x=1780434377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtS8KyaDF6ANk61DuaRykRDvNL5ptvTSnHkO73XNNEk=;
        b=J0hxaCmPQf0pIRwSpVApLLDW1/BWy+wNA4cbhGRrypBafsiaqAFLX+BASU8cxygXNC
         JT8pLVDgGsR108FBe90GOZx7kL+NmmKJzh178nZcgTYUQOYXIhr3t68QPFpD9w54zu/S
         JSeZSm46FZJHv4QClqxkdMX33sLpZOUUE50J/JMusZ2n8+D/50n4Rv6Rr1ZHocyI/7yZ
         LnAocAF57JGQmlJRITGPgVMI+Dz98on8nXCNDvVC0Nl4+zXDpHIoDzysPIWGA0VhwQV6
         H6sj5Kpdj8l/bL8MBxRnvKJiofjpKOkVtYFhOzJ/Q2oU3cfoKrEJRr7IOM1z5IN0IQbc
         9cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779829577; x=1780434377;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RtS8KyaDF6ANk61DuaRykRDvNL5ptvTSnHkO73XNNEk=;
        b=UFAQWvu8d+JW8lwdQ91BkQ5mCH/ZJuRCB0CCLAEgLqhVIK8wyp6vVudGfFp0Uc7tpu
         ZnADmzE9n9JZn4LJ5Tg3TSf1gEekkyfEV7Jc31hWH0ug0+Esw+Mv46LXyjjLe9PfSSxc
         PNUOGNzvyzSeCNKtdvtrApUp8CmH1K2+m7JQi4a2hxZt9mL5RSqd+/snyfU1iqA/Lf1t
         +gYv3SIia3INRtBYfp4q03BR1Wlp5Wzre27eEqDLDHBRqjcTchw+Vt51pxDfFdTxZ/DH
         1jmmu2BAsqKxCZHgFw2KYiOcr+qzaG1BodRsecpWUz9uQrr2Tlekx9FypCGqiCGFLgaL
         zTfQ==
X-Gm-Message-State: AOJu0YxhXsjSAskncT0gpBBx3ohX0IFe+/2ge29clcwUZ5qiaFHjZb2l
	M6dpZyBxXuQSPXM94oMgPvNhtBHsfhHVm7z6yVO6OaOrTXFkF7hmugIQtSrX5v8M4Zg=
X-Gm-Gg: Acq92OEeqvqhGtXdY2ic/j1fA+6tkaZYCaqhrZaiHYddgqd1100U1UCHG9kk+Ugg2HT
	I1Mp2QDl7l6xLk36/raWl/gHVHqoDRYcSR/DvAhLJZOQ/BRyCDSFjTBr6+BE3EH1uJKSc9VNeUz
	nzMqsyJwTNurIYHgXZZRHCu3Muc1uWAvhNsi6TjhVPKD3jCqT/7Az/9LG9W4ytHjy+efBUavu5w
	+KweZCw00tDBcFfYV2vBvNJRqT9onCaGBsd/O1hfaasIReP721+yqlqypBSwoAvlV9qkTXY+7Vw
	8NEwGnm38SaiXPuRZEuKCEEqC+34di3Sn/drCpLdE6Cv6XUUIpS6vkXTMdABirdZgkr5OG256sx
	s3bgIBlAT380D2tri/GMPSGfmNJNUYDG2EERkY5Cf6xKHBCP3ZSiiuzsX8R7MS+9ah99vF/zPqP
	9SQu6OeRac99A+R034AShq91b51/N+JL68YhQddfoZac24wRDqaYDXXGyLcMPqriAcKwR6gx/mJ
	i4=
X-Received: by 2002:a05:6830:a8f:b0:7e5:b3f6:c6ad with SMTP id 46e09a7af769-7e5fed4d54emr12147664a34.4.1779829576764;
        Tue, 26 May 2026 14:06:16 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e606459dc5sm10219965a34.6.2026.05.26.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 14:06:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>, 
 Christoph Hellwig <hch@lst.de>
In-Reply-To: <20260526153531.2365935-1-kbusch@meta.com>
References: <20260526153531.2365935-1-kbusch@meta.com>
Subject: Re: [PATCHv2] blk-mq: reinsert cached request to the list
Message-Id: <177982957492.654322.9541006835743484023.b4-ty@b4>
Date: Tue, 26 May 2026 15:06:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 26 May 2026 08:35:31 -0700, Keith Busch wrote:
> A previous commit removed an optimization out of caution for a scenario
> that turns out not to be real: all the "queue_exit" goto's are safe to
> reinsert the request into the cached_rq's plug list as they are either
> from a non-blocking path, or a successful merge that already holds the
> queue reference. This optimization is most needed for small sequential
> workloads that successfully merge into larger requests.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: reinsert cached request to the list
      commit: b051bb6bf0a231117036aa607cadf55be8e63910

Best regards,
-- 
Jens Axboe




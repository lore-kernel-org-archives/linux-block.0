Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793686832;
	b=UHgYkvCd1dzvSkiWuWBcNAlmv+tgdOrr7whjmrmOmrN6J9BsbwyE3CPO7SACSwlBTGxF
	 AT8yOWgdWYkNfHlI8QeBZy+kHERPo577g2v7hcgWZxjlYSTS9Sm/hpY5ZWyk1XaDBS7zg
	 zHwivr6wpFd0PP2MGCH+zGqWKIoV8lbPWA/8wzDj6MafA+qBvBPOuCKnb3ZyJDLAvzkQR
	 PN8D6c+LrvIrow5qqdkkBvds7ukxWQn1/HQu+fopl2QGHWmgUQVkfulNxuFFbJJpD7PWi
	 /UGTb3eTqMTKLaUlf2IasY1of00S5vXMCM9XpckooZtTFIHnyMQIe1ewkT7imuuxVAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793686832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mp3kk8+6LuA0IVceTCacKEe4tqnDRWucOGMN+FIMuVo=;
	b=pD7gqGDXlhUDDbS3lPwTBUMwRKgPGHEUeMcYxaF4fWPFrvS8bld2y4XCOkcAkLicOlfE
	 Ed67bDLj+tQjH6UNU4FY/apsd12zyXgkKWo6vUjsbr/2whJNgzzxslztod2Vyn4N5bCKu
	 TpnvKq1L4fxCTVTj1F09YhNLaDyjFdORIAMJm13XPRdE9p9XXtMsOr5vc3k5NvDKZ23Fo
	 OFG3WQXJIiGRa5o5J6CA92fTtT191ApB13KD3ZoxOQO+6eXVy7iuO4Z0EH0AEesrLd+JH
	 HYsNvVqdL5GUBPM7zMPnaw1IT2FHoICVK5SSgKVpfO3OAEBjlscBDJg1RLowT+fAfDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AiN34/6U";
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17111606A332
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 06:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17111606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AiN34/6U
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15dd124bbe7so5333055c88.1
        for <linux-block@vger.kernel.org>; Mon, 02 Nov 2026 22:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793686831; x=1794291631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mp3kk8+6LuA0IVceTCacKEe4tqnDRWucOGMN+FIMuVo=;
        b=AiN34/6UNuFp6NCRELTDRnu6ipyq1YrjuEANuk9cKyie0fgNnQXKo8LRlGVxxRSFH7
         HzACOk2lBEIO78HEXe0WZL5ifvlNM1/GDBAaq8H5L5rncPFG08tOqGTwFcl2En+BM+kF
         0dJkFDOVU0L43ETfA/Sa+7jv7agSh/5AadDf24tJ5TXkUq6DlGo88flab739tJhXf+fA
         vxmWyAiGHaK+g5leHor8wdKuttx9CGWa0t6EnQVWuZVsYl+KomDc3lIqFKRRgZLqgTTn
         VSlaW0YWDy7u1cr4nBIrtzdkKBMCsboZ6ty6wq1+t/NLSRPD1blcdQ+vFfNQf/Pn/seG
         zauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793686831; x=1794291631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mp3kk8+6LuA0IVceTCacKEe4tqnDRWucOGMN+FIMuVo=;
        b=goQIAfrZMSmB5npMXJtGDvEdeJT1mz72NvAALRg87rOloS+naoKcjjr5vE6k8dywiS
         2QLkm8RebtcZJBY5Xg1tPpj8b1JG7FtPRwXZVGux/9NMOOXzA9OeZC//FR165Zi5bXH9
         Ux17DaioZzCctogIsjklLSfM+htgWQ69ush1vGmXpPfh0NE6fIK04M9CaYjOuqtcDfno
         VI+IjTSCv+A/RVpd4f/IyCOhncqDNHs08GoyaY/3LhHum503cFElOkyd7HwzwCkyUfWf
         rblBcr49Om0iwL1C445OxukZeC0nEcOSkroOxMQluIGKRBP8QASMxkGxyG/CszsfpgfK
         Kp/A==
X-Forwarded-Encrypted: i=1; AKwUvBzoAdnIKdHKqqbzIhuz17IfElnLCFck7tg/fqeN4FK8Tj4niWqq4qOxRyj0W0XvRIFQSsabCnKLPXiTzA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8a1e1YkDqg69VhXcBKwY2fQ0t/6lh4sSHiuyZ1ptOsqBP2hbCw
	pz0EAsrmC+KXM8lOOUrewbpFxePOmp41kyutZT9ItKah0KDpH2SfcUs3
X-Gm-Gg: AYBFou1JLTlBzfn8yCIi8aYk0DMETi0iNoLwpqr/+2mcR3lz7pdPM63okfWcYlJGsvj
	jFtALcpDEU337ipWu6O/hpU1518agiED7inBeN1GaAcR+5rs8IzV5lE9YkqtmNkqVpMQMRAjObY
	dFA0xBRnX2OGlWMk2oHSivMw1c9lvS+AeU5rD4NMtgnx1iIAauT4HsFemg3CvRU8CD7QkndJPwY
	pg5uM4/sxks+vJ/JKON+UIVarDqiPxbV/YjLhihA5S01khGESTmaL1qaps7JJlE1xzgOrpxLYfR
	LlxhWCBqQPF12J1y8UNnCAvPH8Sev/bhPaf4gfg+UQxORT0qLcEEpyIvofEPRbAVttKRgFrEw2b
	quoSn/NuIcNeE4VYNFiGsWE4eoV1gx0UB8/vTWb/tslrBGrGPfHj/oNay/0kbQKgYIN/hGhGF1v
	41mH/0+6QoKm6mAIus3A+/sgTBMRr0039CxMrgxhndy7BMEFKBTAphv/yjIIMngxOHdDNgtSpYQ
	6tThv6ay2MLUP5QXtAtX7m7dMq4nmVS/oI5GyOTIctteoOWS3IrMGUakOZIi0MNFjCnrf4oSCn7
	a1bndw/0LQgQwQl5u9Xz
X-Received: by 2002:a05:701b:42c2:10b0:185:1640:5536 with SMTP id a92af1059eb24-1ac5ab52fa9mr19515376c88.19.1793686830658;
        Mon, 02 Nov 2026 22:20:30 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac13ef1932sm39727023c88.2.2026.11.02.22.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 22:20:30 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH 2/2] block: set QUEUE_FLAG_NO_ELV_SWITCH under the read lock in del_gendisk()
Date: Tue,  3 Nov 2026 01:20:23 -0500
Message-ID: <20261103062023.2910587-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <44b0d0e5-b14f-4e6c-8e00-16b4af712b7d@linux.ibm.com>
References: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com> <20261102-bug-nvme-remove-ns-async-v1-2-61780fee111c@gmail.com> <44b0d0e5-b14f-4e6c-8e00-16b4af712b7d@linux.ibm.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 3 Nov 2026 11:23:59 +0530, Nilay Shroff wrote:
> Currently, there's a patch[1] in-review to change update_nr_hwq_lock from
> write to read while switching elevator.
>
> So the proposal in this patch may not work out if the changes in patch[1]
> are accepted. I understand your proposed patchset but I'd recommend wait a
> bit till we settle with the patch[1].
>
> [1] https://lore.kernel.org/all/20261031044141.5569-1-laveeshb@laveeshbansal.com/

Right, with [1] a switch holds the lock for read and uses
QUEUE_FLAG_NO_ELV_SWITCH as its busy bit, so setting the flag under the
read lock here could be undone by a switch that is still running.

I'll drop this patch, send patch 1 on its own, and come back to this
once [1] has settled.

Thanks,
Qiliang

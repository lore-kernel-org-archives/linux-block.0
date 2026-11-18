Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018068;
	b=PeI85iAH3jHFIYx2Kd5Qhpbcf/TuFCq5bFPrzyR3wD0sZn3SQD+0HAbw+PBCeFk3B0uS
	 gHHfVTRUo+A1utEGQmnc789u4wNHuaukJkbWQPs1d9evFJnpJo6GxWGxOH+mzonoMXjzX
	 X74fk/u9nW0f2HnRQbH/RSBb2BaQKOBt7JhHVn57NawimlZLVFKM2BKADNzVUwdHrfleq
	 MkvDluHptVDBZHqqix/miVk7qbk/kpxf4/ZoimPsun+ipTD473H4ujL/9jdn4Y4APNqB4
	 gD8IYcTGBRbxi19dx5m41mQmiuub0FxXumtIH5Wer9iABL5r9/c2Pg69CX68uK7hpfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=DIbUD6coJDkzT04ilTmaJVjGCKSpyXQmASeGsNrOapk=;
	b=BEHaQAI3UxvnN5nZ4hScl79O//8IfcTFjmhEPYGJ8CiUEsUy010hNiQfpZ9nGBPOT2Ti
	 kOZ9JTAiDuc14aaeNRZtxbDudl3u2noeP6GXNgmbFi7SFSYDXYj4+UivqA0qIk6XdrByI
	 X/qZ1yJYN90bdtAKrJ3XfG93XMvMcJ8xUuObAMvaCt5w9dTLjJXAKtaXLwdu12xR4NQ6t
	 1eNdNbboMbbFn7pouIcsQhORjlFjgYw4KCEYaX2IgiSqYz19SWsL40TlyRSya6zv15q9Q
	 DJU0janpXiWawVziyDnacC25Nlc4i0HXtDCuZZDWncLtvQ9vtZmXVUnYV4qDxmsc/MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ai3FTj3t;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06BF60A382F
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 16:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B06BF60A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ai3FTj3t
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-57728d859e9so453666b6e.1
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018067; x=1795622867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DIbUD6coJDkzT04ilTmaJVjGCKSpyXQmASeGsNrOapk=;
        b=ai3FTj3t2+3mPftgVKUm3aRG67g3C58w1EZkUuup0vnCgaWWhvm6NQ38URls5hKBr1
         nosqK3X+zyyLepQGUaUkgnSgz28oqk284Q6pp6DCJbF2uqA6/ln2lhsdS0E2Lv4qRboE
         aBSaH4ZQnr5XbDZ4Pat/sg5mmeutIbyDkrnfUuOZx7Hn8WJbBoYr3DyU3fAtGO1e9pah
         lk4EhZQOi/IFz9O4vYVB+fS1QehPJHF65rchUcFDKN4Z7SuKIry3FAQIz7+LKVjVTUeH
         acbBl0k6V2byLl1msgV0aIsvQ1GPvY/fwxkERg7rdTxVQhb0CDpHLLG8XbWr+gt+txaO
         iFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018067; x=1795622867;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIbUD6coJDkzT04ilTmaJVjGCKSpyXQmASeGsNrOapk=;
        b=UklezZMLhQ2OLR6n+U0eIuZmHftB1twZHypJGgJhGkrpNU4kW3c6IrXckpmjhZSSXE
         wRa7mEW72Hil5UvlJvp4FPUdTuKZgsg6y4vEUP/lD5rkF06FA+JeUgDKkHqo0Bh4tJIC
         liGVZCwjzOtgOSmese5DvNbXHJjzU6PC5cGsK+wfyyKOzuL+4yj4LMkyApiY7pPrnzTN
         PWmqZXksyHO6jLbClVFDtUM58JvRB93AI8kwZfd2rZV++viHAUQKpUtZFADT81w5pqUl
         wa+e4Bj6RxF7jlBgkG+C/oaCiar8pzZLAmFLTGuZ5ru8C+ZTsHUzsHDTxDbJETW1PfxW
         yTQA==
X-Gm-Message-State: APuU4Z9oQxU+uaed0IqiXuLSjGGxpl87ky8Guvg9YoAsr7hd1qJZFH91
	5NQFwuIdSxvV/pbFJgO+UgsChRVIxchwkg72OTTAKg91JzA4nI2klfzOOdGHsr0FKCI=
X-Gm-Gg: AYBFou3h+V+eftPt6d9qytQ5Kxn0qYJ8SE3JNPzJvqf98wrVbqAJ1LFVdtagiIxF9Ti
	4WLLoSynt1RGoXPZ1dUT0FHp382a8K227uJ+Eo5B9rlMFiUwlJx3JYxlbqr07YGsHSOQJOxwrjM
	OicYVd46INEojyo98N/pxq0lN8hMHVnxcfJujXKeRruKoxGo1yvfM0sJqHjjcb31wQtlNhXluVB
	brzvp/CSeqPLCDTx1wk+4DzfNVknoN43n8GeV5guPAriVcRq5FXY0r4fB2UirXKy9ONObnkctYH
	37AFK6925RN/uvRU1y6bDSSgmu5BRkuxOAX7fag/5oKKgulZTW7X8LfRVLA/TqBlYwmWiHgLMN/
	ERl8aQ+l4SeRYMmRv+gWyEAA0ZkZnDD4txEdfeAamJFqBCtKSDd/OIZaZfBEDWz3UOKnaB6+Tfw
	dCdImjgQfr6dXf8Jkdhdu3Oq3tG9INSAjF5ozfOCT7RsxRRyPKCOf0LTqJ2JpMA2fHefJThO8kO
	4Ke2L0kTP3Q4MjZWxeUR0GTC2/DSlUvZkzEuvlxYurwDousCTNZQz86t4vcSmRfDSdtCaFqWzxJ
	x0B3KcX+9lfmPMJdnjOjJyFAohV9T/koun8MHs1PSBn42LnXB7nwnDHJj+L6UkUEQzjTd25+4q9
	BGnzeOS7FDd7tNSxV9l3/d8vs8OjLNcxm5YUVVEnmqnziWn6GqFQ=
X-Received: by 2002:a05:6809:59:20b0:564:36f8:ee76 with SMTP id 5614622812f47-5773db2891cmr2282704b6e.7.1795018066756;
        Wed, 18 Nov 2026 08:07:46 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: josef@toxicpanda.com, 
 Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
In-Reply-To: <20261112105939.260856-1-trintaeoitogc@gmail.com>
References: <20261112105939.260856-1-trintaeoitogc@gmail.com>
Subject: Re: [PATCH V2] nbd: Reclassify sockets in the reconnect path
Message-Id: <179501806580.17649.2876095416581742377.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:45 -0700
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


On Thu, 12 Nov 2026 07:59:39 -0300, Guilherme Giacomo Simoes wrote:
> Commit d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular
> dependency") introduced nbd_reclassify_socket() to prevent lockdep false
> positives when NBD sockets are used in memory reclaim paths. While
> nbd_add_socket() reclassifies newly added sockets,
> nbd_genl_reconnect_sock_cb() omitted this call when replacing dead
> sockets during reconnection. Consequently, reconnected sockets retain
> the generic socket lockdep class and trigger false-positive lockdep
> reports.
> 
> [...]

Applied, thanks!

[1/1] nbd: Reclassify sockets in the reconnect path
      commit: 553d28925fdea4044bad4ae1e2bf9484ad21f758

Best regards,
-- 
Jens Axboe




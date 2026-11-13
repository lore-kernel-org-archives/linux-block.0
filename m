Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794569313;
	b=4DiHUnR7lIuxcauaTveVRSCPhy2Pl5NtBOvsPo4F6a0KIl/ZTI3OpEEIemEnnejRWM1n
	 S1C38cmUbcaRmuS1MAvdAtW4INAN9N4caFePSHpoOfkvdYI4BpRxpnWGfMC0RqbD+WtMy
	 0qWv8VZVH++ZBl8+OSNlsHJN1BepV032Wf4N92Q62ycl11reAz06+uwfqs5h1DLvu8jJt
	 xWyHTMACN2BqDAEPggQ1P+CNcW/g+GANT+jvDQ3pz2pTf+gbPRqq11zcGUZTfbQN+Ay7T
	 UPlxpf8ny2F7sUJQq9d6k82q+2kX8MMX7blLOwxbaFPp4jgs2eyXgvraGaJ2xl8RenA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Sb+fCAcXvYMXke6iLBRIj8JRjkfV6/2OJrQ8O5LVpDE=;
	b=eTOYE6ezjWdKCv4rOpJZdWOH0q5cI4eCBIiioJqQwt0UA+SsVusUof41kyfz5QHS7DJC
	 TL4FT21VU4AS6VON07c2R32/UWskp3RomgitCt5g/KlTTBi70GmlpTOIu9FOX0xWD4waV
	 WsrmuycgHBcpgQRxKYK2s7kf6hQV0G5LElEQy0pLepuhSIlpI4zN6anmlXSJ2jhGlbNuo
	 ojfuVJy6zRKyAf2Yjfy/AiOLK2n8fstFhpAD4MNfpchfguLCfBZgLrlKQrmrCv0FOQKxa
	 NyS/XhTghyPmFdWtTLB64xMzjPLmh1TK6dz5f/JCQJYakdodT6JlpYRGhg95HKJXFgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="ISMcD/SJ";
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB82606A321
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 11:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BB82606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ISMcD/SJ
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1383723dfddso954739c88.0
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 03:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794569312; x=1795174112; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sb+fCAcXvYMXke6iLBRIj8JRjkfV6/2OJrQ8O5LVpDE=;
        b=ISMcD/SJdXZBW/k6cWD2EF6D0ymJKCsImzpO6GZAUuGqBuxtv62pSOCGuyUfApOTkr
         4YggTxbk5WvtI3XYooVrNFlEtLxI8s4VaMwMX90k8FfDZLUoPxyQk9i0TVr9ZOEXMGTc
         6l6nMcl8kP4qSkn/fFkOHGH0cTL9giZkIkFWr6zP6XxvbKjR20Ab+JguplocQsUOOSUi
         WuqPlbP5HqeNAzRdQZA7WLWOhhr1RkCGMZY0isEarUKlFpHrjVYNKTxUnFCcCLPHoK7u
         i1y8pcTJ0t0Vol006t6O6ZEdFhtH55Mdtf2StkxeqcWO8I6+W30j/wehIs9vX4/F7gbI
         M89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794569312; x=1795174112;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sb+fCAcXvYMXke6iLBRIj8JRjkfV6/2OJrQ8O5LVpDE=;
        b=jlfDFesgA9lQ+LzZ0A8E4Dm7wvQzn9dFj6KimMcFEL9i3puXQ2ILX+AHEQohV0UP8s
         /aHyTjv4M3dFJZtgDiqJOEgk9LRYhwqCKUSd2P4psiDKMla2A/b2DE/orCN4m948bs0m
         pt9rEvbbLEQO3rDJtSzdD06u1ospJPPecyB2gdWNKDTCzbNhJELrAg6AQo4tKfYI0U5z
         WJpF0xqiIlEgAnq/9ayL871pvFXu1o6k7y9ryhxA3OxNK5jM955+BncZd5/xta/i2wlK
         rcXm5mlnVZ178I557YAmo9P7MX+uwwxbm12+P6PrWbWUxzbIl74DVhlO7Atpw8GeWgjl
         6GZA==
X-Forwarded-Encrypted: i=1; AL+hErHoC2jz9TLw7vHiypBAMY3b0rdXzGyaNnxOzByTkRHYI4ItDUYogz7VelYJjKe0wO15qJcgdH5zEJ3WZg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8QUV7uopOV37FrtW0Q03b8iTJzZWx0LXV/ab9IJn//4K1m2jB+
	u/MCYZKg2jM2HAKkuXJrhNgOXK0+Mr7SheTwFYs0Lr/W3VpNaXzGfROeq9Mewi9uCM0RUVkZjWq
	x//pUlCHzm4Ol2c1bqryIEw==
X-Received: from dldz8-n2.prod.google.com ([2002:a05:701b:4188:20b0:1a7:c918:186f])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:21c3:b0:16a:f5cd:365 with SMTP id a92af1059eb24-1b503055090mr2164922c88.5.1794569311740;
 Fri, 13 Nov 2026 03:28:31 -0800 (PST)
Date: Fri, 13 Nov 2026 19:28:29 +0800
In-Reply-To: <20261104112744.1630864-1-stanleyjhu@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104112744.1630864-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113112829.3683667-1-stanleyjhu@google.com>
Subject: Re: [PATCH v2] block: Keep RPM_ACTIVE in blk_pre_runtime_resume()
 when already active
From: Stanley Jhu <stanleyjhu@google.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, Brian Norris <briannorris@chromium.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Praveen Talari <praveen.talari@oss.qualcomm.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Stanley Jhu <stanleyjhu@google.com>, 
	linux-block@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 4, 2026 at 07:27:44PM +0800, Stanley Jhu wrote:
> Transition q->rpm_status to RPM_RESUMING in blk_pre_runtime_resume()
> only when it is RPM_SUSPENDED, and call blk_clear_pm_only() in
> blk_post_runtime_resume() only when old_status is RPM_RESUMING,
> pairing each clear with a completed runtime suspend.

Gentle ping on this fix for 7.4. It carries Bart's Reviewed-by and
Rafael's Acked-by, and the blktests-ci report on this thread was
retracted as a false positive. Please let me know if any changes are
needed.

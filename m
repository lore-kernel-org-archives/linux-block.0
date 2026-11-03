Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735357;
	b=Hp1tMmHC+Cgt7aFZgLBTQuN6ZpOdQ4kuwpXcJVkTNj14YowsZzAvK+rLMZ50XS3C49if
	 GbrtB8E8oC9jzafHqimBPAHBbF+yXVt6PEqUTYlGMGAV+AXFOelMsuxnpKqreqfMM2CY8
	 x8NmrZkrmbJHPH5+7ljmmraAf4H1R/3btoA50jSIK+epsc+wQxsAJm3zIiWMGDm8rHxaB
	 ExTPYIVzxWZhi5hl7Qf+oxwHoazH2EVCmA4D53KG8dYBpfK5D+gaq2S3wIWSbyHlBgszK
	 1/M5EF3o+C9eHcwlNtEE90WwBCEb28C4BFs/Wkm13BPpfOs/eyzFr3n49pRxsvccOBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=P0AC+ymgXYnQmZ+rTAXF3fAS8FaKmkjFTCnbuMJ/sUM=;
	b=KAKKU82OefN9IUuKYHcSOOiPF2WdEIo45RdMwh9OfKyQbgqOdiP5Lp4kKJ0nnVQ5pCSB
	 RR/G/2Bm+VpOYI6ENJZAGGbzcpKzsyIBXPl0lEomSmjYzhks/65CySyRqEdxHq9CzfpbP
	 ZbTr72I2fW2OUb7p9UKo3p9DMm4jnyaLFTPZk4hv4+Fmd4Y2yqlHIPrPIzTZEkp32Yoza
	 5o/LFk2iPhXubbO7DSkJYtm1ojgCiKVeTxvizLyhUIbfMcdDzR2VddkTibmJuutu8nROS
	 PD5xfaKR+FYM+oUocRiNZ/0nfuQsQWx1PanQHzkRM6CtSNxJHgbYhZTDE6V4+pTa3KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=aGZ2Et9X;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8842606A32C
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 19:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8842606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=aGZ2Et9X
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a1947498bso5137875eec.1
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 11:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793735351; x=1794340151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P0AC+ymgXYnQmZ+rTAXF3fAS8FaKmkjFTCnbuMJ/sUM=;
        b=aGZ2Et9XRSoW7cbdfG5lGqV1+6xNkMS1R5B1w4VS3Ui4cwG+dA7ZizFdMHeq/+0/U2
         BilbKO1Fm20PtDD+HMuAm41zwNmvgYD1/eu5ZYOqs0KvvAzMehsm4uvfUZwfY7oaLBib
         FeozBa5ngKAi8pE181aL5qQbAJrKKuOySBVyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735351; x=1794340151;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P0AC+ymgXYnQmZ+rTAXF3fAS8FaKmkjFTCnbuMJ/sUM=;
        b=DXfV6AnxSYWXwqHPhGYiTkUmL/j70JqHPXQqPVzBUgTXO7wCxdF+hZXh1amYwKfvfh
         jB/Q4FsyKbV0mCyxBiGNmSBYqpvoqO+o4LPXXd+fh044g8B1oQ2CKVABj1KPTZz9Vm71
         xBvLJgoon0aWa/FmUT0yg+ho5pY72ZdoHIH5zXoPzM6D5/r5MKZx35e2ksJ8Gvs1GJrn
         u0VcV6xzcsBqZCnpRCV5hduQFz8Wannew7NWmodH7Qi/WR6hDa3Y9atM8IgovE2JmOh0
         +CSSWBQungpennYMFCqDgfZzY96Tv/l2Vt/SDteI162QSju4W7QcuY8shjzLiojb6wWh
         tVdg==
X-Forwarded-Encrypted: i=1; AKwUvBy6AaGbplb+H9HJCN/zYvEYEkJL+N+MZcV3VRA/lJ2q15oPzYCRbpq264mSF7psWw71ifyfaXimk96TWg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+gmGNv093j57ogC+tCSHjJBUVLxa1SvlOPxrp2Kr31keEaJWRH
	8wPmk+dwGLzDsvKE080uCQb7ijJv724gGbuWAA71x0NAerrG2Z6awKzkcEjHHhxbgw==
X-Gm-Gg: AYBFou1LYW7LPILBbMXyjQEIfnczrt4af26sj4VwM9lXfHJsisAQbUcFAzX1we/Gl0P
	7HuU2I45ue60+42hTQrw8fQKfWmtpAk3kS7mvytYJzGTLSfL6FHYMwnRYhnQDF8DXN7QvpWDulN
	bQeXEZp917nWtg89itVvJswJfvIguxtFQ4SjgtJ2neZasBQMShUAMrQlTxWudGKhNQzXRjdwy8N
	u56VEJZC5V3nwOnirTsWem2/EtGLWH+bsHDeLDbh/ZeLa/dNewdEebr8yqski8RpG/ElWe1qg3H
	+KbR7sOQlPQ/WCrz9ZYdQmumeXe6tAb7oUtlsTJ2nX2/kqjd/Z6RRBbc+2rPXDelyGU8oeF8bFf
	2DldAYvWWWINEtE86cLZf6Uvt8bMiyVAv9wrmqxTSoyafHBbnLVKhbpoktZqCWZHzHnBYkVCfrs
	AiQ0Daeq4RfDUrc24m+Hkgiv+AFJGzUR0Y+5nNQFWiQmRm/Hbuj9O5rbjJ95T1IdmOl8Aim07J8
	ruCFNsJGoKozBy0FBu4dwvjk5BxiQh4rUQokNolTVoQhu5G8w0xIowPWTuglIz2SAgcixUqdM9+
	WzZwkqBH49/5pQNCYkknEydLCbTvi2dvt6YHQAOSVvFDr8/6oGu063Tl2Ktfuum3QgaL
X-Received: by 2002:a05:7301:4203:b0:36a:50f4:ed0d with SMTP id 5a478bee46e88-36a50f4ef92mr16355856eec.25.1793735350827;
        Tue, 03 Nov 2026 11:49:10 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36ca38a54ccsm382104eec.4.2026.11.03.11.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 11:49:10 -0800 (PST)
Date: Tue, 3 Nov 2026 11:49:08 -0800
From: Brian Norris <briannorris@chromium.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Stanley Jhu <stanleyjhu@google.com>, Jens Axboe <axboe@kernel.dk>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Alan Stern <stern@rowland.harvard.edu>, linux-block@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] block: Keep RPM_ACTIVE in blk_pre_runtime_resume() when
 already active
Message-ID: <auo6tLmH0R4_TRG6@google.com>
References: <20261029040001.2100001-1-stanleyjhu@google.com>
 <8125a75a-ea47-49f8-90e4-7f7c83db90e2@acm.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8125a75a-ea47-49f8-90e4-7f7c83db90e2@acm.org>

Hi Bart,

On Thu, Oct 29, 2026 at 09:22:23AM -0700, Bart Van Assche wrote:
> On 10/29/26 12:08 AM, Stanley Jhu wrote:
> > 2. The first runtime resume fails in the driver callback, and
> >     blk_post_runtime_resume() sets q->rpm_status to RPM_ACTIVE and calls
> >     blk_clear_pm_only(), decrementing q->pm_only from 1 to 0 so recovery
> >     commands can enter the queue (intended since
> >     commit 6e1fcab00a23 ("scsi: block: pm: Always set request queue
> >     runtime active in blk_post_runtime_resume()")).
> 
> q->rpm_status should be changed back to RPM_SUSPENDED if a runtime
> resume fails. The changes made my this patch don't look right to me.

Pardon me if I'm misreading/misunderstanding, but I believe your
suggestion is essentially to unwind the quoted commit 6e1fcab00a23,
which might reintroduce a deadlock.

Brian

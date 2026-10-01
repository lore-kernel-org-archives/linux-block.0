Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB43E40FE
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865807; cv=none; b=c0wO2Kh5T5dt+hNZB/4CFZKZe2r1GZ1hC/xqlfheZS4zdoTg74BhjnwzlZ5EM3029g2fFYY501eM1WHUrWpLh63/4B0y0I1TxtXdKv6Epas0EqUsgwrgHV3m37ci4E9YtxvHTrTj4LSf8E+df38J5y5hmm/UgQbd4JB3FQg/r9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865807; c=relaxed/simple;
	bh=Xa5jcdcqx67e3jNNM5ymHB/EDczYtA+SY20lfLqj4/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qWuoyI2c+zgaD88zSB8WmKpVjAiNyCeS5uKUkigX2IG11zp9D+wpIe8ghE+qZrT+1vMy5uBKu74E3x1WgqKRWERCt3USpx+Na/H81jnotUsObTkISjsSYTp0bjOl7R8RHzckuwjcPSZuqikoES+xbDiXMk9ZjQmCReUinFrtmUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=BVEGMhAH; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="BVEGMhAH"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-46556b9e02cso562539fac.1
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790865802; x=1791470602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O/hNnkyBrVzy7QYaX7Aa9ulQWtOZJ0SM2Heb8j07gr8=;
        b=BVEGMhAHhet/nsxLTh8rdlTTbXWPvT89W9mE2T4ZAH6Dk4njtwjSbpSMfupYTX9Gi4
         psGRPWS2iC/zzuLHoi3uw553F61O//qpNg0Mc7Zf/edjT3WHSUTDvtncp8Dj51Hg/i56
         2j2udl5TRf0Ml187PqqaD6qvleBxt591Qov8gWxN+ZFFmpVJJMj9fJi2jYlxVnKw/X5i
         bECYxK5CaoDY6Jv94TaVrTsG4dQ4LL7zI5t5QEFjWGjitq2b3OlvrJap1KNASCXXHPdK
         yHi9UmJEL9hWBH0lmnneaJk/uepC0lCbLWCB4mN9+uvWNHsZpfNAvRn/T04rZHv7hPS7
         PXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865802; x=1791470602;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/hNnkyBrVzy7QYaX7Aa9ulQWtOZJ0SM2Heb8j07gr8=;
        b=cI18PL2AsSQaJgR4M+R3J/uij8b/42xVSk3gbfWbQMzTfzydvzADu3NCPm22IjkYqs
         ewlXp+bsZZwhpWOElr1GJ1joqEuID7yD0QE4YZCsCWHaT3YTSEllISrgy4GDkiq01HQh
         vQvMAzE+keXk7gx132uX3fU9yqomUvL4RoTUP+U9OlngLDNBwR14gEptpQkP1QCtW2hS
         JAhg7tb6eqBu7+T5q7y73qaeFlRPL2+vST9UigEOw/QtaDTrD9gtiZmxbFkR5IABCBiz
         HRK+DnVfkWLYhElXOIhhCE62QFJIH0/f1qrs/V4+Qj5Kv6totlSaz8XaxtF6Hz4FOys/
         6Xcg==
X-Gm-Message-State: AFuF++mTJQeaIYobyzBEFA3REJnLXipdlY2Dx1u5PUDbskeH8Q1sSFK7
	fOzfJog+30MGApEljBmW6dD2KoaW/7Z1+TbX507smnBy1Jd+QRw1xw/8QKIyzJ8rHarTL0sFEM5
	MXQgE3dA=
X-Gm-Gg: AYBFou1fctHrUWZJ1ZWp0hKqmNUuH4D7K1K6iKZnDER4xFxtyyN9PTKVGHEocyxBLH7
	tX2I93S+CNdG0uusK+T9iBsMU1pj/Rk13J9GKsp7WZk+rj9WXsmYQBY58jENu49pUZbay9HIOGR
	1kCkMBCjnSLUQoZJgrnKeJAdeNqThmqUVFXbBJAqrhStRkllTuhgye0jGHIg7oXkJN3EEBDbHhg
	M4M1tC+cUzJc2h8aaPRut3pZfsIvhv0zH4/VDVw3YUn48Lb/KOkuW8Sq5CbDGN+AMWk8BI+ReYZ
	OEzzoktIBAI01zVDpQg3pzZCmqJcbFL5YWfDbDJnToHp22t4ONi+vjKXDg5GHqwzM1DQFN24YEq
	hOgjPQdrvlyfGCb1/c/+kOj8zOYh8lSxOiJecpvlaMYbwNq5rmRZ1knUJ6jvv2JTXdL1Lci0i1Y
	5nFGSwTXY32NE5CBCtZ93RWgAl7glu9PmMD6souxWjP6aBt63J9SafdWH5m1tRbIFA+GfMYbG0u
	yN55N8362Ob0numuu3Xa6RX7Te4Ld/A/Azexvv42LZIa2Bl8ibivb8=
X-Received: by 2002:a05:6871:3313:b0:493:5dc4:e591 with SMTP id 586e51a60fabf-49defe01b8amr2509657fac.1.1790865802044;
        Thu, 01 Oct 2026 07:43:22 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49ded14d8a0sm2638009fac.5.2026.10.01.07.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:43:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260930-blk-plug-ts-flush-v1-1-bf8ca7bc5cd6@virtuozzo.com>
References: <20260930-blk-plug-ts-flush-v1-1-bf8ca7bc5cd6@virtuozzo.com>
Subject: Re: [PATCH] block: drop the cached plug time when
 blk_add_rq_to_plug() flushes
Message-Id: <179086580097.1687323.5913036071644387074.b4-ty@b4>
Date: Thu, 01 Oct 2026 08:43:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 30 Sep 2026 14:32:26 +0000, Vasileios Almpanis wrote:
> blk_time_get_ns() caches the current time in the task's plug. The idea
> is that the cache lives for one plug and is dropped when the plug is
> flushed. __blk_flush_plug() and finish_task_switch() do that.
> 
> blk_add_rq_to_plug() also flushes, when the plug has too many requests
> or the last request is at least BLK_PLUG_FLUSH_SIZE. But it calls
> blk_mq_flush_plug_list() directly and never drops the cached time. So
> a task that keeps submitting without sleeping stamps every request
> after that with the time first cached in the plug. start_time_ns and
> io_start_time_ns are stale and the disk stats charge each request for
> the whole time since the plug began.
> 
> [...]

Applied, thanks!

[1/1] block: drop the cached plug time when blk_add_rq_to_plug() flushes
      commit: e0f2224433b15a57125d6ac5d46182f99c6c9d08

Best regards,
-- 
Jens Axboe




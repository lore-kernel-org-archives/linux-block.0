Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6362989B0
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929269; cv=none; b=g45anEs5zi2tUOS3NvoGEJ8j73Cuu55WpbAsVlLMWR/d56dUmn+rNIl7WGkJh1pcBkxU3Cq0kGgfM14h7TaQ4uPEw8/1ufNteZ/IK0wP8DqHxH3zZLiRJxPZtTf7GuRCVT0FqXymsXseN8LehKHOumkFMyfbRj8DCf3l6NIspyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929269; c=relaxed/simple;
	bh=ksGyib/wPgMuu1GcOqeVXEGU8RPF0pwIOqwbImjNOGU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J05XomMa+AnRRaWvzOROQDrsTQRT7e+v6eJyY61IA0l2U+A0axK2wXwk3EAc2GsG0Ay2UTbbKAfEV/wxqk6V4SIor6u866AZMLt/+8MQavhuVhHpHz/m8LgbXsmD0ttZTf3jCgNngFMaTm1ZliMyhLguG3FGJSwfFWkt7uW7Ax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=ij0/+j9S; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="ij0/+j9S"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69e4af5a411so2793659eaf.1
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780929266; x=1781534066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hribdujf+vvTQjgwbjP/iI7itJpV/FpzhyD007TpZXQ=;
        b=ij0/+j9SQUZ2/XWHhA6SuEykzD1t08/pb5Dn/eOWVDk+Lk78pcZojmkfAQW6J/p9f7
         IYN1IHQD66gvEy2E58MDj6MigXacnbcauiA4KPGsFuGCz/l0ymPisRejAhxZF3srs7vP
         tW8GeDruCUJ/FgBWvCc0ldOqQB5cGu45EpaPUXXlJzzJHQB0H5h3BaaKvW9mLI08L3xc
         +TPDc+m+Hm47tvmmYhSdTufMNkY+jk1ykoK3PjyL4/rDQNSkHllXJDVTVHzHML27r4v9
         vuxKEgAqJ4r0wlfqXGcdoIRVz5LrMwq0nht2iMtsEzzJqvEHKomx2Yv0Yx6+0o+Hao2x
         6Myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780929266; x=1781534066;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hribdujf+vvTQjgwbjP/iI7itJpV/FpzhyD007TpZXQ=;
        b=o75zzJpHHp/1P+3XkcYh/glnA+GVUzpw0DKRqBxBNaN4tgfVQb9wn6JyX2p6p5t3T5
         XoO9aMdc6Qvjors3lkgV2Y463YD1wOnQiWvMwKWKeBWM4YYOn8Y4RL/q8KECkritQHUl
         rTiLfMXjF0w/nOuzd0eHSmyRAEiqbZQOgSK2DVZHOU0zwcyO1+5HzVc6w0tLBK4tOlNw
         XNpochvzL+A8Cr/hVEBMylxCo1inEz/RPxM+Yo1zmTfEn3F5AiiLUHkkfL2lDuFwR7FJ
         b8YdW68GlK3+RGZ+4j5qJMIWsWMzbZmGAKYQwTqUP9G+MpaUv7HcwckxLliKQyXztDZj
         xNaw==
X-Forwarded-Encrypted: i=1; AFNElJ+dRudpwDNA6cJnaRzMcqrDhSLMJbzyJ4/BPi97nR0Ygsh3IoLTmnRzlGDHP+mCxc5WSNm9upbEjrbZKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRw3Ni96QA8FYPj9wrWg29BUG4FdU3pHSRD6yw+NKdYvY2Iij
	l3SR5HNgtNlq5nEcm2L8WuYLgDnPgRwQCrkEhVRhymjAsdw1jakJLY5+qHmFXWdlvPY=
X-Gm-Gg: Acq92OF7d7Gxwo3WdL+7fKSeDjcwR4r0HgHhBV2TN1UYM0+073KVU6ShoBy6YOj8Qjz
	XVNDpqdGhaoQELrseT/6k2pAUczibiPxqYqHbSoqnN3+0GK0ElrstSWW4XX2hIY3LEqvuBPk8UT
	1PDj17gNL6TqyMqENTCo2rQlAJZUtkXUd+ILP445D8Y5Zpoh9RiTwrN9yQlEppX/fNh4UJItvMJ
	3A6GF3PzEe8qUmsRaSCVMltbLVbFAJba2cD1rN07uOFnsZmM57JtYkZTNzcyCi3V1WMQo6ZPzrR
	v9hwIxrGdN9x+UNCz5qdW3jr3evhSqYptOQ3dkUyP7GQslOjr4LWHlgaCoEzFFT4I9gJBZxvnpo
	OZSu0MprXoeSbS////5zs0Y8L2+fbv6MMKA+NdQaycPZR8rGKKHbTBouct2mBad3yvVVOz/YN8Z
	JSJvEFnngttUKI9F99ublPdGI6mZ/IuvlTvW5s7mgY09vgyNdQkzx5XQ9+YFnHdYtew7/0DPC10
	7hwlw7RR6XuNFM=
X-Received: by 2002:a05:6820:818e:b0:694:9ea7:7aa1 with SMTP id 006d021491bc7-69e68b08ea5mr8258617eaf.5.1780929266031;
        Mon, 08 Jun 2026 07:34:26 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e464050fasm9622409eaf.9.2026.06.08.07.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:34:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Philippe De Muyter <phdm@macqel.be>, Kees Cook <kees@kernel.org>, 
 Michael Bommarito <michael.bommarito@gmail.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260607064137.302574-1-hexlabsecurity@proton.me>
References: <20260607064137.302574-1-hexlabsecurity@proton.me>
Subject: Re: [PATCH] partitions: aix: bound the pp_count scan to the ppe
 array
Message-Id: <178092926408.1038952.1954563729404460721.b4-ty@b4>
Date: Mon, 08 Jun 2026 08:34:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 07 Jun 2026 06:41:43 +0000, Bryam Vargas wrote:
> aix_partition() reads the physical volume descriptor into a fixed-size
> struct pvd and then scans its physical-partition-extent array:
> 
> 	int numpps = be16_to_cpu(pvd->pp_count);
> 	...
> 	for (i = 0; i < numpps; i += 1) {
> 		struct ppe *p = pvd->ppe + i;
> 		...
> 		lp_ix = be16_to_cpu(p->lp_ix);
> 
> [...]

Applied, thanks!

[1/1] partitions: aix: bound the pp_count scan to the ppe array
      commit: 2dc0bfd2fe355fb930de63c2f2eb8ced8570c579

Best regards,
-- 
Jens Axboe




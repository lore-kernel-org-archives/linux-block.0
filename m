Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437196;
	b=ntKksAv5qPTFOK1N8mikgLjiSx1jyuzeepGuGy+U7VopJWQZpISzNyImaqvzyffFw8aK
	 zWYkDYxAb1AxBr5HsJUqMOvc32km0pIIJqMjGjZpwEzhFgSmZUGWi2LV0GLZTjlPr7W9s
	 k6t/9mac8sQFHFIktfsRciKDdoxl2qK0e+DsEYHG9kIG+/AdBCHlPVKEw5GeQo9vz8K0d
	 pmkv1hNVd27SG7LTR/9rVqVXiHAAwAzAph2y1VZl0OpyVFVK7I2vloi1JAhe3861Fv48O
	 g48xTWsgC4r1T2wJwcECrj1ZTrmAvt/9x3EwWt3WWHFXhRj2s/ZX/U9s5E1TBIsufRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=Fo0uDjdXWU3pop4tx3TQD5ji39Vy/H3DB6FtX0L0BWU=;
	b=nyucQQ0/fkQUu15bWD42+quhBEDqG9vT3s8gnHQ33sp8A7SbMi7rw0pqEfISBTDy+0Wc
	 gvGz/vpXAXClwsU7ivHOYPig0UiCnGYbsWVaQjc6QOVr+EG02aSOoc8+7h2Ou/PAldLMP
	 6JYCIOPJ4r7/WwfrHokSYUtm2NdyYuu/R4vgLSSBY5wcpo5kMONQuKGDn0GAtUGJQopQL
	 LVuQhipn71Wevj50ZYm+sbQu7xVC7oLVO2/SoD8SxmtFrZ+wkaon8PR+w6wVrmH2kbtS0
	 AQ6I4BdjSUyDoJ68sIkPEYl06UGDHEIqa7rEHi5q/7SqCBmGVcQlOmn4SgSc0iI1S3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=tbWjRXPm;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9215360A2606
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 19:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9215360A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=tbWjRXPm
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6d7e06dbcccso1558009eaf.3
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 12:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792437195; x=1793041995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fo0uDjdXWU3pop4tx3TQD5ji39Vy/H3DB6FtX0L0BWU=;
        b=tbWjRXPmk+19KEFtERQSOkOGgI31xEcQtrTYHe2rvSxon1nlSH2b1KVmo9QPTnKPse
         FNkLQZu5XqbCxum6/LXtH3lv04braMlLbkanJbF/LwwpztLqBqdv1MC2YZtF1khk8uOq
         4wBuD5rKC1QFyCxzcxF6A9rE/SgPLgQq/Z/X2NwSV4WhQhijQIeK43F0ApvExOwvrBbi
         y8emfJlsGCsbOGOQiW+Qrf7hEyGTPUtN2hayIntwFq6mp3aELk2edYOfDkfqJtvA+V60
         Xl8D78/cVV4CURKr1EqtjFz0aDCA5UNNmNVRouAkFAT7vih/XlTJJPAUG122HwLV850J
         eolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437195; x=1793041995;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fo0uDjdXWU3pop4tx3TQD5ji39Vy/H3DB6FtX0L0BWU=;
        b=YmEjGrrAo2NtdBwTGCUPa5Y6/JNlPImVdR+cweDNmorcG23RMyLK487m50zHJ4lfAk
         CNoyF4D/3A/XpFbuonA98mZNKT2DmG2iNMtw6NMhRxn7iT1/x27IUXl1dnGFxv8xB3yw
         EH1FdQlMYZBhsaElCXBBb3tJrVBJZU2H8CvBzA1SZI9E15NS9oQ2L+sJA/C335feR9w2
         J1Dn8gqEeegFo9fvw8j06c8hB9n6T1I5tvadtTLLDVbWa4gk94io2LmWDKM/vYwwsDft
         4XwErqblvE0YoJuJZBIxykviwApbzccQluqk64AEPfizmuybdMKXYtE/4mGeYxlhS/Yc
         u8/w==
X-Forwarded-Encrypted: i=1; AKwUvBylT8/z49gnMI9gfDLn64lLWxGDtSvbjbu0iojCuR5ttKlXAZyMJal3LYiyU+7Pd/AkXp7Bbd/Oig9Z7Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYLZ1TO+RYPn4ph8UneBbWxcnOPo423Mw2fnv5hH9bo6TLfZnvOZ
	lRZvMzr25xfGn0QAF00DClD1Vk7X4UFQBKftoYHcJDP5yM3UzxyC2FkohCpLr1/wnQ8=
X-Gm-Gg: AYBFou2HHBf8FcEpMauj6b1Aj5yX8TzRDiU29oo44RkNb8mbLFkOsLPqNuAZqXhGdIS
	5uQIYsJZf7Dek1iM6NHmYtOklg3M1PrcWgRAm6/xW8aLdOrqLQUMkJ3qxUQQgLmP9jGtxqN+Z7G
	KwCHlZnclcwJQrNi4eNTGT3bnFyOrMia/z+7aOw5zz3fQqUlkPBxSTn2fCJBxnNOiqXjYFi5UP6
	UCu4G/fcEX786fJ+H0dkOoEMbt3CxDbe5SA+QlsvsMXXUlloQ/fR3KHx9zxphi6sD4/IZBV85Gj
	a7dWQs1qa+wZS4E7GXfO1ZShT5nqlnWPu1IL27y5Pf0pVqAuJTczig2yDahcTxuV/SGOLET4SmW
	fRRS/lAkQkcK6GVo8a7vF9qjgJFwYGI1WSM9a+jCIBGuilpxZf26q+xB0uHUMorXBVrwPI0K6Fi
	TCTzsizxArnNbjs3HItOIKOuTXhgr7YnBfuH2F1r2GO2gsKeD9Bkarw8d+IYBzlLgxcsiLdi35q
	PNTAT9vXjWiYThXnZeeO4QnqD2NTNqID+4GcaG9AX33+YC0O19SM2U=
X-Received: by 2002:a4a:ee10:0:b0:6f7:6042:e7d4 with SMTP id 006d021491bc7-70356f9a3cfmr5518042eaf.50.1792437195366;
        Mon, 19 Oct 2026 12:13:15 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8462659e3f0sm6669149a34.17.2026.10.19.12.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:13:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai@fygo.io>, 
 Damien Le Moal <damien.lemoal@opensource.wdc.com>, 
 Davide Zini <davidezini2@gmail.com>, 
 Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org, 
 roy.qing.li@gmail.com, lirongqing <lirongqing@baidu.com>
In-Reply-To: <20261019051137.1715-1-lirongqing@baidu.com>
References: <20261019051137.1715-1-lirongqing@baidu.com>
Subject: Re: [PATCH RESEND] block, bfq: initialize active lists for all
 actuators
Message-Id: <179243719149.3127071.16172542527438059797.b4-ty@b4>
Date: Mon, 19 Oct 2026 13:13:11 -0600
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


On Mon, 19 Oct 2026 13:11:37 +0800, lirongqing wrote:
> Commit 2d31c684a053 ("block, bfq: inject I/O to underutilized
> actuators") extended bfqd->active_list from a single list_head to an
> array indexed by actuator, but bfq_init_queue() still only initialized
> the first two entries:
> 
>         INIT_LIST_HEAD(&bfqd->active_list[0]);
>         INIT_LIST_HEAD(&bfqd->active_list[1]);
> 
> [...]

Applied, thanks!

[1/1] block, bfq: initialize active lists for all actuators
      commit: 29fc0357768a680a9747859b165783cd82d4d75e

Best regards,
-- 
Jens Axboe




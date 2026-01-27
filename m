Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADAD35CB67
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525799; cv=pass; b=nt/wf8N9iBWHEP1+rB4SGVvefqjK02+a5K4tQG05AyYg2a6tcTQTEaddbo+A/MtNWb1zlvOKSVNQlpLCrX7wXgg4B4L2GNQjaQZHGMpDVaeieBxWQ9FVWpP6mqE1IXUB1+p8SCz9XOtsKjvqkRXl2eOHM1pgsidaJ5YIIyztz/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525799; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcfOaOhn2qYSbJZxZzIt4kaf7Ys2zV1ZovPPYGFbeD8ybu42W0c+3pSoGkvDd36tEZlmdus1egvXL3Dlhr6/1pVBNlOk64kGAmwVQDGhfWcqN8iahd1x/65IV45w6/qloiA4YH3QI/OPyvbiyHyWNmJhSH/AMcpRQlgKPvadcq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6bBcinw; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6bBcinw"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-655af782859so11440139a12.2
        for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 06:56:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525796; cv=none;
        d=google.com; s=arc-20240605;
        b=BcMHSjsTc5qeEHKMHvllkuCgJFHsx4xgd4OYT8RJf9yYhzjz7sdCtL+5yFsmZ/OIJY
         WXeDyG19u+XpDm8G6OwjxRFl9n8OJu8Lb+GW1IzXLXxbXX1LTNs5YkGc6YCeMwLstYfC
         4pA6WhncNjPtM4uODzJOvRUx0WO+EwYLTf2necCBYSjEYe/UtZ+VTKgasNf7rpdJ2ZbB
         kpyC8zlrb5bwTE/gpFuggILAOcn9nj4X6lAAze5JyIaTZ6ANoltFZCtNy3B37dXtXCLE
         PUIKPFyKO+xLQCWwYiuqGnZUsfJYiIBrYbXeBj1mepuWFYGGbwGc1FmZmYpcWdkLKqCX
         s8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=ccOhLwjdyClXyuQfoK0CjDDo7/9crv2VpjiDqdY2fvc=;
        b=b0jN+kaqqTNbuZjf+HwDKFlgS6ocUVNOM++XDTdSpGDTCGHkSFwVLN3OIvX7YlNy4S
         Tf2zZqNl85m8Ywrlt6tI91dNDHC8TxIPwzafpljRt+5DQqkZBx2sewSAWVECeJmxDYfw
         w/eRoT9VLPLD6B1EVaOU6O1yemvJ3n2gk1NSwYtOzM54XpFMxDvWa0pB7gZcsc98dAHS
         yl/j6faMRC3ikROkSllYNQRyUqZw9qW3YvP55t83foolMaCfqCOfzY4hYjjJGSQl4HOX
         wc5C81JrslgrA6aBpbSsprG+AsZCuX/MNs1SjI/2uCK+X6XWSHdCI+RgcOYDeWESGu7r
         qElQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525796; x=1770130596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=D6bBcinwm0RIvdV6DoySuwScrLT2pRNjw/p8hTZY/XYRWCnIyhhgION4m2aHtOl4YD
         4fck5g7uO1UyVoYR3WOTP82KvNN2GO9B+1FijMglTVx6gVCOXX1zoHPnNMwZY4BLmGIj
         95xc51jH7r1vukxG3p07DTF9Hw3ziAUY7AV+7RwXMm7skCHlh3Sn/f8qjf865jaok4VB
         +dt5k9wpaF7Vqjo7Ool6yRfGKh94sFCIr9ZostDjpsOffEvA4+NCB+fu1DAebuDuR0Wg
         Ej/i9a827rfdU90sILJ9TVrM6LdrlaWoA7D5zB1Ayp2n74aoREgAxS0MXfd8+cdI39Qd
         r1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525796; x=1770130596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=f74zz3YVWqtWVWobTVU52ABeMeFOYl2CpC+SbRphZFhsCa5r9KZZhW/sd9rhTQDb71
         vKN8sGLqvctRCob+wHVD+ymjIYHCua+kRF6SBVZBX9tU1i9YAC89pgzoSY8wmRA3GmLp
         4SK3L+sqBnDN+f6szW4PA2VdoU86meeV3qkizCbjVxVuP7dWYOObnTu/Bl3EzyvDMRrZ
         apzNq8/5g+1ZLpXdlTr/RByMepmJ45tSAmTfi7TPn82rT58xisd8+zG4K9NZBrX6MSKc
         mNHf/MN3XyjT1wYjTlKRE+fb3bnWSDnyL5htIYs9KpofZzFpo8xZOEqyy9MfXyCJLB/D
         KNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzvaNuOuWm0ytszW9yyNlzLXBEtHEyGu4fIT1CDDeuWrmwN4C6U/OGWCbHxFEHnVmCJJGSgW3+pzGG0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuVBpbZXw2dyY2oiLn0r+Ob/ZTHgm/ygyZsUHRXpxq67DVSNUk
	8AyKtNBNLhlI2kKwrTnCpB/l9GtnHRpkg7p4tJdyM22CNrx4s5HUCpJ+IwLN3bdXfctypoE/ecO
	vaIETrO3co/olJJKh7S6pALy3FBUFfw==
X-Gm-Gg: AZuq6aKcSQL3KalkFnffK1dEBZWfeBf9oSJd42KAUzaiTCyOa4smBtbpJHOV+Bv7cb0
	yMxSxyazkeVsfge5MP1a5Hi/xyAtvscwAOHB7OSPgdDhpZWFXoOQZFr6tKoobUxUuAb7IWMlLQR
	5QMr7HK/PKjNpRgtYvrzZid6WYXJ4GJ7bcsqdnTee31WFdtE1Wt+KXf/GYIrwIiqKKO0G+GVW6M
	j+FTmWN+Er5BAFs2+WCoyBX1Z0CKa34XDoKrt871sowX02mBT1vDxq5lRTfrvJthGL6l6XkbpDH
	3JQVn+V6T9MLzuyzM2Ga24nGb6AsBepO+WAizxgOMkEYeJAS+ZJPBG/6uQ==
X-Received: by 2002:a05:6402:358e:b0:64c:e9b6:14d8 with SMTP id
 4fb4d7f45d1cf-658a6086b03mr1532367a12.16.1769525796336; Tue, 27 Jan 2026
 06:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-4-hch@lst.de>
In-Reply-To: <20260121064339.206019-4-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:25:59 +0530
X-Gm-Features: AZwV_QjH1kmIMaQrUVHIXGBlrGO-v9DSB6aQQaOIY-kGTdF4jliUvC8MjPPK3J8
Message-ID: <CACzX3AtYb5d8iySouG5Dn81vtuwwGtQzqZdWCm-d8ZUCLq-6Cw@mail.gmail.com>
Subject: Re: [PATCH 03/15] block: add a bdev_has_integrity_csum helper
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

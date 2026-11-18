Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018065;
	b=CkOuz8rpd+W/zeyJLo4MD1Y0Wchjt8N+6R6URzPt4h1zz9VluB8XgqcnURF6DAGrBt7n
	 qPFu4eDmCnXQzogjmog1TRM6ij3CPWpGVNnNVcZWhhr43Y0fOACTxe54bohtsgbC8jrrG
	 gT8CRkOCzic/J6lGPRjsyOVht9DBlgDUJnsbb9WkS59Sv2kI5O7YtYsvZUK9Qxnhm7LQo
	 9rKOuJIN4ulFKggx0OrVNX6UVAj+HXFxNnWU4wP619xxkSODn8eDNcb7TwVD/ELTWpVzi
	 SSFE9u4GZQCiOaZlyXmlBTIjYba3lHaT/BT/9YrHyPNhl6rkfXOT9EzqEPZrjgaGniA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=fOgWd5sV20jC8nMnAlt0aIAHoHA+9PI5TZyd2mD/0tU=;
	b=W32tiWajwqFLUHGAO+FPE6iKVub7KFOcSzFZLrnBVpPoxwkerw1vDfSTZQy6XbGXEuu8
	 3HDZpB+sVVfAgci3RNA7HcmIyEg2a37pmxNCSplSQ4ZSGOTq/LxKufu/SLatHPdhCPPut
	 7Olp/V/mmYdmkVn8tiI9Vyksvt/kmDBpAMGK1MAj2zmcHx1TIwJE7GpAxqQHqjIO/OZA6
	 n+tjeyvJxm3flbzkInl1HR2uwKIxPlmz9+M5CuT5KvL6j7Lt6AtVOoKtxZ/8UsDB7/Yq7
	 V8vNEzBibVRM1hYp3PPBTKgtRzdx3jPz5U66PXpeD8tq1xGnEZtXr+WobTIv1Adf1cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Eo582AGW;
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B9A606A325
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 16:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41B9A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Eo582AGW
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4ad881b6517so740124fac.2
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018064; x=1795622864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fOgWd5sV20jC8nMnAlt0aIAHoHA+9PI5TZyd2mD/0tU=;
        b=Eo582AGWIcgJhdR92/+iWkXwSsOKDEyPZfvKQIKRigDJUNEmZHiL/z5BISs0Ahlok5
         8xULT3rpvfWFvuwAEmSAHWNGr/suW6dxr9NnVKVw3AD4pnbMJ0KrhvLfM0/DVz8oKEo2
         es1stpuaCbGae2A461eqTaT/8VlIhLuzZrYfNvqgmElgh7UG/Q9oIDRX+UAkOHtwXxzj
         /lyVWaMVnMrurQdZxszakVvtxVk7nF4+/8g2qf7kIt8xOy5YtAMlTeGQJ8uo7HRhpAcW
         +9QyOaD5sgt7KSU3qbh+3kY3w/xJw16sVgsZB2tQdJAhrqomBqX/GEkgtnfUBOg/JSDM
         90Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018064; x=1795622864;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fOgWd5sV20jC8nMnAlt0aIAHoHA+9PI5TZyd2mD/0tU=;
        b=IjMKVhH8tcXmt1AEaQbiVQUmVGWe34yL8syZ6Fr14TGshM55NwLpq7RHQMtDRYrTU2
         W1TwUc6qdV7RiDkmAIdREjruBciajlZcC64XYM3uxhPIl4/pECH0BspwgVdgjZxbz/EN
         CKqZIG1uxj5Z78nKwyVuIilTTLardMSgd+kVm7KImHGgClFf0gJwoyWCOjbuerFR2BRD
         XHzaW/fKdjfyPmBIfbp2AMO4Adwi27NIyAU1B4OCPEsgQY1g+qGXzgfjBBHXQrRQonCw
         hCrL5hgpj/L7iKkNcuvpRoThm3zWOP5M3IuIWun2VqoKzoRRdHSlD6756EGslmQLZjOL
         bGRA==
X-Gm-Message-State: APuU4Z/Wj1gXGPGSJ49eQ1u2EYquixqumm6jODuJr7XSnM4n8aCmISg3
	Dk2e6JmCvFpsR4r36NxkXCyIIQduWNsMCBpcRFzCtYnvAPFEoOWM6FHOlEib79j0uoahDr5M+gG
	icFwboNo=
X-Gm-Gg: AYBFou2GcnW1FOU2yh7xmnu9iVMAXiYc9M5vAFxEpLAhZjTGo6xp96urnvf5yX8+Kvz
	sylpWOtWvMCqtptI1U4xDUQkNmMxl2RebShCBH5LTcYiKpExw63IfkVyKd6+xz1Zm3GVXMWC8HD
	kPj+2uyQpmMCb8W8XnYd4lgpCBvPZtXn7oMKVBrWJNdNX9v83QC43DdhleKN+nZ3tyo8KmaXC2g
	hQzYwcd/zHaTZJjqYUA9qaEk382uZx1Ej2iJ+exgZQDgLlkoUpuO3wXhwmILwrXgSWd5I4FWkf4
	IEB/oo//QYiJKzIGO/Ek7ZipkkM1vdFVxJ+z7klqr8RQHbz8dz6fx5s9ywmOE1PacOS6Tj0JrXZ
	rbOL3fAYHo+1gKv0w3GvSloELFSmg52zO4X6UFd/sZZ0gmsjBXr0a9+dX+ZpQbbxRd7C4tXYHLi
	65ER5e+9w4A1rOXrL2n0ZhxAb1EAND+IqHF7sz9ZgbckQPzwxOr2WJHo62d4G5xMnoi4j4bxivI
	BsMjg2Bihq0YqYknf7VIOo7u1lZZHANrsAtQTGoWybxEi4T5EiHYBQtB2+yJBrvYkMYRJ8Hrvxk
	RsCaX9B3ISq8D/AkmIN6X4fnpF/WMYvEUQsVKsFTOV546VpRCpZNcDhMXnvWOGZ/Xb7WKCIIe8j
	OR/Tdo0r4jsYzTIt0QFi7OJ9zHe263QaEA+eYt1JRqt3sAmUNW+Y=
X-Received: by 2002:a05:6870:ec87:b0:493:286c:f4fe with SMTP id 586e51a60fabf-4b75fb24594mr2664290fac.19.1795018064090;
        Wed, 18 Nov 2026 08:07:44 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jan Kara <jack@suse.cz>
In-Reply-To: <20261112075806.53821-1-zhaogongyi@bytedance.com>
References: <20261112075806.53821-1-zhaogongyi@bytedance.com>
Subject: Re: [PATCH] loop: protect geometry changes in loop_set_status
Message-Id: <179501806314.17649.9922558643991914536.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:43 -0700
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


On Thu, 12 Nov 2026 15:58:06 +0800, Zhao Gongyi wrote:
> LOOP_SET_STATUS accepts offset and size-limit changes while a filesystem
> is mounted on the loop device. An offset change can redirect filesystem
> I/O to different backing-file sectors, risking data corruption. Shrinking
> the size limit can remove sectors the filesystem still uses. A rejected
> request to change geometry can also invalidate the block-device cache
> before validation.
> 
> [...]

Applied, thanks!

[1/1] loop: protect geometry changes in loop_set_status
      commit: 6e6d4b23e92742a9f56008beb35c20ed4902611b

Best regards,
-- 
Jens Axboe




Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1393A1693
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981087; cv=none; b=qKIAfiZVQYqwkIe3HcbuP/JmkU1YZo+nk0EVHZTPIhM7JzJJMTo481uhRLKVimZwC/SEMPdtoQfeH4NQYjjZHKYlC1jOWxEOTAUoA5btyE8yuMC4H1l+f2+w4/oAGSoaztwQSWASTTPWqvDKcIw6yvHjS3ECGKMoXeVhdk39VAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981087; c=relaxed/simple;
	bh=uWTE4KFoN9z7NQm6uONrFNah204dGFqp0h597QOiKpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrEDBRkl294SMw0QEdN0xK/se8rPxPyHqQHkzreVQWW/uErKHO7KtrAvxNe5GKKIK57HnQftbsNqV+gCBZfQ/y2oKqVC9hRlLSqtQtoRLS5p28Tbe565P73SJ+e6ll9IpQHm0E+ttyaZjLPLvoMIPi53wIl/vRVj/MFYJ4ocPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+TE+L9o; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+TE+L9o"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-836c4474028so62862167b3.0
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 12:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981085; x=1789585885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NP8VYiUC10Sz2tQCfzJkm+STUtPDVYzlvloEvsflTSQ=;
        b=f+TE+L9oCnwbN9jNQcniw8QWsX7Gqwe7xOLGhV2t+WP8OQiznGt1u78o01qL0/uImX
         5Pn0OBRmEcn4EKExNnCrUH1romw32QohX5X7KM6QLxZIA/F2T5egGQvWspsCO6qf6Vln
         ZUdT7kV2/YFKyK0x6g9sRT9SgufHlPztK9aZxEmpCkv0YClVJQCXF6DSuuENyK1jqifG
         gIUji8nb05NPb3YvatBTb7SFYv3fBlhoQ105WSEizVVhAnUSV+uYXP/k9TVzB2PpIBSS
         XZcH2iE+m/OmlHskM9FB85OAzA71g+/SPt/y6ST0ooqrkHpaWzEhgfVcglIS7yhXPUix
         etjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981085; x=1789585885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NP8VYiUC10Sz2tQCfzJkm+STUtPDVYzlvloEvsflTSQ=;
        b=aWRg/cBECGtHgDZ7PPM7CtzS9kbCMFhNpVXJXbviEsPeQAg6R95jpFhDzBqFw+/PkQ
         0regA+PUL4j0k9EEuMO/A1RoOJoL5CHX/dXUK2NK8+QMrev1bin2qkHeIzV84Fzpys47
         pHWSWZt1cgK6l19Ho34cywUFqvRNhB0NEX5sCFIvvl4ekqy3cKM5DXwRn1i/dswjZ+hV
         T7x0DoXR3xV6qJdLnE/bs3bb64aoAzqaqgTmb1acRi9dtlYlvKBA+LgThY/R498h0FcL
         Y1mCAwMfbLFGc8OvnN7rg+/t8vVqi0iLAx0XhpoGQhYnq7Nm0vHFEvqd3mSAYM83xKBG
         rT/Q==
X-Gm-Message-State: AFuF++nQe/nFCIYjvel3nVCciXUp0Skp3gPP2eMAxmmTMjxfFx6K481N
	SXdv0qT786PPUlNUs1e7zh2yqgkVY/XcuiqmGF9jMUR4drGDQPLBJZ7hC6/G26MPHYpl1A==
X-Gm-Gg: AYBFou0q63Z8jm81nvfD7lNpBr+pYiWn0LiniDkUVBimKvLo0DW8l7NTaHq7XPQYsoi
	FNlzpbEyYRB3Ya86zInt+g7cypsjFpkxH4cvyEWeYOam5C2Oby901PooDuQeXdAQgM4+WZmXdl9
	xlk6x/Y17ng1TZprSlKV5/4PdHxssRAKZvb/zUEwDIPgtU4cgIzgIW2Zp+2HbAtOIE4tpY+SJ+G
	i3dOc1HzvSCWya0WqTpmVQcWloP/i/tH64ro9PdvTKSP3IEUvRDJr4xFOTghDyDoGHUqypwBzQU
	2cacFb8QAcKqTHNxIjXkfaojtb616xxxJqg9NkJFxykmmRMQgdyPzLg3h9+nRx+81Kfc8jK/GJH
	Mp+JtVbcWMrsFX+cYakdYhsQFFRpCykc9Dhmn0bwcpwiipyU7fBX0C3Drqn4HqrPTnpGZ/efwfC
	/2RynejagBf4WxgD/n72SKl453XB2X94+qTXgWFfkqLz3hX9QTAfZ5Slc8oZeMlTFEGJFHlg==
X-Received: by 2002:a05:690c:e3ea:b0:873:5bb2:6bfa with SMTP id 00721157ae682-8735bb26d93mr104665667b3.36.1788981085104;
        Wed, 09 Sep 2026 12:11:25 -0700 (PDT)
Received: from debian.lan ([172.245.89.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397f9f0734sm1500624385a.4.2026.09.09.12.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:11:23 -0700 (PDT)
From: Maks <mi9992828@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: block: zero logical block size leads to infinite loop in set_init_blocksize()
Date: Wed,  9 Sep 2026 22:11:07 +0300
Message-ID: <20260909191107.53134-1-mi9992828@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <apm0q8sNDooT53jU@kbusch-mbp>
References: <apm0q8sNDooT53jU@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

> How did you manage to get a block_device created, but bypassed the check
> and override for a zero logical block size in blk_validate_limits()? Is
> your driver writing over the limits outside the API's update path?

Yes, it does update the queue limits directly:

    volume->queue->limits = limits;

There is no blk_validate_limits() call on this path, so this bypasses the
normal queue limits validation.

Given that the driver is clearly bypassing the normal queue limits
validation, would a defensive check in set_init_blocksize() still be
considered worthwhile to avoid the infinite loop in this case?

If so, I can prepare and send a patch.

Thanks,
Maks

Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FD9361951
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 03:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792034387; cv=none; b=eWMBzGLpPtm+SqanUeiCY5YGA+CwgO2bj9v5+W+bUskcAPsySyeq6Uk0/7Tc+JgiFxIAmlDJF0+CD0SLNKCpCh8mtCwAtzw4R2Q8wo7uMIOmU3fi8tc7VXR6suZh02c3R/V2QvxEn5Fvv4udWKIoWT5pAtn7vpr+LScst65fnX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792034387; c=relaxed/simple;
	bh=dDuUS9lEAlDmYNRCGgtkqtpjRNa5kOmWvu33Let1WwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gxoNkzpFFmIJXRd55jtZhkkXKCgrrkx03k0AElW5aD/AL4pEU3YYJi6gFKcseNz47PebFGs+oflSPz9Klgvx0H3enGL4hbJeCKPXFGtbKBoQtfyTGNoXlR2VGXfmirTFfQbE+08y3qOBimjsg96cwPkPOk6ZbRTbIM+y/pCwDac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT9Eiu3v; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT9Eiu3v"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35f036b17easo1332887eec.1
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 20:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792034386; x=1792639186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dDuUS9lEAlDmYNRCGgtkqtpjRNa5kOmWvu33Let1WwQ=;
        b=FT9Eiu3vet6uPGpkuVsjs0r/ZDgw+fY850ubPD4q4piWpXnJvGavQeXkBUXZSYy3ac
         81kBt6rowytSrxgAafUxVUw0atKi+do4YvL6E/5dVYD3qAa8kUpaY9fyO1IPGQ+8YycK
         7K+j4Yz0KVB5FniozV5BR1keaEnPtJN5hITCcNawCyOtHseNwv6BvqwRaTB7sMc63p1/
         ItL51Ze2Zf5C5CCAj3d+mJ99zG2UIFZlPN3eYo7lYeYkcilLi10xiQMPUUH/xoSTjY3+
         mZMssMMXGI3WQ+RaaVQbMyGluz+YvuOT9Tsnm4Zra4Lhf4gNt5GgQKpEZ6Ijr1bvD2PS
         kDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792034386; x=1792639186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dDuUS9lEAlDmYNRCGgtkqtpjRNa5kOmWvu33Let1WwQ=;
        b=JIQJli/atufQr8gX/BT+pJQJbJgdQdocpffqMVL3Fj3TzbY74D1qcMJKK6HV0SikcN
         FQAlBNUbB2Ab6egzR+Poe7uW33n4AdO/zs1OImFVMnPJyYPz69WbCSlKFair4B/wKkRJ
         5TwDe5b7AstcIyzkEGCQFkTCD0BtF1tTsRA5BCs1Zq4PGDXSl+cVzchXWAVxBh1ZKmqs
         VMsdqTexZo3F1jMR6nOwDKDyyyddg1ds6b0Bpw08/3Eai5E7e1F1HYJdTNn9uX8uacNa
         yYZtT850nG+bNCS7+FB5ZWml/MyAlUQApbKFd4IjNxARi6dpqSYnDavxxTTvAEcngXqw
         /n3w==
X-Forwarded-Encrypted: i=1; AKwUvBy4WX/NWRz0B1Td32CvHytv2FkfCJKWtwjJW2Ifpo1Eh+MsmiDjUgob6z9y7shW8ixdauT4ax1x3fCWNQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYI+Ll1DZoEBJ2XEwgFqp12UZZmjtp6UY3Iz0709lCIeFAO80PCN
	wMY3xIVE0VDpwZy3XKChUPU1QSzTQDxuRfdu9CxHijjB2KMofOYe0UEb
X-Gm-Gg: AYBFou2SCGRUGbFkM+2iuyflNhBCH+XRdyoz55JfsLH7t2PMteQ9yJxFD70aX2Wr15+
	tWQ0YrsIo2BlHtL5JUGlavcrAYyn2kf/LTAqHN4w651sJJg+dFKI05BScGU3KhN1LMvCctAS6J6
	XqlvqUUSZrw+MUpBtDJq8TJXl/Zv4LKXLiIOVkeWp0D3VdQ2n1F5pBc2c/YgZO8i8q+57ZYRREO
	5y1xUpqZqYD6CPzuqA+8baaMsZgARiy0hpcP3yoO+1iYmsZ7WAgINzspkgrVBW1q+3JIKcKEzuT
	YluYZxVm/kk6YWATKurlhzKNroLXcInXo12sbwHkZFd/ITbuy9nqsm0wmKf8YlqrCWcLw4fU/Ru
	IIKFDSMaCBbsCDKpwNxZgARH43pTV9SbQ6LvJmzRhZ3TpaeEpXoIDO/0TwCSwA6w9ZUXugc2fN+
	QW75IQQ4yKiMY4fqs/Yn4h7zZzNpP8dArKSGBuxBsp1u3UveIOfb+BGsLCsxs4ICD/J+1EW836r
	i7Nqk/Fy1gfwykF
X-Received: by 2002:a05:7301:3a84:b0:351:985:e729 with SMTP id 5a478bee46e88-3537e01e8b6mr26189806eec.12.1792034385583;
        Wed, 14 Oct 2026 20:19:45 -0700 (PDT)
Received: from zhangbo56-PC.mioffice.cn ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-353814b556esm64832837eec.18.2026.10.14.20.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 20:19:45 -0700 (PDT)
From: Bo Zhang <zhangbo0325@gmail.com>
X-Google-Original-From: Bo Zhang <zhangbo56@xiaomi.com>
To: baohua@kernel.org
Cc: senozhatsky@chromium.org,
	akpm@linux-foundation.org,
	bgeffon@google.com,
	minchan@kernel.org,
	richardycc@google.com,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 10/11] zram: use rw_semaphore for decompression streams
Date: Thu, 15 Oct 2026 11:19:40 +0800
Message-Id: <20261015031940.1410875-1-zhangbo56@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAGsJ_4wuPCPR0DnbrLp7ebdO=Oih6K_yP4XxwETKQ+3U+THVjg@mail.gmail.com>
References: <CAGsJ_4wuPCPR0DnbrLp7ebdO=Oih6K_yP4XxwETKQ+3U+THVjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Oct 2026 04:46:27 +0800 Barry Song <baohua@kernel.org> wrote:
> is it due to the case that sg_is_last() is false, local_copy is needed?

Yes, exactly. Our tree isn't on the sg read model yet, so I detect the
single-page case via zs_obj_get_pages() (page1 == page2) rather than
sg_is_last(), but the condition is the same: the residual exclusive
reads are the cross-page objects that need the ->local_copy bounce.

> Also, with either deflate or zstd, create_dctx() will
> always be present. So, what algorithm are we actually testing?
> What happens if we switch to zstd?

We're testing lzo-rle, which is stateless (no create_dctx), so the
~77% shared figure is specific to it. You're right that with zstd or
deflate every read takes create_dctx != NULL and would fall onto the
exclusive path, so the shared benefit wouldn't apply there - as Sergey
noted, zstd mutates the decompression ctx and its dctx workspace is too
large to allocate per-request. So the shared-read win is really a
stateless-backend property; I should have called that out.

I'll also apply Sergey's vm_map_ram() patch (with the memalloc_noio
fixup) and re-run on-device. Note this only helps the cross-page part
of our exclusive reads on a stateless backend like lzo-rle; it won't
change zstd/deflate, which stay exclusive regardless because of
create_dctx. Will report the numbers separately.

Thanks,
Bo

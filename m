Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30703CF1E0
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437475; cv=none; b=a689Y8Aq0sSubyyjSlxkxIZGD9/M/pRTLIZI5+JLsETj1Yhdd4EMHPmssOygsKO1vwJTXBGukgc0fR5GnS1Aws+qMrN/Hq0b8Gfsmh8NxggP/dhiDeGOP/ch0mrJEMh5zKIlJkj1EAUi/GfcPHwO547l9jXBL3kS7XjqJn9HGgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437475; c=relaxed/simple;
	bh=RzPgH/3eGo+TdM3AJC5ylErp3efZkoBM2RxE6XOg6z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cK/ePNrnSmC4fH+tKJ/lLpMtQlRmX22qXEu+g5CbkhFv4tCw1c7QxERFpj4aEPQqx5/CNRuI5VXDNPBrCGMbFzWw+8+GpkWyhZPvS/BKNUxD2Rpu8US3iWrIrKwU9yY8KlL5dGlRqHQKO275NpQvpmtjyFS+gKxs4yX3+C1oXew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTquKce7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTquKce7"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-86ec25cf7ecso459586b3a.1
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 18:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437473; x=1790042273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8LtHfoqQuWljZWMj5fNvShJKWJ7Eo3q2bY3EGg9Y51M=;
        b=oTquKce7kKml8UudqBdJjRYYXkK7xVBS0OZtZssEc4L6A8jL91zwz31t7CCC2AfJ9Z
         M6F4E01S2fn/GKHTMMVFxIOZWofX6DrXzM3ILW+siPw8AOLa6PutVF8DwY7lkBmZ1KjL
         3BUeL4nljRO+69XLDcCYzoTyhMaU9DShKdjHA4bl0Bc/GAaohyhYb1StPRgvGdc7Sudh
         +6fz4fEmatET/8zD5q541u5TQcuHAcb3wtfPgA3B8oG64DfAWAXpbYq4s6MsO9L70aiv
         oAKLAQBYwHQH8nlxVXejuT++l3BtE43uKUXqQAQOsHwH3/55s3wRd94FgbWVBWvWpAT9
         c31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437473; x=1790042273;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8LtHfoqQuWljZWMj5fNvShJKWJ7Eo3q2bY3EGg9Y51M=;
        b=yCGbueXIrAIBJ/sTFc5E72J8OGfu3xawQ3jYxTGvzKQHbVI2gaWwMz6Ow23FuFat1t
         aWypOXO4Ad09a25FNLaedWWkL5xE3r+bpV/wFBQKB3uQohybbf25kJx83vZhb71xKkIm
         Yl4vvzxbS6ILenEtqAyb4BtxhQIdrlLCe3ZQaK6lLuLY9oWquMkOWP2QB2itz4KQEmaD
         7vsjbcoNIP8ZB7jadd4u1vqH0WE/y+d67h6lOEhI0ndB84B11KEQWsb3FPGAhrr3XWsN
         8bQZxG714EqVzqmCNP+3DddEUFRopnPPr5DcwthpfOQnXnYEbsFa69ZNMiMRnyBE+Cyc
         Gvrw==
X-Forwarded-Encrypted: i=1; AKwUvBypr/12dL2lCtr+vbYOjvqQnDRzVoFc0if55aIni7By/6Vm6vabjOweBePHrdjq5eb4PCyVQ1oOX9eoKA==@vger.kernel.org
X-Gm-Message-State: AFuF++mNrZ1Fd/yOJsglAsHQHb7P83G/HymtATnVbF0FWa/oUCujU6q/
	aI1imYeWfbZ0ZLkQlBICqHOv6xA4X4LdrBdf/hL9OTkWVnW4VgdroYcK
X-Gm-Gg: AYBFou0bNs6T/NxsS+gmo71COyGQphAAimS+z3gRRCSw09rGgsPpd2LDFsTzs5+dQcz
	IUEw40HDMkZR3nEZdsHUxxg/qX8eIZ4xtXI5d0Ah9VKzLvagcdjMc2yuhd9r9nGpRNwN8N5GtcL
	ovpEBL3HEV+qo4N1TOkvw483h40G1ZdHjsbFGF5CEJtw+ZL2YA/jZolPrA795FWo4KP2aWl0Ft6
	Z7PrqWPbfPpgKLfu0xbflp/lGeC7ZF/CHAwbWxhpxmV5XZjjJn0PY1iyZULl4/sLOJnooV55Y+R
	tsSo5pOKX4/0jsSzjBPAU1P0Ln5P42KJME6Eq08zPpEn5xebLM2K4HjE2pjoOR1eJT1TRVQ5Z+5
	VtUC6/mr3eN1px2GAnOldpE2AYxDUcyAt81Vo9asDwKXAS7yxAUjQ2lZdLCJAggC1wHZqG3YYUr
	LvqAiLyLHgHn8SEe6rVT9qPfmmU8kPrShtMXKYP7EUhTg6zbQiBSAKatNbvScz2fteirLvsaLJh
	PHZn5j1KgSEAC6nTLZcbnzyfIepbuAd
X-Received: by 2002:a05:6a00:3a01:b0:86d:117e:5db3 with SMTP id d2e1a72fcca58-8708c45f131mr2265230b3a.26.1789437472373;
        Mon, 14 Sep 2026 18:57:52 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b6139e3bfsm5231011b3a.50.2026.09.14.18.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 18:57:51 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jack@suse.cz,
	axboe@kernel.dk,
	tz2294@columbia.edu,
	baohua@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: Re: [PATCH v5 0/2] f2fs: enable buffered RWF_DONTCACHE
Date: Tue, 15 Sep 2026 09:57:45 +0800
Message-ID: <20260915100000.1789437600-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788795700.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com> <cover.1788795700.git.qiwenjie@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jaegeuk and Chao,

Friendly ping on this series.  v5 includes the mixed-bio completion update,
the syzbot NULL-kiocb fix, and the additional memory-pressure data.

Please let me know if this direction is acceptable or if another revision is
needed.

Thanks,
Wenjie

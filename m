Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1381F4CB3
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776458368; cv=none; b=kLsuHNtHLL5EjO2H53OtqPB/6F3Ie0eUkVGEPD2Sbcv2BcWdz7xPSbhlgjbrls4DV7yBWv0kHFCOO7Q8ruP/1Csc4eK9uLv5bVhYN10dE8KNYpyCpi4kWQ0kAXduVxMpZmUtZVsDDw1gaqA/xQcPlBGP1qa00ox2ISQg6qSqB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776458368; c=relaxed/simple;
	bh=i1BMMLLkRVTYgrHOaPeYIdwZl4S+7A46ZlmuRLF/URY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OMftKBeh9C2eV1CUSrp6bE8I0h2f545GgXlg4s6N+dUjyjEipgvVu7HUwvQVzWgUKCK6fyQsVu04f8T/vTTgS4ixs5LIc+hWfTeWt45iaL2QWLxVFPpYeQXrOiocBSPX0v1ATbRddPhePSkA8XjZolVE2XQrAI5cOkCeDYbFHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=BgFQ98X4; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="BgFQ98X4"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d7f92bde91so633423a34.1
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 13:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776458366; x=1777063166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9QtTnOFkS6069SA6dxGXeQkGgWojJzdS6a1A/pLJw4=;
        b=BgFQ98X4InIoEQ45pCayiBg9sQ0hBO8E+3EIYSjoNgOR2X6F7vj3MFKThKaKxPWFF9
         U5JVX2jRkAp63+xmROr8BNq17QZKpWiWzq++0vf6KykBU2KIYcGU44mB3Ht1Sp5yhwQo
         43olh9GcFCmqVg1hxkPQpnVi11gWMclzkeIcG9CJ9UrdlV7HylzsvhnENkCDoIzWRhTf
         GLOGuLg9ZGH8Tgo1T6cfgOybv59YhM3/lR+YDGo0HkyvbVPMIfGjG2xstTaeFlAEps3O
         lN1/a7HFDMIJUNBnrSzmA7FgzCxSfgB8iyO6EtrkVcqb+Wcg8XlUu+jqrGG7BzBUhYCu
         wD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776458366; x=1777063166;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E9QtTnOFkS6069SA6dxGXeQkGgWojJzdS6a1A/pLJw4=;
        b=KEDJOPktRG2rSf2eEEhaQZrcgArWveZ8m4n16t5lxh3QHTFY4mRm3SvvHnzXLTD5ZL
         egrOxwSZm/U97eVblaWijllIWChZ4k5RqWg2JTO8bVE8LJy39ucLst+4LPHLuF4xymbL
         9aDlUh9ztqZVfGvZnE0N9roOs3eb5MGDI1jrhMUvIvsCZSz5j0aW0xJYvJ9jbKzsjhLa
         KNzyPtJBjhJIyGhGRlbI8hscGgB4qcIBxBdyKTMzzAgP+XzqTtYMIPahVaQR5xMDP5zw
         i5cJBxnIA4tuDxwJG1hD/N3lUToSfmM07aqgzXXeJt4FfM7UZdesXYy2VOc+oImMZuml
         BrxA==
X-Gm-Message-State: AOJu0Yz9hqkSB6iLQI9fvWJNUuyklVmlp5MUW8cx+4DR6td+/tTpry5p
	Te7ra1sNlYJFeTMMj550b+UFKmne8etmXZZ5MspR7khE14tch9k2zquUeX4JkxUk7RXjNTziGwN
	Nzu6kjzY=
X-Gm-Gg: AeBDieuvZlsWTalNwzyYemVLaVf/6AgORHm+6Ooh8CWU2FtxubTewx2NmXaz3Pm5AEj
	mofXqvWpcYf32fzguTRTb9M7w8JNWGJYHP1dRziM0kneb0QkYZIU+j0PMyYFogp0a0w5WKM8C5l
	bKUwp6G87QNOE0T0Bk/JY0xgQBSh7KtB9BxhfW2NQ+g0bN9mNtJ63cxm+4Rqg+IOmfryF0Tx5Lk
	PmN7X2ekqS5jsZWdheKFAFSwRvEXsMZSy2V56BjvQXpZGgPchKT/Xi8Chvs48euCSlBebFpapsq
	T66RYizRFKyh8LpZ8I7Dl740sqO4/T8kkiU+rYgHZjVCkeGbD+jIv/w7hYNxgy0G/EP+IOTUC/v
	+DasOLevwxZ5OlNudNiu7hlVGmA42tVZxBxXGeuTnnq4RgV5MQ6sAl+YBwrF9f2Vuo/UCC/GnZ9
	P1W2Wl2Uq8c6llNHEAlZXO32AVJv+/TdcjsrCJW4h72J+GGtAgB+8VStb2fyBJ2Lw0d8wUqG3Nv
	6jZ4+ZoX8tzMm4=
X-Received: by 2002:a05:6830:3913:b0:7dc:18e:b584 with SMTP id 46e09a7af769-7dc94fa1ea7mr3206947a34.4.1776458365996;
        Fri, 17 Apr 2026 13:39:25 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc9759bfa3sm1926469a34.13.2026.04.17.13.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 13:39:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20260415230246.808176-1-tom.leiming@gmail.com>
References: <20260415230246.808176-1-tom.leiming@gmail.com>
Subject: Re: [PATCH V3] ublk: use unchecked copy helpers for bio page data
Message-Id: <177645836482.906013.10425726665830773163.b4-ty@b4>
Date: Fri, 17 Apr 2026 14:39:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 16 Apr 2026 07:02:46 +0800, Ming Lei wrote:
> Bio pages may originate from slab caches that lack a usercopy region
> (e.g. jbd2 frozen metadata buffers allocated via jbd2_alloc()).
> When CONFIG_HARDENED_USERCOPY is enabled, copy_to_iter() calls
> check_copy_size() which rejects these slab pages, triggering a
> kernel BUG in usercopy_abort().
> 
> This is a false positive: the data is ordinary block I/O content —
> the same data the loop driver writes to its backing file via
> vfs_iter_write().  The bvec length is always trusted, so the size
> check in check_copy_size() is not needed either.
> 
> [...]

Applied, thanks!

[1/1] ublk: use unchecked copy helpers for bio page data
      commit: a7c9fa7f6601c84d27cdd43bd96e8fcbacfb7479

Best regards,
-- 
Jens Axboe




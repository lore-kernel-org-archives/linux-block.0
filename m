Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40044127B4D
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474118; cv=none; b=qdxh+m4h/eGUR9o+3NjgerON5mv8fqKDjMT0PWgX6eVkoCAfxJZ9qKXaJ5O+NDNHcCbPZzUI3XADkDqx+8niz29Bp3mxJDjqSNJispqSHkzUCRq4p29IEe30c71ZM9iPxJAAzz5E5HzB2wPK6kv6hRYeMp50/9Eq2Fw2VaTwd0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474118; c=relaxed/simple;
	bh=ZPf56q26AE3nGu/wiRL+08bLZVXaHvS5JISPV7WHgJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aQ/O0B0UbHojfHgJ4EqaMPsd4OQ4DwMiUzC0IZRLzYkEo04jEcsUtxYfcKQiY/dtYNdMvAEJ58DSaaeGHNhKT4AqF/e4jIfQOeuowqilDXrn2HWu0E0ndTo+mICDAiy2lpwEm0uuyxqkr+Wm6iWIxdZx3J8BPC+CpdCyjMMZ8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LLvMLU7i; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LLvMLU7i"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ea7eff5f3cso505547b3a.0
        for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711474113; x=1712078913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewYIYBjwfNQiqXgzT2gd2jUMPtUAq4sgj9b7IZgioUw=;
        b=LLvMLU7inIk3KnNTC7wUv9p9UOOHU8cR+VymMf+BQ/x5HltoRixtz0A8sFscLTVpL4
         sRIS6yQF4HdnH8af32YZNQudB/GfW+rudjpU5gGF5S+8sxLa1aa04EKIr3cARkx81Fm6
         b64FF4+SPSXbjmVKeOLEyn64Pcr/cVC4+S3AELcKAj4mmx8yKQzVHq0FodZZb/kGqaK+
         ufjjaL29ybfghVN0jh9XFDA0KkEShR9oQYY4F0U5PMx48DsorCxOi9CQKmVDHQEzDQJT
         V7OUPAHPBXkUE243OgLrcyPVFs4HHRHOkJzv9e+W500XjotUL4zBmyvdq+UOzVDWgk9W
         RYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474113; x=1712078913;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewYIYBjwfNQiqXgzT2gd2jUMPtUAq4sgj9b7IZgioUw=;
        b=fZ4dsjHqCTcnWH04/arkwh8DAHiYuh268oINaHEIz0666ynXgo6BcAXmweb6jDHj5l
         BLglEg/Hkf+oqv9HiN5TAicOJZeaiGAIGKH1mOGBesgFrzXl64hss/Z2QxtIe785DIQO
         oKLfhcfh+Zk5bOVnYKD3MiZWKXga821du/GlUr9/c2cNv/zXGcIlaFCnanepXZV3IPz7
         XAATtekWVJowuUgHamlpvpbl5lb3r/qSSS4ctyFKiNuZRt1yUvW1xQUeXUqgQ8UfXBdy
         woZq0DqHYXVWv4n1C0Z++bq2+yNuWjUtg3tmv84zKX5A45Eh2mb8gna2FLJXepQ1SPz3
         B8sg==
X-Gm-Message-State: AOJu0Yw6nFsPUzI836h1s19ZN0/ubVUqdnRDTFSC05BPRz7SR2iNf+Pr
	MqhPuobr1f9aomUIGUD/qnuS8aPV2ZVcomddf1bYrAY9UX94gZqXkwB+Qiix7kC7DXCN8a/MuvS
	r
X-Google-Smtp-Source: AGHT+IHaWorleqBWjKw8oRInCpUSbOgHmou9L5F1jvIF0Q+1QgztJqx0HYpiEjTMsxH80tem3VYGIg==
X-Received: by 2002:a05:6a20:8403:b0:1a3:c3e6:aef9 with SMTP id c3-20020a056a20840300b001a3c3e6aef9mr9553218pzd.1.1711474112815;
        Tue, 26 Mar 2024 10:28:32 -0700 (PDT)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:163c])
        by smtp.gmail.com with ESMTPSA id q9-20020a63e209000000b005eb4d24e809sm7889602pgh.34.2024.03.26.10.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:28:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20240325083501.2816408-1-john.g.garry@oracle.com>
References: <20240325083501.2816408-1-john.g.garry@oracle.com>
Subject: Re: [PATCH] block: Make blk_rq_set_mixed_merge() static
Message-Id: <171147411211.366811.14324273045067456736.b4-ty@kernel.dk>
Date: Tue, 26 Mar 2024 11:28:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 25 Mar 2024 08:35:01 +0000, John Garry wrote:
> Since commit 8e756373d7c8 ("block: Move bio merge related functions into
> blk-merge.c"), blk_rq_set_mixed_merge() has only been referenced in
> blk-merge.c, so make it static.
> 
> 

Applied, thanks!

[1/1] block: Make blk_rq_set_mixed_merge() static
      commit: dc53d9eac1db76fd27b1fcee1f64c840cf82b468

Best regards,
-- 
Jens Axboe




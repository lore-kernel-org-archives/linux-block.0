Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADD53845B9
	for <linux-block@vger.kernel.org>; Mon,  6 Apr 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486291; cv=none; b=B398lW+337cfVLEyh6DaadwZM3cId0AwxDMllsHEIkMSIK2rnQlx+QSjgbwo5pjIJJYgYxFUkXjqJI3lJRqx1CYDjhhvlMoFt3mpqjHk+paDFJopQECnQyAGo5s6RVJGKssJxtivv1sl4na2he0TqoRak5qltwlR3p1ZIyNse2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486291; c=relaxed/simple;
	bh=ak6yaVgu9S/ortrE5hccn6VS1loqVuMDJsK2L8LS5HA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fpejYQsvXSsiXZK2aUsZUTRBltjOiqvWYHMKefnUD4cHmlMBoRARgWTavGOJ7Emy8Ab2LyoDehWdnBC7emBuaHJ0xys+uNwDodKqQCuRQyodUagw7pNfbGXArM84OvcUzFsS7IdfT9jFtyVYAraR15ZHuhcX1FI+hSUYxcrQ/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=EqXWGxGr; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="EqXWGxGr"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4645dde00a7so3498751b6e.1
        for <linux-block@vger.kernel.org>; Mon, 06 Apr 2026 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775486286; x=1776091086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cP+jU4JmX0ZcbJGHqewlu5EjA8WbPEq41I3kRck4Q80=;
        b=EqXWGxGrM5YUdTHEDoFu8WoasTue3p1bOzLqykXrJ7Cu8/uQYhteYnO6f0VbS0dA1w
         x21YNy/VOvfc2A8r1qAg9e1zNja+oUvyph00NYSJ8UMiNu+87CutcAOR5Y/Z3tPnuOeL
         xNKLDR6XvMiiSec7iUuxCV2Ab5x7CNTMXZif+VoBmXz/ygWiQQrCAes4mLAOItXWWmzf
         EDRyfromdnLTY//2IRuviiTN3nSHJzZ5h7F7+k1mrvePmuCyon/FdifrgrvnHMcdgTgx
         FvCvxsALF5iNm1f369NQsc2vigvOV3g2lEcLpI7b9KVw6JIolz5VgBYZFurJ1AteBRL+
         KNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775486286; x=1776091086;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cP+jU4JmX0ZcbJGHqewlu5EjA8WbPEq41I3kRck4Q80=;
        b=f/vyrC4xmWfHZMb/y8Ob+1UugmIX2iKO2xABS3jboQjP+lmiSVMlAZtQmOgs7i4wwi
         KIV4vGkDXaTnKSJhv2pC/Vt0CzUvmYEgR0aCH4rXW+WwxT66tUe2h27sEb+A9bb7gUa/
         AvQOFntfJa9m8qEY/9E195Wp1ntg1/mvJjhCxsJT/KvDcr5rBlfWQpke1UYlbzXaM/IG
         UGYf55UM6xchiU03bc5P8P8XFJ5YmRmOi+5iUdY4q/RLQ7mp9lCRHYzkYY160HiHGe6Z
         cV7OQVvymLFm/OX6Ibb5jowiABhYpRGRxSCit5e9pQsBNoE7K6EdWP2me++ZzFWJ4MV0
         1CBQ==
X-Gm-Message-State: AOJu0Yzfg+lQrgRfleGo/qAtEiURTAb65XNtQqNBiOuZhOWHr0Yx3bJt
	RGtKJ1Ur8bg+r/7PS5709rVaGXk8LzDCdlHlYfPFgoZs0vBqlRq9TWmKnkGY9fIvQzr8N1MF3hW
	AQEEpH7k=
X-Gm-Gg: AeBDiesSvrUdr+8nDzpywQcpUc/4k6JcG9fHkwTjr0bs4S/L3bRYYSfXaPIUN2Dz7c2
	USD7UplSahM0LmDhTd3/nthok+AV87SC6l8zyaEIcaQem542nnaWXD1sq/Whyhs6HzEq2EHd4bO
	aeQ62afKVac4CIVUwl+yqAua9fgkePnpGJ6hT5c7UyNj1j9YEpcCYKclAuaJgf2GCt/wdmm3hv9
	oX4AkEk5ktrYzVjY9QX95qZ6RahRZkc71mxumqE73/6idiUv7hyh8/nUv93IQmU+v/QglMMc8kH
	OQ4h5ug2womPP0llnHLMAJUr+KjM/nNbCUgFcaV4il2xYMRr2FpWk+jp+nE47apmpsRtwFzNaSc
	rK3GvROhElTmVQXH3dMNzaJ3pL5ReYC+pTz0B9Ke53B7U6p1uCiW6zzB0OUteYmhlehyqe4R3Lw
	jOu2DIb8tETtVoCrNQkHRtRoglrjTLbRYLGCliWf0q1Ie1tp224ygoP/yNCMVlGOu8E4mmB0iP+
	BFe
X-Received: by 2002:a05:6808:2203:b0:467:f1e5:a294 with SMTP id 5614622812f47-46f00b46690mr5674172b6e.4.1775486286255;
        Mon, 06 Apr 2026 07:38:06 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-472813cdbe7sm2038256b6e.7.2026.04.06.07.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 07:38:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 "zhang, the-essence-of-life" <zhangweize9@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Shuah Khan <shuah@kernel.org>, Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
In-Reply-To: <20260405-cancel-v2-0-02d711e643c2@purestorage.com>
References: <20260405-cancel-v2-0-02d711e643c2@purestorage.com>
Subject: Re: [PATCH v2 0/2] ublk: fix infinite loop in ublk server teardown
Message-Id: <177548628476.84168.18270412241757304958.b4-ty@b4>
Date: Mon, 06 Apr 2026 08:38:04 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Sun, 05 Apr 2026 22:25:29 -0600, Uday Shankar wrote:
> Fix an infinite loop in ublk server teardown which can arise when a ublk
> server dies while recovering a device. Also add a test which
> demonstrates the problem and verifies the fix.

Applied, thanks!

[1/2] ublk: reset per-IO canceled flag on each fetch
      commit: 0842186d2c4e67d2f8c8c2d1d779e8acffd41b5b
[2/2] selftests: ublk: test that teardown after incomplete recovery completes
      commit: 320f9b1c6a942a73c26be56742ee1da04f893a4f

Best regards,
-- 
Jens Axboe




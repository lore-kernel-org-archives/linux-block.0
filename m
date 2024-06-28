Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89281C9EAD
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591933; cv=none; b=IZILY6LluxrE4kqadyiyIb5Whg9JVlt8i1KbcqRUJfTrwW9SrtCnYJsKVGK53DsJCI9nBvjWEn+ehVaYGjjVbvcrCcPSF+18ot3DeOysmtsG59HNdIu0TJE3iYAkR0svV6y9zgOoOkabS0POxoRG9HwPQG+GINwc8YDUbPXPr9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591933; c=relaxed/simple;
	bh=WlXd8JmFgVfWVxJAjdqpboMIxClnQP8ideSJXjwBrBI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qQ3ek3HhIxOJR5fiRRsvv8ev35NJlgLfeWTGhVEVTABVYwbNev6lMjI4pIBQ5JiR2b+HEYYXGys185vrbzYIt1WiXsuSoHzJZgCDGUQ1m0mvROwt6t+J4YKgtiNwxvhii/EULekFIkxvdHyajILtPsUrRKCUSy02Fm1CXd3F/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XLkvA8CL; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XLkvA8CL"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d562930e0bso38670b6e.2
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 09:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719591930; x=1720196730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmIt5qvmSTkucPG+SeSrsMxC1GSwXlzZ1iTHCUvMAZo=;
        b=XLkvA8CLRXFIvMEPzkGiVOCy4JfuJ5oZQ4Ktn3sdQoiVBNNnDbF7fvHY5qTFhyfv9x
         aNK7J6MhE1kUI8G8De1k6yNL7ElbOjHliX9Gv3Fj60NaqPXpAfrgApFbIB0VukSxif7K
         dg2gdutx0HRV1XdCmTAWc63OFaBxC2wNXGBc3XXoUW9t2lWZ6OJQ3/Y0OGnXF0gd2YSj
         ZJlzrDNmXysc7r9UKSTVo0wZNZMUpU+n2ETY6vUhyXPYnBEgLi0GJPih00Z0MKztbUQ9
         XTexFaOicIAKBJmMwBOXoo9AAoAUBl0JYSAHwUzfsm9irlRkCkrQXgHDxm6UaSlYskzC
         vOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719591930; x=1720196730;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmIt5qvmSTkucPG+SeSrsMxC1GSwXlzZ1iTHCUvMAZo=;
        b=xN0O2L2rx+IgHXiWfcRJ8j4qx5p8dUHicTHZ5yrBcfRpNJbLF2Fjz7XVSr3QHGAkbt
         w4VjqfO3zY5NIFmJzzK4Nlfq25nqW2FLRdOryWWyxfTwIl63/5rfoYp7GQ1VeE9N8/j2
         CE5mtLTWu6k6OxrQMHzjvNU3ZylElvh9UFeVlf0bFdGlWH9Kqh5IjlRymymT8IWr16A6
         0ce+8yd5Q4qkkhHooZBjLaoQ4PS4E44RtLl67pKQY9ZMid0mRpt+vchAGW56mtLrmff3
         PV5zADGgteAWrWIZaxak8aBWGefNvZpmPJ+SehmEh8os7O/vwBzT5Pbpa1MLy4K5xuy4
         31vg==
X-Forwarded-Encrypted: i=1; AJvYcCUhHKv95KVAVM/2NoZi4Vi2O/C0+d4Zho9NbOW5yQDlwR6TxIEZ1liq1yxBtknRA999TF1tySRCZrALLGNu0KWf3zpyX9ig5vFiwC8=
X-Gm-Message-State: AOJu0YzclOQOeyU/YBXsQQlfvX63CeJiFUc0X2K+ZF79SqPy03qIBaZQ
	HMsLdaGXb5rKjxHvTab12ksjZ3+IR+fe8hOAMVQ61RualN3a7Oke3wDl0duWOOw=
X-Google-Smtp-Source: AGHT+IHczAdp6vJXrek4hDM+fYtM83fhK1znVHtTO6nE7dHzwj+q0bkmmEt0yVtca+LvE2HMhBt3kQ==
X-Received: by 2002:a05:6808:199d:b0:3d5:6338:49ef with SMTP id 5614622812f47-3d563384b22mr7941101b6e.5.1719591929799;
        Fri, 28 Jun 2024 09:25:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62f9c7c51sm354432b6e.18.2024.06.28.09.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 09:25:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: colyli@suse.de, kent.overstreet@linux.dev, linux-bcache@vger.kernel.org, 
 linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20240628131657.667797-1-hch@lst.de>
References: <20240628131657.667797-1-hch@lst.de>
Subject: Re: [PATCH] bcache: work around a __bitwise to bool conversion
 sparse warning
Message-Id: <171959192878.886023.14158886545448500224.b4-ty@kernel.dk>
Date: Fri, 28 Jun 2024 10:25:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Fri, 28 Jun 2024 15:16:48 +0200, Christoph Hellwig wrote:
> Sparse is a bit dumb about bitwise operation on __bitwise types used
> in boolean contexts.  Add a !! to explicitly propagate to boolean
> without a warning.
> 
> 

Applied, thanks!

[1/1] bcache: work around a __bitwise to bool conversion sparse warning
      commit: f1e46758e8b2b04c725ac706b5f455c0de0486a4

Best regards,
-- 
Jens Axboe




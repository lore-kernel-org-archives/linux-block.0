Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB081B808
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772674392; cv=none; b=k6c6h9WTqHnxeWXyU7Tx7cnbaHw11ZjT8pV+iRsVs/XSZxTeZ52i8rv4JHAEpeSKA5hdT6cCnw5c/nW1shvyybeQDy/iyOTx2kecFxX4TkdFZygebb8r0FWBCy2Szq0rygOXDtbT3uweG3vcpZLMtfr3/073zws10qtbSTXSf0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772674392; c=relaxed/simple;
	bh=yKkpRJfAHH+aEWRantADj4ssSR9MylVZFqNjzMwABbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL0xIuXpmn4xT2jylAf1/dzJCzlFLuPo3K8eM+Jz94iyW6cbOfs0HmdMxSopach5U/1qbAq6+lfnB6+nT6whYeX5DI3ClkzKDq4bsma7OELPdmoFR8HUH1r2UCe3Wq83k8ubKn9pkyptPJtqPSjlUcBCSAToNtTZAAfn0wG0dxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A/LUy6Op; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/LUy6Op"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82748095963so3834710b3a.2
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 17:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772674391; x=1773279191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hlY/DLVAvTGbsibR1lYmvcW/rlbZp5AzPQGUEqxkzA=;
        b=A/LUy6Op/arHVvBEd7LdsbmrTI3G296I/JDXCkeDThJuwXpUladhq2wdnQ5+jLjKVY
         1ziH0EXGYbmLupU5xOa8MZDFcZPtWMtG+zlKkGazPiU81hQskDMTiAMCgQcHG+8d9G1K
         uhnbzsdUD7jXu24CJOIKW4bC2Xpj+uzyfN/UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772674391; x=1773279191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hlY/DLVAvTGbsibR1lYmvcW/rlbZp5AzPQGUEqxkzA=;
        b=XPMjHoKEYp56A0JED8reE28v8Ic9AWim7KN2u9czi49ztopZij5HZLjnCdR888yXPE
         Sz+abkspekXI6Oe5S4fzmwv9fLVMlss+WSnQPN4/DO8xs50IuxWfpED0udBRIwWVIB4z
         41YjExZ3BBhD89H9EIj9EApU4N/J/INydQlI9jEbJ7eWmvW2Fb1i0Y8t9BIK/psiG0iK
         YCaScKIhWmGLDkqre/xE3BOcTO2eZAAvAbTmiWvRAkep4KGoy0Y1fPEADrqUWMVrFw7T
         QdJ4yDydPi2R5s2oRGYXt+m+NuvFlhUjU0CgQqHhO0y5YBQrsx53Pg+d851o62ANsexd
         9SSg==
X-Forwarded-Encrypted: i=1; AJvYcCW1hhKUNpNm4VXJLZAXNyCQyc+ZnXhSSoCUcwxygQYSdq1q38ozO5gCj7nr4i1Dq1hWHl6ieSc9qET3eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwpw+C7ivxuPmKSVti5OrAZfhtMe2IkZX6ncxnYRNh0BL56ph
	xtRCBDQYiSnGdru+jQoPjS0dlWCmS0ZL3CQOq0fZ7rUUg4cWuigtPOz+ouC/XnRcJQ==
X-Gm-Gg: ATEYQzxtclB8YP5m456Zpotd4F7o5pgd0irSBWvmto9vzS2VoKri7paTxHKFd+Ew7oP
	jY7h8oRLnyydAn1l27ZFY6P+2k8gGFD7GTV6QXF+S0F/gqupRW8A2BerfxaHn7Gmh2v153COyKE
	b8jK9GrzP8+D7RqdCQN+1ZLn6Xn564bNkNaZ+W/VLSXHzYN775e25cb4tppy6tbPsJn469JV6wU
	Wx+1Dphl1QHcIeWDPU17XUA751fHadsztYLLPR8OsLt5yC+IZMOCCxPiOxSWTP6Q2VlnwfbxFPe
	GJq+1u5OMgHc/L3fwmBBa5aAJoZFxeV6b3keBQ4ObxpssNVQ/U8uH9HxlZbY6vExgq8huI8LoC/
	ym919vl6/7Agb4oTGq1S4yB+kJfYhFXwIdOUBRjAH/q5vn4WjnIe2i1CFKmbos7v71Yl0nTr679
	a/rDdERb3KhrdxKy46Wx5OtjE7t6CInOhGCMUOluYWBzNGSMxiDrJtOw883yZYWnI=
X-Received: by 2002:a05:6a00:3d14:b0:81e:372c:b02e with SMTP id d2e1a72fcca58-82972d22fd6mr4322052b3a.47.1772674390909;
        Wed, 04 Mar 2026 17:33:10 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:713c:a5b2:ae9d:686d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82980d76251sm725814b3a.15.2026.03.04.17.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:33:10 -0800 (PST)
Date: Thu, 5 Mar 2026 10:33:06 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>, linux-block@vger.kernel.org, 
	Justin Sanders <justin@coraid.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Jack Wang <jinpu.wang@ionos.com>, Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 14/14] block: Enable lock context analysis for all block
 drivers
Message-ID: <nrdlva4b42gghgjp3gfnmb5b335632g7xy3wumfhhbd52pj5tm@u53ysp7c667k>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-15-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304194843.760669-15-bvanassche@acm.org>

On (26/03/04 11:48), Bart Van Assche wrote:
> Now that all locking functions in block drivers have been annotated,
> enable lock context analysis for all block drivers.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org> # zram

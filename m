Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A42EB5D4
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765868528; cv=none; b=NvNiU+4bvyOVioPHVTRgp0DuQPcxucgDho39r+SvuVet2vppJMUsZNlrm69JgR8rqHYIxNoc+UPiw9uyyfBgB7Bspgs2bKoi0f0d4EUu7pn8T26+2E3gM/B6TiUNq1S0R9wzS5+3v6ocArhXIDYKi9c2foXRuNkpT2gtu69TQ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765868528; c=relaxed/simple;
	bh=4VOKGc1JsClw6IrKZcOE2Zg1UHyvTyDZuX1uuIMs0sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU1Jy17HsnZe1nmHrebTPaqrmzZU2woH/IJNtMbEjy0tTutXhscObo3k2/B2+3EivGxUYUWPQI8FbEUREoudBrZracJHXAijDHhG6aS5+GAzml8dbAUCj2vTw0WwNzY8dXVTqCflGX+jQ5Xgib/dpPO0xD/bjz3Wv/XQvTSS/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=fail smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E/MV2zJ+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E/MV2zJ+"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c30f0f12eso2333095a91.1
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 23:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1765868525; x=1766473325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNPH/jZ/SOwdUZzWI+K9uxXgO1pBllDjcg4a+m2CAM4=;
        b=E/MV2zJ+NymRzlxVl/tUCp8JAnOfN9cYcQbUaS1YwIbRxOaVlzmOKOPTVNEf7VRIjb
         3STiJ3LPJ5SBG5JfpcfIeSv+ABMLFRHCxDkvPYWPP1pK0NOof0vsPA+R5v3PmuEsVKJl
         5zY3oQhE79A040kKvLF90hSLhyp9iwx5RZZ3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765868525; x=1766473325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNPH/jZ/SOwdUZzWI+K9uxXgO1pBllDjcg4a+m2CAM4=;
        b=TmOwcbk8KgRDYYd7XJU0BeUopoQveJ+WWHMwn9BR6e8NNjl39IJf8U9OQs3Bo/5Tty
         +J/Jca82/sKax/pZTGkTUBJGWlFwu5/8CfaW/XKbFiI/oyNc4TIDs0gehFHStjOmTKR8
         gncDIUbC8fFJNG15OPPCczAiohf5SVEq6jfHb4yDSB/ndLu/4fKrqZdgq/LOZ4TYQ0mW
         Dn2r0CrthwL5NMMJVhXmPlhHZk1aIDcAyyBTxWClRJ/rsEFaXKWRZzclsFIT3WF+d26T
         4Lxn0njyUkfs6zA7IE6QTQz+lTcFC2VCa2/LU8XZwToaMLDnSZsxeUWy34coCX0rC+8k
         MuJw==
X-Forwarded-Encrypted: i=1; AJvYcCW4xgkhRhiOIyBrPMsh6cB5ZeffR7NMZhajegCX8z1Wx38uX0PJHpRKUKu6z32FfhpbWlYzXBHAFohNEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNyM8HqviQWW86gr98XF0SloFiDysZE3dmPbxPcYh8wBurEqBG
	ZWOncWq90k6kpFYahShfruX1AXzqY+O/FXimgXCrYY1iigA9SQzBBBRIdOs8kHQMCA==
X-Gm-Gg: AY/fxX7zmL30V7jdo7C873IqadjB1Lr9nwybIdtm4nRdgAtxJFBo2m9fq5CZYEZHKh+
	hO0M5ILadn5floE5XGSgANNFbrSYoWfQjmUsfx76s8LEmlReVAT++RRXC3rOIEJD+INcUoOGdxV
	hKVmF5Wd4GsBp9lcVQfxvZxt/U+OrqmPKPVQVH/8WScDYu/6AfECE/LUx77hkiriSEaYf/pAM7a
	99JC7zVxXCuXMVg/JqFxyHbiM4aqg0iWwW9scr+89Ieh0rUAL3DVeKMS2udff4HxC1z29dOtmH/
	wbRxrT5rjkJQGjxSGMym1qv7EVngLJGoYd7nNvg2oS7Ttrtl428ndACZFDpB0F/7VP1E3G4JfnA
	HQ9PQDQl4YLfboYfKFr7ccccOmv0oiHtNvhnOCTivJDEkZyOdUDF/6aDrwc6Uz+d3+x3HOLiB9N
	PO5RIAcwLqIhnZ/hlVNkXovW0iyh4hdBcU1mjKzQmuwycJ2gTwtfxoZMYuAmaM8g==
X-Google-Smtp-Source: AGHT+IEuT3/plOsYLD8BRfCul71EgZXqqD0VVIL0HHIfNo/gK2/0xTdny+oIdgWzIdgWBZHLY3E6gw==
X-Received: by 2002:a17:90b:3912:b0:343:d70e:bef0 with SMTP id 98e67ed59e1d1-34abd8488c6mr12346405a91.21.1765868525248;
        Mon, 15 Dec 2025 23:02:05 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:a48f:6b66:399d:86cc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cd9a40c83sm177596a91.3.2025.12.15.23.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 23:02:04 -0800 (PST)
Date: Tue, 16 Dec 2025 16:02:00 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] zram: drop pp_in_progress
Message-ID: <e7ur36nfcppqqwqe4lgebb3prjk3lr7hlh5fks22ahsqz3bfyk@si6lxz5mqsqe>
References: <20251216062223.647520-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216062223.647520-1-senozhatsky@chromium.org>

On (25/12/16 15:22), Sergey Senozhatsky wrote:
> pp_in_progress makes sure that only one post-processing
> (writeback or recomrpession) is active at any given time.
> Functionality wise it, basically, shadows zram init_lock,
> when init_lock is acquired in writer mode.
> 
> Switch recompress_store() and writeback_store() to take
> zram init_lock in writer mode, like all store() sysfs
> handlers should do, so that we can drop pp_in_progress.
> Recompression and writeback can be somewhat slow, so
> holding init_lock in writer mode can block zram attrs
> reads, but in reality the only zram attrs reads that
> take place are mm_stat reads, and usually it's the same
> process that reads mm_stat and does recompression or
> writeback.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Please disregard this one, there will be a follow-up patch.

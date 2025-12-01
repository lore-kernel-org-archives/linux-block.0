Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C2298CA6
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764574767; cv=none; b=Bve9F7I5oZMWI/37+oJOB6n8svvDCPBU4Pkc7Pfm+NGFajMf0igePR2Fd4BK21EYg1v2BH0jFaiEw3NXAotHcnZfIm76JW6TZXtc67ZcvUX51bFImKNwFc7LRzgCJLDmU8O1yMbFrVSqjo/vywDLDeppdIhA3+sgrUJes3AbT8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764574767; c=relaxed/simple;
	bh=xY1YVIO3gGFdyamtYTekjbzpBLBW23sybF/NytjwgKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6blzDPoB6uR4CDawHtwiFVHxnws14ReWIJf98+4Jldy1mypkni2PZRYsX9yWrAKp6jUyJmyemAFtF7YhoxFFUPAIYNQLxLy2uVmYq9XFDd9oKun+2UxrQZlCPwqd+yfVnYxyq1EF8dDX2I1R+D8bvhKCJcFbO5U4AhIfFKtSN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gkru4PZM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gkru4PZM"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso6230378b3a.2
        for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 23:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764574766; x=1765179566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHmOAXqm4O99qnKcWZXHRu4eYRJbZDhm5nIu4Y+evcg=;
        b=Gkru4PZMUdye7RnU2OulxNsX+qa+eu3gomUgAQ+9DcKTDzrF2OXBnDY0zkRNiIqM9H
         6A9mFRVhO4qCVyDmD3eCErlwp/7bMN24XEomPWS8yDzPcS34C0R259rq6gQKO85r+iQI
         oadhPssUnFWaBxUMMHXTV6KCaVgoRI2Wl533g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764574766; x=1765179566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHmOAXqm4O99qnKcWZXHRu4eYRJbZDhm5nIu4Y+evcg=;
        b=Kyael8SfyeWx8HIGLJ2FaXY5lmolmGt2p6aEuVloTB+pu0NdmlGMDzOQclimgnYSXl
         dZD8AO1eNLQ2+CiGpcWBP82pS3UfnxcZvEJL/Z+0qNTtqu7rbxJ3dTmPmF646jQ7B0Yi
         DIGr/VoSjbxIf3J4Cx/LJu8iigxVDPVtCZKW1LHLlLh0bvVtwnBetThDgnEPu83vmRmo
         dw9T5l+htt+GsIA1KBfetA/8kYEEhG5ldmF9d/R48xW4CG1KAULVKb0G/WfD4KulGIqu
         3km0fM2cFhXiwJ5daIAQVNccE7FU10i/15EShbAl3F44fmiWj3yGdwKVSI4rTCZiEakn
         1bRw==
X-Forwarded-Encrypted: i=1; AJvYcCWpz48RLWzc+y2GI5XAc2n/J1hTKj06LSOZqHc0I5oELR2PFg3SR+6nYoDxz87OcIESnpQh/XZTaH1AvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnkZzHaxUhIzyXCfTWR84ycZrQDmslDpTgxcPtRhnTx3Sv1Epi
	+6vKtMjrhGzH2mE4FDxyb6MkjzJx1j9HAEwpQd6ocutYWezvOthKi/CHpMd2VMlmCQ==
X-Gm-Gg: ASbGncvx8IbvAeY9nasfSXI7CDNV5gqU6kyNMlul2LqJdzdwK0ya7WZ5Z2fM4u9QizS
	djhhdGrAiCDcp9D9vBlN5U6yNtHFmm0sBzaJjV1gyqhpFjjXFj4kAGYy6wiZ6+0706H9rxhrIXQ
	XbqO/twPzckFRG/c5t/vcnqN5P8FzfYfG9oBga4kvn5YWlVHvdOLxjc7eEH78/nD/oiBv5+VLpM
	phuoQbZ1MCo4CI2nRTSBTZ6TXIc4S7DgKiC1k0OGJ5QMAmEYgFBH0SPefVq1o5YQ93DQFYKEPZr
	vi7+zgj7SrIMJQDyCiPFkBPkxGRY0gLDqa4pIbKZDcWsBh2n4ljTc/kvXKAKKTLTiFLQGX1bnQQ
	askqsWPNzaPNIxEmQzbE0mi/BaKxvNnV59Dgc6MLJyYCSqILLl5XmLu2WelYo1Lhni2cHES+WFB
	4ngcRMwcHTaHIugb70Nv7bv6eZztbpOLSbXzRWHWqTSg4KWSZLdXA=
X-Google-Smtp-Source: AGHT+IGZMdL5p2+g88p5Lpu0jaNJNlaS/+US8v+KrPcVsuzDzoJIztVYpsEnIj7NaKeJSLPgYGvS7Q==
X-Received: by 2002:a05:6a20:12c3:b0:350:ee00:3c9f with SMTP id adf61e73a8af0-3637e0b12e5mr28351389637.48.1764574765376;
        Sun, 30 Nov 2025 23:39:25 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:943c:f651:f00f:2459])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e9c3f79sm12345012b3a.42.2025.11.30.23.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 23:39:24 -0800 (PST)
Date: Mon, 1 Dec 2025 16:39:20 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] zram: introduce compressed data writeback
Message-ID: <24o47a762kurbp33vgmsp5gclyijt47xl6ms3ynxjr3k5o3mbl@t2lsiq6swjj6>
References: <20251128170442.2988502-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128170442.2988502-1-senozhatsky@chromium.org>

On (25/11/29 02:04), Sergey Senozhatsky wrote:
> As writeback becomes more common there is another shortcoming
> that needs to be addressed - compressed data writeback.  Currently
> zram does uncompressed data writeback which is not optimal due to
> potential CPU and battery wastage.  This series changes suboptimal
> uncompressed writeback to a more optimal compressed data writeback.

JFI, v2 is coming.

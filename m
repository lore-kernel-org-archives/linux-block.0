Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87BA18A6BA
	for <linux-block@vger.kernel.org>; Fri,  4 Apr 2025 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733203; cv=none; b=pr5oJ2qoPj9pllDK4im7gmze0i1nriayTkkSS5I37L5v3iaiZFe+RnWwv220LnAiIHndrlURnr9t0DEuLu5RcrkOelOfEZWdKoENlUx74Nbam8ZaU16XbM9z9uPCoqLBijwryD9S5h+ee5BfooAundPlelhnHZXGDwL1rcCHsts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733203; c=relaxed/simple;
	bh=viauY4W22XzOs/4/4vEnGIRS3fPsBxVvkPzWY68WWvw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pYSypYq4WKgn6ctl9meyLJcd5qLjQZivCzB+ik+WbihM/XrLJnDWIpVTZmgfJGKLyA7Z3R5QtmaXeKZYB5A18xmdzaEpH3yff5e1l6FfiOmet7JOxLb4rp5jBYOeNGEnC1mHcfc5r3LPGvzef4WA/gvOOByb2lUo1VvGdWmVyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=h8eE0rtX; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="h8eE0rtX"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85e73f7ba09so129369339f.3
        for <linux-block@vger.kernel.org>; Thu, 03 Apr 2025 19:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743733198; x=1744337998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6aKWvhuA48zE33ggUf4PNXsIWWoh0a+qeJyXXIFSl4=;
        b=h8eE0rtXsQE/odVmu4NafKeKjtF8c61PAkMdzLj3ffuuDy5N6jFMagjkZRNVhVKlqh
         tSv09GJoTrLPRNYkcm/cNpwLGA3I9Yg0uY87MeZk0+oedRPiJgaNB7D1ODabbRE//n9u
         +fouOgOnLwKQAq+YVmm57hyuHa9lKEZ1HJKsdgoeOlZp5M/yyIfxHkeFZVI54E3yLcxU
         JwCkaFkmWv04y0tTN9Uj1oVelkHLnbxGXgFcpTcBYNndaAvVBsX4FXKbXw+2NxysYlnB
         ByIKDkDlXJd0wRbEHVqYTfIwlIccUDydlMa40qFM+WcVB//FuboFhbxgzakGpir+5g5b
         HRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743733198; x=1744337998;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6aKWvhuA48zE33ggUf4PNXsIWWoh0a+qeJyXXIFSl4=;
        b=SvuA9B455WVYMSCoDoR3LE7PH/2zBrZ8j5Vu4vqkmhwCzRA/jDEYZ1iSEtAjr4CsSK
         yAH+bAF8jDxyxkTISkT2QLUai/fNJjT90USqesHjP1ti++xHytTecj+vxtPA0LqRRmkZ
         C+XvJOmn5MhRHJdwUHW/uacOAn9GOaXeiy2hh/QmVLUFjxHMXNwfaffE7YPVRpBlx4Bo
         WzZvfsw+ilrzTTW79AeXGD10NRS9yZYDXYt40QMx3DvN/C4SKOxcxIrmYKYEcycBzzKN
         slkeb1uu3eLo6c9xYXQgMUIvZlDX4qv/QudEggC27my2X/zWISL3AvwgmaWG/NUVV657
         AXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoH2wSmv71BjahYL362aSqny+H1Wa8j20NYdrfS/xK8UGlZdF8sRksKbGTTQBhpkis8DsL36FAMxe/GA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+LN4oQvl6hO076R6/SvUCwn9AvPfdYyi0U9+p+1FHeM11aZe
	bLl4aLAUiEMaenr1WF1pG9SQVEtJzDGvOXB4DJgL8Jg/X+9KpztmZC1kIO5zXRU=
X-Gm-Gg: ASbGncsniNyqxdklXowd0WVjyHOYhOv4lKAKTVpPnXYgf+JGaEZqC4Jb5oWPoH306aE
	0w2KAAmaZD/fwMdzAdMhTQb6zkOGzTmWzw+Kb8XZ9ly6guatYtsLU53wV2O9BmnULFwgShDEess
	6/h2q0dhH6My0T5l64xr1rswqyibbGI+zzo5IRcC10ujOBvtt8HB5jlJ5h6AJ56VbjsMLDMtlNB
	BrIlat9L+jibQpvwW4t2SYZg9JN/tqvi7hYrq4ByILwKdXbOq6sPbMdga8ybzWVHd0h1gTzBPkV
	IXUkXQFPlf2KvgDHEzGjrBfuYcsMxe0rf2v/
X-Google-Smtp-Source: AGHT+IEzvqBl5+D2se6dffkydLAa59IqVJ0Mmc1cResHW31sfryBDHYHwP6o9S5i0eweNbEDnAb4Fw==
X-Received: by 2002:a05:6602:3811:b0:85b:4154:7906 with SMTP id ca18e2360f4ac-8611b439f6amr193994239f.5.1743733198527;
        Thu, 03 Apr 2025 19:19:58 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8611137aeacsm44849239f.37.2025.04.03.19.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 19:19:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, linux-block@vger.kernel.org, 
 Pavel Begunkov <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20250404001849.1443064-1-ming.lei@redhat.com>
References: <20250404001849.1443064-1-ming.lei@redhat.com>
Subject: Re: [PATCH] selftests: ublk: fix test_stripe_04
Message-Id: <174373319721.1127267.3756134797323684566.b4-ty@kernel.dk>
Date: Thu, 03 Apr 2025 20:19:57 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 04 Apr 2025 08:18:49 +0800, Ming Lei wrote:
> Commit 57ed58c13256 ("selftests: ublk: enable zero copy for stripe target")
> added test entry of test_stripe_04, but forgot to add the test script.
> 
> So fix the test by adding the script file.
> 
> 

Applied, thanks!

[1/1] selftests: ublk: fix test_stripe_04
      (no commit info)

Best regards,
-- 
Jens Axboe




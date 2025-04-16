Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A384428DD0
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764815; cv=none; b=aI3vXCYVcP1+w23kWxHY99H0rzVpwhOXKi1ldaNgrye594d0zmx5E2rgBOFfGfapSSTGOo+L/VXY7z8kP1wR+TC1IUS887VJCmEmwR4Utwk3bwaz+JYNNz1oSrEr4hP6S74XZpOUJ+IrfV3wSnuKDvubDH2eg2MSmbu86iC29iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764815; c=relaxed/simple;
	bh=96B9PrXJW4G3rI3fvsK1uPWHxbv4fipG+KQ2mMcseBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frJcq59XxGtzBmYGO8C7QYYMsXDm0oXwVGxixTgMPvysuk2WZ1B+F+++p6W5/b2njHj/cK6Jf32kjZWMJ7lNVVP2f66h19BJlFnagtp2otRVErJB9r4eVujXLv5ZOWnI/6dh+tN5/B040zfIb58FR/lZ2QsNs1kxx+r5xkldqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=THPC0do/; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="THPC0do/"
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-6fedefb1c9cso53971867b3.0
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 17:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744764811; x=1745369611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ls2b3PcDVLxYWfpvpeygqh0EYCIMqg9tqTsrdLj5Hpo=;
        b=THPC0do/jbA0gO42HIb3NlAVqfvmnFilceHccEEMxPn6ffKXiA3nAemGbWQQKOWvhm
         FL1ycjzYkh6eorktDG1dSSfp+Fz5ieU8B32Oe1IIp8l8UYfpLu7zMynjmdFhj1HzjmNj
         1vigtdsRTmHGv+r2wJ5rq+UThJup1qwuUid89/8cQEvlBuMIWzBUM/5GYof7bfsBkSYR
         H68lf5iWtpmOQ5sCjIjmSWfRAYeACks7Nrz6CeL0876mWvkROcwHZG4+ZqVMfdbTRFzi
         cecs1Kmic0ZzE536ZzolBUraDgp88vWtHsaCvFzRuvkrzFDhzTLtQ3FEjBUH2J8kPSOa
         qSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744764811; x=1745369611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ls2b3PcDVLxYWfpvpeygqh0EYCIMqg9tqTsrdLj5Hpo=;
        b=DTEYZg0oE1Htc1qD6ibUx22tFZseDkY+raF9N2lViPYeLe+ZafLf49M5k4z3M08nOU
         6sDWOu8wqq8SBPPZN+8mJyqC+3okNG8aGviMctklgsLhILfVGEwQIie2LbFZTb83Td9Y
         WSrNKAJeiJsKn4YEhDk4W3ywuiKw2uh0a1y8QLZjBKapcB0bnwTR5BoTpFhj+unMId0z
         pDKIXnhtn037/wovBEBQY+i9sQDalRJScHrAVlTSItNB8RAVQgv5Nl1aecSe+pudzHP1
         OGnrHW0HZMExeNv52UOvxLoZNOx7DtdjgFsZToNvz3zECmn14RDsstXquVwXdMiiUZ4c
         3HLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF32h5G/hm6L8qTBweNqXMkhEhO+wJkBRXZMnHDrCMNZu50q9yD5l6owog5jOdjnXTbfsZuIOiT9JKSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZfOsgXh8UxHnJ929dCElSshpjOp9j3kTvdR5kYfSZPakJrQyC
	PEqhdN35W73+WEFFrVQjTWfJWpRGfcq6LfYc72b39pOPvb+DxK3v8GPinnJmUyKnU8jm4LHq4oZ
	8gsZwF+7tnb4/vSd8hqW53nVwsBf+1yrW
X-Gm-Gg: ASbGncuX3od270GT/D+WrnyXnLE9COUaoCdnwVswRh/Y2XDAZX7ToBw1ObvFUMuLnuy
	cu8GrxqbEfoXpVgrBJvhXPINdm6wPdC7Db1qpysMwO3ZBt/kFTb38huTlZA1Fh3WZf9xXfmx55I
	f5qpURpbSWlk3QJYtJbh/EJ1GcmCPPcgtZbAzD2zFVaBah6jwIH77z0yksUDitAH40oR2klhgSU
	KdCXWQw+H20zo3f/Ao5av3I+SYTM2BQj0qHO5GEWpBHtnddJdVfMA/38v0jhTkKGxZ0LXpYJ35w
	OUlXOnp6X6Vw3Fi3vfmMgobXFSu+hrvKvKbWkLFdy3KkzQ==
X-Google-Smtp-Source: AGHT+IHa7i8bVol24qWunlXT4S3rE7nqfEbNrSA6OR95HlTd8daUtz+9iKquVi2+NvgJBKdtQkQEDGk6urqh
X-Received: by 2002:a05:690c:4907:b0:6d4:4a0c:fcf0 with SMTP id 00721157ae682-706acede1aemr23383707b3.20.1744764811599;
        Tue, 15 Apr 2025 17:53:31 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7053e171c20sm6472807b3.31.2025.04.15.17.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 17:53:31 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A6EBD340237;
	Tue, 15 Apr 2025 18:53:30 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A3E47E41931; Tue, 15 Apr 2025 18:53:30 -0600 (MDT)
Date: Tue, 15 Apr 2025 18:53:30 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: don't suggest CONFIG_BLK_DEV_UBLK=Y
Message-ID: <Z/7/inRyIxCIDOKz@dev-ushankar.dev.purestorage.com>
References: <20250416004111.3242817-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416004111.3242817-1-csander@purestorage.com>

On Tue, Apr 15, 2025 at 06:41:10PM -0600, Caleb Sander Mateos wrote:
> The CONFIG_BLK_DEV_UBLK help text suggests setting the config option to
> Y so task_work_add() can be used to dispatch I/O, improving performance.
> However, this mechanism was removed in commit 29dc5d06613f2 ("ublk: kill
> queuing request by task_work_add"). So remove this paragraph from the
> config help text.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Uday Shankar <ushankar@purestorage.com>

> ---
>  drivers/block/Kconfig | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 2551ebf88dda..e48b24be45ee 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -386,16 +386,10 @@ config BLK_DEV_UBLK
>  	  io_uring based userspace block driver. Together with ublk server, ublk
>  	  has been working well, but interface with userspace or command data
>  	  definition isn't finalized yet, and might change according to future
>  	  requirement, so mark is as experimental now.
>  
> -	  Say Y if you want to get better performance because task_work_add()
> -	  can be used in IO path for replacing io_uring cmd, which will become
> -	  shared between IO tasks and ubq daemon, meantime task_work_add() can
> -	  can handle batch more effectively, but task_work_add() isn't exported
> -	  for module, so ublk has to be built to kernel.
> -
>  config BLKDEV_UBLK_LEGACY_OPCODES
>  	bool "Support legacy command opcode"
>  	depends on BLK_DEV_UBLK
>  	default y
>  	help
> -- 
> 2.45.2
> 

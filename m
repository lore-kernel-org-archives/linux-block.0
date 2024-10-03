Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8AA1CFEB9
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998861; cv=none; b=o+6uB2q6rnPRHfOJOvsB60cv36vNWkzMufnbdk8MuHOCSjXybSxi6PNTCObbIaJT7vTdhsqPASc5WpFq1/59GKWt09iUOb/6vhOPgz/MsdZkeSkxL0b1TtFywCUu5yhQNVhNse9UhNLoAXUndOLtl9GgirYHv7tar5quX/jBrgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998861; c=relaxed/simple;
	bh=q6IRr76iK6QOIV2FG2BNM18oC6eW1UnPW0qBc/43JXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxwE1oTqPzdL7Kd0O4gWOJxrKs0YToxwIOMcpfSg88lDAYwqEb03h4lEIh2sLGrvj2dbO39W74Ye2FPWoBrl4TNz3G83P0Rx2jNIJyvrARP4oIi5cml0rO2IRUl0WuIRQDh0v4VTaEzu8+DQaTrW0pqnYTs5EgZBHjwGDBzTTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AEnA6bnF; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AEnA6bnF"
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-82ce603d8b5so73428639f.0
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 16:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727998859; x=1728603659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MaP6Ye2icJldBBF0iXNg9zzZsKodvZccrDgOG+eQBdY=;
        b=AEnA6bnFC1GQfvhuUWWi5VehG3cpEfVURt3foCrldnYErJHDoWYohavzqZoedxv2p7
         4q5j64vPhYgNAXGpvsUf77havNFKJjaiss1yWBpGn/PsQP9L2kwEuu9587IGbsxpqnlU
         uV1MoV/t4PYFt5Nkr80X9EzzjftroTt1ckk5rmwKrJaA2yce1jK6stsVttcxURhnpJeJ
         heiJSlkqfvLXu8lp60+RHm5qTSpw+EIDEdz8oO31074XguocJXCrzoG0GA8gMqDWgR56
         0jlDIg46EWIayasp/foWeg4VcOAuPM/T2e0nKOQSCXRXAbq1E/hDvW2zURgShexTs6ZM
         opCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727998859; x=1728603659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaP6Ye2icJldBBF0iXNg9zzZsKodvZccrDgOG+eQBdY=;
        b=YpyxkaEhqgrLnCqqDDVWaTYMzsWkvfChm2j94wGU4g3KbNoLJSlirAp10sxWLofiud
         /cq/JvM+wT6rc39ofAn1G828S7xWd/0nYrXGVhx4Hf6eT0UPs4fBINjvPkAJPib7rehR
         pCbpCknrN6BhDapDin166nDyuFi/ylJuwOGAypBkh9QSlsj0g9frzoXkjGd0GTPY5Fd0
         +V4SvHZgkIRYA8CnRh3m8yFhLvwDrBgcIzPyPTGOtDpFriFiX3jT+u/z+XWC+CTEc9DM
         HyudfMnk2zjS+7v8m9lEhVFde8w487zWkNXjwFW50sUctDtTeuwWsJd9ZeD0khJMU6jf
         Q7vw==
X-Gm-Message-State: AOJu0YyR4tQVOPB0Ek25XzYNNZtY9rOKZAZpjFbdMJ/fLjkEGzHw3Cn8
	8D5KycDWISJOx3V1AoQjz6GL+dQvWO2d5EVNYkVjfIQeAM53YQkMtym1ChtDGxKLI7jyawSQiZp
	oIRvZbg78gEAoW5rC4NaPaHEOK/rkyNpx
X-Google-Smtp-Source: AGHT+IFAmZ6HECrs39mHB2vmD8N0Ied0JIXb1ap4k/YCRYEd6FlkWa4mGhy3KAVHW8h368vCQNtYLyvjs0wZ
X-Received: by 2002:a05:6602:14c1:b0:82a:2143:8 with SMTP id ca18e2360f4ac-834f7d65974mr157844039f.10.1727998859086;
        Thu, 03 Oct 2024 16:40:59 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-834efe386e7sm9729439f.29.2024.10.03.16.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 16:40:59 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 31C743403A0;
	Thu,  3 Oct 2024 17:40:57 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2FF01E41ADB; Thu,  3 Oct 2024 17:40:57 -0600 (MDT)
Date: Thu, 3 Oct 2024 17:40:57 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: decouple hctx and ublk server threads
Message-ID: <Zv8riaj2HL7S9e/b@dev-ushankar.dev.purestorage.com>
References: <20241002224437.3088981-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002224437.3088981-1-ushankar@purestorage.com>

On Wed, Oct 02, 2024 at 04:44:37PM -0600, Uday Shankar wrote:
> @@ -1036,9 +1028,13 @@ static inline void __ublk_complete_rq(struct request *req)
>  	else
>  		__blk_mq_end_request(req, BLK_STS_OK);
>  
> -	return;
> +	goto put_task;
>  exit:
>  	blk_mq_end_request(req, res);
> +put_task:
> +	WARN_ON_ONCE(!data->task);
> +	put_task_struct(data->task);
> +	data->task = NULL;
>  }

I suppose this is a bug, since the request could be reused once we call
blk_mq_end_request, so we need to drop the task reference before that
happens. Will fix this in v2, along with any other comments I receive on
this.


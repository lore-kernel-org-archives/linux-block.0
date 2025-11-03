Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4111DF24F
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176084; cv=none; b=Ftrigj3vX7Sv0GyGD4DlnhrUOc9DF/4Birx/ua1cM9l04ljVWEkI2U6Xlya7MQ3YpKoDBsh8//p+WtVdU1nzR7wK4qJgI3e6k/Jz3Me4V+W21xMvAujgXhhvnXscAetmnSHIVsODhBaQ88KlHIiQrpWFbq65ALTbI5ggfEPCRoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176084; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfBIg/MaNjLDfSCLBdOVShYLXkM+yJh7YcfoVCGvn4R3EtzMBFrxTyi5X9t34MVANYliQUIDaGpUCxIteyLErRtHgCVUUQwOJfFd6gfGK6f+qowOyAj+nH7SLIML9Lg4i8ly8ZdN/xsp4f95omyQJXZToSEcYI7fSFyGbwrUVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBnvFZps; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBnvFZps"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so2298748a12.3
        for <linux-block@vger.kernel.org>; Mon, 03 Nov 2025 05:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762176080; x=1762780880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=LBnvFZpsXfXDITuhnDH7l+VK6skueOCsghSEL5H/w3hwgQPqbhz74zioXPpe1xvu+S
         3+cI8sKTzLTkYWL9tx+nhga3Q+aW+DClD72Ek8bucpWEAdP4oC8zwSf9Ii83ANY3cRlW
         HiRyF36f1sUzqT//JQk4vPQspWm055Fvfa0M1VLZ2Q1rFu6iPvHUcxnRTS8c8bqdr4aD
         PzaPbiI7TtHmQyRNOOcQ8yl600g0Jxq9qt2exgiEn5J3+eO6iQwHoRnXwo0gUBgYb67t
         7+M6PW0nophwSqZhk9G4kYLBak3tSh31SrSupDMAJQ1c4iBi+1PJjK99RqOottQt2r07
         pRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762176080; x=1762780880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=RVq6HOMtQgRb+lbE43jGsT/9k/mr2lazr5ahvaytXszcG6CvRVdACZgPUyiEUrZEv3
         oNMIYD6AAREqGSPC4mMwSWVPwJl3ZugSoHIi1RaRGnQpKc6NFaGxBPvpAC3m+YUrLo14
         ACqW5FlYbOdNr0CsVF5cJVJPM7xa30xiFvYQ5UHKopeOKZENCBmGLsiKVwItL2OIekAT
         i4+jyggMS3g4m3fop8NUhccYfiA7Hu3GJcY19CeyM0p+kOUytpfPn46nznd65AktebqC
         brb9m8YG4lchFYmlIVF+6ql8capseX4ZeoyeDRwVtQ8Qf0KdalZTsHlBVw6hHQIelyBM
         0Fgw==
X-Forwarded-Encrypted: i=1; AJvYcCWgLWVzSwvjrf5+3GjPwXuopnSgtPazcT9zafKY/778DkU2nLOH4KA3JMb6q6n5RrXOk9vsQn+oWP1OnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfvvzyYAoiemAFwcmm4HOuuIEH75qB1CcPNBXhwXx0ZxJpE5rY
	taIR4tq2oIsLg8v4Ev0H05RYgEswJ/XAomX26piZ69TE1rCzhGAeDEjcJuKdlAk4a9GkoriO7qW
	Xf1k0dlhx0wymCpgNJbGEGU3sZXNkwcvRLZ4=
X-Gm-Gg: ASbGnctNjpyw52Nl5iDlfaQLn+oicOkLTd36Gth4n4rT08VtQKovlR17AOnAASTSbnn
	Frup2J11H9h8qVZew8ybxjBGBC4viQ+Sc3AsQ3RdHWn9679ET5SkCBCKThoitbbb+WcBbY/JZq2
	ErpR33wUcDAWCRUNPKGPN7Z5t5V11L746D6+Vt4neXb6+i6TJs0wo85VpI+Lwi8JDUUN7XbpACg
	L96gGyt4s2E4QWkZCUl6ptZKIJdRwdye6F0jQ2VIB8MSjQaGxfGnMnSZK3KQVOM8daHg/PrHzYk
	ehVoj/UZd8fzuiTY3cgQjbXThy4y8wxdZoWBXDp2pRot2g==
X-Google-Smtp-Source: AGHT+IEKMI+WJpdXwHxfNBvPyx4Y6RT+LEeOV+5qsDqeDfKywsrPY4gYMIzwNV0TzuSI6afx76+BfFJNILy8kBV6O6g=
X-Received: by 2002:a05:6402:3508:b0:640:c918:e3b with SMTP id
 4fb4d7f45d1cf-640c9181050mr2441309a12.26.1762176080413; Mon, 03 Nov 2025
 05:21:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103101653.2083310-1-hch@lst.de> <20251103101653.2083310-2-hch@lst.de>
In-Reply-To: <20251103101653.2083310-2-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 3 Nov 2025 18:50:40 +0530
X-Gm-Features: AWmQ_bmmo-o65uUXWtt3x0fe6bQceDGzl2hXy6vwO-uUDQwXHphwkGyS-NtzYUA
Message-ID: <CACzX3Au17OaG9oJ0Dia-rRxzkBhSa2rr5b5dL7tWBejR1+42CQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: blocking mempool_alloc doesn't fail
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3B1D7984
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310882; cv=none; b=EoREh6Enn3BKACkZLNmuNREUp8BHP9PIgUHBdzFG0pFp22i8J5uEU9+Z/bDr+h+S9woTzkX4JXksl5uJCB3JaU25JiFyIH0+4B5FPGCRcTOyU5ybMgFltdaEr9h3VqlxJiiUnhvtW0c1WNvj2aE3IfCexPXBjUEO2K9v10tmOS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310882; c=relaxed/simple;
	bh=UfsJfKuIY3PfTumtoxik1Ea0qW7eIN7BDbe4vNZ5QTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tv5X4Jgga9HmWo9on+YdNtyv/HhsezTSH6IqoJ5QONMP1IwlNYo64XmEzoaUUcG+16App2NHssVZnqY6+TwGlr63eCKzDchiYG8Si7qjGb8UhVzVXEEF8ChSOuiMObiXJn6/IwkjAFV/Rf/c4UPY9uP4pAWZ8cdmTxYy572ZaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MtgWjhaE; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MtgWjhaE"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8323b555ae2so187681639f.2
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728310880; x=1728915680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VC79KI09BOMVnLp6M0LTx88kNLWiyUtWHxQNIXByZpQ=;
        b=MtgWjhaERUwLDazYZf9528GmKtNqaM74AtUHFvKZ39vdbncKWTGJ0AFR2VDIdKxoVh
         RnodvXuezB7aszBDqAGrlgflE9RhdSc0WEqSjhya5a1MZKrNJC9dWmyFVhU7OaScDFuz
         2PFc8KTjaZSa+oCVrs1tbrKJL1jyUJ//241BFvY6tGu/pAuYm4ZBE6JqR97J8JYUn2F7
         0WMABHEDTPaz1m6PeGAeGxDdRgqsUhFG2wE6L7HtP6euDwOou/wQM4YTUGFEL+azeKBD
         jLR5IyM/QYDf/4q4O0Kb+Nz8xRDu2U2Tq+PEtP27ihypBmWPXrtPCoBkQnh3o1ZOQH4W
         g3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310880; x=1728915680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VC79KI09BOMVnLp6M0LTx88kNLWiyUtWHxQNIXByZpQ=;
        b=ZZ9N7t8aXjXDRl82eFVPlAZXu1K/GTYN0WXhb5NURMb/Jp7vMlPIWv9xdT+pOBhotH
         +u0c/PDvOeR1Ddx2w0144jG7zbCHf3sZalZeQ1dvQbcKb5efQmXYZBDV+ASga1LZwCfp
         l2ukSS+hmQDElZHIyB0h8VGwP72ShaMWqmrGiwghAQ6+/DlSmpcg60kKzETHg+oT8gvv
         34yXDqkeqse9plz2oLulDOJIXjKzNJeBC8nj4Nzr83h/XnvNMfQyEb+JkKEFK8qKTAzU
         smGAJKS32XfXWQnKmgz3OzQzlwbjTxIF/6bdfc+LZHcrTJAU/Y43iqVYcDb5bCEDh3zg
         MVxg==
X-Forwarded-Encrypted: i=1; AJvYcCV+nJZ2/aWQhFqzFkdaI7JpIGKuRb8dHJh1CD8dMk+Xcy5vP5ee2pG7AwtDSLPox21hdyjmxeon3qJ4Jg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8xYbhD8xfV2qlxM5+zIQKTnDVFkNZPY/cx94HuGJFK7fUukrW
	TXcymVL5C8uD3TPemCGoDx/RzO7oFQv1x2Hjdw6stswcUd/rFfj09NovpEWWJZg=
X-Google-Smtp-Source: AGHT+IGEdNw9YxcVJEbUjcPKtzj9rWUNLLjJTyJuMad09+Ov0EAZ2JIxxAkjp223AAfsDuP15ylO7Q==
X-Received: by 2002:a05:6602:6010:b0:82a:4490:692a with SMTP id ca18e2360f4ac-834f7cb0918mr1196787639f.7.1728310879744;
        Mon, 07 Oct 2024 07:21:19 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6eb569cfsm1182684173.67.2024.10.07.07.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:21:19 -0700 (PDT)
Message-ID: <5995b8d7-a94a-4c5d-8bf6-e19998c0ac72@kernel.dk>
Date: Mon, 7 Oct 2024 08:21:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10] block, bfq: remove useless checking in
 bfq_put_queue()
To: George Rurikov <g.ryurikov@securitycode.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Yu Kuai <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
References: <20241007140709.1762881-1-g.ryurikov@securitycode.ru>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241007140709.1762881-1-g.ryurikov@securitycode.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 8:07 AM, George Rurikov wrote:
> From: George Ryurikov <g.ryurikov@securitycode.ru>
> 
> From: Yu Kuai <yukuai3@huawei.com>
> 
> commit 1e3cc2125d7cc7d492b2e6e52d09c1e17ba573c3
> 
> 'bfqq->bfqd' is ensured to set in bfq_init_queue(), and it will never
> change afterwards.

No point pushing this to stable, so no from here.

-- 
Jens Axboe


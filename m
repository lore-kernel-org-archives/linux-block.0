Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5519CC2F
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963713; cv=none; b=j61vMJnOr68T6s6xk3zGUsiJfABDOJPsNKyEu4reicftIq1dLpBjmy+ddG4hbqwpYQS/hZW6p4gx5oK9ArV0nvE+gvIU5oGpIe0kytbha/gQFQNBkvDUXt/33RzFz+joSD6Ly84p7PjKRptcrfUAsDHTmpenJZxtStD3COyd3dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963713; c=relaxed/simple;
	bh=bOmE3YcpZK/3CXAhmu0t3twv25X7t3k2uHa2c2EcvVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3xjPz2Gg8cBtn1uXbhinpdL9H7cPyleTGI2+t0JybZwovEOYnE6xIbqtPoqRvNOWmlATBz2p/gHdpP55XEOB6nrXYWhzGEw/POBmCp3Ujs2FGFq0ahl8CNQTh6DKRYqLxhh7nfmhaDuFJfGrQ2U1h62Wj7hp1xBhMHASwISAl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EtJGQF6S; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EtJGQF6S"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e3bfa1f25fso82932b6e.0
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727963708; x=1728568508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bOmE3YcpZK/3CXAhmu0t3twv25X7t3k2uHa2c2EcvVM=;
        b=EtJGQF6Sa8p2xmhGkv908Q3JnRNtIheWO0cb7plaZMlGSjJKBqScOTDe31L01073f1
         /1jDR0wHV6bJigRO1C8eweIGHkuvBzhdO8BlpR0US292+dLizkLooj9+5KP7/+ieRIG2
         wmFCOkm0TDfPoU9qwOx1wa35LwL5E3a7BeDcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727963708; x=1728568508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOmE3YcpZK/3CXAhmu0t3twv25X7t3k2uHa2c2EcvVM=;
        b=lyDrzTPuu9/7iOu4pIHnNLKSm+XMlj7SOy0tWLaMD7h13T8TEV6BjQ+MKtEVFRF1hm
         Zn+VZj5co0u5JuWQK69bTdpScNbm2c0hGQg5fIYGbVKzinGbF3vnXX9ZJ/+93Dhmxv0v
         FpfrkG8AQeKExRs9ChMZD6RahNpTwWHmFv72Eiy9/8a4+xadKHItPKNF8eIYMajfBNPf
         dDgQ9KfGgd5n3Lc86C46yfACVQwgo7izW4qVeZlnM6FuxaT3NX9qoRtXrD19wv1gi9uM
         iCZ6Du41Jmm1vzQMOTA1SWqgtgKl7dkslbRC8pyvLaYRNOgkJ2MH2At17NHTpF7S9Fi2
         H0tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUN1k5j5YBI2iJHvAorrYNcq5zFNQaepcmFdv4GiZ4+B3nxveY2tHOhvzO3EZ39mdqsAxrpqCgA0WJOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyadejo2QeqfgL1Xm0+u93YuOMznGKFHmQnCvKlJQjuHtlHMnxV
	H8vk7XYgN+FCEXaudRlMxHqZu00D80GE8V2DfHJR93WDYAf0mlMNV3B53c9+oA==
X-Google-Smtp-Source: AGHT+IF1DAiVNaSsERkm9AvX26sdN3J2w5PQD88DZTRv7R0i1VKCdY1954ULkFYZrMw2Gm+661PEyQ==
X-Received: by 2002:a54:4d04:0:b0:3e2:967b:ea8f with SMTP id 5614622812f47-3e3b41071acmr3991469b6e.21.1727963708369;
        Thu, 03 Oct 2024 06:55:08 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:6c:4e9b:4272:1036])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dcb4d31bsm750099a12.57.2024.10.03.06.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:55:08 -0700 (PDT)
Date: Thu, 3 Oct 2024 22:55:04 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <20241003135504.GL11458@google.com>
References: <20241003085610.GK11458@google.com>
 <Zv6d1Iy18wKvliLm@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv6d1Iy18wKvliLm@infradead.org>

On (24/10/03 06:36), Christoph Hellwig wrote:
> What kernel version did you see this on?

6.6

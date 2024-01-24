Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18C0823CF
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117242; cv=none; b=Af4Btv355z84eCss6cpcfc5q2K769eyEKrVZfCtPwVM76k0UX7z00KFcmsT+pN9bagGQ+wBxWLWxAck7kVVDm2m5r+Q1tEysBUVf1qHGK+m7Gor/piGDibewKaY/ZUKvYqx+ikqLY9AEBBwSEGLAoaPas+01kAwbuI1fKWNqf8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117242; c=relaxed/simple;
	bh=1mhXeLAdBX8QDenhPYmvC2e5vnGySSKKYdUgYaxk1u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/P8fA95C9xjGdJIq/m7NMGK4GerKRxu7Y6rNqSjdLE8Yas/AONqPW5KXoREXv6OgHxG4hf0NwtOXa7E2+Y01ZNrYj1nHfdiKGQ3bqzUDTj28jvBn1i3Td9u9qgGSJr9v1EKSJNlRcWksXOFqjVMI81bRNoLoT9Ge0wjGLLkihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xbRAE14t; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xbRAE14t"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bee01886baso73204039f.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706117239; x=1706722039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ousL4DJ8RFPz94d8bohiemkBr/QGzt7CiOfhlR7o3g4=;
        b=xbRAE14tdrh4uSnFRGUpuRHXUFbUJdr+uuDKF0EHLC2xJVyMCScAFpXB9w9wcd4X7F
         LOdg4NEpCzVLkISMrLwFA9IyERDorLfLIwpeqMQ0sGzcdtMdFEffkNId6mYq1CynMTl1
         guJYcHfW17HWDCBVIp/22o40xaR/dp8RDmVt0mwZjIP+z6q48/2VcqKHbScdQG/k0iip
         TnIAXcYrCl4eK/+MIpNYKRbckKKZij+I5qGipD6qyo6hbEQLjhYsQlR3xMr3RCP8mVyn
         ZFN69CGDs9GT7mgnjZiJZvhDXOQe8ndyEoXXYrU2hg3rze2EX6F9qcpAyj1m5bP55JRq
         VKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706117239; x=1706722039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ousL4DJ8RFPz94d8bohiemkBr/QGzt7CiOfhlR7o3g4=;
        b=ir2aYmx8w4h3XqJYYloFb7d7KB/poMRzwdxISNKs6diSFaEmBLDaVPO0bmzzMCpBti
         z2Ga3g+3KZIiFnwCnIPcd/qey+IypFUtvzZBkU80sACGIo9DsHmDmv5KiT1BKZbY/uCA
         3TiJR6hXLehBo6qVceGqppmgGODsDGjP/xvTNkQ4wbZmWnqwV1goQep+KkPNMhkmzT/v
         QUEOPjfM58K6r8hOWrBPmVcHWiESxDX7bnWpHrOQI5srONPVAoPr5bl0Bw/vAZmF2Xnj
         RHdwE8u3Uc4Ej0Q035pyBfuNoEyLZeTG7a+tDSc2bFa4CnYApJ7tQQYYGh69Q36fmKcE
         NHIA==
X-Gm-Message-State: AOJu0YwbPBAeSm+IgBBnnEN+9E4oFlHGL/bqekjJ0l43Y+5scbAGwcgY
	xABqgpN9baAAXp+yIAhYy/0UjH8lhVZhYXZ3b4VjcS2te/DGjawUDZ4LO9HGqYQ=
X-Google-Smtp-Source: AGHT+IH9zTzzWV3Lgq2ZcizbHBX6PHRYKPybEcKsEF8GWRdr5qfB17Unp6xeliA7+LpbAotosUFlAw==
X-Received: by 2002:a05:6e02:1be8:b0:361:9b07:be with SMTP id y8-20020a056e021be800b003619b0700bemr14849324ilv.0.1706117238822;
        Wed, 24 Jan 2024 09:27:18 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g9-20020a056e021a2900b003627b32dcbdsm2459074ile.37.2024.01.24.09.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 09:27:17 -0800 (PST)
Message-ID: <48299596-c92f-4730-a98f-d945ce1f2e7f@kernel.dk>
Date: Wed, 24 Jan 2024 10:27:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: clean up blk_mq_submit_bio
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20240124092658.2258309-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240124092658.2258309-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 2:26 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series tries to make the cached rq handling in blk_mq_submit_bio
> a little less messy and better documented.  Let me know what you think.

Looks good to me!

-- 
Jens Axboe


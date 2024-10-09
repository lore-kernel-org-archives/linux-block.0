Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69829126C0F
	for <linux-block@vger.kernel.org>; Wed,  9 Oct 2024 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481795; cv=none; b=megmOfxZfFBpfZ8FEAoKGtA5BC5tmSI1pWaypZrL4NJJ67rxqfA1ih7TDgxqR35TeMltC3+CdAaxt7xZfuk9Dfsj/yr7T+o8qCWdP4A6uSD3KYHODy5FNDBj/9DsN1IKDsqk+nOBeAuJlAdwfiCNqFeBB5IhUP61f1Dczv3RYs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481795; c=relaxed/simple;
	bh=VE6E3ethquF8BF3+N8dwUzTWcMadHAiIMpcmWbTroCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vf6vOzzrGkZHPZKJUlALgx099Upa5xvBXynUdzYv4PTGeUuslynAJ6+yrmG7YT6AwzwazLCneFR5m6X2T7fvRIUQ16FUwb4qxU3fQ3KuImy2oFPKSVEOaW4FxcGYY+B1XnY6rEkDN34aeccxCGF4jrLmkRLitNErRHC9NEzSvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wfKO14Vc; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wfKO14Vc"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8323b555ae2so292702639f.2
        for <linux-block@vger.kernel.org>; Wed, 09 Oct 2024 06:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728481791; x=1729086591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyf+TeeqENaLGjushgj4CkyUJ1Og8eh7H+0klpu40hI=;
        b=wfKO14VcH9WTylapdvhexXtATRib9X+zL4iRcV6OqQ0s+eQcJpN0ODPKsos1CYNrMf
         yALJptEqp34loZvbruF3Dn60mvJ/oz/yu2K+ol4SgOJDMZ3f3XcCm5d50CGHr+lQK8P2
         +aVDqBkhLIWg9cq0LaDvmH1IQmPW+8CCxVWLpDf8j1+5GXSOscV7xhY18bnDXpnF3v7M
         hcy1XCcIjMAS+nDogf9dq9CQ+VYgC1yqelPJ74iAlQ6Q0cFBz2sCnrDH8i4/ImjmTPQ7
         uQvpcc/ZI6rRiOJpDxKs97ykEFxsaSyX+EbLa0m2RaIsgCqJjQ3DIGLNjkAtQ/VlEWJy
         tIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728481791; x=1729086591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fyf+TeeqENaLGjushgj4CkyUJ1Og8eh7H+0klpu40hI=;
        b=fMcCuG/5KWcrW4RKFdA5bGSWT2sFnxxaMNG756Z2IWnLicQzkI5qMC1djBvR1RjJCs
         l/PxBcU+ZsD5rQNS9CqnC7njq4kyvXa31zdPvVrXhn7w1rBoqRaeNgz1OcdwDnZPNuem
         m7LZrJMhf7cblmagGpj5Y5z+fi0b4rfWvK2Ym8aaNbV883/YLFaNgRhuJ3D+7ZqXA/7+
         zOp8UO2v22EphVt10Xe8IsqFmvyteYJLcY2UoCf7WUWESBgC49H+WS83R6A3W6H3reFD
         oXX2Z34yyDqjpnYUnWzPgYtAT1FmxtGXRvjYN8MmgNe4GowKLY+Sbmq46rOdUG8oq2PE
         rdig==
X-Forwarded-Encrypted: i=1; AJvYcCX84zeVTNc5yX6Bw2HDxwPfWfPdHfKCPpAOHQpcxTm9N6W6uvQob3y3Ob8U1XZasDvnuF6H+EGWV42fqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdVl+Z2Bk8GYvAaY0niX4fLkFFJLgkcEy4Xi6oIUbq6f4OXUc
	3dulJqGpWmxXa7ujZ4lbWk2fCm7dWHek9tgAw5ihols18ZKC8SQHgg6RT3CjKincfPcB/0ZkhyC
	DLHQ=
X-Google-Smtp-Source: AGHT+IFR8YX7tjuzxJabSAFvoaA40ci5R7c3N3UaaVo2uS3lIw6hBhtyshxvIgp/4QS44IRnrym9eg==
X-Received: by 2002:a05:6602:3426:b0:82a:a998:ebab with SMTP id ca18e2360f4ac-8353d4fe3c9mr231092239f.11.1728481791466;
        Wed, 09 Oct 2024 06:49:51 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dba90f4166sm43695173.159.2024.10.09.06.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 06:49:50 -0700 (PDT)
Message-ID: <07e306a9-db8b-40c7-834a-ec9831940b78@kernel.dk>
Date: Wed, 9 Oct 2024 07:49:49 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
To: Christoph Hellwig <hch@lst.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-2-hch@lst.de> <20241009123123.GD565009@google.com>
 <20241009124137.GA21408@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241009124137.GA21408@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 6:41 AM, Christoph Hellwig wrote:
>> // A silly nit: it seems the code uses blk_queue_flag_set() and
>> // blk_queue_flag_clear() helpers, but there is no queue_flag_test(),
>> // I don't know what if the preference here - stick to queue_flag
>> // helpers, or is it ok to mix them.
> 
> Yeah.  I looked into a test_and_set wrapper, but then saw how pointless
> the existing wrappers are.  So for now this just open codes it, and
> once we're done with the fixes I plan to just send a patch to remove
> the wrappers entirely.

Agree, but that's because you didn't do it back when you changed them to
be just set/clear bit operations ;-). They should definitely just go
away now.

-- 
Jens Axboe

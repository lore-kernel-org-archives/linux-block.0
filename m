Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36315201273
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905684; cv=none; b=qfPY31PgWkX1toxbyqpjXuqdtiXw5jRHqTJmmos9fbC8RA5TQaSVYDVdq+FNxxmw6jv+IwebQ4RJx9VSjZ9gX8MZcnzlNeWv3S+04W4ij4O5A4Fk65c/vzZNIuaohG3QkfVyBF63eVvwlCLXORc/EkAmYdiZAgZ4jPb98ArXGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905684; c=relaxed/simple;
	bh=vdLAz1IinJz+0iRckOt1TyiyBF+HrXN7qNLkRIYqB5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2TwFdv8M471GkFK7zJ+xBd/ZrfoflhSILtOKv5JnnsnUsWm2Oh/B/hqwi+P0WhvWnLykWPagF+6aMyxCFp+3aN3d1DlYQDrHQRvWP61Jv+JNIaYrXN6wrzd6HQycLKt0YodNLj37vUs9bsoj8UquutNCiW1rspUu+xGur55iSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NBOAWqv8; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NBOAWqv8"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-83ab694ebe5so260271239f.0
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2024 07:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730905681; x=1731510481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHsExB+1JzBfhLG8VKbByJMpSayH48lldkdC4B5gvfQ=;
        b=NBOAWqv8VvPq+7+7IeBWf0rHkdLN6UrZ6BCdYWzPUqAxH2P1jY9Hm1wDvX7arHLrh4
         LJNsVZNAu2do/LEvq5JgyuMy9xrWZbyULZ/IBNfNheCvM3NlYTkBHaZPhMzRE+hgpbQw
         yl0+dH30Xs2i1m2GU0+VI0HXG4PepW0lKnf17iW1MUtYvCZeGU5u1wj6OrCVCcXEKMn3
         aTMpTK/tA5hjWPKxd+n56LuTp2l2j/YSw++OEz0GGpZRQ9TrFu5lWegIE9XsjlTQF+Jg
         ag4qCK6om9e1epoF7IKcpago4PPyQMvd4WVSmPmf/Cl0kdhqV0v4lND8b6trxaeMXil8
         nxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730905681; x=1731510481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHsExB+1JzBfhLG8VKbByJMpSayH48lldkdC4B5gvfQ=;
        b=nFrvx5do0wxiN1IT+HcDIBya/kO5sBMaUu4YvVd6mxq2C9vUoeQ3t7p7VsgPZA+QC8
         wInRXNJUoFUJx6p4ai/h3v/Pcy52VUHK7ZeZxNXnD9D7/perFmiQZh0UTFc7if1SzdKo
         QltcL/hFHvpcGRWDR7yujG9yDngImPKtub6hvH1Dr/1/Y+7H5iSS+yvBW+Bm93BuibQY
         IWtAhqf1vJyYBCpceUHUCYgdYLRPVeErXxqvpXMAc9QA4symnqH7BExZqyogQwLPOmJz
         KlHsoiqJVNyJbQZ/FnD8W9VXCRIWzFwW0UYCuJcwvcMFQnFu0PkJd/7AMWh/SEji453N
         +FNg==
X-Gm-Message-State: AOJu0YxFxZq5jysWSYWxFi2TqM3lgGvrTXTjI3UWKoxPjdfsgF56ijSN
	1JFtqnV0KnyYImoPe3aAT0pFHYH3DncLQPm5HTrcHBszuX46qeCWvOWZPxlKEsg=
X-Google-Smtp-Source: AGHT+IG6GdNxJPDRJCmGTOZeetX9a2jEZTw1EHq4ee/Atv0LYpYLmNOmWLhoyqaYUPjpZEKtGMLiFQ==
X-Received: by 2002:a05:6602:6420:b0:83a:c4e1:7d69 with SMTP id ca18e2360f4ac-83b1c3b78c2mr3998925939f.1.1730905681218;
        Wed, 06 Nov 2024 07:08:01 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83b67ccb076sm314495739f.50.2024.11.06.07.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 07:08:00 -0800 (PST)
Message-ID: <0e9d2ee4-13dd-4890-97a7-eafd83b2b840@kernel.dk>
Date: Wed, 6 Nov 2024 08:07:59 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 2/7] io_uring: rename ubuf of io_mapped_buf as start
To: Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>,
 Akilesh Kailash <akailash@google.com>
References: <20241106122659.730712-1-ming.lei@redhat.com>
 <20241106122659.730712-3-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241106122659.730712-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 5:26 AM, Ming Lei wrote:
> ->ubuf of `io_mapped_buf` stores the start address of userspace fixed
> buffer. `io_mapped_buf` will be extended for covering kernel buffer,
> so rename ->ubuf as ->start.

Minor nit, but I'd probably rename it to 'addr' instead.

-- 
Jens Axboe


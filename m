Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98769154C15
	for <linux-block@vger.kernel.org>; Tue,  7 Jan 2025 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235526; cv=none; b=WUgq8N2bdevivNKZovziNBGF3NrIHq/TnI2pWCFwVcbVy2WQ8FWHT6gFxzhlLo9+OiVrLJDz7xh0tqHKGEhERt9oxxt7rxt/u9J9yX+GYrtYbXZRBLHkEHYl+SWoyZsJ3A6vlyPp4avGcx4Rs2QnMBz3TP6UxYnu4hGrMJDcr3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235526; c=relaxed/simple;
	bh=eVJmQfqk+wa5AZU0IhCkNx/9MfMPryn71yEHOV3FSII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj8ye94nFB23GfldxNdhWhOpJBGMoc02FjuW58z34DFCBdC5vMXnhclMVOaoWdAUVHGaB5hGhTxTn2K58xbcEI0WfjveepW5NiGVYlwDJ39SCEfYrjhIBKFoB3G0VTknRKWg/Y1Tu6c88IYKf+0gIjwv96JcyahUCNtxQofwuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K7iamkj3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K7iamkj3"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2164b662090so194612445ad.1
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2025 23:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736235522; x=1736840322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6TpyBIBHhRqCq2NSRZgwqe9hlCBkCrXXo96kF987tg=;
        b=K7iamkj3gTXDw0vIgQVPISht3cQa2rah3gmhdGA9ZPZohcNgMyCQ5xu8U+EuNwMWVn
         fpLvRRXifggqtG1Bat2LoIR2yhnwj8wxQwdWZ1FVCzBrCeU06AMFDcGZQ3idL9uEXi1C
         HNgigDZfT2eqbzg3XDHysb4ftyfzKTvATAesM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736235522; x=1736840322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6TpyBIBHhRqCq2NSRZgwqe9hlCBkCrXXo96kF987tg=;
        b=GzFDfGdUFyVckmyuAktcIibfGUXNowNKX1r4ntUYbh2XP55e+T/ZfcGPPFHoS3cQln
         rW8/TzqKnmelmVGY06DJxvK+1+QQY13tEO8BFlwESYS60kNkSIbIWSAdWgLXClBcwOSE
         9qthjbC6WcQlNkS5k0X3SXmXdchaI3MUES5q07ovOE/pPWQU6Nd1hOA+reKKM5jWoXp6
         8AKeV+5WuaBkxR53gJ6Evvv4T3/YXxObRDoAa9FSUdz+pLXcyygrJw0OfkQGLqy+p2W9
         Zd0bmHklhEFihAU/XJGHRJjEsg5YBZlho/ld5WvBUuxmhu9LkqxnWeEUGCtHBGEnk/mg
         jN4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2n8MO4J0hLcHKEnEKsqxn3qSLo5VrJSTUwEVelbJPqHm5Dd/W3p3gq6JZRc0lVQ6lka1gEyZb9zH+7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YymkGsi6dP82hH4mfRUiw2i3C25ETo04UEaUjGG+W3Omjz3hQlR
	sRTAsLO0UxNCdJ7OKSoUNj6h9iCZUS+3UPpPrthD2EcD6GGrKoI9ZZY8fqYDLw==
X-Gm-Gg: ASbGnctdKOXJY2e3+FiY2f/KZ7/sq2/HRov8iB9BuVHPGxb/rzDRb1cQnVvPuCi7APk
	jC1rgCQEA+M2bUvXFvz9aMLYFI3dHXXESr9iqntTwuVZ3UNOHuVy6UmVYFrU95w2TgLCOHiT7tJ
	EZz/dVN5w2O8bWBCkw54dJQ+awzQ/TqMUqJyU8Si3IvWACn7ob2z1IJQ99FH6pJ95Q0zMQ2suoQ
	uIJi6EQKJMTNFC71SzkqiRPNcborChnHrrcokItI9iFvEzrhjIcj1bafA+V
X-Google-Smtp-Source: AGHT+IFP9fBz3XVX9qDbkVrQfLxKKg2cGiqLB8JwvWr59yDGayoZBFKqHGqMHDY/d4+jdwiBBRO7JQ==
X-Received: by 2002:a05:6a21:33aa:b0:1e5:a0d8:5a33 with SMTP id adf61e73a8af0-1e5e048adb9mr95188628637.18.1736235521892;
        Mon, 06 Jan 2025 23:38:41 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c142:c1e8:32c2:942a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad81582asm32720364b3a.9.2025.01.06.23.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 23:38:41 -0800 (PST)
Date: Tue, 7 Jan 2025 16:38:36 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] zram: fix potential UAF of zram table
Message-ID: <sbdzv6z5sixmj7fr3jmjwxqce3tbbzvshbb7qgumio4jdahn24@jvvadmtindgs>
References: <20250107065446.86928-1-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107065446.86928-1-ryncsn@gmail.com>

On (25/01/07 14:54), Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> If zram_meta_alloc failed early, it frees allocated zram->table without
> setting it NULL. Which will potentially cause zram_meta_free to access
> the table if user reset an failed and uninitialized device.
> 
> Fixes: 74363ec674cb ("zram: fix uninitialized ZRAM not releasing backing device")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by:  Sergey Senozhatsky <senozhatsky@chromium.org>

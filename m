Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2250F2582
	for <linux-block@vger.kernel.org>; Sun,  7 Apr 2024 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712526657; cv=none; b=OMK16rpskgAa6XTt68S2TxVUjEeUMxHdAFRXCFMw75QoXfOtkzfHJTPZ1miX3dsHzqD7F20Olz5Fs5rfbAUWG/gE2GEcg2ocK/4SAgX+axxRfgUR9VZevb/qkVsUR8B1NwGU8SYdK3pLn7wpAtIlqWfZyYZ3cnbbhTjfNLlaqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712526657; c=relaxed/simple;
	bh=q3t9G12KIaNKCxbXbi8mOuohdY//ii+H7EUxPmmcejU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EOAm6mrIcxgSyZit881Rl+CUJ0rPddehNjyXxOIrWp/bG3cGqC625NB8xMQLX3M52qwvoQGwMjaa4rx5C9JPsa4r4swREdBDela4VHhp38VhMryC5RgBDt7KhMR+xhv0x+yHegSRwQkYx2Mu+iveBQmwjf2/u2fNj3zCVOGhJ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dYsbW06l; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dYsbW06l"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c5f468a2faso185130b6e.1
        for <linux-block@vger.kernel.org>; Sun, 07 Apr 2024 14:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712526654; x=1713131454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlCwhNPPrZWfLl+0FlaQUkC3u0caIJHTkEmz2WE3heM=;
        b=dYsbW06lGKfLLe0/qZWWH0XvlDOq7ANCbZf8owiXmDJctylIY+7CaJY8XKY7lb1eNr
         B3aHcCflhY2wnYzgO5zXRZ5z1GuhaMdd2dyrEDmRYpGH5+WJOcRAAOPBZv8TTgo0mhO1
         KwREYlf/30UoSwdwC/AiMvXJPeWh5HfywwrW9w9+fo4JSDSa7ippheOzCEYU6glkg/sc
         8u+vVfWUbZi6tLGchOI2mQ8aJkDM4/RlpizeGV1PivEmjbCAO8LjBfI8hxY1Oaw8Ih01
         qlqD8/w/vJ86LKLFkUOH2S+Kb3SfzjnW9XUwCxCTfBr3w0hD1Bw+qJBoSYvtjgI9qRcV
         iLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712526654; x=1713131454;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlCwhNPPrZWfLl+0FlaQUkC3u0caIJHTkEmz2WE3heM=;
        b=JCF1IxE0pJsWh3qzSwVFBTj7ID82J+far+Uc7+qTOaJAeT4Fxt3OHY5008HRZW9GDP
         GctNY4n1hWiiZ95Q7EriO+pocW26CpRed84Ag3XQ7xLh1zuBexvu8UtP08hsMc37Ldk1
         84acGjHqf/fcFvPMZueR7jHHVqEVr5MCojPVlAXFis3yvM372d1bWWA9EG08TwBhpTDC
         JdJRwFAEY1HzEDZEXuELlsCL8Qe5RJRDOXkZ8iVUFnXWmsBEu56KrLW1Ob11oen0XZ1H
         W9Xy2Z2hr0/i3KZCkWdoEPNnhcaimp+TyX6w3/BOgISHTo/qgM6V5Hqcex4xb29ZVUkj
         1DQA==
X-Gm-Message-State: AOJu0YzPPiXNb+OojEZUytZWiqznL+bG9z1Bq4lJUO01HW1pc9Uv8gp7
	jxCh5q0HdqLjezrDhLerJGLp8c+WmthuFjfaxE5kJObRelg5IZcWxph/ZiUeq4s=
X-Google-Smtp-Source: AGHT+IHSiyRLA5+t0aCs8yEl29UZzKFz89EOC9qaIJHs9OdpZOVnN+X9ITmshMEtMkXM/ACY/JNdRQ==
X-Received: by 2002:a05:6870:968b:b0:22e:6e96:ed41 with SMTP id o11-20020a056870968b00b0022e6e96ed41mr7120476oaq.2.1712526654155;
        Sun, 07 Apr 2024 14:50:54 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id lb8-20020a056638950800b004828d99f6aesm540280jab.43.2024.04.07.14.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 14:50:53 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>
In-Reply-To: <20240407125910.4053377-1-ming.lei@redhat.com>
References: <20240407125910.4053377-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix q->blkg_list corruption during disk rebind
Message-Id: <171252665340.2536241.15987324634129666821.b4-ty@kernel.dk>
Date: Sun, 07 Apr 2024 15:50:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sun, 07 Apr 2024 20:59:10 +0800, Ming Lei wrote:
> Multiple gendisk instances can allocated/added for single request queue
> in case of disk rebind. blkg may still stay in q->blkg_list when calling
> blkcg_init_disk() for rebind, then q->blkg_list becomes corrupted.
> 
> Fix the list corruption issue by:
> 
> - add blkg_init_queue() to initialize q->blkg_list & q->blkcg_mutex only
> - move calling blkg_init_queue() into blk_alloc_queue()
> 
> [...]

Applied, thanks!

[1/1] block: fix q->blkg_list corruption during disk rebind
      commit: 8b8ace080319a866f5dfe9da8e665ae51d971c54

Best regards,
-- 
Jens Axboe




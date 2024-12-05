Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197C1A8F6D
	for <linux-block@vger.kernel.org>; Thu,  5 Dec 2024 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382358; cv=none; b=KLK3UOCzadfwA32/y7lqctjCfazc7Y24E1IbmcFmdySjK/SSK5mkkvV2bwEGnWX/eUs7139JqiNCAb/wYXKOnPzlOSoorfmdySLZHoYdaW/9pMwD0QFlWJ46XKRooyW5iPrv2ThdZ0PfcFCVsnI0D+x7EQRDYN2byG/sYOmPwps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382358; c=relaxed/simple;
	bh=zjJgxmY2y1deqyKR6Stt9PT+fsWAX390mIy9QNV8za8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgDMHcX4k9CD64FBoysOYrjZ84aqaCpVykbAgznwmF/xq8IJ9qKwZ/qMUzIBoQvkuqWJMNlCFT5solP7IEOjlphluwXxsvWu7jk0/Mn9HdBVwhRGRdJg/gDW6FNrhDhEZ5LwKfaMD4KO30n3MQPTpgRYuiMDBMNzGE3Jsdss9zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YsJncUg1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YsJncUg1"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21577f65bdeso4965305ad.0
        for <linux-block@vger.kernel.org>; Wed, 04 Dec 2024 23:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733382357; x=1733987157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pnVjnK/k6GXXnPfVx21d5+g3wu4ThlrDFA24wTktnFw=;
        b=YsJncUg1a1f6U1pWsuQgbpsAxT8+oIrE0rzyWKTp8gT/FSob/b6EzyyycQe0BbTJE9
         ZWlqWhSXG/rlcmo+XyLQ06rTNJlSGO1tOfNG9wAf+fg6tSHr2ZVuuQjL/hQMeGDcC7Yd
         U1FTktsfhLwuAtLKuR6KTRXHYbPcEB0ND0mGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733382357; x=1733987157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnVjnK/k6GXXnPfVx21d5+g3wu4ThlrDFA24wTktnFw=;
        b=hPELWIhqZmU3D+bMd01mZbdHS+Y+azoZVfdG5nCnqTtIz315clvsz7erpZx3b4u24l
         rnKD8q6aexLq07QlY2HsFlUTsl2cLgkrOeOYqx1ZP/jOYQ2jqpGD39UZTWBk3IdUUyNv
         K6h3S0mx+cZsUXXa/vH2LlnasJYxGLeJNtjw2BysP08mSNTVh4UOpjg+wKANSK/wirQq
         5IAPpPZrsvhlysOXu7GAnfTLU76c45ExR+WB6JfS5rcr4f7SbBvkw9a9QuUg8kb/1vX+
         k/4gM5C9W5yqkJIe78+Ii45VtUeGc+XKSmOKaYBaCie0IObRUoKkPhmmV3YYxEmKpXsv
         FzRA==
X-Forwarded-Encrypted: i=1; AJvYcCUZZ8LjCZ6ukdM9VjkIqM4XPNxK2pGKUbbKLdC47M9cIgzIt3llFy5rYrYBiBL0sU5OJjQMC/3q7efgQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzattCPYCZhN0mmcyXPw2h8Snp/DTrLTr8lnPcuQHLBe+w8IHdc
	hXT9F6XiAG29/WCTZ25s11VZYxJMU1rqhl/Pa+0dxRRUgxZcYTTykHChYqbi5yofPtGPMERGNds
	=
X-Gm-Gg: ASbGncvB9q/p65sUbtMkNFj2yr5DeTLd+uwCAdFjQQPRPpH+XSSfkzwSyzpLw33/FYQ
	wGPU1Q8bnrDGSRmTs0WJcmmohWpThSl7P0eIWx6E8xO4Fcg706z9RvXVTlwBII3GqduqGEBzT5C
	5Tf2RS9jrTbWYAY+tzX5Wpbhtn59hgmWsHNDMVujJ6IWj/MtLgKQe6sPVPVLrFREEBE9Pi5OaI9
	o1I4H+EKY07E2oXSSpxkgPD+kxJ09+AYh2ahfEAS7Qng/5GT1HE
X-Google-Smtp-Source: AGHT+IHmb5xrPz+rTcqYtFMLlN13EqPWRM+lusJzh9gyYi0pYOG3cg9tOPzuRPSq4iV6N8E2CP/VqA==
X-Received: by 2002:a17:902:dace:b0:215:65c2:f3f2 with SMTP id d9443c01a7336-215f3c56e3emr34471825ad.6.1733382356790;
        Wed, 04 Dec 2024 23:05:56 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:84f:5a2a:8b5d:f44f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9dafsm5958855ad.120.2024.12.04.23.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:05:56 -0800 (PST)
Date: Thu, 5 Dec 2024 16:05:52 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Desheng Wu <deshengwu@tencent.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: refuse to use zero sized block device as
 backing device
Message-ID: <20241205070552.GE16709@google.com>
References: <20241204180224.31069-1-ryncsn@gmail.com>
 <20241204180224.31069-2-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204180224.31069-2-ryncsn@gmail.com>

On (24/12/05 02:02), Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Setting a zero sized block device as backing device is pointless, and
> one can easily create a recursive loop by setting the uninitialized
> ZRAM device itself as its own backing device by (zram0 is uninitialized):
> 
>     echo /dev/zram0 > /sys/block/zram0/backing_dev
> 
> It's definitely a wrong config, and the module will pin itself,
> kernel should refuse doing so in the first place.
> 
> By refusing to use zero sized device we avoided misuse cases
> including this one above.
> 
> Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
> Reported-by: Desheng Wu <deshengwu@tencent.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

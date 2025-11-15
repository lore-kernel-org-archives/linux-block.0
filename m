Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17578EAE7
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 03:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763178140; cv=none; b=meTbqn/8qJXyarmeUpdnVvmPupAFjnC7jSETDpq7R58SJJVNyEAGkcoGzfiuAid2rpcMSLA8pbHuTRr0G+iyTWqsi7Y7Y/gFLX/2QVU6MTcFjAYPXSPywOiMVE0N2yWXIr+u4hzdiHiqz5DyS0yt6fcapZTfN47TQI7zZ60XT/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763178140; c=relaxed/simple;
	bh=8fbJMn3a2CnI53IMpCv6vTPvdaCVUb+Qvl+uByHlSSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPDXApZB2lnjiLx45On635FaANZXfwZATVwH/3Nu67mFAPcyH7nKvR4QeL+h/DHYycnW5Ng/OoHc8pZCbQ5Qnx4rZPBxuv8qCH47REFwCPR8ahAuB13xir5qtSeu7DwI5KdOtkNOnw2jNkWomk4hA6TCAh6wK+lnT3IZeokK3dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GsoXXtt6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GsoXXtt6"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2964d616df7so35575745ad.3
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 19:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763178138; x=1763782938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Af+nXEWtEaAxNcvRVetKdQJrBk2sAifaziyN+YLmfE=;
        b=GsoXXtt6BvTB3Ar00m4qBbyDLcngTl8SKHtDawjwLm3xFKx8mhLAqrjA0gewye9FiV
         UNKHXBmHBOXbr6xgXk2qQcoOriZQNI67FXTbxeE4zBuvm/N0E6/fEX85nVuF3a+6C/a8
         aZmu+Gd4VEzj+CLbVBwQoVRT2j4vzgLUNGJjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763178138; x=1763782938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Af+nXEWtEaAxNcvRVetKdQJrBk2sAifaziyN+YLmfE=;
        b=IIuOAYXlv3Cj2NHm9EqLvqOARFkHkHGVJ2ZMNwzCiD06xk12NaQSkMwXqQ/7jnKXVD
         P7oukhzpRSdnyx3qdJ5rOe33Zv1zzgtO2rPEii+Uj3z9xRpi3/sLYflxXK2AhURRt+o6
         2Qn7r8Ta8JYIlVKMGtEaYm1tUftylMm3eU5433AFmKpLKNXA00YhPLsEBWVlSyaj2Abw
         RYFN9chrbUmaYUFs0prNM6uYYddNGsxSFNioWDeJnx3IDbso/SvFtLRbTouUB6oZiEgM
         86I5MnCFexj3uVlkkRwPqKlJYbNEyMnV71WvkuxWa7uCDuLjKXenmFjFMndqv+zZmDQI
         Bv7g==
X-Forwarded-Encrypted: i=1; AJvYcCXZu55XAgUwHM+G57rXt4Y3hzuKfcpISEZgFMbgW9AlWCRsMl0sUz8sr8gDF57C8B82Gw2Nj1W415QqaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywav4M/AYsDD1JAwcrlkUNF7HPStSIgFLSchluErXxyfdyz6zqS
	Mm4eO0gOmXm8SN9BnTp0kYX1H3YuwzwfwRLR5BiiYCFYqYVbUoPZ7A7CG3829z9Www==
X-Gm-Gg: ASbGncuiS8wJRJLmOUMioLhLDIWknjgWpqgKKOFxDNVddXz3VUx5Ccru6apLfkG/knW
	tRt5YGh5bsWvTcAA+2RFayyz8d1yuL7Bj0IA9o8YQpvHpuSKfpTqwtcmylNrnEO1BtD8npUo0jL
	oLSeA671Viqu9b+QFscxQ7+SBLg1zCYuq/J9f8J97qZMtPVd2n2O/kEy366c6ZomzB+Wddzk0aA
	GnCq7GaaEgYZA2/NC34Wdamxjlb11IinAlezS3LCjb0VlrVAcTgzDZQjCfYZN4s57wlIggeKAQF
	2/KAmtJzBgN8ZzQc7Kay55FnKHYRlYtQ010asSt5Kph3+cAJYJXIp12gcCgswzluTEiEnQ04PsX
	EGtuActHYL+4kKZUm04aWvx1rTaTTwSXUqsHoOsnZhcx2EjJPjduuU0gZPYJrQo4cY26HeY4X7P
	k3tMGdbBNAUSkIWOA=
X-Google-Smtp-Source: AGHT+IHF1HltwLwMqhbQxQs+gAn1RIWFWael5BuA17en31fTdcRQ390Bt7bG4aTQ2UBh7dpIUKY4Mw==
X-Received: by 2002:a17:903:1a2f:b0:298:2afa:796d with SMTP id d9443c01a7336-2986a76bcefmr57326565ad.61.1763178138476;
        Fri, 14 Nov 2025 19:42:18 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b069:973b:b865:16a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245da0sm69774885ad.26.2025.11.14.19.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 19:42:17 -0800 (PST)
Date: Sat, 15 Nov 2025 12:42:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuwen Chen <ywen.chen@foxmail.com>, 
	Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCHv2 1/4] zram: introduce writeback bio batching support
Message-ID: <rt5rjjjypqv7b3syrey4bb3rqmoewvpudt44sacaarzvfvrss7@vtn77o3upvha>
References: <20251113085402.1811522-1-senozhatsky@chromium.org>
 <20251113085402.1811522-2-senozhatsky@chromium.org>
 <aRZttTsRG1cZoovl@google.com>
 <rjowf2hdk7pkmqpslj6jaqm6y4mhvr726dxpjyz7jtcjixv3hi@jyah654foky4>
 <aRd_m00a6AcVtDh0@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRd_m00a6AcVtDh0@google.com>

On (25/11/14 11:14), Minchan Kim wrote:
[..]
> First, this writeback_store path is not critical path. Typical usecase
> is trigger the writeback store on system idle time to save zram memory.

One thing to note here, is that this is likely the case for embedded devices
(smartphones, laptops, etc), where zram is often used as swap device.
However, on servers (or desktops), zram can be used as a general purpose
block device, and writeback can be executed under very different conditions
there.  Writeback is guaranteed to save memory, while on servers there
might be no "idle time", so I can see scenarios when writeback is executed
under load.

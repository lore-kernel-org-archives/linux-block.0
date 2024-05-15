Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2423776
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791798; cv=none; b=QSkiIbi5trggeIYK8C4Cod1VolzmmST5Db+GbQYzlxO9wzXW8ikl7Z0xs9VNzcGYByycZW15/7YRLRaouaZ0YSkTLUTN6X9b7nDnXIdxxwc++FkimlKNByhTDppPTTtO5oW94rgYz89lavKoewv7ChqhnVvUgszSvttw7aH8UZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791798; c=relaxed/simple;
	bh=laEdVHACIJMQScujzTPMp+fHxj2bXDAoqux4V2IQapE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUiF8xvJc9/F7fWXGVE7pNBSk0+YpnNAvo/80NqC8U5L4cPoYT0AmeJV6ATbB7FviERCiCtQqj4KLUTy23rZ3OjaDRHnOlcqDV8FTb9DmgXfH9S7p5mcU4f9vfrxq/CCbqWOU+B4oX5eKFze5p1AyI3bYg6P2PCdx11RmRwJPdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2T2H/u3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2T2H/u3"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f4d6b7168eso4012263b3a.2
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 09:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715791796; x=1716396596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jv5iSW1qFScqGCvRObqnjsWaDgHlyK8fXr0JLPQdhOY=;
        b=i2T2H/u3LB3HoT+g/c/bcbZg//vAuQhG35QlAbZw2pISFV9M5FwqE/r/cWqhHN5z9H
         zmJWuYfNZl3VZCoiaI8oGDpkK1vORvRyj6SjFFy+LYnOxCkIeG6P9+qm5JNfE1LLD8Dv
         vFyjTRftBuNalT8Hq1y6OdhyIeF9z18klEvbmQpom/uzOgO0NMB27kZ2+Iu4JGzn+RR7
         W9WRqGKXXaAx5HVq6Yf4MAjxgS4Zm/VbFgDeqjGC7LF9fdaLW/bvNaLy9T4gX5lOxMvc
         FVKLAeWct79DXr+yq3o7XjrkCaE/aMca6HTbNRvataWsGNfR4tCQblPW7av/WKaFWwX3
         VRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715791796; x=1716396596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jv5iSW1qFScqGCvRObqnjsWaDgHlyK8fXr0JLPQdhOY=;
        b=MXSzF+j0SsrfzCNGaPs+lVTwH6HwOFai5vMChmnuFpEl0sxgR4n7UWbHqQ/3ltfy0Y
         hnmx8PbCJZ87V6wa4fl8v79z6K1VBg3PZGhOj72XAo0Yt/2Flh4p7E2sPnnCCAN2yBKr
         ta67xnp6iq+YeosR91uwAOFkcZUWCM1fJFWzRqKY2eUBSnFrgZFSk4GEpST1BhnGczE9
         dqFkeb4fb+DlWlUw0B5cpwPYOArSZt37nwCseZHgwps2jAhxUQJYpYN1wwnv/g7vPOFO
         gDUQGWsschA6IUBEhLTVNnxzqgCsxGaPvNAd+2u7qHyb20KMiN+1PxRc0kMt3R1/JdEq
         UOsA==
X-Forwarded-Encrypted: i=1; AJvYcCUqDfdznJmN1MPbwMDwYASFF7w/dG4e8Jpq88n9EGiOdbN4uvkU1pj5hZ5GVJwdkny/bzuT2g47ryA2Hy5Ii+fUCGL53reE2KamE0c=
X-Gm-Message-State: AOJu0YxPHFQppj5V6YwNFgzYIpDoMBAk9w2OaaMc7e2iLdsyAb+nPAEf
	j0kw9zVTbn7dmxySEJ4bYI5RsdbuzwYHFi+jpzT6g402kCj58xlM
X-Google-Smtp-Source: AGHT+IHOo0zftAHZUWdHr8s/khtZDHqaC2sEnJz4XpkZkiowBpq1csxHW0VRfbhsJHmg08AZKpk7gQ==
X-Received: by 2002:a05:6a21:1aa:b0:1af:cd45:598b with SMTP id adf61e73a8af0-1afde10f2c3mr17773132637.34.1715791796329;
        Wed, 15 May 2024 09:49:56 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-658c79ca62dsm2774a12.92.2024.05.15.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 09:49:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 15 May 2024 06:49:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Waiman Long <longman@redhat.com>, Jay Shin <jaeshin@redhat.com>
Subject: Re: [PATCH 1/2] blk-cgroup: fix list corruption from resetting io
 stat
Message-ID: <ZkTnsu3gfxCJEnd6@slm.duckdns.org>
References: <20240515013157.443672-1-ming.lei@redhat.com>
 <20240515013157.443672-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515013157.443672-2-ming.lei@redhat.com>

On Wed, May 15, 2024 at 09:31:56AM +0800, Ming Lei wrote:
> Since commit 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()"),
> each iostat instance is added to blkcg percpu list, so blkcg_reset_stats()
> can't reset the stat instance by memset(), otherwise the llist may be
> corrupted.
> 
> Fix the issue by only resetting the counter part.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Jay Shin <jaeshin@redhat.com>
> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

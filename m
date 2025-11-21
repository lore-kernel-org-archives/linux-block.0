Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B1D4964F;
	Fri, 21 Nov 2025 01:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763687860; cv=none; b=JiZq1KlKwW/jBO94psGfaoTe0q0QZ1yhUK6bDo9VMyz3fb16Y8rdbkydTQskN1tCAf3yweHL/qXY9xaEBSDV+quaT/zm5OF5iQRZRBd51UmlHIrEdsorlsAiIYHK5Awv3E8r/J5yYOuQNAXel5yj9QH3mCy2/iHVa+puIlRGHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763687860; c=relaxed/simple;
	bh=ZT6q0M63/4cXHdV+BClRzPOJA/u0+wdnrOMc5HYUXIw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lafpNZBve87+uxPIXcT8ui+kDJVwEhFETLcm3evj9JkBgIZkcKuZs7vaqyF+Vyy2gHNa3jSa6V8EDth8/I0684dpbm952WzUh7I8KhskKz7etSm/oJ58zpThEiayMrgWp+uV5arxpMbR6/+fOFgC8e5/IXnKsKNTII6v9kIKubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Cowy9MsB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Cowy9MsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B856C4CEF1;
	Fri, 21 Nov 2025 01:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763687859;
	bh=ZT6q0M63/4cXHdV+BClRzPOJA/u0+wdnrOMc5HYUXIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cowy9MsBY3XZQQ1HS6JF8Te3k7jLI7mAAtVWJHKLH7sU5r8T7sHapjoFGr8TgJGdi
	 yWCas/O3bmgijmoco3s2D2Kg/fLcA/crWp4RBM9gmBFBeyxeJn6z+TEQKuU95dr0wH
	 nZXfIF3ABlJnTwV7lSgzMRlWv1z2ekjrnzK39HuA=
Date: Thu, 20 Nov 2025 17:17:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Yuwen Chen <ywen.chen@foxmail.com>,
 Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>,
 Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [PATCHv4 2/6] zram: add writeback batch size device attr
Message-Id: <20251120171738.84516c55e4aaeea0bf3b7725@linux-foundation.org>
In-Reply-To: <20251118073000.1928107-3-senozhatsky@chromium.org>
References: <20251118073000.1928107-1-senozhatsky@chromium.org>
	<20251118073000.1928107-3-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 16:29:56 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> Introduce writeback_batch_size device attribute so that
> the maximum number of in-flight writeback bio requests
> can be configured at run-time per-device.  This essentially
> enables batched bio writeback.
> 
> ...
>
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -588,6 +588,42 @@ static ssize_t writeback_limit_show(struct device *dev,
>  	return sysfs_emit(buf, "%llu\n", val);
>  }
>  
> +static ssize_t writeback_batch_size_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t len)
> +{
> +	struct zram *zram = dev_to_zram(dev);
> +	u32 val;
> +	ssize_t ret = -EINVAL;
> +
> +	if (kstrtouint(buf, 10, &val))
> +		return ret;
> +
> +	if (!val)
> +		val = 1;
> +
> +	down_read(&zram->init_lock);

down_write()?

> +	zram->wb_batch_size = val;
> +	up_read(&zram->init_lock);
> +	ret = len;
> +
> +	return ret;
> +}


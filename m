Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768932853F3
	for <linux-block@vger.kernel.org>; Sat,  9 May 2026 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293108; cv=none; b=sDK0oJzyeaObKJsRIpwoll4OugkBJ/KdnYcuoXQ6tmvlAvIsLHHM3dkNOhZMkvwOIOhOSMRMWkXT/lNMjWa0i5zkuduOo0eWGuZgi8t2kAGoVnCaVyKp9S4BvgG+tIHRNKaxVX5Up5snqhkhipv/+6/EOeGWGtQNtgbPShkl7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293108; c=relaxed/simple;
	bh=dX1DT7/XIapuCyUNps6vGdble1ta01efA5iYuPMeyf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPG4B1HawjNs9LRJlLcQikasdN0mzww/YkLldWWhL3fp2gFXB3KS2CoMs09cc7O461iXPzMvwTRyTP589J0Ro5OYiVRxaU6h9r1VuY1u/om73CGcQt3WPM5qPWmlLxuAgFTEihD9D9jA6XB4uxZ189+wzVjs2PokptyLRq5iIbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k8euHPay; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k8euHPay"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8026aa4d53so1745864a12.3
        for <linux-block@vger.kernel.org>; Fri, 08 May 2026 19:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778293107; x=1778897907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PTwvstf0xm7AuzRsUone+BxfsctoSovje/yCegOz74I=;
        b=k8euHPayA1LlrPGmTLQ2THB5qf95hT+3cWWncKM5TOeS79yyM+WYcS8N01HGAcKo97
         b7s8Ko5fYWIdxc6SMoPd/00AT3V1rSBMQ85WeRe4kRpMUkiWQ/CD5spqB3ll/3KaW6o/
         vP2/dVXowbnWJpGNZ1c30V3Nd32ek3J1T56Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778293107; x=1778897907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTwvstf0xm7AuzRsUone+BxfsctoSovje/yCegOz74I=;
        b=HKk/TiWEKNXRjuup/28JDVEBKBCfTJjfAg0vCW6aHQ+Oe/JBldMwq3p1NsNY4DLZ4D
         ICIyaxY870cafDsZ7UI+bKUt2TRsWWvbRWr6BichWMx/ApYSVSEbe34qwtrqHcaL1bbE
         /SeN8g/EGhflpkDTR2he4S2yy5XM+3JZmZx0P+stfM6m82LPeCNACzTYn4ACNzFf67Rz
         ijVMxHNGOgpCu8nouzYK6eVXkVgYp7O4dieQpYdWZu2VJ54Bh1Mc74h382q/8aQR9gMn
         AHnmumrQIA5SsefyTc9WfsQSCSsrFV7iz5rrsT8v3FO64g/pS7bhvl914kvTyqQouD4/
         G9Dg==
X-Forwarded-Encrypted: i=1; AFNElJ/iiLBQgOLVFlCfGsXNsopyPUZwI1876EeaS/NklphXGV4kjFCUQ2Unef3b51htJuMlK43jjy409quk+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXw6Ro6VnIW+t3nJ65wclhm/+pvGqdxLc/KF/rNC9cTpI+6b0u
	ttSUwAIC8MKxrKltM7xc0c+xY29MouD66N2+/rUuHcpRWxG7g1NUwozg1rqdoV4rh9sEAqdQMTJ
	yoRY=
X-Gm-Gg: AeBDieuhPjEr2pi6TIOPjU3gjg4JU/JQeBKXQ/Pn+EgqGWVowwSsMOzSyRqHJ7EZmaQ
	wgfAanSYYnFK7rk2UnCole5Zi2BiOqsdlnaLIWPKIWVoCK0Y3Z/0pluadwmpTaUKNOXqoY/VWXp
	4NhmyD+aJ0EMavrFyrrCCXzf5LT9ETPGFGen7VR6N1lmXZ2YhVf/N5W3gY9n5xCKwiSPM5gmSqy
	hDOyG0o3KvExyYpkXiF/QqjN+dylg0Nc/OjPMtG6/jcH5wJDiITDMAcQTFBu1FHBafJdMTI29TT
	hr0YjwqHL0Ksb5NHuf8W8Q9HEzDxv0SmUrZHmpLbZeaPV2hnp4OvT8HZZRPGSFPCtZD36o5xQ0c
	y/TYnNJI6cm0HBwlvWUsFfU9bZTpaTLA5jxm6UIjuGKE5kWEjlTaRvHNXsKSujDQGKdJxeld0Sm
	hTHUcs7yWhKWLA6la3/POND2wBGcmRb20g6myyJAO+GOGzHO8AgCBkMGSk6Rvj7oA=
X-Received: by 2002:a05:6a20:4322:b0:3a3:1164:c7a6 with SMTP id adf61e73a8af0-3aa5a8fba0bmr16369167637.14.1778293106865;
        Fri, 08 May 2026 19:18:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:96eb:c157:3755:4e22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267689d76sm3059171a12.11.2026.05.08.19.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:18:26 -0700 (PDT)
Date: Sat, 9 May 2026 11:18:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Richard Chang <richardycc@google.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, bgeffon@google.com, liumartin@google.com, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] zram: fix use-after-free in zram_writeback_endio
Message-ID: <af6ZT9oR7GGmMFSC@google.com>
References: <af1BNwmyHK6aU_uT@google.com>
 <20260508084933.3730661-1-richardycc@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508084933.3730661-1-richardycc@google.com>

On (26/05/08 08:49), Richard Chang wrote:
> A crash was observed in zram_writeback_endio due to a NULL pointer
> dereference in wake_up. The root cause is a race condition between the
> bio completion handler (zram_writeback_endio) and the writeback task.
> 
> In zram_writeback_endio, wake_up() is called on &wb_ctl->done_wait after
> releasing wb_ctl->done_lock. This creates a race window where the
> writeback task can see num_inflight become 0, return, and free wb_ctl
> before zram_writeback_endio calls wake_up().
> 
> CPU 0 (zram_writeback_endio)     CPU 1 (writeback_store)
> ============================     ============================
>                                  zram_writeback_slots
>                                    zram_submit_wb_request
>                                    zram_submit_wb_request
>                                    wait_event(wb_ctl->done_wait)
> spin_lock(&wb_ctl->done_lock);
> list_add(&req->entry, &wb_ctl->done_reqs);
> spin_unlock(&wb_ctl->done_lock);
> wake_up(&wb_ctl->done_wait);
>                                    zram_complete_done_reqs
> spin_lock(&wb_ctl->done_lock);
> list_add(&req->entry, &wb_ctl->done_reqs);
> spin_unlock(&wb_ctl->done_lock);
>                                    while (num_inflight) > 0)
>                                      spin_lock(&wb_ctl->done_lock);
>                                      list_del(&req->entry);
>                                      spin_unlock(&wb_ctl->done_lock);
>                                      // num_inflight becomes 0
>                                      atomic_dec(num_inflight);
> 
>                                  // Leave zram_writeback_slots
>                                  // Free wb_ctl
>                                  release_wb_ctl(wb_ctl);
> // UAF crash!
> wake_up(&wb_ctl->done_wait);
> 
> This patch fixes this race by using RCU. By protecting wb_ctl with
> rcu_read_lock() in zram_writeback_endio and using kfree_rcu() to free
> it, we ensure that wb_ctl remains valid during the execution of
> zram_writeback_endio.
> 
> Fixes: f405066a1f0d ("zram: introduce writeback bio batching")
> Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Suggested-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Richard Chang <richardycc@google.com>

Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>

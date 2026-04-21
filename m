Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7D33064D
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794650; cv=none; b=dABKcXO7Talm04sd8dz/j0ijdzYYaQe1awSZXzd6SnjBuGTU2rkbLr1eluV/PkeNPSjljGAcpN2JGacCQ7E70rJCmrlOBiVwvIS2rORNyS6mRSJZP2zrWS+0IL1eAzRvHU6eAMjGP11SL6ehPQ73wGswM6T5+K/8gbfVkNWKQNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794650; c=relaxed/simple;
	bh=xl8N6j3b+gz3fqbPmliNSHd0SllX0JUEKr55gqsTKuk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pK6nr8xICxgUgiNZFkqnE8u1oIVsy//bq+9YtjtCyDvxyR7B36cTtzFVipJW45UGnIYe+Bp6qTE4Ar6OLHB2G0i1A3Leb5VfFhaQV4WZT6ZzNesEO9SR7DbFLphLUCZgSJ0JT94CVAhrOSpXrcCsVMmnT/JdBrf65pa4wHriOuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=UOFrQGO2; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="UOFrQGO2"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-694932346a1so672981eaf.3
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776794647; x=1777399447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QlqQWGWciZ3CiRdbLtPd61zSucf5R9oSxSQJb1tHjKY=;
        b=UOFrQGO2MvO+emIDgebJ657BUMtY4+GNFg4u5TbeK9rXhgTvb3Le9NKpoB1evX64a6
         mbBqVwlqBeS1pjJSIpWr1KtGFk/yooqIzmr/piFVdCDUTIRuYOXShjjhdm046PT4uVZy
         lsZedEVovrFvHJknPGgnqQS0toQ4i/ffM9xTSDlYk8XypOAhEWYwiBA69DlewsxGonDk
         W2KOxP15hagSUxke+iDpbxSW8hYEpym2NX3UyTgpGfk/t8dgNUjPeYtjuyu/9wDqk696
         2FwTDC+0OmGFuCC6zUf2OO7UOa477qxzCj2m1m0qmpA8t/HkduQ1lwPj2gq/PC7y8d0g
         cMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776794647; x=1777399447;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlqQWGWciZ3CiRdbLtPd61zSucf5R9oSxSQJb1tHjKY=;
        b=MvqJZwupK8o16nik/WFTHmGxC6T/gELPO1ooDtkUTdO45EL/+uKJN0wNKWMnV+/jLo
         9HvEjbA77r+oo4kxUX2icmGyeHeqVETC5RO4ezdMh6GZpMotM+Fz7ikWO8HXmHaGJSYw
         IECNAbW4th39YGe1rK4rvTvtDXWkZVGQn+jXsMMsA5hHFllczMkSQ+qvuO/OL3ZEZwRV
         vxEL1DHBqZWsE/dX1bKRiVgDXPcWf/1Hqw/NGgOmoBjQae9Qd5KNlEWO6fekGfPy9rtC
         rBde7OVDL7pzwfinBqOYUVP7j4/JQGvWLnmZeC3D27YcI9FmsJeh+/euO2RxEorxA4TT
         DlKA==
X-Forwarded-Encrypted: i=1; AFNElJ/qYU+ImZ/v87D2/YdT4UZ3J9eb8lnwlOZILuCiwX9psYVWNPHzeoLiJGXs/bR1OnVaqvGzPWrLRJZzZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww5dwfZMFwVXGONRYXFj5QrBP3Iro0nodFEuOI4fEz7Kt1jEgC
	vPrRMBHH5kDZU1+tlBv2hdtgHeq7Fbfa0Q0AQGQ4IEF+KKKW3md8t06gldwUT3hFqPI=
X-Gm-Gg: AeBDievfZqnyGfQtXUZH0RjK61biiHfDCWCv/H/yQFA/7UkZXWWVXS0y50OqtfvECk0
	xt5g2TU3Hf2aGAmwZHol8QhJIC4DFx9vnWgtq8klXC1S7LGoRaUKmArGYMibv8v6YdowI38ABDe
	twubq6sfXlk1Hx3mclC5kmpGKMf/1e5K+MvWKxb4KNox1+5zLEC2XW//Dl8D4ScsNjIABV9O9Dd
	suZMh7dV4b5QXEkY8F/dOFSwz0Wdj2TTABFzDy95OPqYJ7Sw8y8DDJoc03UQ3dpxrhqjbGWN77h
	GKtbqXDQvSdOstaGsfqPTZubVJJnNXqAH3T2GuqqxshJyTqMxqx2d70D0e3PxMxb4lFFV8OmXaz
	W50SEjiUWhOgKQ7xuY1QdgQYrK0OfEwkHN4YGicbX+8vELpBY3L36FfwyROiPX0EiO0yxpwBoNn
	gUbIz1UjCk+JejfLe0rWVHHliOGaNA6OG1fp/yztA6AsH2NSqOqE+hkbsovfa5NAnqqTNuhBqrp
	T4NBM8GcSX9+QSbZvg=
X-Received: by 2002:a05:6820:62a:b0:67e:2e4d:6c75 with SMTP id 006d021491bc7-69462f084a4mr10863101eaf.41.1776794647115;
        Tue, 21 Apr 2026 11:04:07 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464ea14ddsm8661726eaf.6.2026.04.21.11.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 11:04:06 -0700 (PDT)
Message-ID: <a976cbc5-f0ca-4042-a88b-e1b947ed4c29@kernel.dk>
Date: Tue, 21 Apr 2026 12:04:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RCU warning off ublk_buf_cleanup() -> mas_for_each()
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>
Cc: io-uring <io-uring@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "Liam R. Howlett" <liam.howlett@oracle.com>
References: <0349d72d-dff8-4f9f-b448-919fa5ae96da@kernel.dk>
Content-Language: en-US
In-Reply-To: <0349d72d-dff8-4f9f-b448-919fa5ae96da@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/21/26 11:47 AM, Jens Axboe wrote:
> Hi Ming,
> 
> Ran into the below running tests on the current tree:
> 
> =============================
> WARNING: suspicious RCU usage
> 7.0.0+ #16 Tainted: G                 N 
> -----------------------------
> lib/maple_tree.c:759 suspicious rcu_dereference_check() usage!

FWIW, here's what claude spits out on the maple tree usage for
ublk. Simply passing it on...

  Issue 1: ublk_buf_cleanup — missing RCU/lock for mas_for_each (line 5489)          
                                                                                     
  ublk_buf_cleanup iterates the tree using mas_for_each without holding either       
  rcu_read_lock or mas_lock. The mas_find() documentation explicitly states: "Must   
  hold rcu_read_lock or the write lock." Internally, mas_find → mas_next_slot →      
  mt_slot → rcu_dereference_check(slots[offset], mt_locked(mt)). With neither RCU nor
   the tree lock held, this will fire a lockdep splat on CONFIG_PROVE_RCU=y kernels. 

  While functionally safe (exclusive access during device release), the API contract 
  is violated. Fix: wrap the iteration in rcu_read_lock/unlock, or use
  mas_lock/unlock.                                                                   
                                                            
  Issue 2: __ublk_ctrl_unreg_buf — unpin_user_pages under spinlock (line 5431-5455)  
  
  This function holds mas_lock (a spinlock — atomic context) while unpinning         
  potentially many pages in a loop. For a large registered buffer with many disjoint
  PFN ranges, this holds the spinlock for an extended period. unpin_user_pages →     
  gup_put_folio → folio_put could also grab additional locks if the folio's refcount
  drops to zero.

  A cleaner pattern would be to collect entries, drop mas_lock, then unpin. Compare  
  with ublk_buf_cleanup which does the same unpinning work outside any lock — the
  asymmetry is notable.                                                              
                                                            
  Issue 3: ublk_buf_cleanup — kfree without mas_erase (line 5504)                    
   
  The cleanup function does kfree(range) during iteration without first calling      
  mas_erase(). This leaves dangling pointers in the tree nodes until mtree_destroy is
   called on line 5506. Not a bug (no concurrent access, mtree_destroy doesn't       
  dereference stored entries), but it's inconsistent with ublk_buf_erase_ranges and
  __ublk_ctrl_unreg_buf which both properly erase before freeing.


-- 
Jens Axboe


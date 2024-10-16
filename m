Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CF013B298
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729044583; cv=none; b=c9n7OajuMPJhEQigb28iWgCue0FmQB336EXzfuOusMXAQbXpublwY0nIeSYRRSKvljBsZf7aTosgGXj/aasVtDMhoIjs5OoEag0v8juqwpxT/F2iIKTzkxU8pScbBFmQdcRPh0IS2XkM7vpLcF7Jr71r/RPb/fpdzBXuRabGS/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729044583; c=relaxed/simple;
	bh=eUolet1snSZHeCCL4llL4piALp5qR510l7HA0K4id2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pefL993MqOJGEhFBtOk2PnbFUPQZcOPuE77MElFOWmT+Si1LBMjthBjhe0J0Tq3Q1Z9hgIpEghjFmmtRnh4Lg9QgGROfALTxjjQmHfpIoSyF+rWxzzSPwtiJMLA7vKglvRQnCRzCJt3eO5VRiOwhbbCcxG+8DbOUJW1bVbfPJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bV8wSP8y; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bV8wSP8y"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so4698378a91.0
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 19:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729044581; x=1729649381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CD0AIDbbe2k/wft/JxhhhYWwZsuYMnFY5p6ITMALvnI=;
        b=bV8wSP8yG2N8+DecBliUEa/39WfDPzmSaaD/BAMcmTSZ+QV6PjQIQrlR/msvZ9kfjq
         OcAdayQLeiz1wGqBw8Te4erGDTCT8c/+F+lPy0tgwWoy7HSiuzPoEohWcay5XEkh4CxL
         GoecTc9VYf7S6RfNNMRJ93+g1KNiNKSUQjCYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729044581; x=1729649381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD0AIDbbe2k/wft/JxhhhYWwZsuYMnFY5p6ITMALvnI=;
        b=K3HGM5P/aI4AFGDU57vkmBD+U1rCFPoALeFlE3crRz6rxHtv/0wExTaoS89S+oeLGf
         PQ1erLjbg8QH2JhQnEiQk9rR+rfqnbthZF6ejdTLYz/8xewoh/dXoWRXFmrEUAEfgaAr
         vS8bIVyK0IKBbVsdjkd4RcEF32ge5+ykq9Or/uNQBqT3973ioTfylGK9Ns0X06vx9IkR
         IQtOKq+pEmHUvZg2nUb/XlDSkHrABq0Wz5Ke0ak+r2KNXEaOEcEnmS4mV3+U/UL1ZIlS
         W2N4arMP8ttKxHQyj0WC5Wshv5Ed4v9g+MHowRkM67ySYEGKW+UoOv3ZhQVzsT4xBcwN
         94Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWCP1XVeWbVq6SHCQ3m/NrXyGQI0iedSZTzjpa9wHHJf/vRkSFUo5E0LoTWUxIt3FG67BmcShcn7tEvGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpqGVRu+EL+14IK3ROu5XZTRn65+14422ZgENE2ZcvELeFur7o
	H+bDR0ogznaOyLoqH7e2WfaItqV3613i0wFhLRAwt2rfZz+KMxalGRreM111VA==
X-Google-Smtp-Source: AGHT+IEtxmZJcYtemAf1UqN8wg5UwjQoXzLXDGnLmloGlbvWj5oEVFzdrSI+O6/hBezjjVoAwaVdYg==
X-Received: by 2002:a17:90a:c7cf:b0:2e2:a661:596a with SMTP id 98e67ed59e1d1-2e2f0ad039fmr21115454a91.13.1729044581529;
        Tue, 15 Oct 2024 19:09:41 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:2ce0:7364:7a47:e887])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392e8ed7fsm2767682a91.12.2024.10.15.19.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 19:09:41 -0700 (PDT)
Date: Wed, 16 Oct 2024 11:09:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: YangYang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: try to avoid del_gendisk vs passthrough from ->release deadlocks
 v2
Message-ID: <20241016020937.GC1279924@google.com>
References: <20241009113831.557606-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009113831.557606-1-hch@lst.de>

On (24/10/09 13:38), Christoph Hellwig wrote:
> Hi all,
> 
> this is my attempted fix for the problem reported by Sergey in the
> "block: del_gendisk() vs blk_queue_enter() race condition" thread.  As
> I don't have a reproducer this is all just best guest so far, so handle
> it with care!

Hi YangYang, Jens,

Are you OK with the series?

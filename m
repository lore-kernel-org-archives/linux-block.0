Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCAE321B4
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517335; cv=none; b=l36aaYoHlk2LlnbtSX1F9HgEJPS2jgI9T0z873YFOSDKZhrLSKP1VA3P0bbgdOGS2WZ+2LOUF2KuCmPRWU/7OnxJcC1WchojCsc0VmfiR0ePtdW8AGOpmBENW03GX2izEfx3j7a73d7Da/vuyV056WqUhH6lpPt0/ySNBcu/s5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517335; c=relaxed/simple;
	bh=C1ZUs3gG5z72f6eX94YNHIEUFRExkj3puBeJ7GC/KqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQJ2JQIrdCA9+aa5YW8emezpl6wWO8Be5kbali0dehmv39lhhUrZK6xf69vB+OihlpmpG4ebzwZLojULzqDlrqpe8vHOXyXOloN0l0CQ0wvkBy9Gqe/OeAMCTSRf1k77B5cUzZR/rWoN4utniiD6pI3x04RsOGThG0QgMkLYknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=J/Qdu9wH; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="J/Qdu9wH"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-221b9142995so234582fac.1
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710517333; x=1711122133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GKgmBazvbnm7o03uwKfBQxmOXAQWmFLuSuJB3oyuKNI=;
        b=J/Qdu9wHGGOIyLThwQN8vniL0Wu5JyXnAT1+fHBmj5Lvs7n1dx/as8BbBXzD7uMyHl
         xiv4uh2kS7G9E7DCwLDSQGt0AZbF1wb092u96JV7cSH8QNPXP2nbso86EPGFs72eAgAd
         UOYvYLFaYXimdgHjhjDLK9fSkrnfHl9vJW4NB+2V23/TN4W4QvE8ECLFjiogZ/9qK51Q
         npcog/5J3/IZWkdNKyBfiYfhpWAAYdDVDh1ILbxDiJjS03HvBHzOb0vrXZt39zOllqGX
         wb/vk8RxKfg0879fEdVyEzK+6ux4gg5Z6LgVd9L/2O136M0a/8Hl9VVRf/c6N/VMMKL+
         +xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710517333; x=1711122133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKgmBazvbnm7o03uwKfBQxmOXAQWmFLuSuJB3oyuKNI=;
        b=SrR9GRyXoX3woQ/zgyVbyDPwhA4IjbUpySt6U/gfguxDT+XS9ExLYBHym3OiBVRfFV
         sQdnGpv7NIqM0LDonbBZVBZRQb2RRTHYMntK5ccwwGP1LfATuGHJfpnvhkhZol1RcSOh
         KNxvhxTt/AM75eNaR+h1Loy4t68GV0yL5DXD8HgAa1a3ZGD5wCcODFXdvOWPRdr1k+hV
         Veg8MgXkCITN5/OlK5L9YlEQj+j7csrE5PdD3H2afCy7WgAlGJifKIFT1qIHwiDW+roL
         tVV5mbm1JB6pKOX8tsSx4OOX864J4jILMsATZdEqnXHmYC/1S0sAifA2EjZyzc97cSeL
         hxNQ==
X-Gm-Message-State: AOJu0YxlecXUV/EfLnRFfcllXBEmvyrlcmdzSZupJJvbN72mbTr2LyjS
	tcUmYt+p2CH8lRs0aNgd1u6W2mLObuZaE8sH6G/jx+SnADgttyjhdbLPbooFlqI=
X-Google-Smtp-Source: AGHT+IGCO4xlveh6PNk9Ql5h4c88u4v6ykwH7rivIkrx9dkeGvcXYhP2xvmB/AXUquAuIuZL41P/yg==
X-Received: by 2002:a05:6870:51cb:b0:221:b2a:3beb with SMTP id b11-20020a05687051cb00b002210b2a3bebmr5253185oaj.2.1710517333075;
        Fri, 15 Mar 2024 08:42:13 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::129e? ([2620:10d:c090:400::5:d882])
        by smtp.gmail.com with ESMTPSA id n45-20020a056a000d6d00b006e6ff8ba817sm827430pfv.16.2024.03.15.08.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 08:42:12 -0700 (PDT)
Message-ID: <9b9f2053-2b07-47bb-a63f-c766f0c2d30e@kernel.dk>
Date: Fri, 15 Mar 2024 09:42:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] remove aux CQE caches
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
 Ming Lei <ming.lei@redhat.com>
References: <cover.1710514702.git.asml.silence@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1710514702.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/24 9:29 AM, Pavel Begunkov wrote:
> Patch 1 is a fix.
> 
> Patches 2-7 are cleanups mainly dealing with issue_flags conversions,
> misundertsandings of the flags and of the tw state. It'd be great to have
> even without even w/o the rest.
> 
> 8-11 mandate ctx locking for task_work and finally removes the CQE
> caches, instead we post directly into the CQ. Note that the cache is
> used by multishot auxiliary completions.

I love this series! I'll push patch 1 for 6.9, and then run some testing
with the rest for 6.10.

-- 
Jens Axboe


Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1E238B7BC
	for <linux-block@vger.kernel.org>; Sat, 10 Oct 2026 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602257; cv=none; b=P0dYPnGvXFZXZEP9+Bl0BirRKbpkByKR2ieSsJZ77mya/S/QnotK2xr8zEs4I9ddfIbuO+e3JOTZUtXz0EF/K7NcQekxAD8RfolzjY5dH+apEA1b6CD+sEcZFLf1Tycc5M+vMqQTeKmfGzfgriK8E/9yMVGvQmRv8FvY35NKJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602257; c=relaxed/simple;
	bh=fkIQc2cBRsR9esk5rJ4DOFEeLxYdmg2udexU0q42DCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfXeCu1/7qjQUTBXXAxCMu25FgiOzlIPJqxnJ6PygfqtDZRPTdYiZ21mrxN71x/BSWe9hD42ePpC92jDqdBzDubTbhUIofdK2fyFtM1tEZyM7a6Uw0r+/Cg43j76SDQr6RSgRMKIdEOIXlU+Y5+AJ3EhKb1i39bMCLVPrU/xueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFjeLbh4; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFjeLbh4"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-354ba08cfd1so518700eec.1
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 20:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791602256; x=1792207056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fkIQc2cBRsR9esk5rJ4DOFEeLxYdmg2udexU0q42DCE=;
        b=SFjeLbh44TczITHEjC1J7EQQsj2voyKadJ8MTJE7hH8I/dq+RzFBOHDbuUreZ+l3hu
         4YP0dY96HBaN7OPq91LGx6djAJ3vW4uMOnmyOkhbn0DlgZnTOfwc3kMMeqqZoVwlRHuu
         mht1cA1+pGtJpx9QkrQUsOsb/ZVJA/Z1Z/97yeyIL+7v8IT2hbcbLSqbfN9RLZ1NMhBa
         dnEbc+WPMeJUhw/Kgzux36UibFbrkY0gNnzx+9CcdseyKIHT798WoUJcDky4SqCWzmZB
         6vFjnkXHjNNMEz9H29/K/uMBHdmF6PjGoVlUyJTiIjq4ujs2kzs/ZEZFqyoy5RNirNvo
         VzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791602256; x=1792207056;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fkIQc2cBRsR9esk5rJ4DOFEeLxYdmg2udexU0q42DCE=;
        b=i+y/jEKbeEpITHDtvQXGddtxO+J8WBLcf6V7kZUMrVDMFgCRas4dEFa3yJxkpogvzr
         A86LFFp810oRxH4meMeorLraAbbOukqJp8/EGQcMcb/6b7UMK55IfF3grwxtzuqDMjpr
         bTr/DWFu+E8d2VLQ9r2NdMjXVWR4C3DpttwT9Yt4PbGshZRoVU4sBjeluQcSk0D5Flh6
         FZufFh7ydW0HFERPRoosiNrqwrmVxUx6FnDdFbp9SHWC/sNt2fWmYGzGIsJqi7AoPINc
         cLAo0+UWurfe3keSddJvOo0lXaeQ/dnQiseduB5QOruaApOdI7SNsCiLLpmdurxNn3Vr
         +eHg==
X-Forwarded-Encrypted: i=1; AKwUvBxV7+4S86yix+Utn8q4CoHlfjCLSSyAgfqmrhWni2lrC8lFEHM+UbNhOWtyJi5EFr+LTP6cTKuDTD8CDQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIWVLZ4Q55J2FtSHD77vG/lFTBimshZvWKulI16eix+WbnyHE9L
	geBazrxU092s1t4On4IXCQ0ZdVA15ya95YjqjrTyxVnh8BHJEJERWv6L
X-Gm-Gg: AYBFou3GF/fXH2aK3nMUSHXULZAbo0OLQhcr2g25AhSKyVobKxIPKjmtuY5SVxkUYKo
	51+7okGcSy/pFTpOL/RIWvqXCrzy7udTJAEeGFiyiuSco85z40UL+B0n3uxiMbBSZx5c057YSas
	CM0kZvVfxZ7icRjrOGF9TO3lmESuACyeO7KXgF9UTfHjdnXNLV8GTxiwsC3jt57WuZPQFtx73Gc
	MjOR76uoefVFwmFghLLgz1h4vVLf6gZ8RM8liPw6BP3FMaAMC7lbamFGLMIAS7YpfVpV7sgjd/3
	nXebn+UJtOkx3iyY77YWd8GJ8u8o2qlV7bwXRnAjbfwDv4Y7Je+FO06oyhxYENRdTLFm3Eii7T3
	DPa+0d8UoE0uVITPRv3prHT42hMaM88M+1Z9mgW0MVknwGkjS1Yo6j0lz+C7PrIUpFjLqSzm8s0
	AneHzK2YVbnZcW5HTGaZxLddAX8BwXSKGAxozOxqxQldyvkYvTxVdJGsjcx+tc1Q==
X-Received: by 2002:a05:7300:c7c4:b0:353:7b29:54ec with SMTP id 5a478bee46e88-3537e2d8ec8mr4879682eec.40.1791602255846;
        Fri, 09 Oct 2026 20:17:35 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm10654296eec.10.2026.10.09.20.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:17:35 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: don't quiesce the queue when setting the default elevator
Date: Sat, 10 Oct 2026 11:17:30 +0800
Message-ID: <20261010031731.3882546-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010023608.3667184-1-odys.yuan@gmail.com>
References: <20261001-bug-block-elevator-init-quiesce-v1-1-5c85fa0ec59b@gmail.com> <20261010023608.3667184-1-odys.yuan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ming,

The patch and my ping went to your Red Hat address, which I think you
no longer use, so adding your current one. The patch is here:

https://lore.kernel.org/r/20261001-bug-block-elevator-init-quiesce-v1-1-5c85fa0ec59b@gmail.com

Thanks,
Qiliang

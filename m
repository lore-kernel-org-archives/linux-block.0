Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD983218596
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092298; cv=none; b=tduEhbCp6qzMK1G1GwbHEDi0P2og/ZPbkCt0jSWR4y4kQ7MXXhH7dEctDfmz2eYNO+yq6LX1N/rwvcBqoelTwCg3uNfw8ZBkZbCTgqMvl07kjlls03pZfVDWe5lTec5eKYAzSiUY+OX2gNWQ7vPxquGT4wWWyplG8ygustvH6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092298; c=relaxed/simple;
	bh=iPGMl91c7t5RGa6luUsGuLLK2Y4Uq1XKEbahe9phnZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjXmBwE2/wHTj9Vi9Jz0Q7o7ufPxyYpvZBmTfwLjkPa//L6FZh61Zl8PgX0iuvk+x7ppNpgCvklnbAWtcnuY1xNqGODCW+niljpt1w2ZDnCnta+fPFYl0FYsbwHGD6UhTuU3T7OhunlUz6VRs1LBhqPrOdixgGBov6894aB8YPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MP3eRqnj; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MP3eRqnj"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-948da744f87so214038139f.1
        for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 09:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764092296; x=1764697096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/RYkXbjr0Zws5PkDP81koxcOw7wQafJJolXOcPbtL0=;
        b=MP3eRqnjDMu+VfgIgoXsIjZip2LrEx1us53r4meudiB9JGUbZ72aOCwHVqeWpcZFMf
         brjS7X4GVj403fOyNyRKQvVZgImprMv3zy3CchjzM+GyfO9KuAvEZRo5BLVq7yb1JW5q
         SDs7kehGdkBeTBcTdxTsopwd7wvwVVqvy408yKdzW0gEqgdkhuketmjwGMzY7tz/Z1Oo
         RAYaSxGergG2kfyxRGyXiE5ezp35bLfalGIF4hzgKt+PdBqUIvuhfIChYxFmyuaIhCVf
         CD81Odhm44Ln9mP2TZF0/SRi6UX6k8xoOAJQc44N7ZQHA+ovauUoXEg2ucKX0zVJe694
         35EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764092296; x=1764697096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/RYkXbjr0Zws5PkDP81koxcOw7wQafJJolXOcPbtL0=;
        b=SrUt1m3dO+79RIOSK7uKlujzSy0qW1hBsvB0I4RlWsmkAVherk8TbY/utbjA0MhBSd
         RsMCkT4z4EIYA6ZoSkIOtYd/4bH8CQgDipu2UwHlBzClQ1abJZcmPF4Er5wwMK5rjB2+
         6lFUt0fpa0q98p1ZVXVP3M0rA82/tfBpJ+Y4sSH1SJfw0XuwsmRHYBELksomG12JamgK
         j5eKAgVuHckNMPDXElnUeTXR7cUHszlobn+HO+hppEJRIj0D9Jtkcs/3EGg6jvltQ2fE
         n0DNK6q6B0DHWdGLz6wSX/JvvprgSWDBeyMOijlngyQdDJIxjutzhPkBUkWfxO/Rzi9t
         mwwQ==
X-Gm-Message-State: AOJu0Yz9dhtjbI8R0FP5c4seoUofJ9ptn3fg6OCCHGg2BzyW+vgmtana
	VgT9n87JsVxF2aATudKIVekZs5+wqPYgv6cVD4DkDXjgaVz+844S+kzgNo+jZ95g+qY=
X-Gm-Gg: ASbGncv76kmZutXAvH8c2vI6/JiYNwGV0uu25nifq004WgDrNFsi8uuMD6hfodqvNKq
	AMD7RvYHovWBXlkfNcusf/B+NYs07PGutCYNYOMQQv3+xhE6yxqgmiO5kAUsy7+skxObJcX9K9K
	b+xS4FI9uTxFZl5WdDCqL198j5kwnm84enlRHRZwMv0kpaI38yofUjPSK8dyTACA25sZ5rMfe6f
	X32aorZtNG8e1zWHkogobWOtIupcn67kYivXwmDRz3FXz9tVdKh+6kRCgrlyzi+8lWSTAK5Upgf
	SSI8Zl1ffJ6//IIHhvbjDgLhyd/yhvOh13H9MomKaJqGh5/mrZGxcPSEm4POben+NaJnA8fSkoQ
	FoLopPv47gIEE/RaG+EG4gsTJAf7Qfxkify+3aPemwz7BbxDuQP8hgghlqmQ8lcSL2O0=
X-Google-Smtp-Source: AGHT+IEIHRk7SwMmVS4xtcTCAS6Qp+OrN5pgC4aYwqKQ9jNrDNwsm/zNssFdQ4CwiXZVR7EmZb+prg==
X-Received: by 2002:a05:6638:c0fb:b0:5ac:cd9a:4c4c with SMTP id 8926c6da1cb9f-5b999555c41mr3179432173.2.1764092295677;
        Tue, 25 Nov 2025 09:38:15 -0800 (PST)
Received: from [192.168.1.99] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b48bdcsm6970840173.45.2025.11.25.09.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 09:38:15 -0800 (PST)
Message-ID: <e3f09e0c-63f4-4887-8e3a-1fb24963b627@kernel.dk>
Date: Tue, 25 Nov 2025 10:38:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/6] block: ignore discard return value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, yukuai@fnnas.com,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, jaegeuk@kernel.org,
 chao@kernel.org, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-2-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251124234806.75216-2-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/25 4:48 PM, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() always returns 0, making the error check
> in blkdev_issue_discard() dead code.

Shouldn't it be a void instead then?

-- 
Jens Axboe


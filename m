Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDECD257AC2
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199535; cv=none; b=jq/tkM9k9w+eZB5gtyGlu3yIqf7B2uLk568GWSIoLVsAuWm9Oq9eVzuhPruukXSQ/Z8ao4lJjBJDSc2hJDzaaAC33rAMYjBNLel/HXj4vzfmmd+fNkyNbocDqGxKjl0mqYocbONBEs5cpMLb32rrWYq+T6jpsh8g4LBRyE/9H+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199535; c=relaxed/simple;
	bh=uMyLG/olANDH3vtxDotIsuAtyE6YZBa2WeRVoqxGXe8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nWStuGv1Oip8GNjbc/H4e4LsqivqrOjuCgM1JjcIyIyrDNWX6gBbuh2N9wF7UFu92qIGS5JsxwlNSCPj9lposzVWeC79MDsal+WIjeEYWDhABuBPFzjh37QhifIvLY24s4hSXG/TxIahOQDf2TsPTcqOXQflToWU43i5hT1WlMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1knQRczP; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1knQRczP"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3fa6c54cc1aso1573485b6e.1
        for <linux-block@vger.kernel.org>; Fri, 02 May 2025 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746199533; x=1746804333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mk7jnckJHe50gK0g23xzjH2FEe2H32qyA6GEa86GxJI=;
        b=1knQRczPI8QDD971Ntz1G06cXmdbVOZEJM7sfAwubOqt6kd2ZycAvk3EYVi3cO3FfO
         ZEW2OLVI2KkwjSCYvzHWuJfWX9ueswwSXLBnbXu1AlL0bNews89IEGvMX6Qf/F//sMhx
         IjzsghtjsSZ+nis4apChknwU+OqnTZUMoK3mFGu6oCsAo5XjrZffNLiC6lYdUdFNYJKb
         WBKO95pmBub/I3MSUswx9K16APqxasP1pF0iASRIVaN4u6RZ93h/LgUqlTW5y1JYKtxX
         3UkBSGLcJL2jAAzc4FNn5Jn8YozKdoLmS5dqy6zSErM86dtDs0vcXbiUbAtS81AJpbgn
         2FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746199533; x=1746804333;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk7jnckJHe50gK0g23xzjH2FEe2H32qyA6GEa86GxJI=;
        b=sd/8dGcN/rpu2UlcRUlgg8s+4cMky134eJUUeGwDCvlViNTTplTyyvp0KMVjdymTrq
         XIaORWwEUDc/0MOYRa3Il6mJ8fwjA9czC2BAjtvZhdsFSju9b1AzfR+8LHewlSIKZ8eR
         l9bOnpU7h9Frcr5SYE154oneB5C21Ny9iYSmeIDKN2vMWvqMI4sItG4Hr3L1SwrJzjIl
         0CclrRwCIVb4xYOS1hmu/ZGe9Cl/mW85P2UV+3QL+uTTCN4rbpl3KMGypcX7tjRgLioL
         vucd5llomQ09ufNuYAkmpYV9RVzvwbLmZKMiiLC0SyvNT3AuH8xvNqWsOHZ+WiBBC/Ak
         XkXg==
X-Gm-Message-State: AOJu0YytntFU2ZH+ItUdLst1w7+Bau6B+v/0utl7eGo7+3TNJ2UebYAz
	oEQKZkMAfhL7djQquQngrBYZH3n1R8yq+Amf1t32LiYj+1QQmf6P5dtTpyVxyzYUiJ+/pbe9/sh
	9
X-Gm-Gg: ASbGncvxOQ4RVIncIAOKem/I433oVDkupYLUTsDJArWcgv8W3dnWpZN7+9PEB8l9q5J
	C82pUfzXkCyDraHt7AZopBLYYKeDkm4nnjvyeEegRoSmuizBxO/PuPfcxZg0s4nEQiCkhvYK61O
	/TwFsEW+PWmuDMIhvzrMnjdzIaMG0MTmiUdzv6ywch2jY7WD4NCM3q9xHo1tDaIybkBQhuz28SL
	3IwArDiuS4osJrpqCTFQqnqzp4mQr/5fiRAMWxny0FXKJudBDvsQhuLCmL3Y0hFpQ3ePBnCseev
	xOd44bREiUUJ5I6beJ+Ew04qzUzdwaY=
X-Google-Smtp-Source: AGHT+IFzR7E2zIIjn0+K1WL/Hx3nUF2QbOJz2f86nscZPv6Bd2oc2Tr9N8O8BBba7byAnm8tfD0xXA==
X-Received: by 2002:a05:6808:164a:b0:401:e61b:5f76 with SMTP id 5614622812f47-403414b636fmr1739606b6e.33.1746199532822;
        Fri, 02 May 2025 08:25:32 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aa8e1f7sm429300173.121.2025.05.02.08.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:25:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250424082752.1967679-1-hch@lst.de>
References: <20250424082752.1967679-1-hch@lst.de>
Subject: Re: [PATCH] block: use writeback_iter
Message-Id: <174619953114.748556.10592432682022372332.b4-ty@kernel.dk>
Date: Fri, 02 May 2025 09:25:31 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 24 Apr 2025 10:27:52 +0200, Christoph Hellwig wrote:
> Use writeback_iter instead of the deprecated write_cache_pages wrapper
> in blkdev_writepages.  This removes an indirect call per folio.
> 
> 

Applied, thanks!

[1/1] block: use writeback_iter
      commit: 00ef5c728ec05af5f8591016a9d138eab6b6f8e9

Best regards,
-- 
Jens Axboe




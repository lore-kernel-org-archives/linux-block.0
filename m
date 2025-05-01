Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46FB1922EE
	for <linux-block@vger.kernel.org>; Thu,  1 May 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746107795; cv=none; b=ZXJtN26MSPIAnTO6RtSclnAOS/YsRAB2RTwzeknzjOBG9CnAn/EjlLUCjfXV7zWlHCi1vYoTtP+E6+5DPu21Je9rsgDNZ+eY3HdDz43fT0GZB2y6FY9R+NsCYKaELqt8eBq/2+9dbAyEEcpSD2514kSWNPTu2nsuqEoanekC8r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746107795; c=relaxed/simple;
	bh=EDYTdFhpSIfoKy4JH8DesVovYtJ580IoZwGc1oWyHFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6WMg6XSL2rsrlUcChVa1O1JEqgt4c52eZwPMo+QIeBI6UHf3jbhoO1JkPwInQbSiXdOfH73ds2n0EWbElSMKdRDO+SXli7am4NW+yr67C019oamif9di17CUT40O2dWborv8863v6Ue2nwCk69FOCUCwM/ES6TDYPQwSjocbLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JhWKF/D+; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JhWKF/D+"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85df99da233so101515339f.3
        for <linux-block@vger.kernel.org>; Thu, 01 May 2025 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746107789; x=1746712589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaABwqc9FxG0muAe6duB9RUPRqrBuLHOHIHY0BVoZbI=;
        b=JhWKF/D+fWE/QES4fHCM7QU9AARaGSsX1uG+AqF+JkBCh1fSDjQLXz5drL9pn82DFv
         Zob6dDTDj2BEzrYV5ISAFWywdWP+8kyhVIB3DB7+5t/sUbp57eXp3hy/HOTsFQfa8JnM
         zofmmmhZ7ifgllaABLrUIHfLTdMq2NP3ZRaaD8fRCanKIKGIZNpDQMbbf2ZQSVZtn+Y+
         +35ptAizPk0z3A16w7qTv5/ucDnxy3H0o4XbDQ3GjEsDFAyqFND4Pcy5YqhI06o9o1/p
         hBNs6ZP44oaCrk4E11UmTVRrvOK1ibq81iL2ZU9I0ATOkwk6zpoSuEkYO3QtdEXaJ/TJ
         Uaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746107789; x=1746712589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaABwqc9FxG0muAe6duB9RUPRqrBuLHOHIHY0BVoZbI=;
        b=paYk3qr8VXQZ+ookSU9OI/2FdWLt/SjDUumqb1nW86ZWpF4b8dcx03BnuegSEsPzdn
         0gCjhP4JgkW0b9h9jagRvzkff9C2wS20k1T56fs5LwwWMp/DHL/QjofYZvj5TT+N0Etk
         6doOdeDgG7ma6mFIsTG4tGbo5wUwnkbR9CVqzHQKLvCyhocCzYPCUi62TxXlvyl2gVfc
         rMCTA3bg2lb6/AR8iStfZOBUtLSTeFW+MZskrG9Ebhc77VKhcdgqb9ksSaShwm12nmim
         rwD9B3oWeiGRPOReoRi6x5xEQ+arxGM7D3nPqYPcZ41owS9HxjLi9yArjzJawFml1hUh
         P45w==
X-Gm-Message-State: AOJu0YxJGHAjO+5GCnpevuixEbEOuWU3M0XIYTAa/aQ/B25A4C3FfNg6
	ywKFNN8K9/xiJ6iLIwd4SKk3n33qjuo3hFzyohso5iV7kKXYsQxO1kkdDrqPLsc=
X-Gm-Gg: ASbGncui7Ksd3MIM8G8fbIhpWsm36re5RTJCHd1tVR6wKwhdGSHKCXun9hlMAZJkQJa
	fgNc1kuvmAecGxwuAqFGRiSzno0hIisMfiLmfGOSJ7kWI9zxAtb2InWD7Hg8rfL6XaohGni1szO
	3Ps7NCQBILbS9TGXISZkH0KMOj8GFkpbknHqCQcEuLfCg+d1UdU75jR/OWRXgLy+gXg7NICiDLX
	tZhFf7Hf5qYo8lefpOt8b7TJXpt1G25L5bFEo7sBMGsAYRBaJPj/4OPD2hljGFj/Np7LNmxRo95
	PXj5aVBsNW/ziY2713UpYyylHvZj0+RhPF+n
X-Google-Smtp-Source: AGHT+IG/i7pQb+PvTRvTqzbDEDNfr03z7LE5aBfmX0n21LvvGc1XCxyZrk6fRkgjHYGMOifVRlXUmQ==
X-Received: by 2002:a05:6602:3586:b0:861:cb60:1e93 with SMTP id ca18e2360f4ac-86497f80ef9mr866736839f.6.1746107789590;
        Thu, 01 May 2025 06:56:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-864aa58979bsm10677339f.46.2025.05.01.06.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 06:56:28 -0700 (PDT)
Message-ID: <9e4e6afb-6b91-431c-8deb-aedf2f9e3a43@kernel.dk>
Date: Thu, 1 May 2025 07:56:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.15
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aBN4IW2wlSfRIfjU@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aBN4IW2wlSfRIfjU@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/25 7:33 AM, Christoph Hellwig wrote:
> The following changes since commit a584b2630b0d31f8a20e4ccb4de370b160177b8a:
> 
>   ublk: remove the check of ublk_need_req_ref() from __ublk_check_and_get_req (2025-04-29 06:01:36 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-01
> 
> for you to fetch changes up to 8edb86b2ed1d63cc400aecae8eb8c8114837171a:
> 
>   nvmet-auth: always free derived key data (2025-04-30 08:09:09 -0500)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.15
> 
>  - fix queue unquiesce check on PCI slot_reset (Keith Busch)
>  - fix premature queue removal and I/O failover in nvme-tcp
>    (Michael Liang)
>  - don't restore null sk_state_change (Alistair Francis)
>  - select CONFIG_TLS where needed (Alistair Francis)
>  - always free derived key data (Hannes Reinecke)
>  - more quirks (Wentao Guan)

Pulled, thanks.

-- 
Jens Axboe


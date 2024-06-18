Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7FC17BB5
	for <linux-block@vger.kernel.org>; Tue, 18 Jun 2024 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724198; cv=none; b=eqb6O6Mt+5xGNWO6fiCVyIcJ2+j9DjQxPuI8DJ5AgC9zXpiz4ioCj9Cvm0MD+qunqMS/TxAfwpY6+YMzhcodcTEG0l4clS5BbgCRqDOF8zU5jRBSS2Mb7Azq5tAacwFb6X8I5d0w+bJ/ObuuaxAlply0+ilAz9B0eOb6mUjP8Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724198; c=relaxed/simple;
	bh=+UaewZqjCk5jggLlt8A+UFHLlspuoZhO4dFuoF9TpFM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cItdY6P7Hk0CiGJrZu6/AowIP2B2ZWaTfkIAsHzJnXkC/GKcQ3I/HAH42tNAPMhIptzLnnFHhRVisxzJoNtZlM6UeuSc9vE2IeswpsLQXLiE7kO15ivUtvWqRJHwPvYE1tMtLKXeh1VmMsmI7MM1jksS/WpQNCSAFhAu0pBghJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iTzjZ7pG; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iTzjZ7pG"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-254976d3327so433310fac.1
        for <linux-block@vger.kernel.org>; Tue, 18 Jun 2024 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718724195; x=1719328995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6B91qQWLpG+1qHBWfrmUdTmQo/hqZ9PHbgMbp3vqmw=;
        b=iTzjZ7pGwvyEpR7l+YBlSWG2eTwTEkabaTn/t/Yl13KhBBsSqepKBmYuKnaqrwJXkY
         Ulq68qJU+I7MMa+TQ3eyP+30xvypFj+KUJStruDvOH3boEIgp3m5nshVj7W6AwfXa5j3
         hUAgAxeNiREJzTtvpoD9mQCxkPftGdT5G/NRxjaNfgeacRzcIfleqxiutRhAm9i1RC74
         dOrK7uqqvmsaBE9wBsbU2Of2Qpsx2QeNpOEJN3SFTT8B8IYTG7f3ftkKkBHjEU04j6d5
         C9hJHxSbQMgIii5vDU5x0KLzspaVKaU++vMEsZOEiB2FNPqpaJCJqFVQ9puuVBCFtO7c
         PHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724195; x=1719328995;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6B91qQWLpG+1qHBWfrmUdTmQo/hqZ9PHbgMbp3vqmw=;
        b=DGgw9WG03Lo5Kc+2iqxB7OhbEzVnT+THpLBM2N6nxH6xI0rozzo8aiAYrDMuQL+Ghj
         vttSY/3NscBonhyG3ixmLt/+6thwmg2hd0ZmGV0K/kFOYtvAI9gOLX4G0e2LDtUgCPvE
         gXM4RMa8UY57CbyWU77zG9y5BJmnBVbLhmiA5chZvQ1iqpVEfkektgNIXNgp9GEtMx2p
         oE3+d65cifEFMdNdPFCxBdu+vxxa6cgcbIoq+wKSHVL7fOwzx/0gxtl7t7qvPcedEjo8
         k6xwiUAB1ntBiMIyh3GYEqq2fpQa3M6uATZOdGYm1tyqgZYoQJDnEasjm5liBdDobOhB
         EFPA==
X-Gm-Message-State: AOJu0YyK1vUqoIcZIp8ykHevvQOthf0zwJ5DVcJQlOB+lGuPHL2746lA
	sM0IVkkdQpQacEZO+I/Tc+y9KX79FjYcezX88bOhYabUy3b00H5UKGTkdpN+PYoj2BCjV3I0H7I
	2
X-Google-Smtp-Source: AGHT+IGFP+kdLoxpKQx3u24Cy0x7mExeMSZbDQat0SWP9aQxiPjEJWd4R1hjeoSMC4kDIYRzSdOcQg==
X-Received: by 2002:a05:6870:1649:b0:254:a5dd:3772 with SMTP id 586e51a60fabf-25c94dd4630mr96618fac.4.1718724194955;
        Tue, 18 Jun 2024 08:23:14 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5afaa06asm1862377a34.6.2024.06.18.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:23:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: jack@suse.cz, paolo.valente@unimore.it, tj@kernel.org, 
 josef@toxicpanda.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20240618032753.3502528-1-yukuai1@huaweicloud.com>
References: <20240618032753.3502528-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next] block, bfq: remove blkg_path()
Message-Id: <171872419391.44295.6483908119531238372.b4-ty@kernel.dk>
Date: Tue, 18 Jun 2024 09:23:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0-rc0


On Tue, 18 Jun 2024 11:27:53 +0800, Yu Kuai wrote:
> After commit 35fe6d763229 ("block: use standard blktrace API to output
> cgroup info for debug notes"), the field 'bfqg->blkg_path' is not used
> and hence can be removed, and therefor blkg_path() is not used anymore
> and can be removed.
> 
> 

Applied, thanks!

[1/1] block, bfq: remove blkg_path()
      commit: bb7e5a193d8becf3920e3848287f1b23c5fc9b24

Best regards,
-- 
Jens Axboe




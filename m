Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A56D12E1F6
	for <linux-block@vger.kernel.org>; Thu,  9 May 2024 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263378; cv=none; b=or+a/43UZKO+HbFJuri7lM4NTCrZjIx8UAwpakFRpADF36My8hF+0KsTcTwkZwMa4LFcSkXSGHbGK07N0r996RRtoVoGPhpPN2CXZq5Q1Db7td8sGn8GJo/pEMyolVhFAfo47q8ONPVNXChKy5xOK1WoWjdhP8YDcMHOstuqlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263378; c=relaxed/simple;
	bh=av1zIpw3rn8LqXzh68+trwgf6saFpEfQEGO/uFLFw/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rqQr9XuUdVdmIFqm07SAW9cIByPTU0Ku6hAhL4HhdMxzRssHhWkl0QxHf1wj3SnqYOPqkAEcUG7IBDXWurcvRblTVbrIRA4B/lxtwNg0ckrcGHOiKTgvWnT8gJgqupsoZo3hQCNIEFVhIYswYCqG0yR6COWUub4WkORI3rH4+hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=muU3qvzm; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="muU3qvzm"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e186367651so8188639f.1
        for <linux-block@vger.kernel.org>; Thu, 09 May 2024 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715263376; x=1715868176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TA/edpRJXMeLEprDOn75xEWqfIhyfxD+4NC6q2mBXw=;
        b=muU3qvzmsgIdhUWNj0SdgSlNjIKWgXrmpd84+Feww8D9F2ImLN0Fm2xZEpVslhN1ng
         5jjJqIlTnuoMUqPSdNq4EHNBSyeUhUVkoj8iBNIdzCLAm4XzFWaQzddUyXZ6e3g0YhCu
         xL4uJNH7eBNxa0aefPciHtH0jkLKU92TnCm+YDXeZyYMq5PGbJAeW89K4Lki+wxz2ayU
         1TAcUtx51ZYh9EjWvPmi+c+p6Gw0JotNibXsCG6z98kFRK8Dtnq2iU4FB/u+rJJWys8G
         +/krVFeExgm7MQwBZHnNn0UhwFP+YYqhZ77nJaavsyqWy6uOps6BzxFkjvZqBv7vhqbc
         3YMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263376; x=1715868176;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TA/edpRJXMeLEprDOn75xEWqfIhyfxD+4NC6q2mBXw=;
        b=QnJdMNBhuh4cImvVc/NZHfbKk43tF5m/HixvTpEiJtRiBaE21au0lAiD1Gzwe8OgA5
         Y9ZCk2ci2JeuOKowWg/I1jTa7wZyjgZ6FcAzMnOC2St9YUklJJeh+ZZFqasQk0v/Fg2Q
         BVLB+hJk7ecEZgFlJDTbddvIUTnmK4oxztgj9Z/Dvxv8egyhpYsbQ9PdSJUoQ168EjVF
         KsWlJMEy760NPJswSgNabSwRbrLgRaMOp3e2ruZ8zEXdS+KZcOXY72aT37xhYkdf+UxL
         7GTz3WTG8eMRP8Asf3CkN7p4Z4yIihZ2Y0j94qw2iofFGn4SjuIUvcU60NbAbC/Tzgwp
         DG7A==
X-Gm-Message-State: AOJu0YzY7/KESvbErZcI13xXzbNAIjJX+1El8VfMn5nenbzLzqotOIWe
	RGUHMFiG0WNwonblUh6HSgddqhLSe+TQ/G3u0MQRFLKr6AT5ok38rHFTe/7d/wI=
X-Google-Smtp-Source: AGHT+IF4KYubSLdPHVbuhS5ztl4eiR3W4T4uNHOwRLPmKdD+n8RCiV6pIRiCAF5jANZ1ChQQVyXYmQ==
X-Received: by 2002:a5d:9c17:0:b0:7e1:8bc8:8228 with SMTP id ca18e2360f4ac-7e18fbcc8f1mr607300839f.0.1715263375731;
        Thu, 09 May 2024 07:02:55 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376fb1f1sm371961173.163.2024.05.09.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:02:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, hch@infradead.org, mpatocka@redhat.com, 
 snitzer@redhat.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20240509123717.3223892-1-yukuai1@huaweicloud.com>
References: <20240509123717.3223892-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2 for-6.10/block 0/2] block: fix user-aware inaccurate
 util
Message-Id: <171526337498.20280.13592590390769873653.b4-ty@kernel.dk>
Date: Thu, 09 May 2024 08:02:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 09 May 2024 20:37:15 +0800, Yu Kuai wrote:
> Changes in v2:
>  - just replace blk_mq_in_flight() with part_in_flight() for
>  diskstats_show() and part_stat_show() in patch 2;
> 
> Yu Kuai (2):
>   block: support to account io_ticks precisely
>   block: fix that util can be greater than 100%
> 
> [...]

Applied, thanks!

[1/2] block: support to account io_ticks precisely
      commit: 99dc422335d8b2bd4d105797241d3e715bae90e9
[2/2] block: fix that util can be greater than 100%
      commit: 7be835694daebbb4adffbc461519081aa0cf28e1

Best regards,
-- 
Jens Axboe




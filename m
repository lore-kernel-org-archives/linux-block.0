Received: from sg-1-21.ptr.blmpb.com (sg-1-21.ptr.blmpb.com [118.26.132.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0649F1C3314
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763264760; cv=none; b=H+hC9JqmMjMi0PJXMhlzAmutLEkT0B2H4rn5sgBn4D1eVozZWGu8nimmtcZkjNDu5kYdzpCk4r37cLyV/OnvhYKOdiDFzgjr9W3T5YBr411RUsfLrdl0SacOXiHc24xxtK6g5XuG/+Rszt4iU5TOwem8qhgb7ZYLeFnSnnPtuf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763264760; c=relaxed/simple;
	bh=qMVFV1bvTdoSLkpxe2isHVq91AfhXDHtU6QN26PsAIE=;
	h=References:From:Subject:To:In-Reply-To:Cc:Date:Message-Id:
	 Mime-Version:Content-Type; b=c0qDH5hexvq0Q6UXV0N0Ks3IxCdflwKyenouDXbbpxb0dlzqHxYqV9l/iiY+QrUjtic79AFEjZu3Nicj7mIKVXt5i5co3ldft0kVbTQR/GXORV0jYGXFfI6h0WBRuHQTLPSU2BOWd9Gm4Mrd9wa3mZrs8/az6toK7CrIzvUePKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=xJVRKLO8; arc=none smtp.client-ip=118.26.132.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="xJVRKLO8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763264752;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=UzF4Eah3QpBGLy/RHGF7y48Hg+iyJ22kuCFB6K8MnhA=;
 b=xJVRKLO8mM3QI9EbJc2bpIunIRmLT3G8ki6K0MhOOtouYaI2hb5wGARaP9I4liC8GUIFk8
 OatQrvQmFaO440NvjAMeRF4BpsregaCwiGOE1Yt/wnWSta/JpvejqkWc9mQ6eASyKkJhlo
 FlhXtnHOOS9oUzYOEh7GsWyn8SJkc0FrAeCsKfajbEts6h6H6GDzFl1OQOMWm32BquZP8K
 7orz6pPVOSb1a5RFHr7G67mvRxKgINRspuv6F7cW6Lw0DkOyl/L3Zouyu30sJ+n6F2+LUa
 vcH6+0OHIcHNp97BDrSJHdEyiW/YD7YEqcUlouichxpHY3/Gw6Ak7soOY3om+Q==
Reply-To: yukuai@fnnas.com
References: <20251116032044.118664-1-yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+2691948ee+ba5cdc+vger.kernel.org+yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH RESEND v4 0/7] blk-mq: introduce new queue attribute async_depth
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
In-Reply-To: <20251116032044.118664-1-yukuai@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Cc: <nilay@linux.ibm.com>, <bvanassche@acm.org>, 
	"Yu Kuai" <yukuai@fnnas.com>
Date: Sun, 16 Nov 2025 11:45:47 +0800
Message-Id: <3e9941f2-ec26-4e79-b4c5-87bb9aa523fa@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sun, 16 Nov 2025 11:45:50 +0800
Content-Type: text/plain; charset=UTF-8

Hi,

Looks my email server doesn't add In-Reply-To and References, this set=20
does not
end up in one thread.

Please ignore this, and sorry for the noise. I'll switch back to=20
kernel.org email
server to send patches.

Thanks,
Kuai

=E5=9C=A8 2025/11/16 11:20, Yu Kuai =E5=86=99=E9=81=93:
> Changes in v4:
>   - add review tag for the last patch 3;
>   - rebase with my new email address, patches are not changed;
> Changes in v3:
>   - use guard()/scope_guard() in patch 3;
>   - add review tag other than patch 3;
> Changes in v2:
>   - keep limit_depth() method for kyber and mq-deadline in patch 3;
>   - add description about sysfs api change for kyber and mq-deadline;
>   - improve documentation in patch 7;
>   - add review tag for patch 1;
>
> Background and motivation:
>
> At first, we test a performance regression from 5.10 to 6.6 in
> downstream kernel(described in patch 5), the regression is related to
> async_depth in mq-dealine.
>
> While trying to fix this regression, Bart suggests add a new attribute
> to request_queue, and I think this is a good idea because all elevators
> have similar logical, however only mq-deadline allow user to configure
> async_depth.
>
> patch 1-3 add new queue attribute async_depth;
> patch 4 convert kyber to use request_queue->async_depth;
> patch 5 covnert mq-dedaline to use request_queue->async_depth, also the
> performance regression will be fixed;
> patch 6 convert bfq to use request_queue->async_depth;
>
> Yu Kuai (7):
>    block: convert nr_requests to unsigned int
>    blk-mq-sched: unify elevators checking for async requests
>    blk-mq: add a new queue sysfs attribute async_depth
>    kyber: covert to use request_queue->async_depth
>    mq-deadline: covert to use request_queue->async_depth
>    block, bfq: convert to use request_queue->async_depth
>    blk-mq: add documentation for new queue attribute async_dpeth
>
>   Documentation/ABI/stable/sysfs-block | 34 +++++++++++++++
>   block/bfq-iosched.c                  | 45 ++++++++-----------
>   block/blk-core.c                     |  1 +
>   block/blk-mq-sched.h                 |  5 +++
>   block/blk-mq.c                       | 64 +++++++++++++++++-----------
>   block/blk-sysfs.c                    | 42 ++++++++++++++++++
>   block/elevator.c                     |  1 +
>   block/kyber-iosched.c                | 33 +++-----------
>   block/mq-deadline.c                  | 39 +++--------------
>   include/linux/blkdev.h               |  3 +-
>   10 files changed, 152 insertions(+), 115 deletions(-)
>

--=20
Thanks
Kuai

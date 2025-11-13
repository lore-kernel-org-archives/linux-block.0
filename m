Received: from sg-1-14.ptr.blmpb.com (sg-1-14.ptr.blmpb.com [118.26.132.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4CB3009F1
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763015936; cv=none; b=KiL4GoDdtStqLSBdy+aQRUrOEmo8DWCG+ACBvMi9rlv4itxn56aGWYRsb0fSCs4Gp363KOr/XD4/E3Y8n/FTLqU3nMprNTunY1IJg34X7PCGAM0VDyUHCuu9Wddm80aKqkbjo2q1sQUyAOW/3mq3v5Z3aLOluAxAiUx98k/ykWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763015936; c=relaxed/simple;
	bh=DHkwZuB5DCaLJ07n7o9E0NZnSFBa4QYEaEYWu8c6G+0=;
	h=Cc:References:To:Date:From:Subject:Message-Id:Mime-Version:
	 Content-Type:In-Reply-To; b=ro83/uZnSQ724g4B1SW3pHPRm2vNEb7jeN8AxWJadhWrqKHw1IFad0DM62t/9eolYZKMT9HWtEmTniZqYYGJZK1BBLAdR1ylxR0c2uSNWar9cLtFgmLyAeHCpZgRfi3TUXR2nSDCnCrE2S+SdQzu85nfcckV693tw9oBuAf9fsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=ZnF0MwrW; arc=none smtp.client-ip=118.26.132.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="ZnF0MwrW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763015922;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=WTGtqKakEREIYEQdDsIEMU1UWa2o7DpCYlni2wOwUUU=;
 b=ZnF0MwrWISi6g4H8cMV7Qk2dHypIrv0nqq+Hwralot+BvtLrrpvNml2njIfh4fHP/CfQl7
 VB8Tjv6QL6I+HoIBDSz3We3NP2uU/oTXIA6Dk8UOy3WSiGC56fRQt0wXcmsQF0ItdJeDAA
 WKMUaNZuWyAb2DNvZqsfQITTKOd2ciKI7QX6JUHxbPghiAWlFx+MOaFI03JyWSo1c1AVg/
 fG1wXLwbAxv/5yt1r2/hzWDTYwd0n093aQ7tmda0hrh8QrUmlMdh/07GQSgHrBAtGoQ0QW
 dFj/W7AJ2Le+lWcZh8qoujz0PqohFkYrej4+8taWeZywtOUjRh9PCJIcnz1PHA==
Cc: <ming.lei@redhat.com>, <hch@lst.de>, <axboe@kernel.dk>, 
	<yi.zhang@redhat.com>, <czhong@redhat.com>, <gjoyce@ibm.com>, 
	"Yu Kuai" <yukuai@fnnas.com>
References: <20251112132249.1791304-1-nilay@linux.ibm.com> <20251112132249.1791304-6-nilay@linux.ibm.com>
To: "Nilay Shroff" <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>
Date: Thu, 13 Nov 2025 14:38:37 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Received: from [192.168.1.104] ([39.182.0.130]) by smtp.feishu.cn with ESMTPS; Thu, 13 Nov 2025 14:38:39 +0800
X-Lms-Return-Path: <lba+269157cf0+a58a22+vger.kernel.org+yukuai@fnnas.com>
Reply-To: yukuai@fnnas.com
Subject: Re: [PATCHv6 5/5] block: define alloc_sched_data and free_sched_data methods for kyber
Message-Id: <13a39afc-0521-4f2e-86ac-b320d68ad3b1@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Language: en-US
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20251112132249.1791304-6-nilay@linux.ibm.com>

=E5=9C=A8 2025/11/12 21:22, Nilay Shroff =E5=86=99=E9=81=93:
> Currently, the Kyber elevator allocates its private data dynamically in
> ->init_sched and frees it in ->exit_sched. However, since ->init_sched
> is invoked during elevator switch after acquiring both ->freeze_lock and
> ->elevator_lock, it may trigger the lockdep splat [1] due to dependency
> on pcpu_alloc_mutex.
>
> To resolve this, move the elevator data allocation and deallocation
> logic from ->init_sched and ->exit_sched into the newly introduced
> ->alloc_sched_data and ->free_sched_data methods. These callbacks are
> invoked before acquiring ->freeze_lock and ->elevator_lock, ensuring
> that memory allocation happens safely without introducing additional
> locking dependencies.
>
> This change breaks the dependency chain involving pcpu_alloc_mutex and
> prevents the reported lockdep warning.
>
> [1]https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVy=
jO0=3D-D5+A@mail.gmail.com/
>
> Reported-by: Changhui Zhong<czhong@redhat.com>
> Reported-by: Yi Zhang<yi.zhang@redhat.com>
> Closes:https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDk=
cnVyjO0=3D-D5+A@mail.gmail.com/
> Tested-by: Yi Zhang<yi.zhang@redhat.com>
> Reviewed-by: Ming Lei<ming.lei@redhat.com>
> Signed-off-by: Nilay Shroff<nilay@linux.ibm.com>
> ---
>   block/kyber-iosched.c | 30 ++++++++++++++++++++++--------
>   1 file changed, 22 insertions(+), 8 deletions(-)

Reviewed-by: Yu Kuai <yukuai@fnnas.com>

--=20
Thanks
Kuai

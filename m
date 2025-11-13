Received: from sg-1-17.ptr.blmpb.com (sg-1-17.ptr.blmpb.com [118.26.132.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D373009F1
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763015842; cv=none; b=U5Df5XkctcHLBXdywBGVW1SOYFVr6NcIZSZaDBK+yx9d4R++OJI5b00avi3s6PemsTva2CrVekISKFPaqfIGK8iqYO7aa0FHl2aCCpqpp6rKmGu1y3OzQi2Qih+LdtYJm9ryf/hlVpn/cE16uzIozgWK3kl66OBPUtHnJkEajFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763015842; c=relaxed/simple;
	bh=JRdVWNHz6f5PCRiRmh1ramsp6LQT36r3+SkPAjxYCaE=;
	h=Mime-Version:Content-Type:References:From:Subject:Date:
	 In-Reply-To:To:Cc:Message-Id; b=G9MPUuZlT9G8aVH5oCLEmD4AjwtsVxuhcsJ9izORO1oIutNnJL/Fvidkgk5HUZ7WJDJCZUT/VtDsGar/irqhfO+US6aYrg3sXH5Clu+iZnbhLxJ9co7KELMNb7Lcgn5OkifFbATCwSK1vbDufrMI8kWEKmC+f2cK+b0RxpdAsd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=zI+fmGjO; arc=none smtp.client-ip=118.26.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="zI+fmGjO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763015828;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=MNSBDaHvckdUU6E5xEYP48vBIedlDYUsQ7mdMfQOGZA=;
 b=zI+fmGjOH3SnxuUcAuJBpm/IeTG5T6SitZjZjTRPUWC25cOHV3X8H4/eTb6AC3u8XShjLj
 t2V6512A/SD83hF/aRVDJhQgWhQfO3eDuiHp1hiwq5I+WPJ2qEuFf6+nGJFtGf+Z64LgKx
 i2tw3KQHk79aK83P6lzn5+UtghRh9WhAAeqxSseZhCsXHKw/VDD7pQJLJ2DL3cv3mE8zXN
 7t27Ceao4wU2xiQt/ppEj9cdD7myATMZJE2dKyMbr3fHYNHhdMU5x2kd2nNx1npqX/zfcs
 V0dyO4Rf28upOBrAwJ2pCRCHPI4JoDxSe+xhIk3306+87m7YVNWQuR5tvKXV+Q==
Received: from [192.168.1.104] ([39.182.0.130]) by smtp.feishu.cn with ESMTPS; Thu, 13 Nov 2025 14:37:05 +0800
User-Agent: Mozilla Thunderbird
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+269157c92+c3c28f+vger.kernel.org+yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
References: <20251112132249.1791304-1-nilay@linux.ibm.com> <20251112132249.1791304-5-nilay@linux.ibm.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCHv6 4/5] block: use {alloc|free}_sched data methods
Date: Thu, 13 Nov 2025 14:37:03 +0800
In-Reply-To: <20251112132249.1791304-5-nilay@linux.ibm.com>
Reply-To: yukuai@fnnas.com
To: "Nilay Shroff" <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Cc: <ming.lei@redhat.com>, <hch@lst.de>, <axboe@kernel.dk>, 
	<yi.zhang@redhat.com>, <czhong@redhat.com>, <gjoyce@ibm.com>, 
	"Yu Kuai" <yukuai@fnnas.com>
Message-Id: <506e7224-064d-4019-9367-0387409ee12a@fnnas.com>
Content-Language: en-US

=E5=9C=A8 2025/11/12 21:22, Nilay Shroff =E5=86=99=E9=81=93:
> he previous patch introduced ->alloc_sched_data and
> ->free_sched_data methods. This patch builds upon that
> by now using these methods during elevator switch and
> nr_hw_queue update.
>
> It's also ensured that scheduler-specific data is
> allocated and freed through the new callbacks outside
> of the ->freeze_lock and ->elevator_lock locking contexts,
> thereby preventing any dependency on pcpu_alloc_mutex.
>
> Reviewed-by: Ming Lei<ming.lei@redhat.com>
> Signed-off-by: Nilay Shroff<nilay@linux.ibm.com>
> ---
>   block/blk-mq-sched.c | 27 +++++++++++++++++++++------
>   block/blk-mq-sched.h |  5 ++++-
>   block/elevator.c     | 34 ++++++++++++++++++++++------------
>   block/elevator.h     |  4 +++-
>   4 files changed, 50 insertions(+), 20 deletions(-)

Reviewed-by: Yu Kuai<yukuai@fnnas.com>

--=20
Thanks
Kuai

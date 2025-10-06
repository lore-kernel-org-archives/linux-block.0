Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEAB846F
	for <linux-block@vger.kernel.org>; Mon,  6 Oct 2025 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773735; cv=none; b=HoIhLeqq6KjNjfs4cN/u21RebJpWrinaF2FsXvPKZU3g6rKiVckBzu/G/JU4l5kdSyJ0Y3tgJ2NLLipjuxtI3N435J7qHfUuP7u/DoggOiHtCoEM9SwABkVNHSpqdeerk5LbE07wfJd8ymoYxF0jJ+0Pm5m3Ggtooo9//KuL1W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773735; c=relaxed/simple;
	bh=7+gNMJgsHSkD1AEvujqNJ+u6tKXAd+Qn6h1sHijskCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYH3ZqQkbLRxdzb0saQpvQXrNlP+dPhygKSLMJvLYC6BDbHPXo9KgcC0WzTDeaYBD2XFXHGtmw8w4CD39Omk5UO0nLndG65dZ3pd5M4+orWbm+tQko0SUHvrtDaH0m8Pn/ePSiVEPe/h6AXuF6KT9Ci1xAlwzRVvHNB8Cr8pX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rlSVdzds; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rlSVdzds"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cgRtY0S4Pzlgqy1;
	Mon,  6 Oct 2025 18:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1759773731; x=1762365732; bh=fvK3RsS4VJinv86tNMu8mj4+
	OOC7NIwmRtKkVfmPlRQ=; b=rlSVdzdsLZw/xGq84IXoP4TZJKt4qVzw3G37TWle
	Wtaef862t18jfY4rPPpInmuHQFg3aob8r+P5X9uw+nXgMN9FJcs/BiJDdJoJYEcn
	siKLFvrFHYqfDpswIpzcn41QCUM78gAADHHS7vZso6oW3pRD1XSiPX6d7F2Dtc5y
	x/TLQoCmopSJvR+wdBr+otfCULog0787Hr0ICYWVLryU0SxRwGlGDZup1G1t4euP
	GtsveaOEIk0pAhy/Yicqt2cJ+4csBqAqLzuJxLVOqdkr8wZ2/yxz9hZkqZBFuD1/
	flnkuaQ1yiDQ+grPk6fAz50I7CZ4+XZMdnib+4XeLY6Y6w==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zOKoR4wDiUhw; Mon,  6 Oct 2025 18:02:11 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cgRtN33T7zlgqxl;
	Mon,  6 Oct 2025 18:02:03 +0000 (UTC)
Message-ID: <4f16e17d-796b-4896-9d4c-6d227514f1ca@acm.org>
Date: Mon, 6 Oct 2025 11:02:02 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators - Rockchip UFS regression
To: Ming Lei <ming.lei@redhat.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Yu Kuai <yukuai3@huawei.com>,
 kernel@collabora.com, linux-rockchip@lists.infradead.org
References: <20250830021825.2859325-1-ming.lei@redhat.com>
 <20250830021825.2859325-6-ming.lei@redhat.com>
 <pnezafputodmqlpumwfbn644ohjybouveehcjhz2hmhtcf2rka@sdhoiivync4y>
 <CAFj5m9Ki1U6N4N6-=HYy49KfvYAbegmwcXLuKCxjX4E+qy7u7Q@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAFj5m9Ki1U6N4N6-=HYy49KfvYAbegmwcXLuKCxjX4E+qy7u7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/25 7:42 AM, Ming Lei wrote:
>    One possible fix is to check hba->scsi_host_added before calling
> scsi_host_busy():
> 
>    dev_err(hba->dev, "%d outstanding reqs, tasks=0x%lx\n",
>        hba->scsi_host_added ? scsi_host_busy(hba->host) : 0,
>        hba->outstanding_tasks);

My preference is to add a check inside scsi_host_busy(), e.g. as follows
(entirely untested):

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index cc5d05dc395c..17173239301e 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -611,8 +611,9 @@ int scsi_host_busy(struct Scsi_Host *shost)
  {
  	int cnt = 0;

-	blk_mq_tagset_busy_iter(&shost->tag_set,
-				scsi_host_check_in_flight, &cnt);
+	if (shost->tag_set.ops)
+		blk_mq_tagset_busy_iter(&shost->tag_set,
+					scsi_host_check_in_flight, &cnt);
  	return cnt;
  }
  EXPORT_SYMBOL(scsi_host_busy);

Thanks,

Bart.

Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C2413783;
	Fri, 24 Jul 2026 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927345; cv=none; b=hPDMBBSfdMhHwkCy1E2si1YkvThUi2ij+tfo0m2ZHtrYiGphNZTwFMdHKWbOrYgmoHlWygyGEvDpnTkG4CQxFF2NsskbTGzA5C3BEhzVE2llcnMdVfCLWERHabUkoFsy09QygwnoFLIewlaqDKSSG8sNpJRqLUCo/CWqb94MF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927345; c=relaxed/simple;
	bh=FRIggP1YvWWV3rj+5WU1Cj2nMoZrQOSbDSPE/2jMC40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFNzmUiKkDmKAIzSqxEmnkBfFxSijyOdiFKI0TLRgk2iWjVcBRx8p5i162WWwdWwj/0eiJybmWDUr0LO/JvdlT7MRD6sghVVK6orovGw4+woLXDwAiq4AC61scQTBa6FwUO6rbOv33gAfTVn8ANJs0O1gdx8ilhhj4eVKcl9s14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nrusQrhQ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nrusQrhQ"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4h6LFm2P3xzlfvpc;
	Fri, 24 Jul 2026 21:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784927336; x=1787519337; bh=FRIggP1YvWWV3rj+5WU1Cj2n
	MoZrQOSbDSPE/2jMC40=; b=nrusQrhQSEljsn2S6l66GEy9kxAkJkZe4SEmqkNz
	Uc41Y+GvkK01BnkiWcb+kyRnOUNhZCprEqB8ddGutjBhvSozV2NPgFSwz7ySharc
	pi2BcPt87yHut4pW30cJSVNDtkUUhPH8sSVWGsssVKC9xSb+lqe328C1P/tUwlcy
	5xSqvG3Qq7wGVMO4N0w3hBpJzAtgWk1kFmniMrAbMbKhDQg5Copl5hPD28FlnvXl
	xHh8W1Cri1ChPYHX1EqEkZEcpGqdT8usBQ2R/6ubpeJrg5ZpDJnTFvEoVdwFh7UE
	6O/lrCUh5njbP8M1gNa50IfjN20CVew9hegGawyPtNWwIg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3_bfYDR74_ef; Fri, 24 Jul 2026 21:08:56 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4h6LFd1TjRzlfvpW;
	Fri, 24 Jul 2026 21:08:52 +0000 (UTC)
Message-ID: <21529ecb-6d15-4348-824c-b7682bcd7ad9@acm.org>
Date: Fri, 24 Jul 2026 14:08:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 6/9] null_blk: clean up null_del_dev() to use cached
 dev pointer
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
 <20260714041805.1088702-7-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260714041805.1088702-7-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

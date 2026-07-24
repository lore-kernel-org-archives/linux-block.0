Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464FB439F6E;
	Fri, 24 Jul 2026 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927407; cv=none; b=sm4NB3xRMcdlYuS4OpI3K7nsQKNktLi7wuri0xrceXuNsnxXxQ1ScUOmqxQon8pPwpizHS/qvdN5IQbkjsp+dRiu1mLC/BiSVuQSx5z7YUwhiPv2Knuhm7mwGadAO/Gko7OYjOh44OUNjqEzhWDey0nWbiuA431QrNeJykwuic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927407; c=relaxed/simple;
	bh=FRIggP1YvWWV3rj+5WU1Cj2nMoZrQOSbDSPE/2jMC40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0vhVqdaCLbIaQ8FuZu4a1a+uDz0jw7Pqoe6q6Opjs4rjf6DWE0J9L0ojwIduIo92Dus7/QNEGPFtXtvUOb18TTVPBYFsgfcmk1fqHFXia4DG07abIg4oExmLG5suKG0bfZ5Va8pyBWZPGTpXXpHV54azhXYg1skhRHsjukIZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xZuqqgN9; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xZuqqgN9"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4h6LGy4gc4zlfvpc;
	Fri, 24 Jul 2026 21:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784927398; x=1787519399; bh=FRIggP1YvWWV3rj+5WU1Cj2n
	MoZrQOSbDSPE/2jMC40=; b=xZuqqgN9k044Jsn1nnLn39etpSUM1Z7I9vWoSIYy
	poOBA7r+X4xtbcMj/FAeIJCQIw0YAcQkPUS+EX2yR5iCoINmVZO9dazlsQ+UlWp4
	Y7aZ70cl7lBF7RIqz7muVY+TEC/8w5pUTzljZVs8xkQ97XyqAwVdZIJcWw842jtI
	AWqrYSWIQR/J+fgZ+59HWgLobRyqRIgXrVflkDUjbSf6ltuehD/8d8U7sOr2hABP
	6NmWs9NyXmDkI5xHXk2pW8Byt1jRpbmPh2kA225lAWN8ycIbcdYIc482SMs9F5Hr
	6H3vfX/ImroikYONSuuc9T1tOQ6xTGfamjbLZf5sh0NYLQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kcTRC_4GrFcF; Fri, 24 Jul 2026 21:09:58 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4h6LGp6WRLzlfvpW;
	Fri, 24 Jul 2026 21:09:54 +0000 (UTC)
Message-ID: <351cbda7-5bd4-4410-87a7-b6a1f9c03b96@acm.org>
Date: Fri, 24 Jul 2026 14:09:53 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 7/9] null_blk: reject per-device queue resize for
 shared tag set
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260714041805.1088702-1-wozizhi@huaweicloud.com>
 <20260714041805.1088702-8-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260714041805.1088702-8-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764B62DC786;
	Mon, 15 Sep 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951982; cv=none; b=YPV+IzJ2THO4NwgkhS3tukg/2YvfHo9sVGQCz2ga9dHMoHV7ZeJQrTgaKhNYz0ewn7rCUQfu/LZhIlb7v10LAlJg78Yvph2dyI6GiwtzZlBIg5PmcAaSyQjxgUrZGwqj5PgzItZaUjwYCbJipEIk5u+JuKa4MxBQDLE4lAL6mp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951982; c=relaxed/simple;
	bh=nL9ggkeLKrCag013OOuf2Q3tK+5yJb8z4YPOcfsj9ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opLDsGwN3L2EQMOj1bDinT9GiQJO/ZbzXXBIdpZGpE9kGKFpY3l4Qliq+Lo12CRrUgjAdmd+TPPTsY97cIX3X1mZdPI6/mMyPZrA6VrE4vKEnTu6TZCKelStsB8EMnv7OhIbJqmhI7iIpO9aDMx50dyl/cDFZWdiav6Znb8eGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TGFpRk15; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TGFpRk15"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cQV8q2SzFzm0yVd;
	Mon, 15 Sep 2025 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1757951978; x=1760543979; bh=UvimxUoZtBhyUDAYakrj8TxX
	dlqZ1vtiiNbu0AdWBx8=; b=TGFpRk15MH/ooGvAu2NCTZhho8GCRmFPVLcgXz4n
	mHz8j5iCgQTizRF7MxnzSL4Ui2L6p3l6RWjOCh/uWhgFUFf92g+GmOKPbLZE7cTl
	hiRDVB4wa9JB2OQjHaInKA6bqfKH4YuWCf82DLVXIwlG6atvaT5ezFoMCo22JQQ7
	idrx00iBCXNs8nMVxTRHqHrAlGp7Cle6W5XCuOomWSRJHIrGaAQdQuzXJ9TRel0/
	dDPcFYHT5wCrp7EqsvLdts9NXjARQdPKzvgorXcGbFTXBlSkOg9riLprBKrmhxVY
	T/56wqtYEw/Itnx6C6mOYlYZprqapS1VcRTywXGAnnewag==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id E7Fnayo8jkLR; Mon, 15 Sep 2025 15:59:38 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cQV8k4Q9hzm0yV6;
	Mon, 15 Sep 2025 15:59:33 +0000 (UTC)
Message-ID: <41ff57c2-19d4-495b-ae51-f30e555a74b4@acm.org>
Date: Mon, 15 Sep 2025 08:59:32 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] block/mq-deadline: Replace DD_PRIO_MAX with
 DD_PRIO_COUNT
To: chengkaitao <pilgrimtao@gmail.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 chengkaitao <chengkaitao@kylinos.cn>
References: <20250915130606.97949-1-pilgrimtao@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250915130606.97949-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/25 6:06 AM, chengkaitao wrote:
> Remove redundant DD_PRIO_MAX and enum types, Move DD_PRIO_COUNT
> into enum dd_prio{}, and similarly for DD_DIR_COUNT.

Why has this patch been reposted? Last time it was posted I explained in
detail that in my opinion all changes in this patch makes the code worse
instead of better. Additionally, when a new version of a patch is
posted, it should include a changelog. I don't see a changelog in this 
patch. Please drop this patch.

Bart.

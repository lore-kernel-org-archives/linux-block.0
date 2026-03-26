Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D36A42317D
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546922; cv=none; b=kQVM1t5wBFIFlucPW9upkhuHDvmk+aAqTHLehy3FjPud4FIx8XtjO5axKfiZUi6j1KJgbU0uFKiq9QJrWSLsCUhMl/KHcRidH4J2ApMs0rqj0Q7M/mTIOW79bmIM7LHkVRwV6v0LIhPvuIOJfHEpVRHDPFNmX67ixmgAqDJ1i2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546922; c=relaxed/simple;
	bh=NesLQnSpXsMp85bu+iN4UJOAA0KLNIAABNfl6iM9sY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uv85ligqCmeav223qOrkZ6XdZc8xL8o76w4RN1VIOkIGOSr8gvLTg8/jj3+7uselvpjWqRFIJygOxGgk640NPGZtqVmZKRZMzn4WfqBA66xdHvcCcGmu+1sOT/znOPUXydUHnpRUk2lKyxuzEdQe2q+UG4/EFi3f3XJunUqxB9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4CltBL2z; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4CltBL2z"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fhWLG5LZdz1XMFjb;
	Thu, 26 Mar 2026 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1774546916; x=1777138917; bh=NesLQnSpXsMp85bu+iN4UJOA
	A0KLNIAABNfl6iM9sY0=; b=4CltBL2zGZSU1rj3CAmPPO4ndn1LZZM/clQTMHJy
	JQ9jcT6ZlEpJNAADxg7L9Mi5ut3r1NXMtlDvBXH6e+I8dKvnNsXnRYO+wTx2KRtA
	bWINkn0658xvCB6MIf4d1YRNfwU29Hxr4KanJ5ukeobOEGCAIW3HWGKKg3JwUXqy
	1mg52VRvkns1U5jVv23dgeCHIb581QW00U8JQSnxxw1o5WyJ2K4c0tyCMSdDZR8G
	j3mf4p6z7FRq3M7ktk2Y8b5PUeciQ5fNGXRfzB52aAAxhoVj0RlIynXn3pP5oC4o
	wE6eopnaHi9Spcm/ktOakT0MnlaM0AdzvbBw32fBA4+kfw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hrpGrLLPiHJ8; Thu, 26 Mar 2026 17:41:56 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fhWLC41clz1XM0nj;
	Thu, 26 Mar 2026 17:41:54 +0000 (UTC)
Message-ID: <fce9861e-1b05-4124-ae57-76392536a1e1@acm.org>
Date: Thu, 26 Mar 2026 10:41:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/044, scsi/012: Add tests for support for segments
 smaller than the page size
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Ming Lei <ming.lei@redhat.com>
References: <20260323200751.1238583-1-bvanassche@acm.org>
 <acPFQ3laJg0MDRSM@shinmob> <acTocO4Bm-eAo1Ag@shinmob>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <acTocO4Bm-eAo1Ag@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/26 1:05 AM, Shinichiro Kawasaki wrote:
> Today, I reran the new testcases and noticed they leave fio verify state files
> in the current directory. It would be the better to add --verify_state_save=0
> option, or use _run_fio_verify_io() helper function in common/fio.

Hi Shinichiro,

The detailed feedback is appreciated. I plan to address this feedback
after the kernel patches these tests rely on have been merged.

Thanks,

Bart.

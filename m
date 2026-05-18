Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DBD352C4E
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124290; cv=none; b=ppxJCQEYFgksZkPQa1xpBYclBMmFT45LYoyqQAW2AUKtG1l2ndUB2U68opcUVhb8630ymfSa5GJpjKO8qBiUP3UP8fyUkSxpXsfCHqAEjg13YkGx/0wRbiXMjgephxE+L8bs9rOdzjBooELP04Bw2ipwythTDjQXkucbUuMmtbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124290; c=relaxed/simple;
	bh=oRTJkVWF4HeuSUN2WfzzdMQeErRdHBj39qDSjGUtqf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=borXqf2o7F0Si2Rqk/21ND1WdnPKNTPuN8sJQAONbjYdanAb8knY8cI73KXjiUlKPOT4YohuGFMZjsFv8PUbNqNptqecR2yGnk5E6sdXJ03TM9OQyDq2dAqQEckoMgypVhqauav1V0/Geo1kGrsJswpC6leZZ0ElfoYQoHYu0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YURHATHC; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YURHATHC"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gK48c44Whz1XM6JS;
	Mon, 18 May 2026 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779124286; x=1781716287; bh=oRTJkVWF4HeuSUN2WfzzdMQe
	ErRdHBj39qDSjGUtqf0=; b=YURHATHCnGLzPfg4VFv2/hBpoJ0uJyDIm8XB0tiQ
	mwvHQucOgky6IZe3PzPjrdXZkJRaEWFOTYPD4VrOFFpFBrzCVc6iCfon73vgj1TV
	yldjwf3aRvmIekstIBIMPKnJDX0qubi6sWpDb4off1Dz1Tz3SwauTtRap9G8kb5J
	1j2WPbSH64jedUEMaL0ZQpCK3Bmq1xC33mIQxv+g51xQnqZwsNoyTeiqaBUcDuVH
	hNPG+PiWwExJ7s73F2qYT4+q41RWCH0/xBB3oGiuAcL9i0ISvCYGUV83I80KWJY3
	hg3XEXpueh81aKH5ao4piJfb5eCf9Xtj3X/1tKDuFIOmYg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id aPP3SOTTIP_a; Mon, 18 May 2026 17:11:26 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gK48X3mRHz1XM5jn;
	Mon, 18 May 2026 17:11:24 +0000 (UTC)
Message-ID: <b4a8ae4a-1d24-4bce-b53c-17729d070f0b@acm.org>
Date: Mon, 18 May 2026 10:11:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 0/3] introduce command trace feature
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>, John Meneghini <jmeneghi@redhat.com>
References: <20260516120729.113659-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260516120729.113659-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/26 5:07 AM, Shin'ichiro Kawasaki wrote:
> Some blktests test cases have deep nesting, making their behavior
> difficult to understand. For example, the nvme test group has many
> helper functions that set sysfs attribute values and call nvme-cli
> commands. Understanding these behaviors is essential for debugging test
> case failures.
For the series:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04763DDB04;
	Mon,  6 Jul 2026 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343616; cv=none; b=EDMYD0GXnqazJbKG/f0qOxeHA6K2R0mUQ8q+feQEdBl1oLEA8X6Tbs2FgAi6dloBpqmhm/45u3vkPbDIJpcentPVf9hksm0cG4kMcAyPlysKlxHDkW8bczP3cC/EwPRsPnKA0e4DSDQClSVcdcP2eIp9d98YImXa3oyoygWh5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343616; c=relaxed/simple;
	bh=OvP7c6B/T6tXt3wv8TH/i25KJxipcYcvsjjMFh+Wu1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1Hwcafiqj3Y5DpfXKAPsfpKuIYL5NqqXlvONR2yL0k1LxUeADMH2UvvS9jWwvPNVn1IW6sMs1CFgrfkiQhQrcjFKZ903aAhjIcc9vGfBJQCPLFv6FGgzoYWJTbjpN7xOAxw34pmzVhZwXKFfKjIABeORLXxUbpVyFqeiUfn7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LbvauM/s; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LbvauM/s"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gv4YV2YyQz1XM6JQ;
	Mon,  6 Jul 2026 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783343609; x=1785935610; bh=OvP7c6B/T6tXt3wv8TH/i25K
	JxipcYcvsjjMFh+Wu1U=; b=LbvauM/skMvZ2GRdI0s7yZkL/Umop6HY/G49aFRe
	MUJSpmTTOJUJ1CkKktT/dEo86io9QSk4rj7v2i3skR+hwp08eVW3REoWS1IvwlAm
	8i7MYAoSgr0h7eAAEiYEVem+B+WsfJrUNKYq2AqyW/PNlJPS1zYfiHzKbUPo+t9d
	323Jzjmd+W0uz/CrheN4b0yGSwT81M36rPaW9MB0Q21qtABXdC0B4HsY2GKTmWuu
	OC02eqYgf4JrSeIp48H3YBPWf4wME4qLONvfYXffy9OjHhDxlSZ2SchX8J+Gyc+7
	OHG+ob1kMuEF/znEk7Fz8Oz3ov2T6k/ye2FfoHolqSJjYg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id O95jNDLxVLp6; Mon,  6 Jul 2026 13:13:29 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gv4YK0pMTz1XM6J4;
	Mon,  6 Jul 2026 13:13:24 +0000 (UTC)
Message-ID: <7110edad-c10b-492e-afcf-1a597eae6b71@acm.org>
Date: Mon, 6 Jul 2026 06:13:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] null_blk: use DEFINE_MUTEX for the file-scope mutex
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, linux-block@vger.kernel.org, kch@nvidia.com,
 johannes.thumshirn@wdc.com, kbusch@kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260706123507.3809871-1-wozizhi@huaweicloud.com>
 <20260706123507.3809871-2-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260706123507.3809871-2-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 5:35 AM, Zizhi Wo wrote:
> [ ... ]
Reviewed-by: Bart Van Assche <bvanassche@acm.org>


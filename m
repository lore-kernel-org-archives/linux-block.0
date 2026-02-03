Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC93364EB2
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141906; cv=none; b=iCz5wbf6hEO4ynPMSDqC1FX4eerxRvDB61K9i8n7lM0yNOhupttKWcm9vutiuj5YD8/itgwi3OK0bqj2NXXI1O6dfus4ehKqvf1iougCG78jUzXpTEN1qisSXOdvRR6cSDODBLo1Ap5RFfXuCg892jRM02E8ZWgls7OVjB9GTaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141906; c=relaxed/simple;
	bh=iZpC8eIiXGhWIey7Kj9X88+1Rk0f5paUn9XUME2Aif8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxX9O+0Ocg9MhjKtWvtP9Bn6qQip73Q4wbtgUq0MPG0QuxZUoQwO78CywilEj8w8/0fSj1aRTSYrq2MauqiBZO478RTfrVlDkIZVh2jO/T7CYPhiUSZeUo7SWNqeXOYTXtnvQaKIhgGKE2Y3EntxS0YeV7hMNAOmRmjIJnaCeWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JeIvQUAa; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JeIvQUAa"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4f5BB54ldTz1XM6JN;
	Tue,  3 Feb 2026 18:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770141676; x=1772733677; bh=iZpC8eIiXGhWIey7Kj9X88+1
	Rk0f5paUn9XUME2Aif8=; b=JeIvQUAawWOCbJpK8dGMDUA9Apwv5J0Z1c8Wa1qT
	4m6K0x6MN4yvWYr1SKf5nk1iF1ml/RrXhClExQrK079ExXomE9TVqp1hq/2zV5bB
	oXclj31wcsRV3UVqsqTFksUDe9RXTFQhbHRxKAxUS4Hkw8CH71vCvRr8o/n/Hxbi
	9y43xjDt8aM0xBJ3BnPnCK2D5+0iNocLmqmsOEmIDwqiSKGmvlWpaSgl7CkvaiFA
	tXTdLiXaEJg3fmmpbK/+r+pbz5fU18AoCge+6I5i4pqEE4L57UNLjQYyckPS0bhM
	Y5A2alcBZo6ZdE4ZSIEu6B8RbNFt0oxNrcyj0lg3hqfPqg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Lao737PDAOG0; Tue,  3 Feb 2026 18:01:16 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4f5BB25ZBqz1XM6J9;
	Tue,  3 Feb 2026 18:01:14 +0000 (UTC)
Message-ID: <0ea1530f-31d0-43b6-b35b-1286fc58fd19@acm.org>
Date: Tue, 3 Feb 2026 10:01:13 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] A block level, active-active replication
 solution
To: Haris Iqbal <haris.iqbal@ionos.com>, lsf-pc@lists.linux-foundation.org,
 linux-block@vger.kernel.org
Cc: Jia Li <jia.li@ionos.com>
References: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/3/26 7:09 AM, Haris Iqbal wrote:
> We would like to present the idea and internal workings of the
> solution, and also discuss design and some benchmarking results
> (comparison with RAID1 over RNBD/NVMeOF devices, or DRBD) during
> LSF/MM/BPF. We also want to get feedback, and potentially get more
> people involved in the project.

Please include data about the time needed to recover after a network
disconnect. Is this time proportional to the size of the replicated
volumes or is this time proportional to the amount of data that has
to be resynchronized?

Thanks,

Bart.

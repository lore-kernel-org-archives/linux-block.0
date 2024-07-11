Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF7F86AFA
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721730; cv=none; b=LHJDDxc952sS6zDpHTcEMtN/T7cvlkmI3/Ve5FeTLRBZx53eYqc1vLROSm3VbaGQpWyuQWDURuP5p4M4a5QofrHiKiMPd20YnaHrD62wSjtvkLThJAz6qQt9tVt16iEkHtk7//jUx4XLwHHAlGFIhg1aMwePhEeuDG9IuWAUxDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721730; c=relaxed/simple;
	bh=wKRiVpnf8VWLJAzdR6Qp9JH2Y4y2ot5QKJfSTHH9OtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7AeCrG6kTwSYe8RVhnHvXLzih45WP65La5y5bnUwS7r9TsHZ3oy3BzIB8og5CKCo0CHHJHGOqPAJCR55xDEoEAF0w/HD4ocisRVkUQTOkzuU05p6hma4in5CRTizNEMcX56y/PzL2WrAo/pti0GOhLT7rhWbr4qv+9hFIZXXjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=uKUQblMJ; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="uKUQblMJ"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WKjZS27S8z6Cnk9Y;
	Thu, 11 Jul 2024 18:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720721726; x=1723313727; bh=wKRiVpnf8VWLJAzdR6Qp9JH2
	Y4y2ot5QKJfSTHH9OtU=; b=uKUQblMJd+6vKJEzplDiVOydoj92PrdbKSzdxO50
	kFo3LpO3xktzg+fwZPPmpTIyB09ZwrJVdy6469qZhlYbfmAScHlRW3OpLozX0j3d
	N6rsrOZibSu16l9LWf+w0gaxzXPBHhSFthppfpNVP61aHYCzRCZTiQe/vNC0uYLT
	/JRfU3h8Q98wgII6cGenzOEAm9dJMBM8NWbMTgPJUMFuBzp5WyO2p44EjVLsj8In
	TFITayaat0M2ICkbEaA2q3wKe5EnX5Fk/UEaaMgV+bi8tBwAp31EyhcGUQJtGzn7
	wiTuFgbo7voT2N6AK5RHeqE/e6tr2oxDCVRrbzAOhepmCw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id f039HZym804X; Thu, 11 Jul 2024 18:15:26 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WKjZQ2Xhlz6CmM6X;
	Thu, 11 Jul 2024 18:15:26 +0000 (UTC)
Message-ID: <ebe27227-f137-4ed6-888c-2ece88107b18@acm.org>
Date: Thu, 11 Jul 2024 11:15:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] block: Catch possible entries missing from
 rqf_name[]
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-13-john.g.garry@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240711082339.1155658-13-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 1:23 AM, John Garry wrote:
> Also add a BUILD_BUG_ON() call to ensure that we are not missing entries
> in rqf_name[].

Please leave out the word "also" from the description since it's
confusing. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

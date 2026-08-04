Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72932330B0B
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867856; cv=none; b=BOrmpp7VrgIqBXJH6QVGt2T9YBoS1RD8fOotkRjT+CyxZZ4g3K2YuWN0OBbjjfxUeu2VWEZD+d/3dlCGg8C2bsDQej/VydEYDDBOIRoPr6C99u7ism1hTBO+uO6qNqfU+E331UdDt3Ay++tshIaFU+hsZ3un6iPoCy0M9HHE5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867856; c=relaxed/simple;
	bh=JPkOZki+1oxItbFS6iDSlxrGZHeASxoQc7fu3/0HDzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkozuenEaQPOevtpSAs4gJEBzTjPaqf7yoy0nt06uLteoiTrgjqWMxduBUwEzho5Q/1YMUm12Oi/WE3vH607Jq5MbfA7ZNy1MuLd9KOtTm2BP/3nQq9iXwHAKw4PMjWK8Mi5ozZCZetBL0p93TWBU9OrUDKZfdSxOXK9hm77XFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LKq4vRTF; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LKq4vRTF"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hF24T3CrrzlfvqQ;
	Tue,  4 Aug 2026 18:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1785867846; x=1788459847; bh=7XHpOvVVQZ0m01C+DkzKtLZQ
	35TBd0Bt+sRZ/0OxA2E=; b=LKq4vRTF5l8VDkV5QpTGHM4KGPr4hJF+rk0PZAHI
	u2BmJqBIPRB7nEcmPMjYVsPkfnUzW912FDNtHi4/ePylsA3wUP2/sSa9gsjDxD+4
	VXUPFfq6+O1PzblxSYWpnbGMRcOLlAFM3gT4I9nx/2rcGgC0D/PYYJQ8MhVdXBI+
	OgzCMa39UsmDGm+yMalcZIcf49m9JVf3we+/BaaPDREepx7Tilq3mRpnyzE8SJHI
	nj+OFSI32bWpno8cycU1SNpeMsNwO/zGHwD5LNj6spW+3IiQ0QfzPvA7xgC8CfFI
	s6Vrppv6tD85uZWTtp1Fjlt9Z8PkOCfhEiU/doGfIW5zRA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id y5ofg3H7Y9Gm; Tue,  4 Aug 2026 18:24:06 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hF24N0CD0zlfvpS;
	Tue,  4 Aug 2026 18:24:03 +0000 (UTC)
Message-ID: <4162153b-49bf-444b-9bb8-fc0209f3a0f9@acm.org>
Date: Tue, 4 Aug 2026 11:24:02 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] rbd: Enable lock context analysis
To: Nilay Shroff <nilay@linux.ibm.com>, Marco Elver <elver@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Damien Le Moal <dlemoal@kernel.org>,
 Ilya Dryomov <idryomov@gmail.com>
References: <cover.1785440858.git.bvanassche@acm.org>
 <0b2988ca05e8a2733352a447e0810104b878376a.1785440858.git.bvanassche@acm.org>
 <487841d2-9d55-4873-ab6b-dbd94aa7bb71@linux.ibm.com>
 <83968777-6f3a-4c21-ac89-fe9ebcbf254d@acm.org>
 <4f4a40a4-082c-4b3a-9fec-5b7fa54c6a62@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4f4a40a4-082c-4b3a-9fec-5b7fa54c6a62@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/26 3:48 AM, Nilay Shroff wrote:
> However, I still think acquiring_list, running_list, and object_map should
> ideally be guarded by their respective locks. The fact that some code 
> obtains
> pointers to these objects before acquiring the corresponding lock makes the
> locking pattern worth looking at more closely rather than simply leaving
> these fields unannotated.

Marco, to implement what Nilay is asking I need support for annotating
function arguments with __guarded_by(). This would not only be useful
for the rbd driver but also for other Linux kernel drivers, e.g. the
loop driver. If I try to annotate function arguments in the loop driver
with __guarded_by() the following error message appears:

drivers/block/loop.c:2002:30: warning: 'guarded_by' attribute only 
applies to non-static data members and global variables 
[-Wignored-attributes]
  2002 |                 struct list_head *cmd_list 
__guarded_by(&lo->lo_work_lock))

Your opinion about this is welcome.

Thank you,

Bart.

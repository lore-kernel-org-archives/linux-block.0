Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3208425B1D2
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510767; cv=none; b=nsJ8clrg2CtUyBJFiuefzrNRbT5VgpxGClpxNajyzMdFqSfFwEtCikXNBQtVtmQg9Aada4AUAlafoj6lhwV9PgG5/7Y46oTUHKn+lOOabIxZNdCBVNleMJlWjVSaZB5pE7fJQDkAgk+AkeZFrANUe5JJU2maS49FCE+nKopRLQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510767; c=relaxed/simple;
	bh=FXKNMjvu/8vBwWQ8lk8ncpvPqKuBPMD17LAFJ+3jXyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+troMRdw1D9ufje7wc9yVtsO/HH7WI5EOUiZaOGwXVIwcbRcZm+TY6JNm5Op+zJbd2zt3Kw76bdSc9DT+FB5WAAgXyVkVpuG2kJQmLUsH2mC+LonHRU/yQSvdBaMw4mae6HS8tCZXYIgeCXbfpvOwOTUwlfjh3mWPEsqHSpmKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mqFbFzp5; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mqFbFzp5"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bgnt525Htzm0yQL;
	Mon, 14 Jul 2025 16:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752510763; x=1755102764; bh=+PLbwgUnwjvlu3NjuKPKTHn4
	LyRXyzQMtUloJ+Wpu3Y=; b=mqFbFzp5q/DYEyadY2bhC7qG5QnljwvbIjF+DZiq
	1iRVrb8qRCU14UeEnNxvw8s02DoXgLrvcwbqMVLmzkf+nhdEGSIB5p1RNjxrXPla
	EvPlv9ZTJ3PpDQbgd/0qeHa2sqtNZdKK+rV/w3uRdH+mcf9gXsdHmyXYIlyvNIrN
	1/0aGfW/iartYx8a6rJi8jcVf/CvtxKkKVrh1ZMLUiJCLRAHOIlnW9QDRT/4qt1j
	2U1s3CVZcD/wg9DUNV8/sx+P5MkUh+Xr3hFto7oDpgq4g/ZbTJAadGu+9Lzufb7r
	CcFgW7oodRWP7A8diY08ht2yKpRhHKZfvl27V17Ug2vLxQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gQ48Idq1vaef; Mon, 14 Jul 2025 16:32:43 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bgnsz5CQgzm174S;
	Mon, 14 Jul 2025 16:32:38 +0000 (UTC)
Message-ID: <833d34b4-31df-4480-a23f-e6f8e3f1fafa@acm.org>
Date: Mon, 14 Jul 2025 09:32:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] blktrace: add zoned block commands to
 blk_fill_rwbs
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
 <20250714143825.3575-2-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250714143825.3575-2-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 7:38 AM, Johannes Thumshirn wrote:
> - ZONE RESET and ZONE RESET ALL will be decoded as 'ZR'

This line from the description is no longer in sync with the code below:

> +	case REQ_OP_ZONE_RESET:
> +	case REQ_OP_ZONE_RESET_ALL:
> +		rwbs[i++] = 'Z';
> +		rwbs[i++] = 'R';
> +		if ((opf & REQ_OP_MASK) == REQ_OP_ZONE_RESET_ALL)
> +			 rwbs[i++] = 'A';
> +		break;

Otherwise this patch looks good to me.

Thanks,

Bart.

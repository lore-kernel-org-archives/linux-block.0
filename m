Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E6F70836;
	Tue,  7 Jul 2026 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783397948; cv=none; b=f3OEgQGk+jIN/MRQ6scEkqv7CemBUa9Ik7vggIGiI8MwdKI9o16sPeQauC6+MfetqgnrKBRLomlgUc4CA7+AGs0MMRSrrFijPfsgUxV0+OuTbvMcxSstlGn14W1dL7AThDY+5MZyMOeNtTywbP3jYJ/gpTswttQwj8fU4zX9sH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783397948; c=relaxed/simple;
	bh=y/UoNh0ACXDWLWycJypBAbisMEtPgIHUIs5Lc06q/vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dT3m7P2au54b/Mj/u5LZPIANeXmUztzds144l7FO3HSEfDQbX4zDgWxcSCpdb1NAGHEV7S7dlUAlCl5FOV0R3GC6zkAn5Tg2cdtaH3WrNcfMm9Y+U6t38fwos4KbFSW+AenKF1iWoyZXdrW2u5+iNJ+m0XxbzFn2YZckRNyG2Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orE/rzOh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orE/rzOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9E61F000E9;
	Tue,  7 Jul 2026 04:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783397946;
	bh=X0eBSaf0GQPzQzSa8Xx2nomM2dACsoLt9ckOtxwqw88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=orE/rzOhsb+Siac+T/fez03ryspcepf0rvkxivFzQ0QTIQQNg4hOuOPMKijFD5ZtF
	 E+cp3YA2U6hHUZqiepL6hstC+BR/R1as5QzRx4XnVzOZp/7Bu8qbH0onlKAbS8hQHk
	 ZmGY5NP0f9pCqtZuiv8LLlZ0IbQmK5W9kitDtmyML0el85CESsyESyiq1GCnq74L31
	 b9y6VADY+WWYzo/Yu6pn6a6ahInLEDE4BTubt7o96w6fS6MsOMuJKgUOWW0iKcL8cv
	 H1Q3JGdOeR6rDgRUWV9squS78e30NBaFaF6xMdv40guRhWWFUVM/QtTOXyHPDws7zG
	 mkW0Figz6Tmsg==
Message-ID: <1f24e512-abb8-4aa9-b3cf-2a8256b7ccdc@kernel.org>
Date: Tue, 7 Jul 2026 13:19:03 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/6] null_blk: move unregister_blkdev() after
 destroying dev in null_exit()
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, nilay@linux.ibm.com,
 linux-block@vger.kernel.org, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, bvanassche@acm.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
 <20260707025542.1299859-5-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260707025542.1299859-5-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/26 11:55, Zizhi Wo wrote:
> In null_exit(), unregister_blkdev() was called before the null_blk

s/was/is

> instances were destroyed, which is inconsistent with the cleanup order in
> null_init(). Move it after null_destroy_dev() so that teardown happens in
> the reverse order of initialization.
> 
> No functional change intended.
> 
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

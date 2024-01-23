Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C702B23D2;
	Tue, 23 Jan 2024 05:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705987731; cv=none; b=ajyz3+atDfiadiJXWW8yl15CIPlXwYnbuWRp+adfl69ZewEV5Vu3VATp19JtmdkYmFLk4Gz71cJ1uJcMkWT5OK/UNqNAIJsmi66JBlm7AboSnW+t5t00L7N2Ekv6BpKXru7nXbIFN0N4xvw4kZgiI8/uz28OsJTBshWQZ7hIEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705987731; c=relaxed/simple;
	bh=GuoueqnTFJPG1iNvVXaPu2ynYxAiDk0ADDDfkdnKKgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbi7vZH1NkACyj8/ups7fdbpgVaV2XtRoAFMkfAe2+vlhQaYxXHsi7AqhTawQ9W4MyBwQbheruBsLy38uqqNCawZ+v9zpfVZSLjwriVKZ11lYIwsq4b2sWqEtOajKJMJxV4GTMrnEUt0pMOFBteWsm4gbJYy6D6MxHkhYi19Bkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umIknSPc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umIknSPc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A6FC433C7;
	Tue, 23 Jan 2024 05:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987731;
	bh=GuoueqnTFJPG1iNvVXaPu2ynYxAiDk0ADDDfkdnKKgs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=umIknSPcCQME7cm1J4/2wqtlPNDKrz83Pt+L0nsAG1+hS5iMH1TDDtKGCJr+Akk+d
	 p0J6ZAop8LWHaa1kdEmVlHtc88GzDbMBtUGxGHSgA+wACrwF4FI0fGvB0f0Nxx+uMM
	 eJa4OmIgn38EVGajU2objX+8Fv+4IlTBbCSjJQnmYQ1WFQTJUkRZNY4GSYht+rm8gL
	 9Dg82aj5aooLS2A5BRHmHvyo5QkUeBgjWAxLJr8Yl9ilq7EFcx49Se81n24tUeyvhc
	 Qe6vKHhiY03C0BZpRdUBxJXge1MRrrSsNkIXJIdnL+T7r+Mi3p51VmFHcRTQ8twbQS
	 JLvHmD6GR+Jmw==
Message-ID: <d67be298-6e87-45e0-878f-c692b1ac9c99@kernel.org>
Date: Tue, 23 Jan 2024 14:28:48 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] loop: cleanup loop_config_discard
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-14-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 02:36, Christoph Hellwig wrote:
> Initialize the local variables for the discard max sectors and
> granularity to zero as a sensible default, and then merge the
> calls assigning them to the queue limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645571;
	b=tjT6eGR1k7Hbi1OSsn1xK89n6G6lq0SH59UTEy3mOvgm0agyI9aH0ufx+T/LCneFNlbc
	 9Oq0nvDUanBMqY4Rdz1pXwMy/JIjt97PIiP9JtkmbPvuByFOQaqiquXq70i30ynX8uKyJ
	 cCiVmYlIJwEphgF9Rk/3NrGNV0aAtYS/y6oZpDNswfjLm9NOf5zKQAt30BGzhiuH7T64+
	 atGptAWpOCLYhFmTWf9tU5tn/FjfELQ7wnNWDc/15Z0jLSrfd0GDRsOLmeJ3zIUKibE07
	 pEe7cr6OWdy11zZMvVmK98FkfsWTBKvBChQEQExEwahGhAkr7V8hoEKgJWmqSuuS64Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645571;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=RFoMOAAFr3c9fpP5gmrldnBRPs1+vH1e5Pkgn4ql1Cg=;
	b=1ctGpHevVTNAGMbIB0TQ7+fCu06qm8+lhtB+J1NN8NYh9UI0vdZeMDR86Lv38McAq4m9
	 NwFG3HLF1HKq2Hf0Diax6plUct1k9sC70HCHBDlzw8jhYND1L6Luze3KshSrEIDDuW1J/
	 PfDUYlYuB2bBGqgv7GJcIYVqyPgHZedruYkLJPXJlyA3xjqcdVQpltQ4mHwK8iMQnoSja
	 7ACcUDgzgmNAIhnDgsdnmVM4onC6cydjJZKTDwkiSswm1PCjyUXTF2VUn01v6hpUDUps+
	 mWLBZnUo4CEdHhChEuUUP/eCa1U8+YoAT8a0gtbVg710c4DnsyJ7PgdegHYN4anuvjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UJczVqb/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE260A2621
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJczVqb/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1589F1F000D4;
	Wed, 25 Nov 2026 22:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795645571;
	bh=RFoMOAAFr3c9fpP5gmrldnBRPs1+vH1e5Pkgn4ql1Cg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UJczVqb/UU/BVZgmWSUQLHrj1tclQYhhg1qnId7qyqe4J5DH/WXfNBrhyw6HXV8/P
	 zrdzqBDTOlL9mSI1Br/2pBc2s9RcqBrFws1rJ+Tzsl1qrdCsVANTHUdXGGrmFlqnuI
	 AADsFxC5EYRPnFxHGkyZvi5xM5XKY+esLGJJKAqPQ4xSKe68H8ppg5IQDevnzENkGW
	 JUqWA7Yq+XTM9jekHr9SZQPNhOtD+dbWnmQhegMw1mvfwdSxVqbIjX3tr9NrQVDTC7
	 tHXyMNZUn6R0YAyq2W1h4DxdQBMUIYK0/cq6BA3kFf70oH8/zGyzCWTlSddBMyn0+k
	 l1od8u/DQOc4g==
Message-ID: <b046d41c-b585-4664-ae0c-cc49b59fde8e@kernel.org>
Date: Thu, 26 Nov 2026 07:26:08 +0900
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] blktrace: add ioprio field to struct blk_io_trace2
To: Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Niklas Cassel <cassel@kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20261124133553.152463-1-johannes.thumshirn@wdc.com>
 <20261124133553.152463-2-johannes.thumshirn@wdc.com>
 <20261125045820.GD19878@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261125045820.GD19878@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 13:58, Christoph Hellwig wrote:
> On Tue, Nov 24, 2026 at 02:35:49PM +0100, Johannes Thumshirn wrote:
>> Add the UAPI definitions for passing I/O priorities, and with them SCSI
>> command duration limit (CDL) hints, to user space:
> 
> Before we start encoding this too hard we really need to fix how CDL
> is used in the kernel.  The whole idea of the user configures the
> CDL descriptor and then the I/O issuers magically knows an I/O
> priority maps to it is completely broken.

Well, that is what is out there now for users that use the drive directly, and
it is in production already. So we cannot really change that.

> We need a way for the FS to know or even configure the CDL descriptor
> and then use that.

For the file system use case, yes, I agree we can do better. Right now, the
current ioprio scheme will only work with ioprio_set() (setting the IO priority
for the user process) and direct I/Os to files only I think (not sure if
buffered I/Os can inherit that per process or per user priority). So there is
room for improvements and we can definitely design an FS interface with some
generic block layer helpers that can set descriptors.

But that I think should not block the blktrace work as we have production
requests for it for the users using the drives directly. Tracing ioprio is still
valid for the pure I/O priority case anyway. bio->bi_ioprio just happens to also
contain the CDL index, at least for now. blktrace being a debug tool, we can
change it later if we need to clearly separate IO priority and CDL index.


-- 
Damien Le Moal
Western Digital Research

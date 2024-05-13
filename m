Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE114EC5E;
	Mon, 13 May 2024 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715602986; cv=none; b=aEpvjtEbFh0kOLECbCUiC2PeZlwIMeyySqCEEdtxJAdhXR8UCY1t9SjKKU1j1OBsWeOZvbTIkTj7LCmRM+kJjQwFff8z2tx7uxBZqOCDBUUHRXaVxlm7R79OCYGnw+2CLiCxJJn4jKKHXIwHLXnv1E7yxrqLNTLsiJYwpPmaJd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715602986; c=relaxed/simple;
	bh=GMpp0dPFuIFfvEUduPyIjFcKlLnBpiSg9daDEDmMREo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTbCEDmoImQbPZtEd015bqs/NgWxm3yrLzT7C+QzanKiRLejU3OtGamWaxEWDKeM6eTVRvEBCx6+FkmU/xp0G47gBpZ4xAXM6PbkDp0fEHvEFhTgpqWWzAcCV0qGG7uZ2jWU/Dd1JHPnLM5xGIpC08b5n+47Ujf2tPKkW6IYkbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=jzT6xeI3; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="jzT6xeI3"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VdJXy1tR4z6Cnk90;
	Mon, 13 May 2024 12:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1715602962; x=1718194963; bh=7Ih71/Watz1cdPTWlkmWtBwl
	P9ZcU5ZJPsGWDZOPS0Y=; b=jzT6xeI3w+cBrbZgW+L7A5crY0hWa6Q4mx/1MHQE
	B8JU1uAtmpxRvcx8kY5GQZBcuGgyo2OONYgKdIgmhlAvT6oKhREKiOFVCBfTCmHA
	a3JXZoC1XANZmc9Z/saTfeC99ouZ0tuRaxaafBSKRBySDS3d6wwcjB+VOxYoJYuG
	Kshui5g5ctx5ZcnXxJ/HO/HaeHSThdryHdvqM/b3bwdcbQkcR27Z6D6ISOpRZDCi
	6N1JwHxIu+EMOmqRUAf+7TGxu6V+wD0lNfW+An2y4fbLVOVBDm6pCyNoR80qHnHM
	9X88dvEGxU9nWcY+IUWLez3lumEp7uNOlnogIavx0EP7hg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6kRT-qnGtJMv; Mon, 13 May 2024 12:22:42 +0000 (UTC)
Received: from [172.20.0.79] (unknown [8.9.45.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VdJXV0Dx6z6Cnk8s;
	Mon, 13 May 2024 12:22:33 +0000 (UTC)
Message-ID: <1b618942-a0fe-45d9-90de-eede429e7284@acm.org>
Date: Mon, 13 May 2024 06:22:31 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rust: block: introduce `kernel::block::mq` module
To: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>,
 =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
 Joel Granados <j.granados@samsung.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Daniel Gomez <da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>,
 open list <linux-kernel@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>
References: <20240512183950.1982353-1-nmi@metaspace.dk>
 <20240512183950.1982353-2-nmi@metaspace.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240512183950.1982353-2-nmi@metaspace.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/12/24 11:39, Andreas Hindborg wrote:
> +    /// Set the logical block size of the device.
> +    ///
> +    /// This is the smallest unit the storage device can address. It i=
s
> +    /// typically 512 bytes.

Hmm ... all block devices that I have encountered recently have a
logical block size of 4096 bytes. Isn't this the preferred logical
block size for SSDs and for SMR hard disks?

> +    /// Set the physical block size of the device.
> +    ///
> +    /// This is the smallest unit a physical storage device can write
> +    /// atomically. It is usually the same as the logical block size b=
ut may be
> +    /// bigger. One example is SATA drives with 4KB sectors that expos=
e a
> +    /// 512-byte logical block size to the operating system.

Please be consistent and change "4 KB sectors" into "4 KB physical block
size".

I think that the physical block size can also be smaller than the
logical block size. From the SCSI SBC standard:

Table 91 =E2=80=94 LOGICAL BLOCKS PER PHYSICAL BLOCK EXPONENT field
-----  ------------------------------------------------------------
Code   Description
-----  ------------------------------------------------------------
0      One or more physical blocks per logical block (the number of
        physical blocks per logical block is not reported).
n > 0  2**n logical blocks per physical block
-----  ------------------------------------------------------------

> +impl<T: Operations, S: GenDiskState> GenDisk<T, S> {
> +    /// Call to tell the block layer the capacity of the device in sec=
tors (512B).

Why to use any other unit than bytes in Rust block::mq APIs? sector_t
was introduced before 64-bit CPUs became available to reduce the number
of bytes required to represent offsets. I don't think that this is still
a concern today. Hence my proposal to be consistent in the Rust=20
block::mq API and to use bytes as the unit in all APIs.

Thanks,

Bart.

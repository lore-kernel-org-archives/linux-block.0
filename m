Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E1DF6C;
	Mon, 13 May 2024 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605724; cv=none; b=L2/OoBKNigAErHGeGHFoY8FcwThCc2ULN6OnWmnI+eEoTKN0dAuCUMYqXfY+lbIMPzgP7mgV0+9NIwjFWDuENaL6xieHWSqhbufaoNmZvgz1/pYbZ9flL7xu0HK4XUcq3QDe0gUEAd1ydNZCIJ7feaxBHacAGHdfcB7kdOPygsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605724; c=relaxed/simple;
	bh=jMBP6V+KrQiY7ae7qCJD7wO2o7LlEvAAj86B765UqAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHY05MmvjgRjHn4EjgUXS8XgO+5YCPvGL8PXRmjL+j5In/+D9d2miQlOHABOW7TCaO6xi8RxVOFer+6nFP+1F4MX/TGObyFd9EUCRYMkoutaE4L1lf7zw6Ia9rsk4fxXSD4eRzO63AqfU1lkRkR/fZxQ4pkhtj7ccYuP/cHbbJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLHbT8oY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLHbT8oY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C93C32782;
	Mon, 13 May 2024 13:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715605724;
	bh=jMBP6V+KrQiY7ae7qCJD7wO2o7LlEvAAj86B765UqAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KLHbT8oYxB7LFOPNmCzkTbTuUHu5Xo7HGa+GZJwAtDu9mh+NF94yhQVh5y31OmTv8
	 +9RbHUHEXJhpll++YzGTK9bpuLBF8O5kpnE7eaa+P1SU6PTaIKzhXKNeoAkSaEXORE
	 BNyAfhtWDUhzxfX7xYLTguzxzVa4HGM4XIhMi6t85K6rG1Tv8j0MPoEIsu/n5qVGzA
	 Q6IdgpzRwpfmHUwmdBm8nUIjVteAZDvrp4Yu21v663slo2hGKd6fABS8rTMttFNi3l
	 VP+7+2TpKxG5onWKhFoTFKs3N+dWo7OiXz+5mZtOJ/oJ8Yjb3fGBgO6wy/RnmiCrat
	 eFg5LPWwUyRuQ==
Message-ID: <f3a5d43c-b94b-49ef-a883-c27e4720c8a5@kernel.org>
Date: Mon, 13 May 2024 22:08:43 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rust: block: introduce `kernel::block::mq` module
To: Andreas Hindborg <nmi@metaspace.dk>, Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Andreas Hindborg <a.hindborg@samsung.com>,
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
 <1b618942-a0fe-45d9-90de-eede429e7284@acm.org> <87r0e5j2st.fsf@metaspace.dk>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87r0e5j2st.fsf@metaspace.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/05/13 21:48, Andreas Hindborg wrote:
> 
> Hi Bart,
> 
> Bart Van Assche <bvanassche@acm.org> writes:
> 
>> On 5/12/24 11:39, Andreas Hindborg wrote:
>>> +    /// Set the logical block size of the device.
>>> +    ///
>>> +    /// This is the smallest unit the storage device can address. It is
>>> +    /// typically 512 bytes.
>>
>> Hmm ... all block devices that I have encountered recently have a
>> logical block size of 4096 bytes. Isn't this the preferred logical
>> block size for SSDs and for SMR hard disks?
> 
> Yes, that is probably true. This text was lifted from the entry on the
> sysfs attribute in `Documentation/ABI/stable/sysfs-block`, but maybe
> that needs to be updated as well.
> 
>>
>>> +    /// Set the physical block size of the device.
>>> +    ///
>>> +    /// This is the smallest unit a physical storage device can write
>>> +    /// atomically. It is usually the same as the logical block size but may be
>>> +    /// bigger. One example is SATA drives with 4KB sectors that expose a
>>> +    /// 512-byte logical block size to the operating system.
>>
>> Please be consistent and change "4 KB sectors" into "4 KB physical block
>> size".
> 
> OK, I will. I can CC the changes to
> `Documentation/ABI/stable/sysfs-block` then'
> 
>>
>> I think that the physical block size can also be smaller than the
>> logical block size. From the SCSI SBC standard:
>>
>> Table 91 — LOGICAL BLOCKS PER PHYSICAL BLOCK EXPONENT field
>> -----  ------------------------------------------------------------
>> Code   Description
>> -----  ------------------------------------------------------------
>> 0      One or more physical blocks per logical block (the number of
>>        physical blocks per logical block is not reported).
>> n > 0  2**n logical blocks per physical block
>> -----  ------------------------------------------------------------

That text is bad. 0 really means physical == logical. Otherwise, there is no way
to know how to access the drive because the logical size is the unit for
accessing the drive. In practice, the logical block size is always smaller or
equal to the physical block size. The physical block size is always a power of 2
number of logical blocks.

> How does that work? Would the drive do a read/modify/write internally?

Yes.

> Would that not make the physical block size as seen from the OS equal to
> the smaller logical block size?

Not necessarily. There are a lot of 512e drives out there: 4K physical, 512B
logical. So applications/hosts can still do 512B accesses for compatibility but
performance may be bad. For such drive, the user should really do 4K aligned
accesses.

> 
>>
>>> +impl<T: Operations, S: GenDiskState> GenDisk<T, S> {
>>> +    /// Call to tell the block layer the capacity of the device in sectors (512B).
>>
>> Why to use any other unit than bytes in Rust block::mq APIs? sector_t
>> was introduced before 64-bit CPUs became available to reduce the number
>> of bytes required to represent offsets. I don't think that this is still
>> a concern today. Hence my proposal to be consistent in the Rust block::mq API
>> and to use bytes as the unit in all APIs.
> 
> I think that is very good idea. How do others feel about this?
> 
> BR Andreas
> 
> 

-- 
Damien Le Moal
Western Digital Research


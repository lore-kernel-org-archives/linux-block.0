Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E725A642
	for <linux-block@vger.kernel.org>; Tue,  4 Feb 2025 03:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738639375; cv=none; b=dZAF0y2XmbV1TzrNWRnj3TzNWT+U3Wju7n9jejqogicR++s7KEg8gv+VVwlRycr0n0h21I9wlVf2oSkO9uHGJZI2ttgDK9b6v1eDkptpzlimsedxiqZDyzJaPvxip7iNyLHS4bsxA0FmY0VEDIolmdOiiA/EefsIztF8d8xKrnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738639375; c=relaxed/simple;
	bh=3cZ1tfAcU0t6D+nSddFPUPGeVZ1GF0xPw/p1AZ8sohE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWVliDB1I3X4uWNEkPKfEn24mvr/Xn8zOMkrKr6oNET+lniWKbinSvemHr1FzCXfhW7dqIG1tot246D47ZHx4HxhjxQT8sVwbNy6pOXC//PQhse5iUZaGPnHnaPFn7guepP9bU7gaQYTeifANkLkCxAto+eousE+/UWrTOt3DXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fun/vaVe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fun/vaVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53FEC4CEE0;
	Tue,  4 Feb 2025 03:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738639375;
	bh=3cZ1tfAcU0t6D+nSddFPUPGeVZ1GF0xPw/p1AZ8sohE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fun/vaVeZGw1D2oJQHN+knSGu8iWt2h4Nx9spAUtz9S5DDYRaIYT7Cw/X20WJF1qc
	 V9RsEKw303R0MeAcO5Bh6Y1Jqw50lfeHqVFugVghJxL3QhbTWFXoAbJXZbGOaBjx7u
	 jwmeHhUXEdcFG5w4UkQcTmwAP5OyeLZDWxoXYVKNWljzBwi6wEjZtnGiSXdWyD3Uga
	 l+KVQVHD8jaKwUPDCbp0wVmZloiagr72NURn6kSG4746cy3AAjukU30II15/06sUFJ
	 iD6SGxPvmP9R1PDEx5fumtnJyugi8H34Cyl6yWcbwocvxWyBpz1zluV11AuLA8PVTj
	 cjLY6gAurBmDg==
Message-ID: <a63406f1-6a45-4d07-b998-504bd2d6d0d7@kernel.org>
Date: Tue, 4 Feb 2025 12:22:53 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] New zoned loop block device driver
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20250106152118.GB27324@lst.de> <Z33jJV6x1RnOLXvm@fedora>
 <ac42d762-60e5-4550-99f1-bd2072e474c2@kernel.org>
 <CAFj5m9+LUtAt2ST41KzMasx4BuVYBXjAuLg5MDr0Gh31yzZKzw@mail.gmail.com>
 <20250108090912.GA27786@lst.de> <Z35H1chBIvTt0luL@fedora>
 <Z4ETvfwVfzNWtgAo@fedora> <d5e59531-c19b-4332-8f47-b380ab9678be@kernel.org>
 <Z5OHy76X2F9H6EWP@fedora> <cb5d4dad-35a9-400e-9c53-785fba6f5a87@kernel.org>
 <Z5xJh84xZbjcO-nJ@fedora>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z5xJh84xZbjcO-nJ@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/25 12:54, Ming Lei wrote:
> On Wed, Jan 29, 2025 at 05:10:32PM +0900, Damien Le Moal wrote:
>> On 1/24/25 21:30, Ming Lei wrote:
>>>> 1 queue:
>>>> ========
>>>>                               +-------------------+-------------------+
>>>>                               | ublk (IOPS / BW)  | zloop (IOPS / BW) |
>>>>  +----------------------------+-------------------+-------------------+
>>>>  | QD=1,    4K rnd wr, 1 job  | 11.7k / 47.8 MB/s | 15.8k / 53.0 MB/s |
>>>>  | QD=32,   4K rnd wr, 8 jobs | 63.4k / 260 MB/s  | 101k / 413 MB/s   |
>>>
>>> I can't reproduce the above two, actually not observe obvious difference
>>> between rublk/zoned and zloop in my test VM.
>>
>> I am using bare-metal machines for these tests as I do not want any
>> noise from a VM/hypervisor in the numbers. And I did say that this is with a
>> tweaked version of zloop that I have not posted yet (I was waiting for rc1 to
>> repost as a rebase is needed to correct a compilation failure du to the nomerge
>> tage set flag being removed). I am attaching the patch I used here (it applies
>> on top of current Linus tree)
>>
>>> Maybe rublk works at debug mode, which reduces perf by half usually.
>>> And you need to add device via 'cargo run -r -- add zoned' for using
>>> release mode.
>>
>> Well, that is not an obvious thing for someone who does not know rust well. The
>> README file of rublk also does not mention that. So no, I did not run it like
>> this. I followed the README and call rublk directly. It would be great to
>> document that.
> 
> OK, that is fine, and now you can install rublk/zoned with 'cargo
> install rublk' directly, which always build & install the binary of
> release version.
> 
>>
>>> Actually there is just single io_uring_enter() running in each ublk queue
>>> pthread, perf should be similar with kernel IO handling, and the main extra
>>> load is from the single syscall kernel/user context switch and IO data copy,
>>> and data copy effect can be neglected in small io size usually(< 64KB).
>>>
>>>>  | QD=32, 128K rnd wr, 1 job  | 5008 / 656 MB/s   | 5993 / 786 MB/s   |
>>>>  | QD=32, 128K seq wr, 1 job  | 2636 / 346 MB/s   | 5393 / 707 MB/s   |
>>>
>>> ublk 128K BS may be a little slower since there is one extra copy.
>>
>> Here are newer numbers running rublk as you suggested (using cargo run -r).
>> The backend storage is on an XFS file system using a PCI gen4 4TB M.2 SSD that
>> is empty (the FS is empty on start). The emulated zoned disk has a capacity of
>> 512GB with sequential zones only of 256 MB (that is, there are 2048
>> zones/files). Each data point is from a 1min run of fio.
> 
> Can you share how you create rublk/zoned and zloop and the underlying
> device info? Especially queue depth and nr_queues(both rublk/zloop &
> underlying disk) plays a big role.

rublk:

cargo run -r -- add zoned --size 524288 --zone-size 256 --conv-zones 0 \
		--logical-block-size 4096 --queue ${nrq} --depth 128 \
		--path /mnt/zloop/0

zloop:

echo "add conv_zones=0,capacity_mb=524288,zone_size_mb=256,\
base_dir=/mnt/zloop,nr_queues=${nrq},queue_depth=128" > /dev/zloop-control

The backing storage is using XFS on a PCIe Gen4 4TB M.2 SSD (my Xeon machine is
PCIe Gen3 though). This drive has a large enough max_qid to provide one IO queue
pair per CPU for up to 32 CPUs (16-cores / 32-threads).

> I will take your setting on real hardware and re-run the test after I
> return from the Spring Festival holiday.
> 
>>
>> On a 8-cores Intel Xeon test box, which has PCI gen 3 only, I get:
>>
>> Single queue:
>> =============
>>                               +-------------------+-------------------+
>>                               | ublk (IOPS / BW)  | zloop (IOPS / BW) |
>>  +----------------------------+-------------------+-------------------+
>>  | QD=1,    4K rnd wr, 1 job  | 2859 / 11.7 MB/s  | 5535 / 22.7 MB/s  |
>>  | QD=32,   4K rnd wr, 8 jobs | 24.5k / 100 MB/s  | 24.6k / 101 MB/s  |
>>  | QD=32, 128K rnd wr, 1 job  | 14.9k / 1954 MB/s | 19.6k / 2571 MB/s |
>>  | QD=32, 128K seq wr, 1 job  | 1516 / 199 MB/s   | 10.6k / 1385 MB/s |
>>  +----------------------------+-------------------+-------------------+
>>
>> 8 queues:
>> =========
>>                               +-------------------+-------------------+
>>                               | ublk (IOPS / BW)  | zloop (IOPS / BW) |
>>  +----------------------------+-------------------+-------------------+
>>  | QD=1,    4K rnd wr, 1 job  | 5387 / 22.1 MB/s  | 5436 / 22.3 MB/s  |
>>  | QD=32,   4K rnd wr, 8 jobs | 16.4k / 67.0 MB/s | 26.3k / 108 MB/s  |
>>  | QD=32, 128K rnd wr, 1 job  | 6101 / 800 MB/s   | 19.8k / 2591 MB/s |
>>  | QD=32, 128K seq wr, 1 job  | 3987 / 523 MB/s   | 10.6k / 1391 MB/s |
>>  +----------------------------+-------------------+-------------------+
>>
>> I have no idea why ublk is generally slower when setup with 8 I/O queues. The
>> qd=32 4K random write with 8 jobs is generally faster with ublk than zloop, but
>> that varies. I tracked that down to CPU utilization which is generally much
>> better (all CPUs used) with ublk compared to zloop, as zloop is at the mercy of
>> the workqueue code and how it schedules unbound work items.
> 
> Maybe it is related with queue depth? The default ublk queue depth is
> 128, and 8jobs actually causes 256 in-flight IOs, and default ublk nr_queue
> is 1.

See above: both rublk and zloop are setup with the exact same number of queues
and max qd.

> Another thing I mentioned is that ublk has one extra IO data copy, which
> slows IO especially when IO size is > 64K usually.

Yes. I do keep this in mind when looking at the results.

[...]

>>> Simplicity need to be observed from multiple dimensions, 300 vs. 1500 LoC has
>>> shown something already, IMO.
>>
>> Sure. But given the very complicated syntax of rust, a lower LoC for rust
>> compared to C is very subjective in my opinion.
>>
>> I said "simplicity" in the context of the driver use. And rublk is not as
>> simple to use as zloop as it needs rust/cargo installed which is not an
>> acceptable dependency for xfstests. Furthermore, it is very annoying to have to
> 
> xfstests just need user to pass the zoned block device, so the same test can
> cover any zoned device.

Sure. But the environment that allows that still needs to have the rust
dependency to pull-in and build rublk before using it to run the tests. That is
more dependencies for a CI system or minimal VMs that are not necessarilly based
on a full distro but used to run xfstests.

> I don't understand why you have to add the zoned device emulation code into
> xfstest test script, and introduce the device dependency into upper level FS
> test, and sounds like one layer violation?

The device need to be prepared before running the tests. See above.

> I guess you may miss the point, and actually it isn't related with Rust.

It is. As mentioned several times now, adding rust as a dependency to allow
minimal test VMs to create an emulated zoned device for running xfstests is not
nice. Sure it is not an unsolvable problem, but still not one that we want to
add to test environments. zloop only needs sh/bash, which is necessarily already
included in any existing test environment because that is what xfstests is
written with.

-- 
Damien Le Moal
Western Digital Research

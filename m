Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A6221D86
	for <linux-block@vger.kernel.org>; Wed,  5 Feb 2025 06:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735737; cv=none; b=hORRfzaqpqBUGLnQkbGMDh8f72BQBKT7VcelIt2eODyRsKximCCcoLSEqaPb2f1u9nFpIsZYcPw0o3yKUSXjEqHnihcThMMusT7TATy2wJtKbHQ/4w/F65ZSldIbpXp1uvttcu50eV7rArBRQLZ7G4YUs5Avn0u8byudY21pjX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735737; c=relaxed/simple;
	bh=PCAHOmXTXpvaAi5mBNCqYwHpll0rkzL3ghd7yfyMyXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBMAnbJDbva1QdI1kMxUgH2ReTiSNbJX2adfX3DqlaOxIxQbp4zlQ6DmbK1VAUdefjbt29fENc9bzXICsX8W1b0C5/xtyIhow7C+lAqSHdc6BrkJMOeKRa9pEpGZLIq7cu92l3ueMV0n2g9cKhKpc2tothUdZoiSmoKw9CyXQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nODmQYEp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nODmQYEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AF7C4CEE3;
	Wed,  5 Feb 2025 06:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738735736;
	bh=PCAHOmXTXpvaAi5mBNCqYwHpll0rkzL3ghd7yfyMyXQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nODmQYEpZ3OfNrI71cTUvj/Yi1q66R6OL/V3JJyP3RQjH5LCjZQ55DQqoc7r/ZYCh
	 NWRLZ9gkaIfDd/J+ifiCGJr6pZSF7rLV8/ZqD6/0YHa3ejnKoTUy259c9icWY8EMEU
	 m92qbbFxG4cNbEstw1MqTSuvFMu+58w18W7TGdaumUoOvhi9Ch44fnxpNi8NW/KNLe
	 BPga5+kWJWpzO1GsmDnV/qpEqOQK/nzv0XXV9EJ6Cdbip0ZtXG+AvQli+JWM2zzwzZ
	 8doQwc3/zDAULjL0TKblTOtn15qqFgtnPR1Cam19lznJa6jN+bG1HA+rkeC4RRS4QR
	 eel/VaXKxt1NA==
Message-ID: <f6d82d47-ff27-43e8-a772-0ab90a2f86c4@kernel.org>
Date: Wed, 5 Feb 2025 15:07:51 +0900
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
References: <ac42d762-60e5-4550-99f1-bd2072e474c2@kernel.org>
 <CAFj5m9+LUtAt2ST41KzMasx4BuVYBXjAuLg5MDr0Gh31yzZKzw@mail.gmail.com>
 <20250108090912.GA27786@lst.de> <Z35H1chBIvTt0luL@fedora>
 <Z4ETvfwVfzNWtgAo@fedora> <d5e59531-c19b-4332-8f47-b380ab9678be@kernel.org>
 <Z5OHy76X2F9H6EWP@fedora> <cb5d4dad-35a9-400e-9c53-785fba6f5a87@kernel.org>
 <Z5xJh84xZbjcO-nJ@fedora> <a63406f1-6a45-4d07-b998-504bd2d6d0d7@kernel.org>
 <Z6LeXsYw_qq4hqoC@fedora>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z6LeXsYw_qq4hqoC@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/25 12:43 PM, Ming Lei wrote:
>>> Can you share how you create rublk/zoned and zloop and the underlying
>>> device info? Especially queue depth and nr_queues(both rublk/zloop &
>>> underlying disk) plays a big role.
>>
>> rublk:
>>
>> cargo run -r -- add zoned --size 524288 --zone-size 256 --conv-zones 0 \
>> 		--logical-block-size 4096 --queue ${nrq} --depth 128 \
>> 		--path /mnt/zloop/0
>>
>> zloop:
>>
>> echo "add conv_zones=0,capacity_mb=524288,zone_size_mb=256,\
>> base_dir=/mnt/zloop,nr_queues=${nrq},queue_depth=128" > /dev/zloop-control
> 
> zone is actually stateful, maybe it is better to use standalone backing
> directory/files.

I do not understand what you are saying... I reformat the backing FS and
recreate the same /mnt/zloop/0 directory for every test, to be sure I am not
seeing an artifact from the FS.

>> The backing storage is using XFS on a PCIe Gen4 4TB M.2 SSD (my Xeon machine is
>> PCIe Gen3 though). This drive has a large enough max_qid to provide one IO queue
>> pair per CPU for up to 32 CPUs (16-cores / 32-threads).
> 
> I just setup one XFS over nvme in real hardware, still can't reproduce the big gap in
> your test result. Kernel is v6.13 with zloop patch v2.
> 
> `8 queues` should only make a difference for the test of "QD=32,   4K rnd wr, 8 jobs".
> For other single job test, single queue supposes to be same with 8 queues.
> 
> The big gap is mainly in test of 'QD=32, 128K seq wr, 1 job ', maybe your local
> change improves zloop's merge? In my test:
> 
> 	- ublk/zoned : 912 MiB/s
> 	- zloop(v2) : 960 MiB/s.
> 
> BTW, my test is over btrfs, and follows the test script:
> 
>  fio --size=32G --time_based --bsrange=128K-128K --runtime=40 --numjobs=1 \
>  	--ioengine=libaio --iodepth=32 --directory=./ublk --group_reporting=1 --direct=1 \
> 	--fsync=0 --name=f1 --stonewall --rw=write

If you add an FS on top of the emulated zoned deive, you are testing the FS
perf as much as the backing dev. I focused on the backing dev so I ran fio
directly on top of the emulated drive. E.g.:

fio --name=test --filename=${dev} --rw=randwrite \
                --ioengine=libaio --iodepth=32 --direct=1 --bs=4096 \
                --zonemode=zbd --numjobs=8 --group_reporting --norandommap \
                --cpus_allowed=0-7 --cpus_allowed_policy=split \
                --runtime=${runtime} --ramp_time=5 --time_based

(you must use libaio here)

-- 
Damien Le Moal
Western Digital Research

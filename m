Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687987;
	b=lB68sv3LYkdrpU4M/rtKoG1Nj9D2ADAkqlgaGiK+4FclKpuo9Vt0VIkc6lfsAsvXx+CS
	 w9vM1OSYgqeAYm2lnjUm+K3QClSWpAbLCSBEicAqtnnoF6mpCGTGx3WTctkaHcxSghMt0
	 XJTHWL7KqLxIkVUctWYCZkyXbU3+tGKlHJ4QU27wayqBQqvgXALYwXOEL4FzrrXXBAaFo
	 okmDiJO4KAhZuBcKaaNMhcGcKbZzGXkDevcBC2mWgQMnPqCD3ux9OGIGCH1g2iPDHPGLq
	 h2nVhZvuYyqveYnD4Y2AQZKa+p97MKlFbPX6goRXC0uNn0iEGsYyaobjo3/6/2U3JDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687987;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=MUsiADJ04rpJgmFJzFzxzRu8rCIUB5cThov6L5V2r4s=;
	b=p2vvm4+xgjgnaas2qZrVQ7WYv37oVoXGGJ1v8t/rgo2ScHqTH0TUoPfGHB29TtR0Wb3u
	 xTClrOv2iE00wbKdUpUZWuxHaiW11o+js4DEWRlcjFk8rOq9Ut3AoXITBqx97t2kRFb5X
	 WToy8jPYwKN8BoTvL38dkUGBHop3bqKEiwbN2+DR870pk6p/waD8lYXFgK1VuGdLLygxf
	 d39+tTCuXBUtFi89CNb2tq6+cN2zMy/5J9IyQyyPMVpgDjtofLFLaGcqo5rMj4zxjFoYz
	 RuihRwgkQRSmyOvl4o0ldEdz/d9YdzDHkQZyMf/M+hbOcr3kfJf3jyEz6ePZHfbf6zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.99
Received: from dggmsgout11.his.huawei.com (dggmsgout11.his.huawei.com [124.71.93.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F77606A324;
	Tue,  3 Nov 2026 06:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17F77606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout11.his.huawei.com (SkyGuard) with ESMTP id 4jJf725QgLz1c0QY;
	Tue,  3 Nov 2026 14:39:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1E80540574;
	Tue,  3 Nov 2026 14:39:36 +0800 (CST)
Received: from [10.174.178.164] (unknown [10.174.178.164])
	by APP4 (Coremail) with UTF8SMTPSA id gCh0CgAnZvWmgelq_OCWCw--.39623S3;
	Tue, 03 Nov 2026 14:39:35 +0800 (CST)
Message-ID: <4851c5b8-7522-4ff8-b6e7-d69f5d9a7557@huaweicloud.com>
Date: Tue, 3 Nov 2026 14:39:32 +0800
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
Subject: Re: [PATCH] block: partitions: reject GPT entries with starting_lba >
 ending_lba
To: Christoph Hellwig <hch@lst.de>, Zizhi Wo <wozizhi@huaweicloud.com>
Cc: axboe@kernel.dk, bvanassche@acm.org, yukuai@fygo.io,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, chengzhihao1@huawei.com
References: <20261102080442.3775061-1-wozizhi@huaweicloud.com>
 <20261103053418.GB1382@lst.de>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20261103053418.GB1382@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnZvWmgelq_OCWCw--.39623S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1UAr45Xw4kXw45Gry3urg_yoW8XFy5pF
	4fJ345Cr15Ca4fu3srtan7Ja4rZrZ7GayUtF98XrWrKrW5ZasrtasrKFWUuFyjvr9rWwnF
	vw4Ygr97ua13AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtVW8
	ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2026/11/3 13:34, Christoph Hellwig 写道:
> On Mon, Nov 02, 2026 at 04:04:42PM +0800, Zizhi Wo wrote:
>> From: Zizhi Wo <wozizhi@huawei.com>
>>
>> A GPT entry whose starting_lba is greater than its ending_lba is accepted,
>> and the kernel creates a partition with a bogus size. The bogus sector
>> count defeats the end-of-device check, so I/O through that partition is not
>> confined to it and can access sectors outside the partition on the same
>> disk.
>>
>> is_pte_valid() only rejects an entry when its type is NULL or when
>> starting_lba or ending_lba is greater than lastlba; it never checks that
>> starting_lba <= ending_lba. For a reversed entry both field checks still
>> pass, but efi_partition() computes size = ending_lba - starting_lba + 1 in
>> u64, which underflows to a huge value. That value also wraps in the
>> end-of-device check in blk_add_partition() (from + size) and does not fit
>> the signed i_size, which turns negative.
>>
>> Reject entries with starting_lba > ending_lba in is_pte_valid(), matching
>> the head-level check against last_usable_lba < first_usable_lba.
> 
> Looks good in general.  But should this be a >= to also catch zero-sized
> entries?
> 

Thanks. I think > is the correct boundary here because GPT's EndingLBA
is inclusive and efi_partition() computes the size as:

size = le64_to_cpu(ptes[i].ending_lba) - 
le64_to_cpu(ptes[i].starting_lba) + 1ULL;

so starting_lba == ending_lba is a valid one-sector partition, not a
zero-sized one?

Thanks,
Zizhi Wo



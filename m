Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E685239565
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744699455; cv=none; b=cNv/Rxk4PsN3xTV3KTDbjCCFQfLWyE0LKNxd4k71zrmE0LDjCWpK8/fTWNcjAfNYFGGZFKakRddM6XFvehWvz8275vGx63cjLdTbvUAiP2LJs7I3aBe2C4lKQ9biJbcA4r6p5J5ejk/fTA4iW4DLCEEq9FhLcVYBf99pPRGUPB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744699455; c=relaxed/simple;
	bh=JbhNJp5GTV5mP8XFqEsGb+Z2nzZWL/3ufLs4efo0uCU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Z79+ttAz3/CwIcTIJ9j3fhpRGFOaHEuJieknTMxG6bGhr16xS82kfbIE4qEbp0DB0czJyncBlamtMLMthdeH14mdsODDyKTIDXNdAc+M6RiayGjKf5yuq+Ujiblj0QB67PXWpLboSWRqzLy9bT32aiCSaNBDUM4PqXjjx+3Xm2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZcDgR75Zvz4f3jXP
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 14:25:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A32121A1A0D
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 14:26:19 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2AJ_P1n5soiJg--.44039S3;
	Tue, 15 Apr 2025 14:26:19 +0800 (CST)
Subject: Re: [PATCH 2/7] blk-throttle: Refactor tg_dispatch_time by extracting
 tg_dispatch_bps/iops_time
To: Zizhi Wo <wozizhi@huawei.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, ming.lei@redhat.com, tj@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250414132731.167620-1-wozizhi@huawei.com>
 <20250414132731.167620-3-wozizhi@huawei.com>
 <58cabe9f-86c6-d26a-d27b-0a138b00e7ec@huaweicloud.com>
 <e37717f0-3704-4bc4-88f8-dc3e7d812aac@huawei.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <769d7e88-b78a-077e-5100-c6cf3bae54d9@huaweicloud.com>
Date: Tue, 15 Apr 2025 14:26:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e37717f0-3704-4bc4-88f8-dc3e7d812aac@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnC2AJ_P1n5soiJg--.44039S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYk7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0
	xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF
	0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/04/15 14:13, Zizhi Wo 写道:
> Since the time_before() logic has been incorporated into
> throtl_extend_slice(), can we simplify the code by not adding the extra
> check?

Yes, I missed the early return in throtl_extend_slice().

Feel free to add:
Reviewed-by: Yu Kuai <yukuai3@huawei.com>


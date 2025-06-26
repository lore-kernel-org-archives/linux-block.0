Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E6F17BA5;
	Thu, 26 Jun 2025 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750937538; cv=none; b=gArNt+khwtlG18K+JZ7BhqZ0LTWKF89Q553X60fIrUbglWu6sgbRqdphxqzWAO8bm9qzgx/c5dxybcgNX2jAwgU+CzW7G77EvVfdjQAOUa/CmUoqDF/yeiQYo9DowDRAdRJyExqrB5LceGx1ESum5AJSQ1/mPAl4Nykgh3LUZFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750937538; c=relaxed/simple;
	bh=4lRYK29TYeLqqY7lMO7yv7T9NuQptYhpLNwm4028BKs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oJD3qTZWUJYFQHFCPQiE/cLu9jXsXKh0kPqzdSaBSR1yAwtEneLTl4mVeKgmwMcHlW+IopuufKIhxno3Oc54utbRRtpB8z7oLu9FqR6hwweMb9NsKfSQDa1n8dJbW4OH60TLN3JC9ohrz+5BNkMEg2Jy2DnYYQOqryOIVrWaNbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bSc3c1LBSzYQtt5;
	Thu, 26 Jun 2025 19:32:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 172CD1A0C1C;
	Thu, 26 Jun 2025 19:32:11 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB321+5L11o+5TZQg--.49631S3;
	Thu, 26 Jun 2025 19:32:10 +0800 (CST)
Subject: Re: [PATCH] block: fix false warning in bdev_count_inflight_rw()
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, hare@suse.de, hch@infradead.org, john.g.garry@oracle.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@redhat.com, calvin@wbinvd.org, david@fromorbit.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250626083927.576207-1-yukuai1@huaweicloud.com>
 <2350a34d-2f7b-49c0-b286-2856c088131a@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3da33719-886d-0e39-d79a-6bb10c50c770@huaweicloud.com>
Date: Thu, 26 Jun 2025 19:32:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2350a34d-2f7b-49c0-b286-2856c088131a@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB321+5L11o+5TZQg--.49631S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU
	oOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/06/26 16:54, Damien Le Moal 写道:
> Nit (grammar):
> 
> 	 * While iterating all CPUs, some IOs may be issued from a CPU already
> 	 * traversed and complete on a CPU that has not yet been traversed,
> 	 * causing the inflight number to be negative.

Thanks, will change to this in v2.
Kuai


Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690BE2AEE4
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115004; cv=none; b=WhLVnSXK40R5znsHFFDnvYOBVy+wtP30ojT9gyzQk0nykb589yRUEHR9PukIjQFBBinu4HWU2TXKYCy2UBjp7rk+mQ0PNdyGHoRAnwltmgAYNCtP7M49mVBLtuhhb3FC6zsZfTsIzLhfd0p72O3vRabJdkA+oPf20HVgSkdpK4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115004; c=relaxed/simple;
	bh=GDmnLvKW9Y8O65Lbgrnp7oLQEhGFP+Y+3vZCNU2LEkU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pz+KcXMNfDJvTT6WPWUYIg4xLFzTdsc51Z/0dnuV+FF2Sn37h0sgAyO5lDZJSlUo36m+MWr+mhm5DE4I6zi36qIGeK6KMQ9RmHT81QIqQLO6f5fjzGjVHT3YsRaKb3jbWxPOGKM3hJDRAaPvsNblLJBCYKJQCiZq+wqV8GNCTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XcWPt1989z4f3v5R
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 19:29:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9821D1A0196
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 19:29:56 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCHYoaydR9ndZG6AA--.13447S3;
	Mon, 28 Oct 2024 19:29:56 +0800 (CST)
Subject: Re: [PATCH] brd: defer automatic disk creation until module
 initialization succeeds
To: Christoph Hellwig <hch@lst.de>, Yang Erkun <yangerkun@huaweicloud.com>
Cc: axboe@kernel.dk, ulf.hansson@linaro.org, houtao1@huawei.com,
 penguin-kernel@i-love.sakura.ne.jp, linux-block@vger.kernel.org,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241028090726.2958921-1-yangerkun@huaweicloud.com>
 <20241028094409.GA31248@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c2ec4267-6cd6-43ec-2857-287d4610441c@huaweicloud.com>
Date: Mon, 28 Oct 2024 19:29:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241028094409.GA31248@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHYoaydR9ndZG6AA--.13447S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtw15AFyxGFy8KF1fAF1xuFg_yoWkWrg_ua
	yUWrWkA348XFZ2kF4UtF15urW0vws7ur4rA393XFn7G3yxZ39rX34kurykXrWUWws7Kry3
	WF98Ar17K392gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
	r21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/10/28 17:44, Christoph Hellwig Ð´µÀ:
> On Mon, Oct 28, 2024 at 05:07:26PM +0800, Yang Erkun wrote:
>> Fix this problem by following what loop_init() does. Besides,
>> reintroduce brd_devices_mutex to help serialize modifications to
>> brd_list.
> 
> This looks generally good.  Minor comments below:
> 
>> +	snprintf(buf, DISK_NAME_LEN, "ram%d", i);
>> +	mutex_lock(&brd_devices_mutex);
>> +	list_for_each_entry(brd, &brd_devices, brd_list) {
>> +		if (brd->brd_number == i) {
>> +			mutex_unlock(&brd_devices_mutex);
>> +			err = -EEXIST;
>> +			goto out;
> 
> This now prints an error message for an already existing
> device, which should not happen for the module_init case,
> but will happen all the time for the probe callback, and
> is really annoying.  Please drop that part of the change.

I don't quite understand this, if the gendisk already exists,
the probe callback won't be called from the open path, because
ilookup() from blkdev_get_no_open() will found the bdev inode.
Hence there will only be a small race windown for concurrent
create on open callers to return -EEXIST here.

Thanks,
Kuai


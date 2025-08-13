Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DDE1C860B;
	Wed, 13 Aug 2025 03:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755055670; cv=none; b=q2mTnc1EurG85mcB29vfPi5ZrONet1wUbEvxZohCS26zOyk1x9KkwIaOZvRtRJsnMK6vUUnqEXl7nKIE4Xarb4SqdVvI+K3ZIlli+eja84uD8u22ZlUeoXj7sp67i4w3Y1PCwnpGRBJJVlOECo6Dq5h8QO9fie6H1vrHs6Cy16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755055670; c=relaxed/simple;
	bh=+LyA6zR1lhskcssggkrVNKAvL4doi16EDP09/N5iP3I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=unIBn2KLbHTIs5/GO9/sJUO11lxhOBx/vQdswJrdySi1/J0PXM3vKDVZIUkGq+HehuqxQyxZDprA2KAsSmMU6GQiS0aJvmXCWpVWJOaMThG8BJWIgwaXtW2Q9AXNeXPemmljMdFccFAYzNWNXA68kuqhDyvx/vWtnUkvJaZ1Njg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c1v2T39zwzKHMcS;
	Wed, 13 Aug 2025 11:27:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AE18F1A0B39;
	Wed, 13 Aug 2025 11:27:44 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXkxMuBpxo350EDg--.56379S3;
	Wed, 13 Aug 2025 11:27:44 +0800 (CST)
Subject: Re: [PATCH v2] block: restore default wbt enablement
To: Julian Sun <sunjunchao2870@gmail.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, nilay@linux.ibm.com, ming.lei@redhat.com,
 Julian Sun <sunjunchao@bytedance.com>, stable@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250812154257.57540-1-sunjunchao@bytedance.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b8481fcc-07dc-d16e-9a2a-ab8e19f64c97@huaweicloud.com>
Date: Wed, 13 Aug 2025 11:27:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250812154257.57540-1-sunjunchao@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXkxMuBpxo350EDg--.56379S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF15Wr17Kr43ZF18WFWktFb_yoW8XF4xpw
	1fGr1YkFZrGFWxCw17Aan7Zayjq3yDWr1UWry8u34Yv34UCwnaqayI9ryaqFWqvas3C3Z0
	vw4xtFWrtryUA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/12 23:42, Julian Sun Ð´µÀ:
> The commit 245618f8e45f ("block: protect wbt_lat_usec using
> q->elevator_lock") protected wbt_enable_default() with
> q->elevator_lock; however, it also placed wbt_enable_default()
> before blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);, resulting
> in wbt failing to be enabled.
> 
> Moreover, the protection of wbt_enable_default() by q->elevator_lock
> was removed in commit 78c271344b6f ("block: move wbt_enable_default()
> out of queue freezing from sched ->exit()"), so we can directly fix
> this issue by placing wbt_enable_default() after
> blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);.
> 
> Additionally, this issue also causes the inability to read the
> wbt_lat_usec file, and the scenario is as follows:
> 
> root@q:/sys/block/sda/queue# cat wbt_lat_usec
> cat: wbt_lat_usec: Invalid argument
> 
> root@q:/data00/sjc/linux# ls /sys/kernel/debug/block/sda/rqos
> cannot access '/sys/kernel/debug/block/sda/rqos': No such file or directory
> 
> root@q:/data00/sjc/linux# find /sys -name wbt
> /sys/kernel/debug/tracing/events/wbt
> 
> After testing with this patch, wbt can be enabled normally.
> 
> Signed-off-by: Julian Sun<sunjunchao@bytedance.com>
> Cc:stable@vger.kernel.org
> Fixes: 245618f8e45f ("block: protect wbt_lat_usec using q->elevator_lock")
> ---

Usually we put the fix tag before Signed-off-by, however, this is
negligible.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>


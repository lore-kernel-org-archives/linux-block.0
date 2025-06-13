Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472CB241682
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 02:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749783132; cv=none; b=koBTnFC30xgy8rbZ7LGCzP61TpHQYqbtiA4o1OJWD15WIPLTEAMp9adnnUNqpJgbEZiLYBGUBBH5DghTrKtzpoJTWxaNNOKDfN91mjyii3wMiNDmzTdteiNknHpIwnNZSPOW29/37MkPcmp1CfFyClzADcRbaJ3mzdTLOIUpRfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749783132; c=relaxed/simple;
	bh=Xkb7TB2kyv/z5xcqArWvPV4v+n9/rVEzzXW6eA6fEIA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rQln94eXCDDDicEmdcsxXxjf8hyr/QIfdX5wNDR8meL/22xP1OeANqPxGMSK7RN3AF56ONqnpZI49VFsazUY9Iq1ncqKIvzcrA4dAltvK2w9fODgjD3kzwoZIgAqCuh1A8Gi4Wx5UdQZeJ3eX8ZB6AQjctmRlo/U7E9Kfj4VBUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bJP7X0TyMzKHMTG
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 10:52:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6911F1A08BC
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 10:52:06 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgA3m19Ukkto+OZqPQ--.49749S3;
	Fri, 13 Jun 2025 10:52:06 +0800 (CST)
Subject: Re: [PATCH] tests/throtl: add a new test 007
To: Zizhi Wo <wozizhi@huaweicloud.com>, shinichiro.kawasaki@wdc.com,
 linux-block@vger.kernel.org, ming.lei@redhat.com
Cc: yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250613023538.2900008-1-wozizhi@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6e302504-ff4f-e689-dbff-d13d464734bc@huaweicloud.com>
Date: Fri, 13 Jun 2025 10:52:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250613023538.2900008-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3m19Ukkto+OZqPQ--.49749S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWUXw4UKrW7CFyrXryDGFg_yoW8tF13pr
	y5CFZYkF4xX3ZrGrn3GanrCFZ5Zws7ur12y343Xr15ArnFq34UKF1Ivr1ayFZ3tF9rWr10
	93W0qF95GF45AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/06/13 10:35, Zizhi Wo Ð´µÀ:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> Test change config while IO is throttled, for IO splitting scenario.
> Regression test for commit d1ba22ab2bec ("blk-throttle: Prevents the bps
> restricted io from entering the bps queue again").
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   tests/throtl/007     | 41 +++++++++++++++++++++++++++++++++++++++++
>   tests/throtl/007.out |  6 ++++++
>   2 files changed, 47 insertions(+)
>   create mode 100755 tests/throtl/007
>   create mode 100644 tests/throtl/007.out
> 
> diff --git a/tests/throtl/007 b/tests/throtl/007
> new file mode 100755
> index 0000000..98ba4ea
> --- /dev/null
> +++ b/tests/throtl/007
> @@ -0,0 +1,41 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2025 Zizhi Wo
> +#
> +# Test change config while IO is throttled, for IO splitting scenario.

This test do not change config while IO is throttled, it's iops limit
over io split.

> +# Regression test for commit d1ba22ab2bec ("blk-throttle: Prevents the bps
> +# restricted io from entering the bps queue again")
> +
> +. tests/throtl/rc
> +
> +DESCRIPTION="bps limit with iops limit over io split"
> +QUICK=1
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _set_up_throtl max_sectors=8; then
> +		return 1;
> +	fi

And this should be updated, please take a look at
60fa2e3 ("throtl/{002,003}: update max_sectors setting").

Thanks,
Kuai

> +
> +	local bps_limit=$((1024 * 1024))
> +	local iops_limit=1000000
> +
> +	# just set bps limit first
> +	_throtl_set_limits wbps=$bps_limit
> +	_throtl_test_io write 1M 1 &
> +	_throtl_test_io write 1M 1 &
> +	wait
> +	_throtl_remove_limits
> +
> +	# set the same bps limit and a high iops limit
> +	# should behave the same as no iops limit
> +	_throtl_set_limits wbps=$bps_limit wiops=$iops_limit
> +	_throtl_test_io write 1M 1 &
> +	_throtl_test_io write 1M 1 &
> +	wait
> +	_throtl_remove_limits
> +
> +	_clean_up_throtl
> +	echo "Test complete"
> +}
> diff --git a/tests/throtl/007.out b/tests/throtl/007.out
> new file mode 100644
> index 0000000..d28cdef
> --- /dev/null
> +++ b/tests/throtl/007.out
> @@ -0,0 +1,6 @@
> +Running throtl/007
> +1
> +2
> +1
> +2
> +Test complete
> 


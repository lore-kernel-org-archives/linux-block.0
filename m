Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1942048
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 02:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734488061; cv=none; b=MPXF2GdECZx26PYuQ0rmprjPd/Ww3UD0XNfFQvLgfBA/UTsFTjROJlWl0Z6axoumhd2kV/OAwotHF4KgPNHwAxq1mXNQ5hb9eyMcZvdmVR02J9XTdRJMFnrYonwuMOJW+kbCl9EuYEB/Sw5asopPftBcNfavJxeX5kXv21AUZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734488061; c=relaxed/simple;
	bh=D17fRSQ0lKwktVQ07xVTD5dxzLSnYLj5cCr7lDq9alc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OnJZoE5ioN6X+X9KLe9i/MlR+JNr2L+YYGGa8Z5DqolJPGIR4nM3X/GtQ52kF+ofbjH2H5x6ulti50pICkgfCc7ccemzmQ8WNZPUvYghyklQDhXYm2aBU2+QqzjhfuWCDAyoNuqdvAaB4VOm4fRQT9APpZ8CdWTi/sWluwM90oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCcgD6m07z4f3jqx
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 10:14:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 658AF1A058E
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 10:14:15 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCHYob1L2JndyKmEw--.30519S3;
	Wed, 18 Dec 2024 10:14:15 +0800 (CST)
Subject: Re: [PATCH blktests 1/2] throtl/002: calculate block-size based on
 device max-sectors setting
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, yi.zhang@redhat.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20241217131440.1980151-1-nilay@linux.ibm.com>
 <20241217131440.1980151-2-nilay@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <cc7f2e1a-72bc-5f5a-e8e1-001275af3d9d@huaweicloud.com>
Date: Wed, 18 Dec 2024 10:14:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241217131440.1980151-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHYob1L2JndyKmEw--.30519S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyUXFyftrykuw1DXw4UCFg_yoW5GrWkpr
	W7CFWftF4xKFZxWr13G3WUWFWFvws5AF12kry7Wrn8CrZrWasxKFsFv3yj9FWYvF93urW0
	vF1kXryrC3WUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7I
	JmUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2024/12/17 21:14, Nilay Shroff Ð´µÀ:
> The commit 60fa2e3ff3ab ("update max_sectors setting") added max-sectors
> while setting up throttle device. So now we should also calculate block-
> size which matches the wiops. Typically, size of each IO which is submitted
> to the block device depends on the max-sectors setting of the block device.
> For example setting max-sectors to 128 results into 64kb of max. IO size
> which should be used for sending read/write command to the device. So take
> into account the max-sectors-kb and wiops settings and calculate the
> appropriate block-size which is then used to issue IO to the block device.
> This change would result in always submitting 256 I/O read/write commands
> to block device.
> 
> Without this change on a system with 64k PAGE SIZE, using block-size of 1M
> would result in 16 I/O being submitted to the device and this operation may
> finish in a fraction of a section and result in test failure. However the
> intent of this test case is that we want to test submitting 256 I/O after
> setting wiops limit to 256.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   tests/throtl/002 | 14 ++++++++++----
>   tests/throtl/rc  |  4 ++++
>   2 files changed, 14 insertions(+), 4 deletions(-)
> 
LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/tests/throtl/002 b/tests/throtl/002
> index 185e66b..02b0969 100755
> --- a/tests/throtl/002
> +++ b/tests/throtl/002
> @@ -14,6 +14,9 @@ test() {
>   	echo "Running ${TEST_NAME}"
>   
>   	local page_size max_secs
> +	local io_size_kb block_size
> +	local iops=256
> +
>   	page_size=$(getconf PAGE_SIZE)
>   	max_secs=$((page_size / 512))
>   
> @@ -21,12 +24,15 @@ test() {
>   		return 1;
>   	fi
>   
> -	_throtl_set_limits wiops=256
> -	_throtl_test_io write 1M 1
> +	io_size_kb=$(($(_throtl_get_max_io_size) * 1024))
> +	block_size=$((iops * io_size_kb))
> +
> +	_throtl_set_limits wiops="${iops}"
> +	_throtl_test_io write "${block_size}" 1
>   	_throtl_remove_limits
>   
> -	_throtl_set_limits riops=256
> -	_throtl_test_io read 1M 1
> +	_throtl_set_limits riops="${iops}"
> +	_throtl_test_io read "${block_size}" 1
>   	_throtl_remove_limits
>   
>   	_clean_up_throtl
> diff --git a/tests/throtl/rc b/tests/throtl/rc
> index 9c264bd..330e6b9 100644
> --- a/tests/throtl/rc
> +++ b/tests/throtl/rc
> @@ -71,6 +71,10 @@ _throtl_remove_limits() {
>   		"$CGROUP2_DIR/$THROTL_DIR/io.max"
>   }
>   
> +_throtl_get_max_io_size() {
> +	cat "/sys/block/$THROTL_DEV/queue/max_sectors_kb"
> +}
> +
>   _throtl_issue_io() {
>   	local start_time
>   	local end_time
> 


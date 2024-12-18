Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263717080B
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734488704; cv=none; b=ryH4HbVzlZWt0i+s0PTueptI2HXvf9nKfo0I6iCpyfi0g+2iN0d4+/n5hjFMUbagm4sP93Ns+90DXfx6l9cWYZ47yop00ccbE704Vguk3UZYUHyqfCba0ziUnqlZMhRqQ/oXWb5ztBqoRucA/EaEHw+H8w+RhRUpitI/YCwajbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734488704; c=relaxed/simple;
	bh=NPuWjvyeZCs+PKdpAAsn5exiv7WJwXhNNVjHh9F4cmQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NjGqpN7SpgZrXqIyEavUJ2FteqtsCxmQC82uCpFbm67GEtEeAaSN62uul6XhoG+hBElq4v++CGFxS4tGea44JlMQZ+na1bZrb4fynnfhnwG/SOBqWKhINZR8NMUg3yzEkDSSqaf4oVgb0GpfTLCkuzvAN4M36b2YuVJtIQvanNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCcvc0Hwvz4f3jqb
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 10:24:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7C5291A06DA
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 10:24:58 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgB3noJ4MmJn5tWmEw--.62823S3;
	Wed, 18 Dec 2024 10:24:58 +0800 (CST)
Subject: Re: [PATCH blktests 2/2] throtl: fix the race between submitting IO
 and setting cgroup.procs
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, yi.zhang@redhat.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20241217131440.1980151-1-nilay@linux.ibm.com>
 <20241217131440.1980151-3-nilay@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d2b28360-259a-8938-47eb-b14b5b4df754@huaweicloud.com>
Date: Wed, 18 Dec 2024 10:24:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241217131440.1980151-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3noJ4MmJn5tWmEw--.62823S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtw15ZFW7Jr1rAr43KFyfZwb_yoW3KFXEk3
	s7Kryjg3yxA3srJanakr43WrW2ya1UurWrZ3WxCF42q348Aws3uF92qw17Zr13ZayIyrs8
	W34S9w17KwnIkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UtR6
	wUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/12/17 21:14, Nilay Shroff Ð´µÀ:
> This commit helps fix the above race condition by touching a temp file. The
> the existence of the temp file is then polled by the background process at
> regular interval. Until the temp file is created, the background process
> would not forward progress and starts submitting IO and from the main
> thread we'd touch temp file only after we write PID of the background
> process into cgroup.procs.

It's right sleep 0.1 is not appropriate here, and this can work.
However, I think reading cgroup.procs directly is better, something
like following:

  _throtl_test_io() {
-       local pid
+       local pid="none"

         {
                 local rw=$1
                 local bs=$2
                 local count=$3

-               sleep 0.1
+               while ! cat $CGROUP2_DIR/$THROTL_DIR/cgroup.procs | grep 
$pid; do
+                       sleep 0.1
                 _throtl_issue_io "$rw" "$bs" "$count"
         } &


Thanks,
Kuai


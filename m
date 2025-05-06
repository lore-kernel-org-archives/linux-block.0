Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D5F29952D
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 01:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493678; cv=none; b=ac39KqQ9jo1/1158syqw+STJLCgFqGI/O7QCaMIlX1kW7iP1NY5dYZn+CRi5YfFc5rL5E9XaIVPE4Z5m2s0fahplVj7nSXHHT3C/OC+ADw6Q2rm/LhuyIYvk3sHTuaWu/vhR2Tais7dh2kn0I4LyfvA7mYlGWtMDgYtweVmWPqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493678; c=relaxed/simple;
	bh=Za0hjW+3+dz6tUdbNzfbWdtMMAyozAdVu1nRzK/lepU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOpvJGFr4vZU0Ta0SCawlFM8avTDKqvKbID+K8zE8cXu7a226ndqE3DzKLnjUbs3t6Fmwx1sQXsdVN9V379lqWANQmQGj6L/H+37m8QUFL8CnEB+fLrbOHKrckYSzVhdFJxKwjlkFDq1oGUy5s4o/KqaDwWryP9njM4wwUd/Ja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zs0c70MQSz4f3kvp
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 09:07:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 063A51A0A04
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 09:07:45 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl_fYBloEF0+Lg--.30270S3;
	Tue, 06 May 2025 09:07:44 +0800 (CST)
Message-ID: <05d61a7e-5f11-4898-ab3f-965ff81cfdaa@huaweicloud.com>
Date: Tue, 6 May 2025 09:07:43 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/3] blk-throttle: Some bugfixes and modifications
To: axboe@kernel.dk, linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, yukuai3@huawei.com, ming.lei@redhat.com,
 tj@kernel.org
References: <20250417132054.2866409-1-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20250417132054.2866409-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnSl_fYBloEF0+Lg--.30270S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XFW3Kw48Jw4kWF13Wr47XFb_yoW3CFg_XF
	WqyFyrJw1jgayrAFW0kF95uryjka1jqr18C3Z8KFW7Ar9rJ3WDXr97Jw4xWFsrZa929F1D
	Jrn8tF18Ar13XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

friendly ping

在 2025/4/17 21:20, Zizhi Wo 写道:
> Changes since V1:
> Modified patch 1 and 3 to make the changes more concise, without
> introducing additional logic changes.
> 
> The patchset mainly address the update logic of tg->[bytes/io]_disp and add
> related overflow checks. The last patch also simplified the process.
> 
> Zizhi Wo (3):
>    blk-throttle: Fix wrong tg->[bytes/io]_disp update in
>      __tg_update_carryover()
>    blk-throttle: Delete unnecessary carryover-related fields from
>      throtl_grp
>    blk-throttle: Add an additional overflow check to the call
>      calculate_bytes/io_allowed
> 
>   block/blk-throttle.c | 113 +++++++++++++++++++++++++++++++------------
>   block/blk-throttle.h |  19 +++-----
>   2 files changed, 90 insertions(+), 42 deletions(-)
> 


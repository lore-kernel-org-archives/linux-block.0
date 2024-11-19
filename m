Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D75638DF9;
	Tue, 19 Nov 2024 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979853; cv=none; b=BkwRocp7VAmcAbz0CE7XuzH6sCOHZbJX7Un0J191/0FInmI/LXmD6kwumuRCrU8DSwUilV1fVahvqiZ10NOAaoTaZ5t4xV1fCtLgPL7+dhjspwOuzsSzu1hygOiZvlpH0bDXYPjKHdUBwukcpC3D6OHaawUVz+z62zha7iLofbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979853; c=relaxed/simple;
	bh=VzbXylXVXwOKoNDmI+cRWKOy5BIUN0WCeiDAbo+VN7Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=H1hGB3FxeSRRhIy4VG8jlKyczQbZXM6410LeEA7TK9l53oZNE9P4FStqfQjpxZ6xTPO2mDFUzlicQPhIoCeN/6VU8uV3qnjcug8EBPrLPbb/RkiaxcEptbltD7khjkzOQdC4kFg7IEsoKhZhjdxw5fmcK1QYmDjUerjjpZ+8bIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xsn4M0rHVz4f3m7Y;
	Tue, 19 Nov 2024 09:30:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 774D51A0196;
	Tue, 19 Nov 2024 09:30:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCngYVE6jtni3LCCA--.13143S3;
	Tue, 19 Nov 2024 09:30:46 +0800 (CST)
Subject: Re: [PATCH -next] block: fix uaf for flush rq while iterating tags
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
 <ZynG3g8o_iLOjwai@fedora>
 <88ffc0a3-10ab-e6fd-01e1-57ff8011c257@huaweicloud.com>
 <ZynQCXVc5OjGaF-1@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <efb457db-97d5-34aa-4fa1-678a387ee366@huaweicloud.com>
Date: Tue, 19 Nov 2024 09:30:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZynQCXVc5OjGaF-1@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCngYVE6jtni3LCCA--.13143S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYg7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2js
	IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2
	V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUAV
	WUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Jens!

在 2024/11/05 15:58, Ming Lei 写道:
> OK, looks fine, since queue usage counter only works in percpu mode with
> disk attached for !GD_OWNS_QUEUE, maybe QUEUE_FLAG_INIT_DONE can be renamed
> too, but anyway:
> 
> Reviewed-by: Ming Lei<ming.lei@redhat.com>

Can you apply this patch perhaps for rc2?

Thanks,
Kuai


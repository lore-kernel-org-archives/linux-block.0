Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5A027450;
	Thu, 31 Jul 2025 02:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753929546; cv=none; b=qD4sPfgUIPubAfVwmrVZ2s6DhaGDzOEAJQ/Zpi6Sd2pLAiUAFYOgAswjzNw81yDJ0eukYd51RCusulrVdHWNYUYt8a89S5ceA0VEAWOq2j9O/ZYzf4PzSUwxNwpFQw7FVzv6a64MF2w3gl2H6kDIV0XInBlpviB15kO51DklDVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753929546; c=relaxed/simple;
	bh=8V2vkQ4Paur/1HgNG/DwdwcZ95DNfzZ/MLpTsqpSrbY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c5FYljHzrHKPQ8U1HkKnT0rlRKbkZz+NvQQAz0bbpurU7CYs5x8R6Y2wn6vpa1E1G8qWwHEq71n6tHRgLvcNA5XRE3XZ0rom17bhbENO9ipl28nhYao2rCnXHLmeM+6YOMa6Bf+q28QZGtXkw/R3YBEkt+efmvvfEFvRevcq3aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bstZF4tRdzKHLtS;
	Thu, 31 Jul 2025 10:39:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 97BF51A1A77;
	Thu, 31 Jul 2025 10:39:00 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxRC14poXD46CA--.37766S3;
	Thu, 31 Jul 2025 10:39:00 +0800 (CST)
Subject: Re: [PATCH v2 1/2] lib/sbitmap: convert shallow_depth from one word
 to the whole sbitmap
To: yukuai@kernel.org, Jan Kara <jack@suse.cz>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, yang.yang@vivo.com,
 dlemoal@kernel.org, ming.lei@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, Omar Sandoval <osandov@fb.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250729031906.3615228-1-yukuai1@huaweicloud.com>
 <20250729031906.3615228-2-yukuai1@huaweicloud.com>
 <ozjsdoiqa2uem65qqj4fjbrwm6toxlj5bzv7f5dg5xfiljv3zi@wcaamboo2r6h>
 <8edcdef6-8749-aa45-e7d2-ada677645d76@huaweicloud.com>
 <jr54uomodnzqyw4bu4hcdpllgafkhueyygiiempuudwjy3vir5@d7lv3jsxxqx2>
 <223acbc1-60d4-4687-8eea-5306aa44ae24@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c748a3ee-bf33-e13e-d507-984277acbb32@huaweicloud.com>
Date: Thu, 31 Jul 2025 10:38:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <223acbc1-60d4-4687-8eea-5306aa44ae24@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIxRC14poXD46CA--.37766S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF15Wr18AFyfJFW7Aw1rXrb_yoW8XF4Dpr
	4UKw12k348tr1jkw1Yqa1DXF15uw13GwsxGF45Xw1xCrZ8Ja10qFyYqFy5ZF9rurW8Zayj
	vFWfXry7Gw1UXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/07/31 2:24, Yu Kuai 写道:
> hi, Jan!
> 
> 在 2025/7/30 21:03, Jan Kara 写道:
>> I think having two APIs will be even more confusing than the current 
>> state.
>> But as I wrote I think you can have API to specify shallow depth in total
>> size and in sbitmap_queue_get_shallow() do:
>>
>> shallow_per_word = (shallow_depth << sb->shift) / sb->depth;
In order to consider the last word, I think we should use __map_depth()
here.

>> rounding_index = shallow_depth - shallow_per_word * sb->depth;
And then it's not possible to calculate this rounding index easily. How
about following, although the reminder handling is not perfect.

  static unsigned int __map_depth_with_shallow(const struct sbitmap *sb,
                                              int index,
                                              unsigned int shallow_depth)
  {
         unsigned int word_depth = __map_depth(sb, index);
         unsigned int shallow_word_depth = word_depth * shallow_depth;
         unsigned reminder = do_div(shallow_word_depth, sb->depth);

         if (reminder && !(index & 0x1))
                 shallow_word_depth++;

         return shallow_word_depth;
  }


>>
>> and allow depth shallow_per_word + 1 if current index < rounding_index 
>> and
>> exactly shallow_per_word if current index >= rounding_index. This will
>> still evenly distribute shallow depth among words and I don't think the
>> additional overhead of the several arithmetic operations will be visible.
> Yes, you're right, I did not get your idea before. Thanks for the 
> explanation
> and the suggestion :） Will follow this idea in the next version.

> 
> Thanks
> 
> .
> 


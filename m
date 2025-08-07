Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB01428E7;
	Thu,  7 Aug 2025 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754530261; cv=none; b=EwmdHIMTdXS3OKUTcUSyWJkx8MMoeiwiCfSCwNbskcgaGIZn/VYdiqJ15DBFuVEVkLQFpoGvu/c7CkUZ+EpiWXtNU3slt5006WVCWleZa/AhtjasAHaDhlPdGY/OsGeWBE+V42LrChW4Og7W2wNhAz01GWn/8yxvQZ+WvZJsiMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754530261; c=relaxed/simple;
	bh=HMjyOSFlWe+el4KAgTKAjwuxCLUJQTYqY+39ERHTw/I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jorvmwHP7wFGB/+GtiJx2hyG/EYmnPbFDWH910oRz/OQY/iZd0wgnNB69N2zbJAvck3rsZFGqCYIl8q2LSuNJZfhivCL7vam0NKZwJtr8gbktBsK+elt4eG2WnSwDZcOSkFwItaz9MN3D7qQtjVypML0hClhC69v5ZaJiMGnF4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4by8kN1k9SzYQv97;
	Thu,  7 Aug 2025 09:30:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D9E361A07BB;
	Thu,  7 Aug 2025 09:30:50 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHERLJAZRonmVTCw--.2916S3;
	Thu, 07 Aug 2025 09:30:50 +0800 (CST)
Subject: Re: [PATCH v3 1/2] lib/sbitmap: convert shallow_depth from one word
 to the whole sbitmap
To: kernel test robot <lkp@intel.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, akpm@linux-foundation.org, ming.lei@redhat.com,
 dlemoal@kernel.org, jack@suse.cz
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250805073748.606294-2-yukuai1@huaweicloud.com>
 <202508061722.0vTVFHLe-lkp@intel.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7d2b0108-4d16-97fb-5de9-7438414d9ca4@huaweicloud.com>
Date: Thu, 7 Aug 2025 09:30:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202508061722.0vTVFHLe-lkp@intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHERLJAZRonmVTCw--.2916S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW5Cry3Aw18CF1fKF17KFg_yoW8XryrpF
	yDCrn2gFZ5ur1rur1jqwsI9FyUJ3ZFgrnFqryF9ryjkrW2gF1jqrs0krnayr1ktF4DGF4U
	KFW3G390gw1jq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/06 17:41, kernel test robot Ð´µÀ:
> All error/warnings (new ones prefixed by >>):
> 
>     In file included from ./arch/sparc/include/generated/asm/div64.h:1,
>                      from include/linux/math.h:6,
>                      from include/linux/kernel.h:27,
>                      from include/linux/cpumask.h:11,
>                      from arch/sparc/include/asm/smp_32.h:15,
>                      from arch/sparc/include/asm/smp.h:7,
>                      from arch/sparc/include/asm/switch_to_32.h:5,
>                      from arch/sparc/include/asm/switch_to.h:7,
>                      from arch/sparc/include/asm/ptrace.h:120,
>                      from arch/sparc/include/asm/thread_info_32.h:19,
>                      from arch/sparc/include/asm/thread_info.h:7,
>                      from include/linux/thread_info.h:60,
>                      from arch/sparc/include/asm/current.h:15,
>                      from include/linux/sched.h:12,
>                      from lib/sbitmap.c:7:
>     lib/sbitmap.c: In function '__map_depth_with_shallow':
>     include/asm-generic/div64.h:183:35: warning: comparison of distinct pointer types lacks a cast
>       183 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
>           |                                   ^~
>     lib/sbitmap.c:222:20: note: in expansion of macro 'do_div'
>       222 |         reminder = do_div(shallow_word_depth, sb->depth);
>           |                    ^~~~~~

/* The unnecessary pointer compare is there
  * to check for type safety (n must be 64bit)
  */
# define do_div(n,base) ({

I didn't notice that under specific arch, do_div() will require the fist
paramater to be 64bit.

I'll wait a bit longer for people to review the solution before I send a
new version.

Thanks,
Kuai


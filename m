Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633E3643
	for <linux-block@vger.kernel.org>; Fri, 10 Nov 2023 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBE944A4
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 17:22:22 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SRLdz2y8kz4f3kjf
	for <linux-block@vger.kernel.org>; Fri, 10 Nov 2023 09:22:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BAD5F1A016D
	for <linux-block@vger.kernel.org>; Fri, 10 Nov 2023 09:22:17 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgA3jkzGhU1l0VoYAg--.6725S3;
	Fri, 10 Nov 2023 09:22:17 +0800 (CST)
Message-ID: <c1955b5b-4980-55dd-a1b7-54c19831d9d2@huaweicloud.com>
Date: Fri, 10 Nov 2023 09:22:14 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/4] brd discard patches
To: Mikulas Patocka <mpatocka@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: Zdenek Kabelac <zkabelac@redhat.com>,
 Christoph Hellwig <hch@infradead.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-block@vger.kernel.org,
 dm-devel@redhat.com
References: <2dacc73-854-e71c-1746-99b017401c9a@redhat.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <2dacc73-854-e71c-1746-99b017401c9a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3jkzGhU1l0VoYAg--.6725S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY
	6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr
	0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxG
	rwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x07UCXd8UUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

friendly ping...

在 2023/8/10 18:07, Mikulas Patocka 写道:
> Hi
> 
> Here I'm submitting the ramdisk discard patches for the next merge window.
> If you want to make some more changes, please let me now.
> 
> Changes since version 2:
> There are no functional changes, I only moved the switch statement
> conversion to a separate patch, so that it's easier to review.
> 
> Patch 1: introduce a switch statement in brd_submit_bio
> Patch 2: extend the rcu regions to cover read and write
> Patch 3: enable discard
> Patch 4: implement write zeroes
> 
> Mikulas
> 

-- 
Thanks,
Nan


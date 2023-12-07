Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA0210CF;
	Thu,  7 Dec 2023 05:24:38 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SmFNs2WxKz4f3l1t;
	Thu,  7 Dec 2023 21:24:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1E4351A07F3;
	Thu,  7 Dec 2023 21:24:34 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgAHXkyRx3FljQlYDA--.45823S3;
	Thu, 07 Dec 2023 21:24:33 +0800 (CST)
Message-ID: <7dbaaedd-e039-1025-76de-4ebf7fa7bc35@huaweicloud.com>
Date: Thu, 7 Dec 2023 21:24:33 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5] block: add check that partition length needs to be
 aligned with block size
To: Min Li <min15.li@samsung.com>, axboe@kernel.dk, hch@lst.de,
 dlemoal@kernel.org
Cc: gregkh@linuxfoundation.org, kch@nvidia.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, willy@infradead.org
References: <20230629073322.GB19464@lst.de>
 <CGME20231016060514epcas5p2ab38287c243a9539736453b4cb34e447@epcas5p2.samsung.com>
 <20231016140311.32367-1-min15.li@samsung.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20231016140311.32367-1-min15.li@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHXkyRx3FljQlYDA--.45823S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYB7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE
	52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGV
	WUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48J
	M4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUojjgDUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

friendly ping ...

在 2023/10/16 22:03, Min Li 写道:
> Thanks
> 
> Min li
> .

-- 
Thanks,
Nan


Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB40C77B60
	for <linux-block@archiver.kernel.org>; Wed, 26 Apr 2023 06:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239400AbjDZGYK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Apr 2023 02:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbjDZGYJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2023 02:24:09 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F682684
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 23:24:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q5pjZ6VMYz4f3wLG
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 14:24:02 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLODw0hkrg+0IA--.52964S3;
        Wed, 26 Apr 2023 14:24:04 +0800 (CST)
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address:
 00000000000000fc
To:     Changhui Zhong <czhong@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <CAGVVp+XSpFsjfzSNxLiK9SFnLvLB-W7bPHk7tySkkX95BM5BoQ@mail.gmail.com>
 <ZEdItaPqif8fp85H@ovpn-8-24.pek2.redhat.com>
 <CAGVVp+Wrhi0bWWR4nDVM5OXKp==RKbVKPSyt8pbuofUWVqQDGA@mail.gmail.com>
 <f5d3b05b-33a6-818f-6476-c3993f9d4e87@huaweicloud.com>
 <CAGVVp+W9SnHaEyi7o2Pkh6XEJsWL1E7W7esHvyXfXed8DFjt8g@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c1277414-bc3c-b191-de9c-1620c5533aa0@huaweicloud.com>
Date:   Wed, 26 Apr 2023 14:24:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGVVp+W9SnHaEyi7o2Pkh6XEJsWL1E7W7esHvyXfXed8DFjt8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLODw0hkrg+0IA--.52964S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYz7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
        Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
        6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
        CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0
        xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfU5WlkUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2023/04/26 14:20, Changhui Zhong 写道:
>> Is this patch in the branch for-6.4/block?
>>
>> 3723091ea188 ("block: don't set GD_NEED_PART_SCAN if scan partition failed")
>>>
> 
> Hi, Yu Kuai
> 
> this patch was not found in the for-6.4/block branch, and found it
> exist in the master branch
> 

Can you try to test with this patch?

Thanks,
Kuai


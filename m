Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16270C43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 02:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D938F20692
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 02:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLIC6f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Dec 2019 21:58:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbfLIC6f (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 8 Dec 2019 21:58:35 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6378178B73AE9BF9E9C5;
        Mon,  9 Dec 2019 10:58:32 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 9 Dec 2019
 10:58:22 +0800
Subject: Re: The irq Affinity is changed after the patch(Fixes: b1a5a73e64e9
 ("genirq/affinity: Spread vectors on node according to nr_cpu ratio"))
To:     George Spelvin <lkml@sdf.org>, <ming.lei@redhat.com>
References: <d59f7f7a-975a-2032-aa61-7cbff7585d33@hisilicon.com>
 <20191119014204.GA391@ming.t460p>
 <a8a89884-8323-ff70-f35e-0fcf5d7afefc@hisilicon.com>
 <201912080742.xB87gNOS011043@sdf.org>
CC:     <axboe@kernel.dk>, <john.garry@huawei.com>, <kbusch@kernel.org>,
        <linux-block@vger.kernel.org>, <linuxarm@huawei.com>,
        <tglx@linutronix.de>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <604256c2-7b89-c516-c383-4ae85de67475@hisilicon.com>
Date:   Mon, 9 Dec 2019 10:58:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <201912080742.xB87gNOS011043@sdf.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2019/12/8 15:42, George Spelvin 写道:
> On Tue, 19 Nov 2019 at 11:05:55 +0800, chenxiang (M)" <chenxiang66@hisilicon.com> wrote:
>> Sorry, I can't access the link you provide, but I can provide those
>> irqs' affinity in the attachment.  I also write a small testcase,
>> and find id is 1, 2, 3, 0 after calling sort().
>>
>> struct ex_s {
>>      int id;
>>      int cpus;
>> };
>> struct ex_s ex_total[4] = {
>>      {0, 8},
>>      {1, 8},
>>      {2, 8},
>>      {3, 8}
>> };
>>
>> static int cmp_func(const void *l, const void *r)
>> {
>>      const struct ex_s *ln = l;
>>      const struct ex_s *rn = r;
>>
>>      return ln->cpus - rn->cpus;
>> }
> Your cmp_func is the problem.  sort() in the Linux kernel, like
> qsort() in the C library, has never been stable, meaning that if
> cmp_func() returns 0, there is no guarantee what order *l and *r
> will end up in.  Minor changes to the implementation can change the
> result.  You're sorting on the cpus field, which is all 8, so your
> cmp_func is saying "I don't care what order the results appear in".
>
> (A web search on "stable sort" will produce decades of discussion
> on the subject, but basically an unstable sort has numerous
> implementation advantages, and problems can usually be solved by
> adjusting the comparison function.)
>
> If you want to sort by ->id if ->cpus is the same, then change the
> cmp_func to say so:
>
> static int cmp_func(const void *l, const void *r)
> {
>      const struct ex_s *ln = l;
>      const struct ex_s *rn = r;
>
>      if (ln->cpus != rn->cpus)
> 	return ln->cpus - rn->cpus;
>      else
> 	return ln->id - rn->id;
> }
> (This simple subtract-based compare depends on the fact that "cpus"
> and "id" are both guaranteed to fit into 31 bits.  If there's any chance
> The true difference could exceed INT_MAX, you need to get a bit fancier.)
>
> .

Thank you for your reply,  George.
In function ncpus_cmp_func(), it only sorts by ->ncpus (which makes the 
affinity a little odd if the cpus of all the nodes are the same though 
it doesn't affect the function).
Maybe it is more better to sort by ->id if ->ncpus is the same in the 
function.




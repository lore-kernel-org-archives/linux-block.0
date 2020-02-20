Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF17C11D04
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 11:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E892F24654
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 11:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgBTLHI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:07:08 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56276 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbgBTLHI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 06:07:08 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 691A75058EBBDCA0161B;
        Thu, 20 Feb 2020 19:07:04 +0800 (CST)
Received: from [10.173.220.74] (10.173.220.74) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Thu, 20 Feb 2020 19:07:02 +0800
Subject: Re: [PATCH] bdi: fix use-after-free for bdi device
To:     Jan Kara <jack@suse.cz>
CC:     Tejun Heo <tj@kernel.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <bvanassche@acm.org>
References: <20200211140038.146629-1-yuyufen@huawei.com>
 <b7cd6193-586b-f4e0-9a5d-cc961eafaf81@huawei.com>
 <20200212213344.GE80993@mtj.thefacebook.com>
 <fd9d78b9-1119-27cc-fa74-04cb85d4f578@huawei.com>
 <20200213034818.GE88887@mtj.thefacebook.com>
 <fa6183c5-b92c-c431-37ab-09638f890f6c@huawei.com>
 <20200213135809.GH88887@mtj.thefacebook.com>
 <f369a99d-e794-0c1b-85cf-83b577fb0f46@huawei.com>
 <20200214140514.GL88887@mtj.thefacebook.com>
 <32a14db2-65e0-5d5c-6c53-45b3474d841d@huawei.com>
 <20200219125505.GP16121@quack2.suse.cz>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <59a8851e-7ba2-e70d-36d8-be47829a7581@huawei.com>
Date:   Thu, 20 Feb 2020 19:07:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200219125505.GP16121@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.74]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2020/2/19 20:55, Jan Kara wrote:
> Hi!
> 
> On Sat 15-02-20 21:54:08, Yufen Yu wrote:

> 
> I've now noticed there's commit 68f23b8906 "memcg: fix a crash in wb_workfn
> when a device disappears" from end of January which tries to address the
> issue you're looking into. Now AFAIU the code is till somewhat racy after
> that commit so I wanted to mention this mostly so that you fixup also the
> new bdi_dev_name() while you're fixing blkg_dev_name().
> 
> Also I was wondering about one thing: If we really care about bdi->dev only
> for the name, won't we be much better off with just copying the name to
> bdi->name on registration? Sure it would consume a bit of memory for the
> name copy but I don't think we really care and things would be IMO *much*
> simpler that way... Yufen, Tejun, what do you think?
> 

I think copying the name to bdi->name is also need protected by lock.
Otherwise, the reader of bdi->name may read incorrect value when
re-registion have not copy the name completely. Right? So, I also think
using RCU to protect object lifetimes may be a better way.

Thanks,
Yufen

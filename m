Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA34FC433E1
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 07:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF8820738
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 07:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgHUHtO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:49:14 -0400
Received: from verein.lst.de ([213.95.11.211]:46007 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgHUHtO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 03:49:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA26268AFE; Fri, 21 Aug 2020 09:49:10 +0200 (CEST)
Date:   Fri, 21 Aug 2020 09:49:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de
Subject: Re: [PATCH 3/3] nvme-core: fix crash when nvme_enable_aen timeout
Message-ID: <20200821074910.GA30216@lst.de>
References: <20200820035413.1790-1-lengchao@huawei.com> <fc1efcce-99d9-05cf-5f32-9c454e3b0efe@grimberg.me> <820d5867-3e44-a009-d6b5-ea1a3fecd037@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <820d5867-3e44-a009-d6b5-ea1a3fecd037@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 20, 2020 at 02:43:20PM +0800, Chao Leng wrote:
>>> -static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>>> +static int nvme_enable_aen(struct nvme_ctrl *ctrl)
>>>   {
>>>       u32 result, supported_aens = ctrl->oaes & NVME_AEN_SUPPORTED;
>>>       int status;
>>>       if (!supported_aens)
>>> -        return;
>>> +        return 0;
>>>       status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported_aens,
>>>               NULL, 0, &result);
>>> -    if (status)
>>> +    if (status) {
>>>           dev_warn(ctrl->device, "Failed to configure AEN (cfg %x)\n",
>>>                supported_aens);
>>> +        if (status < 0)
>>> +            return status;
>>
>> Why do you need to check status < 0, you need to fail it regardless.
>
> agree.
> Just want to keep the old logic. I guess the old logic: if supported_aens
> is true, the result of set features can ignore.
>
> If there is no objection to doing so, I will resend the patch later.

In the past we've dedice to ignore real NVMe errors in various
spots as the functionality wasn't deemed critical.  I think that is
pretty sloppy and we should only do that where we really have to.

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C261C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 09:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D8864EBB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 09:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhBXJbk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 04:31:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12995 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhBXJb3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 04:31:29 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DlrG55sl6zjRTj;
        Wed, 24 Feb 2021 17:29:01 +0800 (CST)
Received: from [10.174.179.129] (10.174.179.129) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Feb 2021 17:30:31 +0800
Subject: Re: question about relative control for sync io using bfq
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        chenzhou <chenzhou10@huawei.com>,
        "houtao (A)" <houtao1@huawei.com>
References: <b4163392-0462-ff6f-b958-1f96f33d69e6@huawei.com>
 <7E41BC22-33EA-4D0F-9EBD-3AB0824E3F2E@linaro.org>
 <7c28a80f-dea9-d701-0399-a22522c4509b@huawei.com>
 <554AE702-9A13-4FB5-9B29-9AF11F09CE5B@linaro.org>
 <97ce5ede-0f7e-ce63-7a92-01c3356f4e44@huawei.com>
 <3E4B9F62-7376-4CA5-9C9D-21F6B9437313@linaro.org>
 <6ba9537b-052c-715b-111b-34a7d53179ec@huawei.com>
 <9E3D68B7-35D3-412E-8196-BF5AACDB1377@linaro.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <591785c0-d762-8a96-8d54-d52b6ac3595e@huawei.com>
Date:   Wed, 24 Feb 2021 17:30:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9E3D68B7-35D3-412E-8196-BF5AACDB1377@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/23 18:52, Paolo Valente wrote:
> In a sense, my solution is an evolution of your initial solution.  It
> is conceptually very simple: just track whether all weights and all
> I/O sizes are equal.  When this condition holds true, no idling is
> needed.  When it does not hold, idling is needed.  Your case would be
> solved, service guarantees would be always preserved.

Hi,

The solution sounds good, and it's ture that my case would be solved.

Thank you very much!
Yu Kuai

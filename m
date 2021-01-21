Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEDEC433DB
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 09:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A11D239D0
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 09:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbhAUJBX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 04:01:23 -0500
Received: from verein.lst.de ([213.95.11.211]:59699 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbhAUJBD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 04:01:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D723C67373; Thu, 21 Jan 2021 10:00:12 +0100 (CET)
Date:   Thu, 21 Jan 2021 10:00:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
        axboe@fb.com, kbusch@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 3/5] nvme-fabrics: avoid double request completion
 for nvmf_fail_nonready_command
Message-ID: <20210121090012.GA27342@lst.de>
References: <20210121070330.19701-1-lengchao@huawei.com> <20210121070330.19701-4-lengchao@huawei.com> <fda1fdb8-8a9d-2e95-4d08-8d8ee1df450d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fda1fdb8-8a9d-2e95-4d08-8d8ee1df450d@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 21, 2021 at 09:58:37AM +0100, Hannes Reinecke wrote:
> On 1/21/21 8:03 AM, Chao Leng wrote:
>> When reconnect, the request may be completed with NVME_SC_HOST_PATH_ERROR
>> in nvmf_fail_nonready_command. The state of request will be changed to
>> MQ_RQ_IN_FLIGHT before call nvme_complete_rq. If free the request
>> asynchronously such as in nvme_submit_user_cmd, in extreme scenario
>> the request may be completed again in tear down process.
>> nvmf_fail_nonready_command do not need calling blk_mq_start_request
>> before complete the request. nvmf_fail_nonready_command should set
>> the state of request to MQ_RQ_COMPLETE before complete the request.
>>
>
> So what you are saying is that there is a race condition between
> blk_mq_start_request()
> and
> nvme_complete_request()

Between those to a teardwon that cancels all requests can come in.

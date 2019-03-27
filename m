Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A63EC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6B420811
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfC0I2B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:28:01 -0400
Received: from verein.lst.de ([213.95.11.211]:40528 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfC0I2B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 04:28:01 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8AA3868B05; Wed, 27 Mar 2019 09:27:52 +0100 (CET)
Date:   Wed, 27 Mar 2019 09:27:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
Message-ID: <20190327082752.GN20525@lst.de>
References: <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org> <20190318073826.GA29746@ming.t460p> <1552921495.152266.8.camel@acm.org> <20190318151618.GA20371@ming.t460p> <1552924164.152266.21.camel@acm.org> <448615db-64e2-cbe7-c09e-19b2d86a720a@grimberg.me> <20190321013908.GA15115@ming.t460p> <95da080a-7fb4-33a9-1dc3-4452c565c83a@grimberg.me> <20190321023235.GB15115@ming.t460p> <1bc084aa-e9bb-fc69-2983-5e825065046a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bc084aa-e9bb-fc69-2983-5e825065046a@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 21, 2019 at 02:40:51PM -0700, Sagi Grimberg wrote:
>> nvme_rdma_teardown_io_queues:
>>          nvme_stop_queues(&ctrl->ctrl);
>>          nvme_rdma_stop_io_queues(ctrl);
>>          blk_mq_tagset_busy_iter(&ctrl->tag_set, nvme_cancel_request,
>>                          &ctrl->ctrl);
>>          if (remove)
>>                  nvme_start_queues(&ctrl->ctrl);
>>          nvme_rdma_destroy_io_queues(ctrl, remove);
>>
>
> Yea, you're right. I'm fine with this patchset.

Is this an official Reviewed-by?

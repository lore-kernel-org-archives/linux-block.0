Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F744C04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5922086D
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5922086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeLLHVe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:21:34 -0500
Received: from verein.lst.de ([213.95.11.211]:60316 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeLLHVe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 02:21:34 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 825D268DD2; Wed, 12 Dec 2018 08:21:32 +0100 (CET)
Date:   Wed, 12 Dec 2018 08:21:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH RFC 4/4] nvme-multipath: disable polling for underlying
 namespace request queue
Message-ID: <20181212072132.GA28850@lst.de>
References: <20181211233652.9705-1-sagi@grimberg.me> <20181211233652.9705-5-sagi@grimberg.me> <20181212071140.GD28461@lst.de> <d0d76a09-7ec9-2018-d4ce-7a08d4ab4002@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0d76a09-7ec9-2018-d4ce-7a08d4ab4002@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 11, 2018 at 11:19:22PM -0800, Sagi Grimberg wrote:
>> So we need to make sure in the block layer or I/O submitter that
>> REQ_HIPRI is only set if QUEUE_FLAG_POLL is supported.  I think it would
>> also help if we rename it to REQ_POLL to make this more obvious.
>
> It used to check for it, but was changed to look at nr_maps instead...
> So I think this is a regression...

blk_mq_map_queue looks at both QUEUE_FLAG_POLL and nr_maps for the
queue selection, but that doesn't help with the problem that we should
never pass poll requests through stacking devices.

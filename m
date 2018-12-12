Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16398C04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADF620851
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADF620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeLLHh6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:37:58 -0500
Received: from verein.lst.de ([213.95.11.211]:60385 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbeLLHh6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 02:37:58 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3231468DD2; Wed, 12 Dec 2018 08:37:56 +0100 (CET)
Date:   Wed, 12 Dec 2018 08:37:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH RFC 4/4] nvme-multipath: disable polling for underlying
 namespace request queue
Message-ID: <20181212073756.GB29091@lst.de>
References: <20181211233652.9705-1-sagi@grimberg.me> <20181211233652.9705-5-sagi@grimberg.me> <20181212071140.GD28461@lst.de> <d0d76a09-7ec9-2018-d4ce-7a08d4ab4002@grimberg.me> <20181212072132.GA28850@lst.de> <f134d4e7-5d0e-7345-0414-9aa3524c75e9@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f134d4e7-5d0e-7345-0414-9aa3524c75e9@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 11, 2018 at 11:29:33PM -0800, Sagi Grimberg wrote:
> Yea I agree.. Would probably make better sense to forbid it in the core,
> but I'm not entirely sure how this is possible make_request drivers...

Either we can clear the flag in generic_make_request when QUEUE_FLAG_POLL
is not set, or just change the few users to never even set it in that
case.

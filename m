Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDECC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A252206B7
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 15:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A252206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbeLDPHb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:07:31 -0500
Received: from verein.lst.de ([213.95.11.211]:44358 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbeLDPHb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 10:07:31 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8356B68C07; Tue,  4 Dec 2018 16:07:29 +0100 (CET)
Date:   Tue, 4 Dec 2018 16:07:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 10/13] nvme-mpath: remove I/O polling support
Message-ID: <20181204150729.GD3630@lst.de>
References: <20181202164628.1116-1-hch@lst.de> <20181202164628.1116-11-hch@lst.de> <f62ed781-28cd-dae0-f3aa-544d75cdc4fc@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f62ed781-28cd-dae0-f3aa-544d75cdc4fc@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 03, 2018 at 05:11:43PM -0800, Sagi Grimberg wrote:
>> If it really becomes an issue we
>> should rework the nvme code to also skip the multipath code for any
>> private namespace, even if that could mean some trouble when rescanning.
>>
>
> This requires some explanation? skip the multipath code how?

We currently always go through the multipath node as long the the
controller is multipath capable.  If we care about e.g. polling
on a private namespace on a dual ported U.2 drive we'd have to make
sure we don't go through the multipath device node for private namespaces
that can only have one path, but only for shared namespaces.

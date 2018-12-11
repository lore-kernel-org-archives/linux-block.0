Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286A9C07E85
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 14:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE322081B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 14:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE322081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeLKOFw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:05:52 -0500
Received: from verein.lst.de ([213.95.11.211]:55556 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbeLKOFw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 09:05:52 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1425568DD2; Tue, 11 Dec 2018 15:05:50 +0100 (CET)
Date:   Tue, 11 Dec 2018 15:05:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/9] scsi: introduce a max_segment_size host_template
 parameters
Message-ID: <20181211140549.GA8473@lst.de>
References: <20181206155258.11465-1-hch@lst.de> <20181206155258.11465-3-hch@lst.de> <20181211020237.GB27651@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211020237.GB27651@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 11, 2018 at 10:02:38AM +0800, Ming Lei wrote:
> Just one concern, max segment size is often related with one specific
> controller's DMA capability.
> 
> Is it possible that HBAs have different segment size, but all are driven
> by same driver(shared scsi_host_template)?

It is support just like most other attributes - by having one variable
in the host template and one in the host, allowing the driver to
override the per-host one between scsi_host_alloc and scsi_add_host.

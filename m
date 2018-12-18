Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4C3C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 16:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A466121841
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 16:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbeLRQ5I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:57:08 -0500
Received: from verein.lst.de ([213.95.11.211]:41913 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbeLRQ5H (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 11:57:07 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 558AE68D8D; Tue, 18 Dec 2018 17:57:06 +0100 (CET)
Date:   Tue, 18 Dec 2018 17:57:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     yupeng <yupeng0921@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me, jthumshirn@suse.de
Subject: Re: [PATCH v4 1/2] export trace.c helper functions to other modules
Message-ID: <20181218165706.GA13271@lst.de>
References: <20181218045138.4282-1-yupeng0921@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218045138.4282-1-yupeng0921@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Mon, Dec 17, 2018 at 08:51:37PM -0800, yupeng wrote:
> Export bellow three functions:
> nvme_trace_parse_admin_cmd
> nvme_trace_parse_nvm_cmd
> nvme_trace_disk_name
> Thus any other modules which depends on nvme-core could use the trace
> events in trace.h

But we don't actually use these trace events anywhere outside of core.c,
even with your second patch, do we?

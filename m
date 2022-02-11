Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECF9C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 15:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349505AbiBKP4V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 10:56:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240763AbiBKP4U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 10:56:20 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BA7196
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 07:56:19 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2B51568AFE; Fri, 11 Feb 2022 16:56:15 +0100 (CET)
Date:   Fri, 11 Feb 2022 16:56:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/3] block: remove THROTL_IOPS_MAX
Message-ID: <20220211155615.GA4167@lst.de>
References: <20220211101149.2368042-1-ming.lei@redhat.com> <20220211101149.2368042-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211101149.2368042-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

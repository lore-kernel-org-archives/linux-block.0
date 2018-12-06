Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A78C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 22:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7DD21479
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 22:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="yiArfrNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7DD21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbeLFWHt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:07:49 -0500
Received: from ozlabs.org ([203.11.71.1]:59501 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbeLFWHt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 17:07:49 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 439qTt2G8kz9s4s; Fri,  7 Dec 2018 09:07:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1544134066; bh=KGuCFjWxji6SvpIj2RT0SE9YsKFUBVJ4Jx8PAtgIrYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yiArfrNenDEsByJoDoDrGACq0h6Tvr/ok9jyVJ8xon3QZkY3QzS1IYYyxyfdQtlV/
         5lmgdv0hR+gtOs0jije8lcibPWcTi/tv2DMct9+e6EX9Ne08h3tw7J9jEjfQ4b3kez
         zm5eEw6ymfymr8S1xtHRkt9/HNN0zQKgbX5/LI/tOq10V1VeEJ96dWgvkcHD8yP6hU
         3k02cg2A+ZclgfH+eIimbdRzyom2jpJ4sohSa5GpmiHDtKz9CTUqkA8M3q2pXwX0rN
         qs71Za0kBNF4lH71SQOOdBV6SKBTGfaJRXR4GpyCLzUdOJTwwY0MbR33OrRlniUlBv
         Yw5wG+0l+pRXQ==
Date:   Fri, 7 Dec 2018 09:07:41 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 7/9] mac53c94: remove DISABLE_CLUSTERING
Message-ID: <20181206220741.GB12090@blackberry>
References: <20181206155258.11465-1-hch@lst.de>
 <20181206155258.11465-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206155258.11465-8-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06, 2018 at 07:52:56AM -0800, Christoph Hellwig wrote:
> mac53c94 has no limitations on crossing pages for segments.  Just make
> the 65535 byte segment size limit explicit, even if it matches the
> current block layer limit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Tested-by: Paul Mackerras <paulus@ozlabs.org>

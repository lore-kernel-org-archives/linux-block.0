Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81DBC49ED9
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 08:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B616D20830
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 08:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfILITs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:19:48 -0400
Received: from verein.lst.de ([213.95.11.211]:45250 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfILITs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 04:19:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EDA73227A81; Thu, 12 Sep 2019 10:19:44 +0200 (CEST)
Date:   Thu, 12 Sep 2019 10:19:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jon Hunter <jonathanh@nvidia.com>, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/3] block: Respect the device's maximum segment size
Message-ID: <20190912081944.GB14283@lst.de>
References: <20190909125658.30559-1-thierry.reding@gmail.com> <20190909125658.30559-2-thierry.reding@gmail.com> <20190909161331.GA19650@lst.de> <20190912005728.GA2731@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912005728.GA2731@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 12, 2019 at 08:57:29AM +0800, Ming Lei wrote:
> Could you explain a bit why we can't do that?
> 
> The segment size limit is basically removed since the following commit
> 200a9aff7b02 ("block: remove the segment size check in bio_will_gap").
> 
> Before that commit, the max segment size limit worked.

No, it didn't as explained in the commit log.  It worked for some
cases but not others.

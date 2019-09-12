Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8A6C49ED6
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 00:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499C020872
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 00:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfILA5m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 20:57:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfILA5m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 20:57:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E9FB308A9E0;
        Thu, 12 Sep 2019 00:57:42 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7E021001958;
        Thu, 12 Sep 2019 00:57:33 +0000 (UTC)
Date:   Thu, 12 Sep 2019 08:57:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jon Hunter <jonathanh@nvidia.com>, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/3] block: Respect the device's maximum segment size
Message-ID: <20190912005728.GA2731@ming.t460p>
References: <20190909125658.30559-1-thierry.reding@gmail.com>
 <20190909125658.30559-2-thierry.reding@gmail.com>
 <20190909161331.GA19650@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909161331.GA19650@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 12 Sep 2019 00:57:42 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 09, 2019 at 06:13:31PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 09, 2019 at 02:56:56PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > When enabling the DMA map merging capability for a queue, ensure that
> > the maximum segment size does not exceed the device's limit.
> 
> We can't do that unfortunately.  If we use the virt_boundary setting
> we do aggressive merges that there is no accounting for.  So we can't
> limit the segment size.

Could you explain a bit why we can't do that?

The segment size limit is basically removed since the following commit
200a9aff7b02 ("block: remove the segment size check in bio_will_gap").

Before that commit, the max segment size limit worked.


Thanks,
Ming

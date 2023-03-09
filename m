Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A41AC64EC4
	for <linux-block@archiver.kernel.org>; Thu,  9 Mar 2023 09:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjCIJmE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Mar 2023 04:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCIJmC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Mar 2023 04:42:02 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD515E824F
        for <linux-block@vger.kernel.org>; Thu,  9 Mar 2023 01:42:01 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 60E2768BEB; Thu,  9 Mar 2023 10:41:58 +0100 (CET)
Date:   Thu, 9 Mar 2023 10:41:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme: fix handling single range discard request
Message-ID: <20230309094158.GA24868@lst.de>
References: <20230303231345.119652-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303231345.119652-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks,

applied to nvme-6.3.

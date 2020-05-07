Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7A3C47247
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 06:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED6C2075E
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 06:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgEGG1s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 02:27:48 -0400
Received: from verein.lst.de ([213.95.11.211]:44818 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgEGG1r (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 02:27:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6109268C7B; Thu,  7 May 2020 08:27:44 +0200 (CEST)
Date:   Thu, 7 May 2020 08:27:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: PING for Re: bdi: fix use-after-free for dev_name(bdi->dev) v3
 (resend)
Message-ID: <20200507062743.GA5814@lst.de>
References: <20200504124801.2832087-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504124801.2832087-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 04, 2020 at 02:47:52PM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> can you pick up this series?

ping?  Especially as 1-4 fix a kernel crash and should probably be
5.7 material.

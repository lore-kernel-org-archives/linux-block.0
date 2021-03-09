Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAC4C433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 11:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809D8650F3
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 11:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhCILbf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 06:31:35 -0500
Received: from verein.lst.de ([213.95.11.211]:59554 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229520AbhCILbF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Mar 2021 06:31:05 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3625868B05; Tue,  9 Mar 2021 12:31:03 +0100 (CET)
Date:   Tue, 9 Mar 2021 12:31:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
        minwoo.im.dev@gmail.com
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210309113103.GA9233@lst.de>
References: <20210301192452.16770-1-javier.gonz@samsung.com> <20210301192452.16770-2-javier.gonz@samsung.com> <20210303091022.GA12784@lst.de> <20210303100212.e43jgjvuomgybmy2@mpHalley.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210303100212.e43jgjvuomgybmy2@mpHalley.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 03, 2021 at 11:02:12AM +0100, Javier González wrote:
>> Ignoring some of the deprecated historic mistakes I think the policy
>> should be:
>>
>> - admin commands that often are controller specific should usually
>>   go to a controller-specific device, the existing /dev/nvmeX
>>   devices
>> - I/O commands and admin command that do specific a nsid should go
>>   through a per-namespace node that is multipath aware and not
>>   controller specific
>
> Sounds good.
>
> The current implementation re-routes IOCTLs to the char device through
> the existing bdev IOCTLs, so I believe we follow this policy already. We
> basically default to current behavior.
>
> And I assume that for legacy, namespace IOCTLs to the controller will
> still be routed to the namespace (assuming a single namespace).
>
>> Which also makes me wonder about patch 2 in the series that seems
>> somewhat dangerous.   Can we clearly state the policy implemented?
>
> Patch 2 is the one that exposes the existing logic for multipath. How do
> you think we should do it instead?

So trying to follow the code:

 - nvme_cdev_fops implements file operations that directly on a nvme_ns,
   so they are path specific
 - we allow opening them even for a hidden controller
 - there does not seem to be a char device node for ns_head at all.

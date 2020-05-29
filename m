Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C422C433DF
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 13:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B972100A
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590758545;
	bh=UVQdnteZ2cgBRyB/3h3rC0V4k7ngf/QHjY3iyUE0UFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J1mCUsOefCseLdr3NCc4WTbb/IlnE+gLPkwKpgCZsF3l5A1PQHf3MLNjhK2PXVcEj
	 97b4+Zn+kAk5AOwJHPfht66dicV2IzZb6/sIbr7evjwWX/Ad8Hu8Uucdj6x1EL4kuG
	 TjjB7MVAmHmwfzZ8ZhowFx1rCmMVa+WHHVPd9h/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgE2NWX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 09:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgE2NWX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 09:22:23 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3CC520C09;
        Fri, 29 May 2020 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590758540;
        bh=UVQdnteZ2cgBRyB/3h3rC0V4k7ngf/QHjY3iyUE0UFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tzh9x24hfsAol8syt4bhnfX8gedUsa7SauSGWr1+lo6Qp63Ctpb9ZimY8XTBSXBRW
         FiyEHnnXQc1/jgWSEz8/uG8W+YmrG9eYG9OwF87IzeRwhwns/ovYjzE3+IZae6yOzJ
         go4ykP6hyH7u26AOWGNdBxSRKZb20K9DAzaRd+1c=
Date:   Fri, 29 May 2020 06:22:17 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Alan Adamson <alan.adamson@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv3 2/2] nvme: cancel requests for real
Message-ID: <20200529132217.GB3506625@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200528153441.3501777-1-kbusch@kernel.org>
 <20200528153441.3501777-2-kbusch@kernel.org>
 <68629453-d776-59e5-cdc9-8681eb2bab37@oracle.com>
 <20200528191118.GB3504306@dhcp-10-100-145-180.wdl.wdc.com>
 <20200528191443.GA3504350@dhcp-10-100-145-180.wdl.wdc.com>
 <f9cbedc9-88b2-acc8-5b95-f1c247ab1525@oracle.com>
 <CACVXFVOTQ7HLV5DCP1XezPqha13LfUrj-fZE8++_BAoTvtPWMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVOTQ7HLV5DCP1XezPqha13LfUrj-fZE8++_BAoTvtPWMA@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 29, 2020 at 11:39:46AM +0800, Ming Lei wrote:
> On Fri, May 29, 2020 at 4:19 AM Alan Adamson <alan.adamson@oracle.com> wrote:
> That said NVMe's
> error handling becomes better after applying the patchs of '[PATCH
> 0/3] blk-mq/nvme: improve
> nvme-pci reset handler'.

I think that's a bit debatable. Alan is synthesizing a truly broken
controller. The current code will abandon this controller after about 30
seconds. Your series will reset that broken controller indefinitely.
Which of those options is better?

I think degrading to an admin-only mode at some point would be preferable.

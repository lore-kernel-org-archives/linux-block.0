Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBC1C433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 08:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E61320C09
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 08:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgFZIyt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:54:49 -0400
Received: from verein.lst.de ([213.95.11.211]:50944 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgFZIyt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 04:54:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6891768C65; Fri, 26 Jun 2020 10:54:45 +0200 (CEST)
Date:   Fri, 26 Jun 2020 10:54:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        hch@lst.de, linux-block@vger.kernel.org, axboe@kernel.dk,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
Message-ID: <20200626085445.GB25535@lst.de>
References: <20200622162530.1287650-1-kbusch@kernel.org> <20200622162530.1287650-4-kbusch@kernel.org> <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 23, 2020 at 01:53:47AM -0700, Sagi Grimberg wrote:
>>   	if (ns->lba_shift == 0)
>>   		ns->lba_shift = 9;
>>   +	switch (ns->head->ids.csi) {
>> +	case NVME_CSI_NVM:
>> +		break;
>> +	default:
>> +		dev_warn(ctrl->device, "unknown csi:%d ns:%d\n",
>> +			ns->head->ids.csi, ns->head->ns_id);
>> +		return -ENODEV;
>> +	}
>
> Not sure we need a switch-case statement for a single case target...

I think a switch makes inherent sense when there is an identifier that
can have multiple values, even if there only is one for now.

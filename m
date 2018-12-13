Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C26C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 09:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FC920811
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 09:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FC920811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeLMJPK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:15:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:52744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726578AbeLMJPK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 04:15:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B7700AE38;
        Thu, 13 Dec 2018 09:15:08 +0000 (UTC)
Subject: Re: [PATCH 2/4] nvme: create slaves/holder entries for multipath
 devices
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-3-cascardo@canonical.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b1a12b3b-fddc-56df-baed-c09151031266@suse.de>
Date:   Thu, 13 Dec 2018 10:15:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181206164812.30925-3-cascardo@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 5:48 PM, Thadeu Lima de Souza Cascardo wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> This allows tools like distro installers easily track the relationship.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [cascardo: only add disk when there is ns->head]
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> ---
>   drivers/nvme/host/core.c      |  5 +++--
>   drivers/nvme/host/multipath.c | 13 +++++++++++--
>   drivers/nvme/host/nvme.h      | 12 ++++++++----
>   3 files changed, 22 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)

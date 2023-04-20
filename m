Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477A4C7618E
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 22:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjDTWAW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 18:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDTWAV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 18:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944EE1FE9
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 15:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 394C9649F4
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 22:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CE8C433EF;
        Thu, 20 Apr 2023 22:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682028019;
        bh=lpeuFqq+JJBC7Hijr6nx2Hv/xZ+LaNP4GGeIkHluD8c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dDWeIc/ABJAxGAvHQ5Ld20nqU9B/gvShn9i0sHZZKR867DH5qIouOwiexSngLmiJn
         sHlh2NASFnIIpCgTv8Hbp1UqzbeaTdh7Awuxx9dxKOVxptbbavtgwy9ZXNFG8fkGvD
         QkjLA4/M4IPmzbfaPUn4LzSaiMeriT+YglMAa6Q0bUZUAOPnm7NWPATajc7be3Ta9o
         r1N63CaPzdm30795iDgKuwBQ9KcLiNUJRADjVImiVW7w0OGERCTsRV9HpT9yin2uaE
         y6PUr2bwhsK8hD7VUTX2k4IijZ/OC4KxKK9yDStIY4SIbwZCCOVmKXF2kXcCFqQqOQ
         IMptQ64tjySvw==
Message-ID: <141aee35-4288-1670-6424-e6c41c8ef4c9@kernel.org>
Date:   Fri, 21 Apr 2023 07:00:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 10/11] block: Add support for the zone capacity concept
To:     Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <nks@flawful.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-11-bvanassche@acm.org> <ZEEEm/5+i7x2i8a5@x1-carbon>
 <f9d35d19-d0ba-fcb7-e44b-f0b8c55ba399@acm.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <f9d35d19-d0ba-fcb7-e44b-f0b8c55ba399@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/23 02:12, Bart Van Assche wrote:
> On 4/20/23 02:23, Niklas Cassel wrote:
>> With your change above, we would start rejecting such devices.
>>
>> Is this reduction of supported NVMe ZNS SSD devices really desired?
> 
> Hi Niklas,
> 
> This is not my intention. A possible solution is to modify the NVMe 
> driver and SCSI core such that the "zone is full" information is stored 
> in struct request when a command completes. That will remove the need 
> for the mq-deadline scheduler to know the zone capacity.

I am not following... Why would the scheduler need to know the zone capacity ?

If the user does stupid things like accessing sectors between zone capacity and
zone size or trying to write to a full zone, the commands will be failed by the
drive and I do not see why the scheduler need to care about that.

> 
> Bart.


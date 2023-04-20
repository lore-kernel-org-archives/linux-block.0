Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371FEC77B76
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 23:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjDTXxs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 19:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjDTXxn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 19:53:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF2C525A
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 16:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5739F64CE4
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 23:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888C8C433A1;
        Thu, 20 Apr 2023 23:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682034810;
        bh=WtACodc67rYXyrwnwRhHIew/MCwjHEmm/TVxetoWvR4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rEHYtYbZQ3oDXDXbuFKH+Ijme519igQK2X/vsfSvtxMFqhqLT/w8tAPj2a7lf7rXm
         PpwhgGqbLYxhO4SpetEuqoouVW+cQJKgjq7gB8K5YGq98yLWjT54GZ8l2Fx3A5yBkH
         b2DFUYQ/6M5sTFhi4/4yEudkm93xB8PTN1y1uOyyCXBBqbxKI9evdKFYrc20jZHDJJ
         IU8vnWQHnK3kcDxJQgPTkD+jqXoDsPiufDOjJNfoe3gwrN1Zhc/crh8K8eF9c2KIi8
         LHL3iO2toqOcYuWlQRWZoOH0+lm3QF6rOuVV2ycBzS984cX8c3m2LqXwozJVmXto+z
         99Ytbir2F2MVQ==
Message-ID: <c4a52bff-5cab-5029-ad7f-e5f9452bc0e2@kernel.org>
Date:   Fri, 21 Apr 2023 08:53:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 10/11] block: Add support for the zone capacity concept
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <nks@flawful.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-11-bvanassche@acm.org> <ZEEEm/5+i7x2i8a5@x1-carbon>
 <f9d35d19-d0ba-fcb7-e44b-f0b8c55ba399@acm.org>
 <141aee35-4288-1670-6424-e6c41c8ef4c9@kernel.org>
 <ec7cdc7d-9eb7-65a4-6ba9-1ae6cf6f43d2@acm.org>
 <a5d9a370-6264-ebdf-f9f8-7b3263c2b6f0@kernel.org>
 <490ed061-6d82-f9fb-2050-4a386e2e4c8e@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <490ed061-6d82-f9fb-2050-4a386e2e4c8e@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/23 08:44, Bart Van Assche wrote:
> On 4/20/23 16:37, Damien Le Moal wrote:
>> Why would you need to handle the max active zone number restriction in the
>> scheduler ? That is the user responsibility. btrfs does it (that is still buggy
>> though, working on it).
> 
> Hi Damien,
> 
> If the user (filesystem) restricts the number of active zones, the code 
> for restricting the number of active zones will have to be duplicated 
> into every filesystem that supports zoned devices. Wouldn't it be better 
> if the I/O scheduler tracks the number of active zones?

I do not think so. The reason is that for a file system, the block allocator
must be aware of any active zone limit of the underlying device to make the best
decision possible regarding where to allocate blocks for files and metadata. For
btrfs, we added "active block groups" management for that purpose. And we have
tracking of a block group active state so that the block allocator can start
using new block groups (inactive ones) when previously used ones become full. We
also have a "finish block group" for cases when there is not enough remaining
free blocks in a group/zone (this does a finish zone operation to make a
non-full zone full, that is, inactive).

Even if the block IO scheduler were to track active zones, the FS would still
need to do its own tracking (e.g. to be able to finish zones when needed). So I
do not see the point in having the block scheduler doing anything about active
zones.



Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F31AC0015E
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 01:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjG0BJh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 21:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjG0BJg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 21:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495822709
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 18:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D291F61CF8
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 01:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A201C433C8;
        Thu, 27 Jul 2023 01:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690420174;
        bh=bKukCZndgqITZOKgUCo1W2+EG+G4EW7w1FT6R02vOqs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R3z1Qe0hyO02qda6samoLuS4alT4CW2Wig4cj3MaM7Tts8Npnmj8DrZfErlzcHCzr
         3OvgV/MNMsD0O9Kl1/652+ahM+XNQzgQ8xoVOzFKh2T6Pd36NUY++336HM0DUEq9D3
         JCZmzw38bQyUXgv0fTb8m+NDrN7NYLnw/CPhvotdwLmf+OGg3in7y/Dddsccf2JEmv
         16GsoMl2l3x0eO9ujjkxZaM0VTDNwOEexv9NAO7tmLa9nzxIK7umrSGufqSpgnKgZH
         ciqQMe0N/tBdzcoBtxtOfo//tvkfD+hSg7eQNSGdO71BvlwOyoWYQU9fbnsneIlaNH
         61LXS6lSgphdQ==
Message-ID: <97122568-61ed-d376-c438-a07880b7db8d@kernel.org>
Date:   Thu, 27 Jul 2023 10:09:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 5/7] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230726193440.1655149-1-bvanassche@acm.org>
 <20230726193440.1655149-6-bvanassche@acm.org>
 <c4e4b310-c6c6-e7e7-b5e3-ff44dc63097f@kernel.org>
 <8f2000c0-e9fb-0c7b-5dfa-6807230688a0@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <8f2000c0-e9fb-0c7b-5dfa-6807230688a0@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/23 10:03, Bart Van Assche wrote:
> On 7/26/23 17:33, Damien Le Moal wrote:
>>  From all this, and given that for (3) REQ_NO_ZONE_WRITE_LOCK is set
>> unconditionally, it now seems to me that this request flag is useless...
>> Thoughts ?
> 
> Hi Damien,
> 
> Thanks for having taken a close look at this patch series.
> 
> The flag REQ_NO_ZONE_WRITE_LOCK was introduced based on earlier review
> feedback. Removing that flag again would help me because that would
> allow me to develop a test for the blktest suite that submits I/O
> directly to the block device instead of an F2FS filesystem. I like
> F2FS but it's probably good to minimize the number of layers when
> writing blktest tests.

Sounds good.

If you could also test the series with zonefs, to hammer it some more that
would be good (I unfortunately do not have any zoned UFS devices to run that
myself). You can run zonefs test suite (see
https://github.com/westerndigitalcorporation/zonefs-tools/tree/master/tests).
Simply execute "zonefs-tests.sh /dev/sdX" as root and everything should run
(need zonefs-tools and fio installed).

> 
> Thanks,
> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research


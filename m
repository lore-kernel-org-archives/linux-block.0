Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14D6C7EE2C
	for <linux-block@archiver.kernel.org>; Tue, 30 May 2023 15:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjE3PPA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 May 2023 11:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjE3POw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2023 11:14:52 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489B08E
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 08:14:50 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-760dff4b701so23852739f.0
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685459689; x=1688051689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tp/ySIwwm4tl/YIed7+PvRfuzdgg1UhCSe2CIK+Ly+s=;
        b=xOkOoj4cDaSXirzk4uIboFQnwwINYWkE41mSD75bBat4nxEXJuipsA9ArGyo2UeBqx
         Kq9+mAB55iKthDhGAImEFsxB+rRsmEMgs6FpMVpSTjHfjf+dcWciLu166pMGZmx0Cbom
         D2CnJp0JOlcSk+AtYAprigutEBdADB/JeK1MfqKHq6SU5zjqHVQvSYnJ/tZe15ZHCmZw
         obheJiX+2Ze0w6gCDga10r1butszL/v1bdNLsPQJxdDk5hqhOOPZOPc/F51qTRMTFSK9
         BVTLgTLAJU3vvbHG1HC9noz2HJsQ7wD6E5CGkvfADErM+d/V4AMklilsjXurfBo7Qg1G
         9ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685459689; x=1688051689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tp/ySIwwm4tl/YIed7+PvRfuzdgg1UhCSe2CIK+Ly+s=;
        b=O5jFOefG2iQl0zRa2mmdULpUMrgs578BAPa84XIZZNFoGpY5ji9Cg4SsGpj2G1qH6I
         +cmz4nkXoKT9QnyEz3SGmTgIBXD8xOccqfYN4PDyjFGfiokcaYkT+8B+BgNdwSp7NAvc
         EhgDWY3LIlENKZrblfRQDqfe7xmJ+K54nuKhBWD+wPSFzPzQryBp/sht9MkJLYkD5WbJ
         +4X5TUe1wm6DJfzwVUSZ4MnlYnu//favwdzuP1x/yFP0qZedOHvFS0FmPpDM86auyiX7
         UflYgFk03I2N0l9X7uSgBv0G18i9XPP4zpZroEGzfu55prw6J++Rz1nIlVNd+duDNSCq
         EAcg==
X-Gm-Message-State: AC+VfDxcghfURP5XMj1nmPXDoquvTy9G+sYREZfGvDVWif50XI7F9XAE
        nZBZgm3a7ZInCJkJzz6/QhsI0g==
X-Google-Smtp-Source: ACHHUZ5N9fZwp0C4udilf2wbvP/vXNdHUtnkR6kuIJ7hXoCHV8PblKq9G6f5VgAxs1O6gmhEp8JA/Q==
X-Received: by 2002:a05:6e02:ef3:b0:33b:85f4:2edf with SMTP id j19-20020a056e020ef300b0033b85f42edfmr1197714ilk.1.1685459689656;
        Tue, 30 May 2023 08:14:49 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i9-20020a056e02054900b00325df6679a7sm2575003ils.26.2023.05.30.08.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 08:14:47 -0700 (PDT)
Message-ID: <bc5833bc-1c78-8d9b-69f8-1401b673b861@kernel.dk>
Date:   Tue, 30 May 2023 09:14:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 00/20] bio: check return values of bio_add_page
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>
Cc:     "agruenba@redhat.com" <agruenba@redhat.com>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "hare@suse.de" <hare@suse.de>, "hch@lst.de" <hch@lst.de>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "rpeterso@redhat.com" <rpeterso@redhat.com>,
        "shaggy@kernel.org" <shaggy@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
References: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
 <3235f123-0638-b39f-f902-426059b87f81@kernel.dk>
 <efedff15-af48-31e5-2834-d8a879f1e6d2@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <efedff15-af48-31e5-2834-d8a879f1e6d2@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/23 12:37 AM, Johannes Thumshirn wrote:
> On 24.05.23 17:02, Jens Axboe wrote:
>> On 5/2/23 4:19?AM, Johannes Thumshirn wrote:
>>> We have two functions for adding a page to a bio, __bio_add_page() which is
>>> used to add a single page to a freshly created bio and bio_add_page() which is
>>> used to add a page to an existing bio.
>>>
>>> While __bio_add_page() is expected to succeed, bio_add_page() can fail.
>>>
>>> This series converts the callers of bio_add_page() which can easily use
>>> __bio_add_page() to using it and checks the return of bio_add_page() for
>>> callers that don't work on a freshly created bio.
>>>
>>> Lastly it marks bio_add_page() as __must_check so we don't have to go again
>>> and audit all callers.
>>
>> Looks fine to me, though it would be nice if the fs and dm people could
>> give this a quick look. Should not take long, any empty bio addition
>> should, by definition, be able to use a non-checked page addition for
>> the first page.
>>
> 
> I think the FS side is all covered. @Mike could you have a look at the dm
> patches?

Not the iomap one, that was my main concern. Not that this is tricky stuff,
but still...

-- 
Jens Axboe



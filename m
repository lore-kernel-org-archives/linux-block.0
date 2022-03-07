Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2779C433EF
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 01:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiCGBtL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Mar 2022 20:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiCGBtL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Mar 2022 20:49:11 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C45640E
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 17:48:17 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so11632374pju.2
        for <linux-block@vger.kernel.org>; Sun, 06 Mar 2022 17:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bk2SrrmMwatO8jIwgacbXdZ4/wRBNWsFXgo/yRl17T4=;
        b=qe8VQ7Ey9aFJv5/tIwGJ/LU1ejeuGS64JhOS+25C1lWHSNpZBozRN/sfD3ErSOSScB
         ZSjxFFduO3+yaIuMMx5wAKmIrFi5TXX9Ll4D23If3kUaQLb7NetoDQqNeYa7gIz+CEm9
         330ffM+vc3t27IrWa6V7mdpJeqKq3uowClPtcqlOUticFnnBu+t2wsnQYpWfxAq0EDha
         AqLhcJJVJd2gich7lIpOuyBZ46p328u3j6Ti6hwk51x9Ud24wepHQt9oklUlX4BF6PDy
         LQd1QfDwI10Org3lT0bCDyqY+LT6k6btZggBBHxnl6UYWWRgjfh1avB8RjCu3FvfhFJF
         UL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bk2SrrmMwatO8jIwgacbXdZ4/wRBNWsFXgo/yRl17T4=;
        b=YVXd5NGAx258TEJXs0OdNTLseN3xOyL6hVYAfPkrCSOHRlZ2iyXKlwkxmYje7vrsC5
         ladtk13WgOvU3Hp5O28wkBFkxTdXT89DlBvOGoCS2N4/vAM7kT5yYPaYAK1DEK4KWhdM
         jE8cgxS4zUBvahSkPV2q1HY48QPfgaZf93Sxk1EypKPbY8vNfN1K5c59Q0AaprUKvGQ6
         Uyy11i0WHx7IS08AColLOzjr0Kq/S1ATIpbfFK0HB2kRkX/+ne8t3PFpGNh9BCdTEUlc
         5DuXmgyp5JYy14ZfKpKqCe8djoyFZwyq3yGfKa7lwLC6SHBD3CmvJpEH3zjbVWgRHVOk
         o1/A==
X-Gm-Message-State: AOAM533ED5E3ua6+/8dhnOGwyXBXjrADL6nHhrT6+Dl66JJ2KUNKniVw
        0Qba5XeZrSc3ntMKFWZ17125hQ==
X-Google-Smtp-Source: ABdhPJw4tIzpDi8DJH6TcUSQE31XToP6eLrLTWEl2sq3N8CBypa2+SNU3rgG8PftpPRJ1suDhMy+yg==
X-Received: by 2002:a17:90a:12c8:b0:1bf:6484:3e27 with SMTP id b8-20020a17090a12c800b001bf64843e27mr2912077pjg.209.1646617697215;
        Sun, 06 Mar 2022 17:48:17 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id nk11-20020a17090b194b00b001beed2f1046sm14238923pjb.28.2022.03.06.17.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 17:48:16 -0800 (PST)
Message-ID: <2ced53d5-d87b-95db-a612-6896f73ce895@kernel.dk>
Date:   Sun, 6 Mar 2022 18:48:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 2/2] dm: support bio polling
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>
Cc:     ming.lei@redhat.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20220305020804.54010-1-snitzer@redhat.com>
 <20220305020804.54010-3-snitzer@redhat.com> <20220306092937.GC22883@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220306092937.GC22883@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/6/22 2:29 AM, Christoph Hellwig wrote:
>> +/*
>> + * Reuse ->bi_end_io as hlist head for storing all dm_io instances
>> + * associated with this bio, and this bio's bi_end_io has to be
>> + * stored in one of 'dm_io' instance first.
>> + */
>> +static inline struct hlist_head *dm_get_bio_hlist_head(struct bio *bio)
>> +{
>> +	WARN_ON_ONCE(!(bio->bi_opf & REQ_DM_POLL_LIST));
>> +
>> +	return (struct hlist_head *)&bio->bi_end_io;
>> +}
> 
> So this reuse is what I really hated.  I still think we should be able
> to find space in the bio by creatively shifting fields around to just
> add the hlist there directly, which would remove the need for this
> override and more importantly the quite cumbersome saving and restoring
> of the end_io handler.

If it's possible, then that would be preferable. But I don't think
that's going to be easy to do...

-- 
Jens Axboe


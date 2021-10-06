Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9533CC433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 18:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB5C610E6
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 18:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhJFS3Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 14:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhJFS3Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 14:29:24 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E8DC061746
        for <linux-block@vger.kernel.org>; Wed,  6 Oct 2021 11:27:32 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b78so3911617iof.2
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 11:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tc69Dyki6YTtI4VB0qOAr80S4BNh19uLij6WVKUQK1Q=;
        b=o5nGOJFCgLtTAmCaz/aZJ9ir9yhvTCmUQJqMpeFA3Fh0H/beJpjwdWOJjLi4ZEZygQ
         RnhRuh54Qy3tC52MiynrPwrUBV5q+2dmcjLl1FbUR4hRh4SWI/martEE6WLUsIRYd48/
         v1DGy5zq1OGo5zhgP/xXhSQfB7mdNqJY8T3naxdABTAxmRs/YB6Hc/Xfu0xD97bOh73t
         kENeEKcOOJayIP7UpgLlgUORClFl3WfAV/1hTC+l2bvKOgzeKnmzdeWu+IqrjFTPItaj
         z2AB0KiI785zkVFyJNh3UatQioQaPKElCfHosCujdtwLyJ31pKidMTCSNuMAOB8++5lP
         fxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tc69Dyki6YTtI4VB0qOAr80S4BNh19uLij6WVKUQK1Q=;
        b=fZCxqsFeRsNd2f1Wudrtc0KeBqgWZq38EQ/vg5N4PQ3ahn1Vgud0Cy3KU0Q/Rcxhen
         xZ351Ak5ARuL28VqUhMVDndewFG42olOFqQIqe3pL1vM+Yay6RvGfsxLTRMs96lgti/Z
         f5hNdZ9fABdbM0lhpMsoL/GGo6RsK0SJpDLo3r4bfGMTXUOpRqJ21PfYwvKZIcm9yxtt
         ah0C/JG5zy7hQenHTLrGLF/L2ByZLNLjgAmIv2tQgv6PgOCXj33jsStQct0AFirBLQ26
         FvXWUH5+vNJ3Ms57YYEsITZcFrBg/66fDKdqMdM+IB+X2g31Lv8erbkFQ0DmL/dor1pz
         EptQ==
X-Gm-Message-State: AOAM530xmZU3fkgSGJvfIm5Go3gcibnsywGediDKN5Kl/3itz6w5uGFV
        p1QxhTyR78aZgNY3Yi6OXbc6B/aK2qPVMAOHW+E=
X-Google-Smtp-Source: ABdhPJyftJi8jDfqeQC/PmoSMF+zXrmgdMtNYx/78HMu8L9ILGH+PfcPF5nLo1izl6CJSLv8/xSttg==
X-Received: by 2002:a05:6602:25ca:: with SMTP id d10mr7765365iop.124.1633544851178;
        Wed, 06 Oct 2021 11:27:31 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d11sm8872309iom.29.2021.10.06.11.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 11:27:30 -0700 (PDT)
Subject: Re: [PATCH 2/3] block: pre-allocate requests if plug is started and
 is a batch
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20211006163522.450882-1-axboe@kernel.dk>
 <20211006163522.450882-3-axboe@kernel.dk>
 <bf1418a7-127d-dbd7-6fef-6351bfe2abe4@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <41c497f1-0666-3fe0-823c-fe8753473055@kernel.dk>
Date:   Wed, 6 Oct 2021 12:27:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bf1418a7-127d-dbd7-6fef-6351bfe2abe4@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/6/21 12:24 PM, Bart Van Assche wrote:
> On 10/6/21 9:35 AM, Jens Axboe wrote:
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index 3b967053e9f5..4b2006ec8bf2 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -22,6 +22,7 @@ struct bio_crypt_ctx;
>>   
>>   struct block_device {
>>   	sector_t		bd_start_sect;
>> +	sector_t		bd_nr_sectors;
>>   	struct disk_stats __percpu *bd_stats;
>>   	unsigned long		bd_stamp;
>>   	bool			bd_read_only;	/* read-only policy */
> 
> Hmm ... I can't find any code in this patch that sets bd_nr_sectors? Did 
> I perhaps overlook something?

Good eye - nope, that's from a different patch! Looks like it got folded
in by mistake... I'll fix it, thanks Bart.

-- 
Jens Axboe


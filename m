Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1352C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F492183F
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uCQT8ejW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfC2Orv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:47:51 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39764 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfC2Oru (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:47:50 -0400
Received: by mail-it1-f195.google.com with SMTP id 139so4246917ita.4
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DAC/+M8ynsVY5NuVoeUrG1PH3ren/uZ/WMG0cZLsvQM=;
        b=uCQT8ejW0bnDHIQtbWeNhxK5i+rFnOv217foe+0tYwD+BkQM/UqOcUMCuhs6KGdkFM
         2YSaq3zqUKR9AyfZmoicsJRmKjcnQaQ/gCZ34eLi1z/JDfqGJG7oAEmS/8+R4eYlc14B
         kE0KIBZ6Apn1bwSCwBhLrwDlG7bd6m9ibSGzZAi0frPVY4xYcuLizSEvDWO83EEL3tgh
         vHXroWhi8PMLy8tFWEJvuZXpWnCeBDCtDI2KquvgPdjfwtLZCDpRAY+0Md4sgfyz0mP+
         XHpE6NzeWuskoa0TByM1ZIxhyvses8HEsjLnOk59lA+7/yYufUx0KsUNfbhGq0Wcpd9+
         bvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DAC/+M8ynsVY5NuVoeUrG1PH3ren/uZ/WMG0cZLsvQM=;
        b=WBWk7hILuBcRzlzEch7w1EJJHbse3fOl36j0GN2EA0JqW7fGxAc2JYzNoWZUrrlz+U
         118+Ft0sJxbUeO4EA+DiL7ueiPJfVUX7Wjg3jOaVnRkmmSso98/a+ZopqEU+m1+XcXGF
         WpCEtcvD/Nx9o3OJWGvUBCd7h8Ifq5xZL0Pu7id6mzF+sjDvf0aldEcloJSANhxxL1rH
         JfOMrFJd5naSsu8X6lZeLUI5Pq/CrCWMVj6Q6TO5/WC/R8rdY+IumvI8HdYdtnAWKTMN
         /Q1OMdg4BQ87IMh/IhKg5VeTy8CGOK8PKbo7+phlGETjHU9c6M9UfhLhRixs4UW+EoFL
         qkfQ==
X-Gm-Message-State: APjAAAXCsJjEvHrUiQsm8tXvto5SSQRxT33jPmgx5xfFomTQSrjrNZv8
        3EKm15zPeVmIdlRG87j6knd04A==
X-Google-Smtp-Source: APXvYqwEEZseMlDqUZwXLDz4TlKOq6in3HT3vRoWen7dVkkgMpigjmShBYLELWApp01/tqy4h11ftA==
X-Received: by 2002:a24:360d:: with SMTP id l13mr4691074itl.83.1553870869896;
        Fri, 29 Mar 2019 07:47:49 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m25sm1070029iti.24.2019.03.29.07.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 07:47:48 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] block: verify data when endio
To:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        tytso@mit.edu
References: <20190329142346.1677-1-bob.liu@oracle.com>
 <20190329142346.1677-3-bob.liu@oracle.com>
 <41c8688a-65bd-96ac-9b23-4facd0ade4a7@kernel.dk>
 <73ecbb57-fd99-5df3-8859-e218b830363b@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c3caf423-99e7-8c47-684f-1b0ca32e627c@kernel.dk>
Date:   Fri, 29 Mar 2019 08:47:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <73ecbb57-fd99-5df3-8859-e218b830363b@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 8:40 AM, Bob Liu wrote:
> On 3/29/19 10:28 PM, Jens Axboe wrote:
>> On 3/29/19 8:23 AM, Bob Liu wrote:
>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>> index d66bf5f32610..e9f25f162138 100644
>>> --- a/include/linux/blk_types.h
>>> +++ b/include/linux/blk_types.h
>>> @@ -18,6 +18,7 @@ struct block_device;
>>>  struct io_context;
>>>  struct cgroup_subsys_state;
>>>  typedef void (bio_end_io_t) (struct bio *);
>>> +typedef int (bio_verifier_t) (struct bio *);
>>>  
>>>  /*
>>>   * Block error status values.  See block/blk-core:blk_errors for the details.
>>> @@ -187,6 +188,8 @@ struct bio {
>>>  		struct bio_integrity_payload *bi_integrity; /* data integrity */
>>>  #endif
>>>  	};
>>> +	bio_verifier_t		*bi_verifier;	/* verify callback when endio */
>>> +	struct work_struct      bi_work;	/* I/O completion */
>>>  
>>>  	unsigned short		bi_vcnt;	/* how many bio_vec's */
>>
>> I told you this for the initial posting, and the objection still stands.
>> Adding 40 bytes to struct bio is a no-go.
>>
> 
> Yes, I know that.
> Already list in Todo:
> - union with "struct bio_integrity_payload *bi_integrity" to save bio space.

As written in the other email, that solves _nothing_. So in terms of RFC, I'm
letting you know that adding anything to the bio for this issue is going to
be a non-starter.

> This is only a rfc patch, because not sure any other objection of this
> passdown-verify solution..  Will consider more about the bio space if
> there is agreement of the passdown-verify way.

OK, also see other mail on a potential route for the bio space that
doesn't increase the size for the bio at all.

You and Martin keep claiming this isn't an issue, but it is. Hence I'm
just making it as clear as I can that bumping the bio size for this
isn't going to fly.

-- 
Jens Axboe


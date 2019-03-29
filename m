Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DD5C10F05
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9950B2183F
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jdY5yGzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfC2OiI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:38:08 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51378 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfC2OiI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:38:08 -0400
Received: by mail-it1-f196.google.com with SMTP id e24so4053892itl.1
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eQpIfLC+fwJsGVmnvxqsf2yilFvyJXO22CqcFpk5C2Q=;
        b=jdY5yGzwcPXdlQ6i38rqoB3F+Jwwm4cXR0VBag/rlf4Qr7G1tK+E44I4QKQIup+Tsc
         wV5JuUYQAt8E4F2ejUv7bcr5Tz/1kfkbq9sInTIz29z161GV4iEdbuSdUOvfIzy+YSUg
         YIxQJppMoUoLkSM1P6Y4eOnvCwp8HFSzaPxbwwvz/GLHlUFC7RaNFmrR2iUGDJQS60RS
         CCEjAeXJ9vSh5bUhVaZxudGZrjKOrKy/2Ufp1p+XF9unwLm3xfy//b8zA4VN6AmdcPmx
         DjllZctSSUi4P8XZoK3y3oc0msBEg3oxwM9VSyOtyfrWPxDrgyDVeuL3yC6WMnS7df/s
         xT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eQpIfLC+fwJsGVmnvxqsf2yilFvyJXO22CqcFpk5C2Q=;
        b=k7zv0cBYh9pkr1jin+aPeSDdHRcTOAwQB8a+jtMI8I9sCOYKLgFGIcYCuZFy3gm//D
         ug6G1pnSuXZWQGBiO/paautPtCDlZf7yAMU6TG9yPsOCHLqJaXId2Gn5BHpEmomTyalE
         3KiovRrvmrWbqYPLQt5+6yZt0q6h4HguXYIiSZVYM+bu+gh75Yy6wKA/PuktupU/la/z
         02mft5d03fuOs3geU4G6ToLZg9oVHx8Z+ab71EzVXC8fwWhnzKAiHqFIq5dj65JF8T1P
         6UmHmbUbtzxtcv1Tumr1ai/lQykPAkkOxUstaFDhD+0ecoVr5GMgyNootiUbNVWXiNzP
         DN4Q==
X-Gm-Message-State: APjAAAX6vPwYUDAmjOUoLm7bi2HRp/9GoHf8v8Nq4E0LgJQrmj5yPZPb
        sKRmKs+50bEsey0g06AfGms2Tw==
X-Google-Smtp-Source: APXvYqymxhrY7ZRiInV8U9y/4jALhw8KuSa7dnsjxt1QTcn+q2mkrIOCwgyIJMYReHoz2DpHsBQ0cg==
X-Received: by 2002:a05:6638:1a:: with SMTP id z26mr34038518jao.99.1553870287551;
        Fri, 29 Mar 2019 07:38:07 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j66sm1060135itb.38.2019.03.29.07.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 07:38:05 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] block: verify data when endio
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        shirley.ma@oracle.com, allison.henderson@oracle.com,
        david@fromorbit.com, darrick.wong@oracle.com, hch@infradead.org,
        adilger@dilger.ca, tytso@mit.edu
References: <20190329142346.1677-1-bob.liu@oracle.com>
 <20190329142346.1677-3-bob.liu@oracle.com>
 <41c8688a-65bd-96ac-9b23-4facd0ade4a7@kernel.dk> <yq1ftr5rbq1.fsf@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f65d6a7b-9e69-ae1e-b8b8-8769dc650311@kernel.dk>
Date:   Fri, 29 Mar 2019 08:38:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <yq1ftr5rbq1.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 8:34 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> I told you this for the initial posting, and the objection still
>> stands.  Adding 40 bytes to struct bio is a no-go.
>>
>> So that's a big NAK on that series.
> 
> I think you missed Bob's comment that this will go in the existing
> bio_integrity field. I believe the main purpose of the series is to
> solicit feedback on the callback approach.

I didn't miss that, but it fixes nothing. That will unify the 40 bytes
with 8 bytes, we're still growing the bio by a LOT. And we can't even
nicely hide this behind some ifdef, sine distros enable everything and
hence we're solving nothing by doing that.

One potential solution could be to setup a specific bio_set for this,
and allocate your read bios out of that. Growing struct bio by an
enormous amount for this is just a non-starter to begin with, end of
story.

-- 
Jens Axboe


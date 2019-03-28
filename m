Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B895DC4360F
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5A721773
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YtlkjgCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfC1Rw7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:52:59 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:56131 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfC1Rw6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 13:52:58 -0400
Received: by mail-it1-f196.google.com with SMTP id z126so7430856itd.5
        for <linux-block@vger.kernel.org>; Thu, 28 Mar 2019 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZUKVvK3zStQ5OiXH7oTyIJzujcigGrkrH736rsTacvk=;
        b=YtlkjgCxkHImr1n2Jy5HSXH0CbM9U1PkDma6eV/ehXr5hIZfEQQMJDkDIP9sGknx66
         qoeh2R/5yWny88+wldgY7vsEIA1gmWtXO88nila1XEqvGVnQ/t+tEwH0MFGNvN2hlH6o
         EIV7RCvlMTnScqxs/GocflriZB6GMgA+H64lZaMqNTT4+qX7EkhKyhdZAmf+gQVi7gqM
         Q/7YluVX/ug3J09yRvC3+CQjA7p2CxdYHO7163qzlg+Rt8IW8eoV89rUh+DgUzkyu7yc
         SRHdh3kBbM0ne8gtuGBbuyY+H45hd/eXLfk2R0+YNf9DCirShRTxxKCyT/TxnHdfqHaF
         jNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZUKVvK3zStQ5OiXH7oTyIJzujcigGrkrH736rsTacvk=;
        b=uIJi98vMythAlQyWXisZuA4UzvmhYIYkbrpwVtIEAd8t/TKEiHQNczam5yQGeHiZBb
         ZOd3zKNO+3CR2dnsO4JNhklG7WQWpqY2GGh9P3pSniRi02yG3G9IHy4Vun8cwmuDZyqu
         fUi7aJ8jx9gWlKht5wk/Fp0cAwgUCJ+QrMuj84YMA6jzw29TmTJ7rX6tPFVjD3SAxXWQ
         YHud+EEtYN27G9ZdewwI+KO2KLgiV0uYSyHzZz2RLWkVO7eCQvpDRm2+x4nK1zeQhzmc
         PBYO9wAy0waOOBHPglJJJ+mRgkwVXZFESVhrBJOOimlM5vDFHugiQQgWPDph9i/qrNym
         YLYw==
X-Gm-Message-State: APjAAAVVWNs46TX71BxUZH5XKEV3UgflYZsU4WuTcOg6nLzToX+hLMAX
        Ae+DAmMMQjyayjIUPajVvIVviw==
X-Google-Smtp-Source: APXvYqyeU4ONUdEYhz+LN7akT8RlZCgj6/nvAdepTOwgKIK7MdybA0IfwR9YWHn4qYzHT3hYu1PtQQ==
X-Received: by 2002:a24:5f90:: with SMTP id r138mr1144032itb.122.1553795577556;
        Thu, 28 Mar 2019 10:52:57 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i23sm11130609ion.40.2019.03.28.10.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:52:56 -0700 (PDT)
Subject: Re: [block] 4e366a7962: blktests.nvme.005.fail
To:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jan Kara <jack@suse.cz>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        lkp@01.org, Ming Lei <ming.lei@redhat.com>
References: <20190325010409.GB6379@shao2-debian>
 <bb98759a-2b51-9785-d903-282ca1ed91cb@suse.de>
 <20190328174846.GA22610@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6cf48b68-a81b-d28e-96dc-0f8185eddec7@kernel.dk>
Date:   Thu, 28 Mar 2019 11:52:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328174846.GA22610@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/28/19 11:48 AM, Christoph Hellwig wrote:
> On Thu, Mar 28, 2019 at 05:31:29PM +0100, Johannes Thumshirn wrote:
>> In all cases I could reproduce it I had nsegs == 2 and
>> rq->nr_phys_segments == 1 (rq->bio->bi_phys_segments == 1).
> 
> And all cases are pass through as well?
> 
> Can you check if this still shows up with the series from Ming which
> switches the passthrough requests to use multi-page biovecs aswell
> and gets rid of the hairy code you quote below.

Since I already merged that in my 5.2 but didn't push it out yet, I've
made a temporary branch available if you want to test through that:

git://git.kernel.dk/linux-block 5.2-tmp


-- 
Jens Axboe


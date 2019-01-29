Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A18C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 13:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EBB2147A
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 13:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ygd9ZrVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfA2NVR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:21:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34920 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfA2NVR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 08:21:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so8745798pgs.2
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 05:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BlOo7egXvzIJsjOlxeDhgXzkZi+e4Z/oxVC6vnookqw=;
        b=Ygd9ZrVMrQ+PRDPqG441MSp9oPVndhlTIap4qRA5ZHyYnnv9+Tz8osl0SJp3XzG2IP
         ZTAHZ4ySse4gYJbzAQ8wbKqHj67xTEGfM6B9SRK06zG7ubSpZAsB/kyZ6hMpHMP4rAyJ
         q3pRUp28nVpYcg98NkOVUgnsqjo7qG4Q4tvGEzRCRBHdjhngfsKMp11NrVwYr0GIUAnU
         zvBLgkFiAbVn3MwFDfIN6G8CP+cIfGt+9Rj9Hz4qEwDmLD7+f8EPx8phxl/TgzYGnnmM
         cCKTQFC6IzBN9rSReM2gHlqfTYUhvtZekjaxPhOB5AevFtr4SX87ZWaR297+VzQNI8wK
         2lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BlOo7egXvzIJsjOlxeDhgXzkZi+e4Z/oxVC6vnookqw=;
        b=Xcyl5E4/sxx3pxSYkkPEtM55VvRJCsPgccj7/0NMS+pF5XuwvhInLCh1P8f/XVdtxy
         mkybNwT37LVzlftreqCAbYS4yan4dryk6yUVwzStVDHV03ypuJJeMKPfccQcmxf4j3r4
         y5w+Hk2wfaSMZxOHD2l7miENBqbX7rYV7vJFHCMD4Nd6j60IzsKj8N9aLfhz1mQHeL6g
         gKdSWPJVRmcwhZqIwyHmhimH7FTKanqWY+2p2BOWpw+aJddFA7zQbXj4ejIJ/89xi+JO
         4Iu/Q2illja8KvKmIHe1kcR4d4G6yt/E6DAs5a0MhDBztavJaV9UAnVA4LGcKjOyHWON
         1ygQ==
X-Gm-Message-State: AJcUukfi/+jwIpDMzUrQ1Nu13uj4MOOwBfWIR0WL+y2U+UhWWJUzGsmF
        xkto/Y9Hb69PCAXrTyxkbHGOeb+sm4M=
X-Google-Smtp-Source: ALg8bN5xd9IrqxjV+drSu1NS4yVhhr6Nz+4I0kcr/PLbKwh+lpFZuBt/E0EEKiGlTRdampsEVBYjew==
X-Received: by 2002:a62:2fc3:: with SMTP id v186mr26344241pfv.82.1548768076611;
        Tue, 29 Jan 2019 05:21:16 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id i193sm98671866pgc.22.2019.01.29.05.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 05:21:15 -0800 (PST)
Subject: Re: [PATCH 09/13] io_uring: add submission polling
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-12-axboe@kernel.dk> <20190128150926.GB10110@lst.de>
 <9cf014d9-cf16-fa49-83f0-0e9ddb57cc81@kernel.dk>
 <20190129062940.GB2996@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b2b874ef-0203-aa58-6cb3-2fa410ae6363@kernel.dk>
Date:   Tue, 29 Jan 2019 06:21:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129062940.GB2996@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 11:29 PM, Christoph Hellwig wrote:
> On Mon, Jan 28, 2019 at 10:05:37AM -0700, Jens Axboe wrote:
>>>> 2) Probably want the application to pass in the appropriate grace
>>>>    period, not hard code it at 1 second.
>>>
>>> 2) actually sounds really useful.  Should we look into it ASAP?
>>
>> I think so. Question is what kind of granularity we need for this. I
>> think we can go pretty coarse and keep it in msec, using a short to
>> pass this in like we do for the thread CPU. That gives us 0..65535 msec,
>> which should be plenty of range.
> 
> msec granualarity sounds fine.  But is it really worth using a short
> instead of a 32-bit value these days?
> 
> Also 16385 seems very limiting for a cpu value, especially as our
> normal cpu ids are ints.

I'll bump them both to 4-bytes.

-- 
Jens Axboe


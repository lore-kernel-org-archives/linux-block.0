Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87A0C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B865720869
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="O5eiivpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfA2TKL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:10:11 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55936 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfA2TKL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 14:10:11 -0500
Received: by mail-it1-f196.google.com with SMTP id m62so6326578ith.5
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 11:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zI5ljca5yqDtnKIcobUuAgrn44uAMEaqsB9abz9HTv4=;
        b=O5eiivpr/4/eM+EZj377IaSV02qrGWckGEZ3OaEPGydHMKechjHHTvPV3YgDnq+3pA
         v2FYywD9jVXJP94KCLYiEPpULrLs3g7KQHw/+YEm1SGZm5UtPzZyNvp/3Vx5tSPtV8yQ
         1bvY3XVcHhMy4DTzoIwarIbitkHP6GsrMMC3A1bqCWftGmsYonbwttdVWUig4jBNoVVG
         8k4i4r+FyCK725OqeKfN706Jza6PCQNzLtS+xvbB5ta1z2fUdAZ8HDTysZmpYG42LjB8
         XcNWrrEUoo8AApNNFnfArBM1kJViR0vD6VFkY73dEONRxZXL0BAGsn33yodQY/9FcA7b
         0Xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zI5ljca5yqDtnKIcobUuAgrn44uAMEaqsB9abz9HTv4=;
        b=jAAngpDupk4U8Yd6djTKqGTVrDMvE2n5BIo51Cf3I3Q3XnH1pW/oO9EaxKb3C6oSC/
         6L6/57/WPDWiaUKNQN9ufIekGvNN55Q9lzXi62iBeu8MvSgiUjPfe40DRoGENRrrhDIf
         wbNaxls/J/ZTgBoPfbzEvn6lVuW9zf62X8M2nGjFrg67YaPxe74GsMKnR6m+efESM/mJ
         g0fzjTBbmt1VexFtv1Drqm1sZoRvzVubbf8bI0vXukhAeFuxBk6FTk6Spe6xvSqF49yY
         WtRFlH27Zhw+4zSBCgp0qy6sl2d/XtpQzYxWw+n85Nln1/zj3EZZth7SLyNEzDZ0jl2A
         fGbA==
X-Gm-Message-State: AJcUukeIWtJYpLqf3SNGmFo4btaMD39CggzI2GULBQI217R0sAmci1ne
        XMglQmJYBSgoHE8hb2FvDkHaEw==
X-Google-Smtp-Source: ALg8bN6ruvDxCrFla43Lf0h+KpGeOmmnZ1IBYgcEayf88MnWIJoDyqh2uY9AgGh8xlXdzD+GtDqvag==
X-Received: by 2002:a02:3003:: with SMTP id q3mr17428649jaq.16.1548789010507;
        Tue, 29 Jan 2019 11:10:10 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o21sm14839414ioa.71.2019.01.29.11.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 11:10:09 -0800 (PST)
Subject: Re: [PATCH 07/18] io_uring: support for IO polling
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmoyer@redhat.com, avi@scylladb.com
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-8-axboe@kernel.dk> <20190129172414.GA15347@lst.de>
 <f21fc281-bbaa-3af5-3d64-a55933f1cbfb@kernel.dk>
Message-ID: <cd1b43b7-7116-e53c-91fa-168e6c249e63@kernel.dk>
Date:   Tue, 29 Jan 2019 12:10:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f21fc281-bbaa-3af5-3d64-a55933f1cbfb@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 11:31 AM, Jens Axboe wrote:
>> The code looks a little clumsy to me.  Why not:
>>
>> 	while (!list_empty(&ctx->poll_list)) {
>> 		int ret = io_do_iopoll(ctx, nr_events, min);
>> 		if (ret)
>> 			return ret;
>>
>> 		if (!min || *nr_events >= min)
>> 			return 0;
>> 	}
>>
>> 	return 1;
> 
> I think you messed up the 0/1 here, how about this:
> 
> 	while (!list_empty(&ctx->poll_list)) {
> 		int ret;
> 
> 		ret = io_do_iopoll(ctx, nr_events, min);
> 		if (ret < 0)
> 			return ret;
> 		if (!min || *nr_events >= min)
> 			return 1;
> 	}
> 
> 	return 0;

Or I did... I think yours is correct.

-- 
Jens Axboe


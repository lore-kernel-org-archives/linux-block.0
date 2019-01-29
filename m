Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8DAC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 18:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12912080F
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 18:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KhpLh/5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfA2Sbz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:31:55 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36278 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfA2Sby (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 13:31:54 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so6131301itj.1
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 10:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p8645Unzw6Y4fH7PYA13sGAQVmkuoEXvQtZbSlPt40M=;
        b=KhpLh/5i38ACDlcgNyr4lvrYn9GeuqxVxyBXTDsIFV/xSJeqNFbotN3djyI5j4ZgTt
         iZbAruB/yKnx5aqkd4E++ulaSqAlUCDcJLnaKzq70ZuqFrsj3UeTSDN+HQpcZMy7caXp
         NO5loqsrSibQbVt7dJVWoXsxMUgc+BcBpg9st3FR3aJ1uLo4dnifpMf030Ke1rkagTHb
         m8HhtSliGj432L519X4C6UXbHzSQptHtOIVkD4pM5i5dX3AwjnaOoXFmWpnSyNqI9rpY
         eWbpIHMmClJmjmyi6FdwefGO0VA9IDB9Mor32ogyNCXuMzXk9Tz5fTyLV2AbAcYg+EQL
         yQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p8645Unzw6Y4fH7PYA13sGAQVmkuoEXvQtZbSlPt40M=;
        b=ZPPyQQFr4UXtsj03zv4Ru0rjuzmBcfKzR3rO3e8nXkoSD+TwwlUS0DEu8w3Iz7UBpv
         qC9sX92ypVfItLe36EQXVvdwC2pgtPmvljVYBby64t/IB3SpE08fIxGR9pFVnocteRPC
         INoZT6qNfhCcbE6627WfKS3WaVvYXKq6dKdyvnZQjL1bmDvRx7PvIhVgqdSX0P6z1HCh
         oR13jX26aFJ+n7/HWd2fKAPazWKCfOyYx3r6YuilDpTXTllZMtOMWZcD3/LM24f0NeY5
         zQjzhBOhijBfw0rD6ZmFSZbg5ZzgFsqzeR44y/pvaCLK5OXUXV+amoDpBHxtYarTeFTh
         c1Cg==
X-Gm-Message-State: AJcUukd2nkqwMnuknyVlHB4WUl7XSfTrU3SD8UJk7JsSAwcoHo41DuaP
        aXC6jK0utg0djcKQSEOYfAcKjA==
X-Google-Smtp-Source: ALg8bN6hp0rDN8vySNwjH4Bp6EEnTT1Faz8hMJ6+axdyXiCeSdQlOVl65OcEKXd8mOVzMI26tk1NNA==
X-Received: by 2002:a24:874a:: with SMTP id f71mr13001355ite.120.1548786713452;
        Tue, 29 Jan 2019 10:31:53 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t64sm2310323itb.5.2019.01.29.10.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 10:31:52 -0800 (PST)
Subject: Re: [PATCH 07/18] io_uring: support for IO polling
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmoyer@redhat.com, avi@scylladb.com
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-8-axboe@kernel.dk> <20190129172414.GA15347@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f21fc281-bbaa-3af5-3d64-a55933f1cbfb@kernel.dk>
Date:   Tue, 29 Jan 2019 11:31:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129172414.GA15347@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 10:24 AM, Christoph Hellwig wrote:
>>  
>> @@ -118,12 +120,16 @@ struct io_kiocb {
>>  	struct list_head	list;
>>  	unsigned int		flags;
>>  #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
>> +#define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
>> +#define REQ_F_IOPOLL_EAGAIN	4	/* submission got EAGAIN */
>>  	u64			user_data;
>> +	u64			res;
> 
> Should this be ret or error instead?  res is kinda off.  A little
> comment describing it won't hurt either.  Last but not least with
> the actual errno value stored here we probably don't need the
> REQ_F_IOPOLL_EAGAIN flag, do we?

Yes good point, that flag pre-dates us having the error in there. I'll
rename the field, too.

>> +	/*
>> +	 * Only spin for completions if we don't have multiple devices hanging
>> +	 * off our complete list, and we're under the requested amount.
>> +	 */
>> +	spin = !ctx->poll_multi_file && (*nr_events < min);
> 
> no need for the braces here.

Killed

>> +static int io_iopoll_getevents(struct io_ring_ctx *ctx, unsigned int *nr_events,
>> +				long min)
>> +{
>> +	int ret;
>> +
>> +	do {
>> +		if (list_empty(&ctx->poll_list))
>> +			return 0;
>> +
>> +		ret = io_do_iopoll(ctx, nr_events, min);
>> +		if (ret < 0)
>> +			break;
>> +	} while (min && *nr_events < min);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return *nr_events < min;
> 
> The code looks a little clumsy to me.  Why not:
> 
> 	while (!list_empty(&ctx->poll_list)) {
> 		int ret = io_do_iopoll(ctx, nr_events, min);
> 		if (ret)
> 			return ret;
> 
> 		if (!min || *nr_events >= min)
> 			return 0;
> 	}
> 
> 	return 1;

I think you messed up the 0/1 here, how about this:

	while (!list_empty(&ctx->poll_list)) {
		int ret;

		ret = io_do_iopoll(ctx, nr_events, min);
		if (ret < 0)
			return ret;
		if (!min || *nr_events >= min)
			return 1;
	}

	return 0;

-- 
Jens Axboe


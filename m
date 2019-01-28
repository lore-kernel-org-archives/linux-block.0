Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9F0C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A82B2171F
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lg+ZACfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389072AbfA1Qsn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:48:43 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36902 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389049AbfA1Qsn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 11:48:43 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so20323871iti.2
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 08:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fEszEDnE9WcL0Eva9wM6KWO3hgFQuwPg6XjOwfEx01E=;
        b=lg+ZACfR3xtvhH057ReLy8PcgxRrbrXSyCI/7u8KRZtX320ChuEo8inXklTDp6mG66
         aQvb5LYOywJnXDTZaD3r2b/vmbuuSo73tdHJSICoRNQenZdoOR703A7CA8jUrCo0zI9Q
         vwYiz3je5RqcFst4WnDakKFbhXwLSzLExknz05AkHbA3VNq3YbJGkZrvCHYitgRrTxHm
         4VDO4v4iOa7kDbNQpsAMYPnxnF1XOmH0kKn4SUA00LNRC9B34AtMW2B/6C+ZCz3Uu290
         uMrBD2IjBp3II+jEXmSnLNMjwVTT4qo8mNvw2f5zB/d2HkTMt9p5fEmd+Ok+Z3X3z61E
         1pDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fEszEDnE9WcL0Eva9wM6KWO3hgFQuwPg6XjOwfEx01E=;
        b=CEliKzszn5BEBADojsMqyYYMxIcYU3lEJbzeZlXyppYX2UNljsFw68Ecs0qXdtLuOh
         lFE/kjejpvYdWyyF8D0hOx91xGW6jGv7uqtp2hRhL0sDpKz12aTgeT65QvUMqhCwcLyz
         AZWuninv7OGMTL0YvBGVlvYL1ClwVyUgJmpk6jdC9IOIIXHaRUELJasVhNsjP3WNX1na
         N5rtDF1giWGmjCn69+lGLgrVPrVBgxXSgnn3zU8RDuQUDQ/4/rqvMMxLLDQy8pgtZr27
         rhUs/oSbtQetK2PxSiJA8xpQ0QVSvlkfbH5Po94o+9SaFKMxtzpJKMH0V6Y5/WQpcbna
         DtPA==
X-Gm-Message-State: AJcUukfuVfajdMSPqVJLM0Wi5l5bmK5vQRSQ5rvyG6H+Sm6dV4PJLAAH
        hxX7Qvs5HbX1hlsJ3CK3C22ieQ==
X-Google-Smtp-Source: ALg8bN7tcQ6WZ4MILUHCS7XHLf/Hli2078EJbCkvbmWQjXmu3ecqsgN3ci7NT2tfKpxrEIT+5BWdmg==
X-Received: by 2002:a24:4a95:: with SMTP id k143mr10351560itb.77.1548694122102;
        Mon, 28 Jan 2019 08:48:42 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m45sm17227993iti.10.2019.01.28.08.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:48:41 -0800 (PST)
Subject: Re: [PATCH 08/18] fs: add fget_many() and fput_many()
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-10-axboe@kernel.dk> <20190128142928.GC9563@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a9a60b83-0856-e634-83ed-3d8f63f0306d@kernel.dk>
Date:   Mon, 28 Jan 2019 09:48:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128142928.GC9563@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 7:29 AM, Christoph Hellwig wrote:
>> +struct file *fget_many(unsigned int fd, unsigned int refs)
>> +{
>> +	return __fget(fd, FMODE_PATH, refs);
>> +}
>> +
>>  struct file *fget(unsigned int fd)
>>  {
>> -	return __fget(fd, FMODE_PATH);
>> +	return fget_many(fd, 1);
> 
> I'd still prefer removing the double indirection in this call, but
> I know you disagree.

Not a big deal, I can kill it.

-- 
Jens Axboe


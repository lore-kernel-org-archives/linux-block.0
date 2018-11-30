Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E453DC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72CC20863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Pp/yPJ7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72CC20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbeLAHZm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:25:42 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35869 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeLAHZm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 02:25:42 -0500
Received: by mail-io1-f65.google.com with SMTP id m19so5569304ioh.3
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 12:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ILR9IQFuXcXZOexnm0jRqAY+ogjhTBGIy7tLB9mbXso=;
        b=Pp/yPJ7rnniRlXSlYXvRF+N4Snqem8YNhkwbEH5YDFZCHSCdsRE/pAYgtJ5hSVeRSV
         aoV07BRPoPQC+e7xYV3kUo1UbSWJP5EUXjans5WxDe+x+k9LKUHlLvd9q12AO2+zLoRL
         zkZyajvtiCxii3MOWWo2K0m2LsK9gzModwkPBM5kJKoWS/fg/PcXmYN/Wqbxuq44i1JF
         8IDPuOmkElRarcS/sGYAIslv7Q144Cf8yLgJUa5W4pppgOb9vFleiwdDqhNWksDZeNnP
         tttLsw9WITH2qmev1Y5Gy+zSdohMF18lUlD2z5yMjL/VNlDfOrFTPtWuqJylDhMLWqBv
         cEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ILR9IQFuXcXZOexnm0jRqAY+ogjhTBGIy7tLB9mbXso=;
        b=ZSeSBtCVVzGhYEtjCxG00yI5HG0rTa9tHnPDl0Gdk9iICHwH70k5iBlWrSzY9POvDT
         Uk20ydbKww/dym4yTInYxKLPR+TMDHnWuqqBwOZwR+UTXRq/J6wBHhWwmZBWfnEn/T6X
         C0Z7oupoCpgRzQ8I1e8xqmiiSwFABL2vm1NhFvLrpPiq88ckwjy3OGotZRHQmg3hcSXV
         0AraWH3pOMyRQlvYqe9ywedyp/e8IscIcxPGcayFh3AgjzkMN9BuyU0xviQhFuDOnaxB
         RUbaBSS6q7VM+wjUwmyEClS9LVEYg8megBbX5f+f6mxHnC8eRWmYOlpTCeky2dSh511u
         XoKQ==
X-Gm-Message-State: AA+aEWbOVLsgXpc5TBbwxrl9PsvM95lf2nAXjN08KLJfaubUScw/TrOr
        Y7OBPezqpl3itY3FJdU/nI2PVg==
X-Google-Smtp-Source: AFSGD/VVjjQMtbtnF9uUuQkZ6GD1V/YZ1sJngKSwfBBE0nXko19Fx9edwrmTyPwamt+ckLX3yQm8aA==
X-Received: by 2002:a5d:97d9:: with SMTP id k25mr5904603ios.146.1543608915714;
        Fri, 30 Nov 2018 12:15:15 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id p12sm1970599iom.64.2018.11.30.12.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 12:15:14 -0800 (PST)
Subject: Re: [PATCH 26/27] iov_iter: add import_kvec()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-27-axboe@kernel.dk>
 <20181130191747.GO2217@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <adf997aa-4265-9462-90b6-129b9383011e@kernel.dk>
Date:   Fri, 30 Nov 2018 13:15:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130191747.GO2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 12:17 PM, Al Viro wrote:
> On Fri, Nov 30, 2018 at 09:56:45AM -0700, Jens Axboe wrote:
>> This explicitly sets up an ITER_KVEC from an iovec with kernel ranges
>> mapped.
> 
>> +int import_kvec(int type, const struct kvec *kvecs, unsigned nr_segs,
>> +		size_t bytes, struct iov_iter *iter)
>> +{
>> +	const struct iovec *p = (const struct iovec *) kvecs;
>> +
>> +	iov_iter_init_type(iter, ITER_KVEC, type, p, nr_segs, bytes);
>> +	return 0;
>> +}
> 
> What the hell is wrong with existing iov_iter_kvec()?

Hah, looks like I overlooked that. Not sure how anyone could look at
lib/iov_iter.c and not get lost in the beauty of it.

-- 
Jens Axboe


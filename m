Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F049C43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 20:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466D5218FE
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 20:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BQZ5tKm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbeL0UWz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:22:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37754 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbeL0UWz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Dec 2018 15:22:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so9177300pgb.4
        for <linux-block@vger.kernel.org>; Thu, 27 Dec 2018 12:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pNi1Whdsli9omogARo3YV43tDdm9p8Nj+zBNpLVDgsM=;
        b=BQZ5tKm3yK10J4PApkiJ7YfDBeFjgZdn58N5bDantBr10ugODaAeai9foPvzWFIMRk
         PJsEysihsnhN+9k08g78GiUjBtUxdUctwGVaPcvOfMVMPKrt0AOIhSZHeJUmnqLtgQ2I
         jE8eRMPui3mlLCO2bEfP99do9OnfHt3mPKuCjmqU3lnbzPtiihDGg0ZLDkFOqbVk+fmG
         DP33LW55DpX7H2HvkpKxrj7qcjPn8Pr84M8xppBmm0l48vo2+ZmC6L08ku7G1m89zvqE
         ZWiu0rrSC+Nx3Dtc7RTkrjyMmj8P94SY8gDiSTLl31ApUibqsl17bin6vucvwdsOXNyp
         R8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pNi1Whdsli9omogARo3YV43tDdm9p8Nj+zBNpLVDgsM=;
        b=li9jiD5ZZaYnnvBOAEtsIzQPv1nHLXt8C1TJm+CRU9C8a+PN6nGFF7gBkOd9M8LwX9
         zlB807poJy5Ot8oTWIM/bMUp7YR4uCBv/ccsvpZj47rHChctHmEagzlrF6O088dZVi/4
         rEHl8gLtCep7ETpsc9R2WPFL4gvKZKpe8KZjygN0CwLLARu0EmXCGg9ADSU85TvVFKzG
         8Ki7O90dKGjcrPkGX5jNcd/9WFPzJ8SD1Jh7Cve4UjEtXEil3y3M09jjkz6nf5p/X/40
         qHQPA5BV7UB9k+Mpy84a0IdyvC8mwXyAELvkf5eND6+l4vcWhFfjT8QE6/3sUcdBxKbe
         qROA==
X-Gm-Message-State: AA+aEWborUoi6ek6vU9clrLEOYH33rMDFFXLR27dtX1M7Dh4/n2BUKow
        QqZ+QR1nEGY9t08w/X0mGNuLqw==
X-Google-Smtp-Source: ALg8bN4l/476ommB54aKM7mmGqLKssA5kPWivUldaeLEiGcDhVScte5YGluLRjCbDC7equAeXjDc1w==
X-Received: by 2002:a62:b15:: with SMTP id t21mr26403970pfi.136.1545942174095;
        Thu, 27 Dec 2018 12:22:54 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m20sm48883974pgv.93.2018.12.27.12.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 12:22:53 -0800 (PST)
Subject: Re: [PATCH 04/22] block: use REQ_HIPRI_ASYNC for non-sync polled IO
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk
References: <20181221192236.12866-1-axboe@kernel.dk>
 <20181221192236.12866-5-axboe@kernel.dk>
 <c34a6e3a-1142-4763-dfbe-9fa1b3579211@kernel.dk>
 <20181227131553.GA22342@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6cd2e234-6fae-7e90-6291-7eba7a7757ea@kernel.dk>
Date:   Thu, 27 Dec 2018 13:22:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181227131553.GA22342@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/27/18 6:15 AM, Christoph Hellwig wrote:
> On Fri, Dec 21, 2018 at 12:25:07PM -0700, Jens Axboe wrote:
>> On 12/21/18 12:22 PM, Jens Axboe wrote:
>>> Tell the block layer if it's a sync or async polled request, so it can
>>> do the right thing.
>>
>> Forgot to drop this one, please disregard it as it's super ceded by the
>> next patch anyway...
> 
> FYI, I'd just add the users in the patch introducing bio_set_polled.

Folded.

-- 
Jens Axboe


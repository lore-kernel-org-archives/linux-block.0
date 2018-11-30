Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901BDC64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5763E20868
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sNYUNS+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5763E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725749AbeLAH0U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:26:20 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36227 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeLAH0U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 02:26:20 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so323957itj.1
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 12:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mlsgSww9CmfRNfA52k/Bt12W10Qol3D4pdxP79O+2T0=;
        b=sNYUNS+LuNXPls+t6iQgtHLA5Y3y8W0xFK86H053eBZ0EBQOz3QGMoRjNJdb9UVDTN
         5jnBKwzzE485Fq9EFqeXx7slMozt83kcMcdP+8gTizrXMq8wIGKvlQ0Xkplgn9t4vXEz
         ff3TCzAw6hqS29WpthZXwhfsznBVTmYNIFLfEVima+AIN1OOqZD4k4AtHnuvz8xTzpAK
         XFYsbill1MccUAnzuLIjpyLNogM7kohNti3VrqTzI1vpohCDE3mAfcJ5BKFSQlW9n43f
         FWlvCuuxGgfSg/7rORx5l60DRvQsF3a3RtPs4eZiqlIgDaISCJFZEAP8ccRVN/JnBkl4
         5Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mlsgSww9CmfRNfA52k/Bt12W10Qol3D4pdxP79O+2T0=;
        b=Sg2h4qbuFgKXSa+ktHtWq7jHzhQqcpD7Kepd+gUs5SplQFtoDNc3+NRKda5R+t2/iJ
         tV13On/SaVbuK9iaVESOuRWXygohr5sRUYiaFAB9AbG4P/dYO2gnxLAB+75yYZKRnTVI
         JcXiN7huw3+ewLS0eZ1krxAGn5JjQfW560cjCacoQPaMSsoJfHaWqMLRHKD1TnjmijDG
         r+rdS2c19UN9O8fc1VZ5L3UrVsaedBiDhEJGefFDMGgE85MPeY7dJxawzMEyBYwKQlp8
         OSqI7VQEKhJriNKEHzrMO/fB862kbpOYL7HMURgAOj0FO6y9Cv0vVFxOjUi9bVbQtncv
         hXMg==
X-Gm-Message-State: AA+aEWYEeRUSfHByYvv2pH+x8jHNtt2B/MKHKDICzctzwXbcI/jvkNaY
        CaH7xGRW+STuFQV8ZqtN8TMblhRNXRE=
X-Google-Smtp-Source: AFSGD/Xrv4gKolviZ3H2x7lrTleWkNrcGH2NbSc5BNOOklmXErFbYnkmZD/8+PwhcekBeqjo0RU1rw==
X-Received: by 2002:a24:5a11:: with SMTP id v17mr211978ita.114.1543608954230;
        Fri, 30 Nov 2018 12:15:54 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r14sm2223886iol.34.2018.11.30.12.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 12:15:53 -0800 (PST)
Subject: Re: [PATCH 24/27] block: implement bio helper to add iter kvec pages
 to bio
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-25-axboe@kernel.dk>
 <20181130192102.GP2217@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e42d763-9c94-6b84-7099-f5ef5964404c@kernel.dk>
Date:   Fri, 30 Nov 2018 13:15:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130192102.GP2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 12:21 PM, Al Viro wrote:
> On Fri, Nov 30, 2018 at 09:56:43AM -0700, Jens Axboe wrote:
>> For an ITER_KVEC, we can just iterate the iov and add the pages
>> to the bio directly.
> 
>> +		page = virt_to_page(kv->iov_base);
>> +		size = bio_add_page(bio, page, kv->iov_len,
>> +					offset_in_page(kv->iov_base));
> 
> Who said that you *can* do virt_to_page() on those?  E.g. vmalloc()'ed
> addresses are fine for ITER_KVEC, etc.

Then how do you set up a kvec based iter with memory you can safely
DMA to/from?

-- 
Jens Axboe


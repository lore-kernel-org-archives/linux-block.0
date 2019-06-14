Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90E5C31E44
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 06:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F5C20851
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 06:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WiYyETSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfFNG55 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:57:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43982 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfFNG55 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 02:57:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so1253584wru.10
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 23:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DhecLLPjumi3GbS9dz6qFkZSJyBgb8dUibghtRSqB+M=;
        b=WiYyETSp1ryeNuKihIk7XRKrMQrTqOe9xj4oK1z/NY23vggVwNMZhE0Tga96OfheuZ
         Ajmq/O+sgztDg+BmsLNDKPoHfmbKCsnd7Znq18SsMRRIjZSvR0ZSRE33zhQZSYii3Vr1
         i7b8O2xVMpS7T/ifkzjb0vnqJjsGJdSZz/qDRvZNQqTs1TWtviU7VAds3iUC0osM7FUw
         ny9fWZqJZ+vL1QOYXRg2w6Ex1rRU8lTHiW2fnlG+8cIMIV4gdw4hIVuj0TIQMQUnUsKZ
         XmBR273i6eApGXisoUDq0j2EwgGxJFykPW+lwDGu7nEQ7EJjGlqclS03Z4rPJ8/A7NYo
         Reog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DhecLLPjumi3GbS9dz6qFkZSJyBgb8dUibghtRSqB+M=;
        b=MP4fISE4Vr8WIebvlfu+IMzx1Q8/1Lx6ql+lHAApOWmHMnHPG9wNqL8/JagKHUo8uL
         ypytBzF4d80tRO4Sz0sHeNy/IjE1R5fgFdupTRnpnIxfQTxwfyvISs3XqjE1wUF+kfjv
         aAlFEv2J5hT2aKXzLVoj3Bs5O/X92HsDLFoi3nM5Y7Rg6+lr50XL6a84PYTeFcfKBCOw
         a5bf2fJwwqVzuqrYu3LyB5Nl1vqXJ5DxEcnofUjL85LJ4AIyTRDCQcmI/o2P/6jASpPd
         BHv1VST3MCM9uIKbSHH7vJ9yyBplsJl1jZzbDhD1qrK8w9sbsqHk+qImkhA6KDOLqxyf
         G4GQ==
X-Gm-Message-State: APjAAAUcosSHXMTNf/Ld2vfhAKVv8n/cqJsVECbiXW2enTjvoZaaW7Nw
        kowlaK+EU+RipsEfx56jLt1KMw47iPv//ppI
X-Google-Smtp-Source: APXvYqz7TuzT3FfezAd+TrzoQqdNYYlqIUsbwri8gNnSH5UbLif3uCKfGI6j/y6g52/S55uQ55ANaA==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr41562536wrp.352.1560495474748;
        Thu, 13 Jun 2019 23:57:54 -0700 (PDT)
Received: from [192.168.88.149] ([62.170.2.124])
        by smtp.gmail.com with ESMTPSA id d3sm4352087wrf.87.2019.06.13.23.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 23:57:54 -0700 (PDT)
Subject: Re: alternative take on the same page merging leak fix v2
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20190613095529.25005-1-hch@lst.de>
 <00c908ad-ca33-164d-3741-6c67813c1f0d@kernel.dk>
 <20190614011946.GB14436@ming.t460p> <20190614054514.GB6722@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3c6c6496-a053-d6bd-6878-3b1433d036fc@kernel.dk>
Date:   Fri, 14 Jun 2019 00:57:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614054514.GB6722@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/13/19 11:45 PM, Christoph Hellwig wrote:
> On Fri, Jun 14, 2019 at 09:19:47AM +0800, Ming Lei wrote:
>> On Thu, Jun 13, 2019 at 04:04:03AM -0600, Jens Axboe wrote:
>>> On 6/13/19 3:55 AM, Christoph Hellwig wrote:
>>>> Hi Jens, hi Ming,
>>>>
>>>> this is the tested and split version of what I think is the better
>>>> fix for the get_user_pages page leak, as it leaves the intelligence
>>>> in the callers instead of in bio_try_to_merge_page.
>>>>
>>>> Changes since v1:
>>>>    - drop patches not required for 5.2
>>>>    - added Reviewed-by tags
>>>
>>> Applied for 5.2, thanks.
>>
>> Hi Jens & Christoph,
>>
>> Looks the following change is missed in patch 1, otherwise kernel oops
>> is triggered during kernel booting:
> 
> Ok, true, sorry.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

I've dropped the two patches. Please send them again, when they are
tested. Not making -rc5 at this time.

-- 
Jens Axboe


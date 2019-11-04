Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51FFCA9EB5
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 15:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD70720869
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 15:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZxaZWlEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfKDP71 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:59:27 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42481 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfKDP71 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 10:59:27 -0500
Received: by mail-io1-f67.google.com with SMTP id k1so19008686iom.9
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 07:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6iZ6AZ+TBSqDJ+B/fR4roJ5nXBDRimP/sXvAYEAvs8U=;
        b=ZxaZWlEfQWLXe04EVrk0ZdhUSorJ2tqD/oTd35Rs56WaRb5ml2EMU4nKo+dhQn9G48
         V/FUup6Pij/dc1FLOVr0DwhvgQKCa/3pLjarJwqbos3dlRWPjbKBNdY8zaj7A8DCGUZh
         JAiK4210ROdjDaS0bdVTQ3mhRDspWD1+Ad0CU/5bfKnqeoed6qa+ZLSrKCw7BeEFpN2j
         LGEE+dG78I2OnKXtEpxffI9k0kJ1rLdWk/wCf3n4QHppR9tdXFNfIKLGtGiHnc1obbjI
         kxEDxnH4VTFgTX+B5AsgklslYj5dCyzhILjehYf7ciHbRySTJh57yQaPcB3KEgndRuvB
         8qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6iZ6AZ+TBSqDJ+B/fR4roJ5nXBDRimP/sXvAYEAvs8U=;
        b=itwQEoccC3tfupCfQSjNh9hnIKjD5udzwESxfTwNFpZoRhbFLbkd635Xsyniqq+WX4
         SNMz/J20HuKlUTc0rr9RS5kulPpTaeDdC6o55MsvLMaZetOZ+kn8Oh+oLkmui2gi4dRp
         ellf6WJNCWBPZS+GlurRZhuTIVfBzkT1ru5v1wtgn+v9HyiUZQYa+8TNQ9rhb/f1WUqk
         KD9gcTOkW01ULiuV0DaUSQ/M2TBwAjdkdMcMLtQPLPrKpn0mgnh2ttOY7IK9h4VCwwmr
         13nv9tWSsN/IzqlhWH5fMby/NWsa7B9RQteaa+ekfIADsUYpD1OTxqc7CdCEIqs+y1T9
         J5Qg==
X-Gm-Message-State: APjAAAXX8t6kVu/t3uRdnGgMaawC3wiwJapjFcLKAT1K4CPPY2WklNJx
        gLrGJAffNM1kyEIrOFMHijkLyg==
X-Google-Smtp-Source: APXvYqyGCoW0xXf8sZ6zHoKfmU1IR7ju8LcrqB57NiBDC3X64zJwB7lEFaNQ20KUSnRj8lmMRgDMCQ==
X-Received: by 2002:a5d:9b0f:: with SMTP id y15mr10449414ion.35.1572883164707;
        Mon, 04 Nov 2019 07:59:24 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f13sm488201ioo.54.2019.11.04.07.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 07:59:23 -0800 (PST)
Subject: Re: [PATCH liburing v2 3/3] spec: Fedora RPM cleanups
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@redhat.com>
References: <20191104155524.58422-1-stefanha@redhat.com>
 <20191104155524.58422-4-stefanha@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd3e6fde-72b7-32d2-b9cc-2616a843d534@kernel.dk>
Date:   Mon, 4 Nov 2019 08:59:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104155524.58422-4-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/19 8:55 AM, Stefan Hajnoczi wrote:
>   %changelog
> +* Thu Oct 31 2019 Jeff Moyer <jmoyer@redhat.com> - 0.2-1
> +- Initial fedora package.
> +

Rest looks good now, but I think you forgot this one!

-- 
Jens Axboe


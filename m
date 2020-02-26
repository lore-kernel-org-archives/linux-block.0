Return-Path: <SRS0=LW4I=4O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F49AC4BA12
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 14:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6883E24688
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 14:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AKk/C6bl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgBZOZO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:25:14 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:46736 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgBZOZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 09:25:14 -0500
Received: by mail-il1-f193.google.com with SMTP id t17so2477499ilm.13
        for <linux-block@vger.kernel.org>; Wed, 26 Feb 2020 06:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=99t4/LSu709UOxxHgYYUFaE6oXsju8vQQ+Dan2LeyS0=;
        b=AKk/C6blVn64C2GdGSB/11TdQP23YBX8LXOs3f/XbzIXqr7hAnkujGrXxJ0GQT48Lv
         2v5ZX98cPy5pTkdPtua8t2/B0nKg9uc8DXXJrgFFNrM1ag3T47CbyZQQ/aCH3Ktr8Pxk
         uoFERM1qWTnUf9//HAleqtIGtpdyRsFlXwkO/saMKUFejE4NjFAzPQz7EIcm8ldY6mxL
         wzHwYSGXsezQVveXPAngRMU9mkVfuA2WXc77iJlvVCARQ5NAX4g4/H26RuVa6sPk/qX9
         V7FXAFJxM1RtJXLYWiCgnE1VNOnXBPFjmc+JnL1kw5r1pWsPl7338FTsvxLmLOylZZC/
         CCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=99t4/LSu709UOxxHgYYUFaE6oXsju8vQQ+Dan2LeyS0=;
        b=f0n19jkLL+FYi1z2AyAT8e2uCfsX/cepjqV4Uw7kThykpRGQXJEh/zXwO19fXSM57A
         8tFnvOXVM225DpAGTjwmdtNCqtZJQdDpTU2MZ4XYPS95zG9cs7HGxXL80nI38t20rSzX
         xNL0GJ9FdMoND3X9YIiBO4LPxMag4G4VDivXkOVT097sbt51PXM9T1qZTykyxKSJQyJ+
         Jo99KXFpfokOnDD74A1X0+EXi4jCVgp6fy9tUIATMl0beJWBC6GNhXfb3PMI65Sl5Wcv
         dEerEbHRKW5vHusMMxTscPdSIRJydMWGi0xWLo56FMj2MT6pinKTr/DjYDVzCMZ+VYiy
         MaQQ==
X-Gm-Message-State: APjAAAW4JqMtxvGcAgT8DKvXLs+v4TkLY+OlbYziTXFWvcJ55DIcSAjr
        LMPV6vcUzn8OmHOMKlrxvtCXnA==
X-Google-Smtp-Source: APXvYqzJN5sYhszLLxiqSgaobFmDkIvmEoRA1VDdlBLUayiIJ2XsJh54cxRdrAFsQuKLE4ruGUvNOg==
X-Received: by 2002:a92:5e9b:: with SMTP id f27mr5359159ilg.263.1582727112384;
        Wed, 26 Feb 2020 06:25:12 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v64sm756538ila.36.2020.02.26.06.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 06:25:12 -0800 (PST)
Subject: Re: [RFC PATCH 0/4] userspace PI passthrough via io_uring
To:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org
Cc:     martin.petersen@oracle.com, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, io-uring@vger.kernel.org
References: <20200226083719.4389-1-bob.liu@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4defe33b-689e-04c1-a1d5-c2e7a572027e@kernel.dk>
Date:   Wed, 26 Feb 2020 07:25:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226083719.4389-1-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/26/20 1:37 AM, Bob Liu wrote:
> This RFC provides a rough implementation of a mechanism to allow
> userspace to attach protection information (e.g. T10 DIF) data to a
> disk write and to receive the information alongside a disk read.
> The interface is an extension to the io_uring interface:
> two new commands (IORING_OP_READV{WRITEV}_PI) are provided.
> The last struct iovec in the arg list is interpreted to point to a buffer
> containing the the PI data.
> 
> Patch #1 add two new commands to io_uring.
> Patch #2 introduces two helper funcs in bio-integrity.
> Patch #3 implement the PI passthrough in direct-io of block-dev.
> (Similar extensions may add to fs/direct-io.c and fs/maps/directio.c)
> Patch #4 add io_uring use space test case to liburing.

No strong feelings on the support in general, the io_uring bits are
trivial enough (once fixed up, per comments in that patch) that I
have no objections on that front.

I'd really like Martin to render an opinion on the API (PI info in
last vec), since he's the integrity guy.

-- 
Jens Axboe


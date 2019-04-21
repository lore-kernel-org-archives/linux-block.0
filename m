Return-Path: <SRS0=4R18=SX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830D1C282DD
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 01:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F97820859
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 01:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eBWcVXp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfDUB6T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Apr 2019 21:58:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37306 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDUB6T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Apr 2019 21:58:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so4278974pgc.4
        for <linux-block@vger.kernel.org>; Sat, 20 Apr 2019 18:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XoSYHhYzT7lcTyft16O2aF7J1qIpWEiU0h9xfhvcLkU=;
        b=eBWcVXp3GiA0NLZp+eyT2VdYF9BR/Vf6exsymXAKhLInX24n8mTz6JnHipTkm5lgyO
         7EGJ3wfY8FWil95sOtbc3pdIQhzXGOIWl9xm2JC7rm+dXpKPL/NPtQxnvumPLcAcyvTk
         TMO424tiitvzzipuNSzmrPfc7CVzucROI7B5iPaCMicnWkH5nvJBMz1nA3G9mJrLsHNJ
         rARtkaYVBMHVxSFtuNZ9Lrv7Hs9FNXjtYnPRDKMoRIg/BLG2Epp16CTKIV4+HCeRpYsu
         IqC71hS1/k52LgbDMAi38CWZeZGcSsnnnwlL9QqtY5Ll7WsP9/+wIDR4aeJVSew/F3Ch
         sFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XoSYHhYzT7lcTyft16O2aF7J1qIpWEiU0h9xfhvcLkU=;
        b=RoJRWy6nkW0Abi21wjIjFXBXmeVrpMSGRI6hMIItNl1j0mCL4HTSXFUa3omhu6ihOx
         D3Vy6kB/8+PRv+k4g+1Poh87CAS16gTyDCLiAfqMiCOScrnttdc8a/1f/7V9Lk2ZlYNr
         hbuKQiiKDIm37lCgBkmZLg1Ah3FwAyoWMhkjBxAXClUCpKTBNgZjk6PA09rM5OJPR7Mf
         YxCv9ipFmJ2iFy90isy5qA/25snQqD3iu7pQ4R1Wpn6ws0Z+7e1l8nja+Cy+ONpoQ6Kc
         0BBc0OV9rTwMgiSES+2xP90a6/uuqmJX64nJxlT28KZplFlecOTpz8HTDRtA5GnroZA/
         +cAQ==
X-Gm-Message-State: APjAAAUmqSwXmDU03inwogZ/ZagZ7pG4SRYoIztHAkDMG/6UZZWGPlIA
        FQpmCsTOl8rsB2X2sB9fQv78t7fR8LrE4Q==
X-Google-Smtp-Source: APXvYqxEidKB95RR2qMdOju8rnb4a9tFpdrhBkJr+ixUguTy5S3thD47qIjbbSTJG+jiFjTlPugvVQ==
X-Received: by 2002:a63:4c:: with SMTP id 73mr11923136pga.210.1555811897953;
        Sat, 20 Apr 2019 18:58:17 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f87sm14111824pff.56.2019.04.20.18.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 18:58:16 -0700 (PDT)
Subject: Re: [PATCH 1/1] io_uring: fix bad free in io_sqe_files_register
To:     Dan Robertson <dan@dlrobertson.com>, linux-block@vger.kernel.org
References: <20190421014245.17652-1-dan@dlrobertson.com>
 <20190421014245.17652-2-dan@dlrobertson.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7519f82a-3973-c092-3d65-ed7e8e6d7efc@kernel.dk>
Date:   Sat, 20 Apr 2019 19:58:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190421014245.17652-2-dan@dlrobertson.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/19 7:42 PM, Dan Robertson wrote:
> Given bad input to the io_uring_register syscall the io_ring_ctx
> user_files member is cleaned up in io_sqe_files_register, but a
> following call to io_uring_release will result in a double-free.

This was already fixed for -rc5 last week, in this commit:

commit 25adf50fe25d506d3fc12070a5ff4be858a1ac1b
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Apr 3 09:52:40 2019 -0600

    io_uring: fix double free in case of fileset regitration failure

-- 
Jens Axboe


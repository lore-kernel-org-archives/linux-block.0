Return-Path: <SRS0=4xm9=X2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1825AECE587
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 14:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F0521906
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 14:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Am2icvsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbfJAOKO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:10:14 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35782 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbfJAOKO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Oct 2019 10:10:14 -0400
Received: by mail-io1-f65.google.com with SMTP id q10so48367608iop.2
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2019 07:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3YUx0HE7NiysDC7RZVfxopyCJv9liIb6R89MTahPdRA=;
        b=Am2icvsCpWu9R2jUDF5p07FY8Xh6t9Zk2ZbZUtTvUV4Deh3tXSewk/lOIhmxj7NCVY
         hwoNwW4X4LHYD40xbyrfVyv+6HfcA9SQDcC5KWQ1hs0OQbcz0koawBX9QQr96Nn/QtOz
         Cmp9v8GC5RgZaOd96XvdRc06fphYAjIcRrMkKY+0x/kg5at0EUsSiIKTGAHEURxzXh0r
         knuWvO2YMyL1DMHtoVLR3wW76wouPj+0AJUhbK+/T0U2BqruBULXooT/zjGmLoK+7xh1
         uXQoJI3xiCWXfVwSqoDbLNuzqL4vftHrJvswGMzCX0AgtofFV/sgrWp3pJ/fSxnkHAfq
         Mn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3YUx0HE7NiysDC7RZVfxopyCJv9liIb6R89MTahPdRA=;
        b=Z1d22jlwpFLrHF98rZxRoxp8VSLQ88wEPn7jhJ6aWNXLj8wvrap5y2J2lrdYZRb17q
         OIwBTZofEU8/G4noSZ0f3k4FN9nBt8/S70k+CpNP6IKDX2qEUDRs5WPVAu80TTn/hax3
         PETZvTTaqYbKJEVv5STZ+43o2BH3YPFyIcfy6si59cNwIHBWnkuLHcoBcptoN0C48Hsk
         nPQoteyg0rvK1y9A39PaCNKO6vAADnF1juvHFQ+6HIWdWvNVmV50EHnUWVLfb/o04SNG
         +PimWRDYmfQtstUwHoGTbQRuQ15wSUuet1ZRL7QOpqsfNuFEElVCQtRBcz3l7eciHPWX
         xwAA==
X-Gm-Message-State: APjAAAVLLOn8VJeGMb4mfEeUFlaGFJPg8/SToRHDPEz/bZlRsDcHA/S7
        KCJwoDfObyZYYqXmBDmP1KpWDQ==
X-Google-Smtp-Source: APXvYqwyQ78cSYCEY59QpZFzt9hWgZe8cTZEsDwwEpX7/UuXo/5xfiD6Z3upSoLEMYx8IRdazyU8mQ==
X-Received: by 2002:a6b:8bd8:: with SMTP id n207mr5770851iod.147.1569939012260;
        Tue, 01 Oct 2019 07:10:12 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c8sm7042439ile.9.2019.10.01.07.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 07:10:11 -0700 (PDT)
Subject: Re: [PATCH v2] loop: change queue block size to match when using DIO.
To:     Martijn Coenen <maco@android.com>, hch@infradead.org,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@android.com,
        narayan@google.com, dariofreni@google.com, ioffe@google.com,
        jiyong@google.com, maco@google.com
References: <20190828103229.191853-1-maco@android.com>
 <20190904194901.165883-1-maco@android.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c65da8b1-755c-57f5-d49d-fb25e8dc809b@kernel.dk>
Date:   Tue, 1 Oct 2019 08:10:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904194901.165883-1-maco@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/4/19 1:49 PM, Martijn Coenen wrote:
> The loop driver assumes that if the passed in fd is opened with
> O_DIRECT, the caller wants to use direct I/O on the loop device.
> However, if the underlying block device has a different block size than
> the loop block queue, direct I/O can't be enabled. Instead of requiring
> userspace to manually change the blocksize and re-enable direct I/O,
> just change the queue block sizes to match, as well as the io_min size.

Applied, thanks.

-- 
Jens Axboe


Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A65C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 15:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163ED21707
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 15:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="s3sUe3aU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfD3P1c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:27:32 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:33714 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfD3P1c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 11:27:32 -0400
Received: by mail-io1-f42.google.com with SMTP id u12so12610130iop.0
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 08:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AozbW9bCHEY0I4T33gKXh5v6hfCjcSv3G9eLyzyu4HM=;
        b=s3sUe3aUmlFxzQhT3frfu/viBoLOVdT/qjXybgep46hfnHZrZ0h1tJ5skoN3VSn3pm
         UKmisldS7vKwD9VuVb7pXIvvWcavPKIMKDnEk5jxl9GvacIKX5Qcn6hqu9vjuv++atDI
         HrPiThyrsfOugdmIrE5lodPNmDiM63R2f0VegSVs+nJOrfbQWLfIh+q9U0FMjAVvI4Kn
         yFAOdGqpC+RjMqYwqmTkaQXED+QAeQQUgK2ud1Jq6lHW9EdXf9AeNnOR7ga3snL2Pp7W
         QX1+h7UZ3I2WiS3RRAmFJpwAtZ6p2R/SdOvCA75NygsiGqOdhdHJpKNScD9hO2piDg7V
         Ehiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AozbW9bCHEY0I4T33gKXh5v6hfCjcSv3G9eLyzyu4HM=;
        b=kXZmWixB2zXyLMSsBhr8TKogYXKd5V53d7drJtT5YrIk9iysQDbQGeI1YJMgV2cRTp
         QyMpitqNzM3hQeErQoks4Dxt6vfxfHzb8kt7bw1iBZYr/a5rgn+lkijw9hrfsL6MnuG+
         H79k2VgqmSR6L0F2RkPIfiiBdaOsXyCQWOd9vV5MlprY70sS4qYS+xgebrmbCd6fRAHY
         mCT0nz2PF5ZyCzDMkF9lXXPhYvkqhW5VHOIh36ZihL+2k58sxxP10wVClly1vFnKYzOU
         MBy4qYiSjiMiuEps4BQc2eMb/H7X7U/ecXULnYrXxVqYceSBnOhkY6l49+iC/9BEtIis
         t/3Q==
X-Gm-Message-State: APjAAAVEmkfhzaLLVCzT1qprXFE185JcZKpp7Vp4/EVqN49VtnmCP0FC
        rU/WoA9kGfa46iRU/TA6i/Vm3g==
X-Google-Smtp-Source: APXvYqxlpwIsrApMV8ea5Rbkrs63s/eHAjm2ZXKIT2jpDYI4EjU6/KuzpuUfeJPRqaHSIH+Gsr1nSg==
X-Received: by 2002:a6b:fe01:: with SMTP id x1mr22745182ioh.4.1556638051360;
        Tue, 30 Apr 2019 08:27:31 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r142sm1672537itb.20.2019.04.30.08.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 08:27:30 -0700 (PDT)
Subject: Re: simplify bio_for_each_segment_all
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
        linux-bcache@vger.kernel.org
References: <20190425070300.3388-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5a2f15d5-84cd-55d5-d580-a65b6601fe70@kernel.dk>
Date:   Tue, 30 Apr 2019 09:27:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425070300.3388-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/25/19 1:02 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series simplifies bio_for_each_segment_all a bit, as suggested
> by willy.

Applied, thanks.

-- 
Jens Axboe


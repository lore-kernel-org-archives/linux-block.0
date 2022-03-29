Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F83DC433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 12:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbiC2Mb2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 08:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbiC2Mb0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 08:31:26 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB82E51E7C
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 05:29:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s11so15729506pfu.13
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tEYwtozV5kisc/HAoJLg2e6AQnfx5UPKwLpWtsEvskI=;
        b=h6qN1hZ/Wy+W4nMvMo+YgmhULsEGKb9vKrt3zQTuX1qu/icKXYYLqymQaN0+Dd52S7
         mk1huIyhDWoZR+n5dGJ+hNuahS4f8R6rwhTZMpxRU3SbojZiXVnGg40V3T4R47SaYYdL
         YitKJDQxXwmD2ZgyXMq4CAFqmLACx27CJHD4Qt60L/2WO10HDzEYIQA27Mnvtu0mV5/p
         iRnclSv1S14Bo6TcZfJ+g1lMMFphPtmY2fkvVVoxLBf1GR7BG0MI14tA5CvGkJnKPHYh
         m4VbaDa5bB1s+1fFLUeZZzRB/h5a3FEw3U+FSaTRZNgSUxfMiGO3nN6tLmNnwaERbt1Q
         Dfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tEYwtozV5kisc/HAoJLg2e6AQnfx5UPKwLpWtsEvskI=;
        b=CG32gRcDgsNTxX/qOPYo+3VIxnxlMAXk7XQRDDZw6uc/9doo4XxpIIBs6moeugNtG8
         NI9C6DSmDbYNNHN9UeDuOkTqPB8TkqZal3fcX48XiVDNnO7ocF+vn4CmTd0AgU2q+0Ja
         5+h47zHHdarqU35qjX865wS95/X+ZoIv1FGT6XQUhBLxca/0B3dPHIPEo3Fr5T+qpomj
         /EuXFwDaJC/FuPugF4lnC69+aT1pltNKdpMBPfq485zk+fZpE1OgV9UMmfzMbXA/ul9R
         9mja8YKt0jx0864J60hqNzV386Z5j8r8S3pHBYqPLi1wzjROmchcpKXNr8SkgojWm1Z3
         UjUg==
X-Gm-Message-State: AOAM532boWL37MTBdymix4K960G06cdul7kgln9o3ltN2tE4OQMlI+N4
        cBhpBlkDL49h9/+d4MEd0bNIHT4N9Qbgrl4P
X-Google-Smtp-Source: ABdhPJzoQakIPG9Twcvrn4xf/24ThJCflQdfRtNpgJCGfbFPjnk+udG4I5buLv2jOnATPKAA3PnIPQ==
X-Received: by 2002:a05:6a00:3018:b0:4fa:d533:45e5 with SMTP id ay24-20020a056a00301800b004fad53345e5mr27557494pfb.13.1648556982245;
        Tue, 29 Mar 2022 05:29:42 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 135-20020a62198d000000b004fa9a8f73casm19843683pfz.99.2022.03.29.05.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 05:29:41 -0700 (PDT)
Message-ID: <f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk>
Date:   Tue, 29 Mar 2022 06:29:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: state of drbd in mainline
Content-Language: en-US
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220329070618.GA20396@lst.de>
 <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
 <20220329073254.GA20691@lst.de>
 <CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/22 1:50 AM, Philipp Reisner wrote:
>> The complete lack of bug reports and maintainer interaction usually
>> suggests low to no use and heavy bitrot.  If that is not the case
>> here that's fine, just asking..
>>
> 
> FYI, feature-wise the in-tree DRBD is frozen. Maintenance only. Users,
> seeking advanced
> features switch to the out-of-tree DRBD and use other means of communication:
> Github issues, linbit's community slack channel, last not least
> linbit's ticketing system.
> 
> That is why you see virtually no activity.

I've been thinking the same thing. Even if most users are out-of-tree, you'd
still expect to see at least some reports on the list. A few followup
questions:

- Why aren't the drbd maintainers responding to posted patches? They seem
  to simply be ignored, and I'm left to pickup the trivial ones that look
  fine to me. In-kernel drbd appears largely unmaintained, and has been for
  years.

- Even if out-of-band communication is used for in-kernel users of drbd,
  that doesn't result in any patches or fixes that should go upstream?

- If there's zero activity for in-kernel drbd, all users are using the
  out-of-tree version?

As far as I can tell, drbd upstream is stone cold dead, and has been for
years. Why shouldn't it just get removed? Is it just bait to get people
to use an out-of-tree version?

-- 
Jens Axboe


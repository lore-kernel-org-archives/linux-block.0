Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994BFC10F13
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 17:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649CA2087C
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 17:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AXSNCiEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfDPRDD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:03:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41575 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPRDD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 13:03:03 -0400
Received: by mail-io1-f65.google.com with SMTP id v10so18230229iom.8
        for <linux-block@vger.kernel.org>; Tue, 16 Apr 2019 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CTATxVA+Sh1XdJKMCxdbliZy7iFAhuisG2PQl7eeoGs=;
        b=AXSNCiEWtbQnp7lWLobNjD+yb7kXkJhLTIt4n0Gm9WKI86IyLbrbJFsh1BMT8gFSdg
         5Ke62CozAzTVTDQIelQ3MZWzEx/Zl4xH0c3F5lKhV/SaRCAmLKj/c76Roi2lL4qU5znS
         0EgROEeRUbRxu48leRois/2qrYO94Sb7cydUNIo9FE4PYPRg/GdUdOC6+yaa/otVbOKY
         LX9eEnHrTYwB7oXFGkq9MedaAXCUlkrNmTMVwuHQgndsn7ShwqeVW25++LPEWvaG0WTo
         Kg6mWKOCo1jV84P78YykHOAcYMXrBH+14fTblYjhIv6ZkoqMDwfIBn5IObrxK0N0k0tr
         2SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CTATxVA+Sh1XdJKMCxdbliZy7iFAhuisG2PQl7eeoGs=;
        b=BDo7DnVe80LQJTiP1t7p6QNMkr8qAw1bRrcO2QL0u0TEBCZzBrq+ZDAbF3Quk5ymwU
         l51j4fkD8C+MT9El5183zLCbjcEpX9Y92ER4RHdye3az3VZVKkp/wOHBAITxAHjA+NDw
         kVmEedxDwp0eyeM1dSBbVoLCPtqAyW3Y7E/6uWa3vKNaIOtoMKjMp+GKWC2VDM0550dY
         3J2/yh9/FxJt9av3Zqs8T+itxO+cxQl3fkbssz4Q2XoZxbIOFZCubRZD0SMVeNF6Lsdg
         Un3Ywyp02riuj31ayhr/5gxRg1kOGaXQbap7Dl19SQfxTiim40+tRGv2et4YSgGG6kIj
         /zUw==
X-Gm-Message-State: APjAAAWUKzzWH3X0ff+J/yVevC6BQoJB2mwHZPRY2uHrUfYcnSI433xk
        iQHL3pOCt/U0m8i3ME1qBo+J7KUuBRpccw==
X-Google-Smtp-Source: APXvYqxekrIvGaMQJxxPgqpZoFfM3OCXCLD7jvbF/GH+WAy+e2vtKcntuTdgk9zdIWZK9E6mryC3vA==
X-Received: by 2002:a5e:8706:: with SMTP id y6mr56943104ioj.160.1555434182682;
        Tue, 16 Apr 2019 10:03:02 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i23sm19157227ion.40.2019.04.16.10.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:03:01 -0700 (PDT)
Subject: Re: [PATCH] block: make sure that bvec length can't be overflowed
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
References: <20190416153847.8173-1-ming.lei@redhat.com>
 <20190416164658.GA4030@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9d0f5255-c37a-1830-7632-6f4d7158b21b@kernel.dk>
Date:   Tue, 16 Apr 2019 11:03:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416164658.GA4030@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/19 10:46 AM, Christoph Hellwig wrote:
> s/overflowed/overflow/ in the subject.
> 
> Otherwise this looks good to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Although this will create yet another conflict between Linus' tree
> and the 5.2 block tree.
> 
> Although maybe Jens still reset the tree and move the merge past this..

That was my main worry too... But I'll probably just deal with it and
redo the merge, I don't want to do two, and I don't want to have to
deal with answering for why we get repeated conflicts in this area.

For the patch, I do generally prefer doing an AND with PAGE_MASK
rather than a modulo with PAGE_SIZE. I know the compiler will take
care of it, but still, it's more prudent imho.

-- 
Jens Axboe


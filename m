Return-Path: <SRS0=mBf9=44=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FDDC10F27
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 12:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1F12146E
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 12:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0RdqNJ64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgCKM6n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:58:43 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35673 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbgCKM6n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 08:58:43 -0400
Received: by mail-io1-f67.google.com with SMTP id h8so1796472iob.2
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2020 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pXMGtTgQX/vG6YdfwMEutnSxHcYYkuMTZjUufEEkwrs=;
        b=0RdqNJ64RPB/YwilvK1FgfDcZgni+Z2YUWUBcLwScASQbGBbB9Dz+LE4Mm35IFt6vr
         4cSxKXzulAxx/FMhBjxo7H6LFUFR8GPqsvxXNjSRUPuzvFkJ4jv1PyVkcJG+rzbCC2Np
         QluikAk9mzDbEMQsnqi+vhGhm69SUbxzK8wbFD8zbHl+VIITIdrwzXk7cwoU57h6DYTK
         xP/B6p8lJjmkYSUT2EEde9KDBifsOxQlJzU6xNbSL1nZM0pl98Obd5V+EG9SnWmey6tz
         SPlj8XfxaXHr4JqefQegQiSZa1hJYMurvTPgBuMJ9xU7xwGx1tFUNwEPiNDvzHAuPBK6
         0h/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pXMGtTgQX/vG6YdfwMEutnSxHcYYkuMTZjUufEEkwrs=;
        b=Uv9e2mMa7fj4hlcoo6vu6oM9A0gwtDwR1T71IQjr1TCsl4KnZ6xW0CxneJG6Q7v4Wg
         GHGN8CkUt+tkwvd8+ORIFbZUlL9FxAALSyuDWDw8M8rY2NXxtyoeAvs2RZvc2sACWqLy
         KMAvq3uyxIr0z3Ln1j40/zI8zHjc1Qf0DL89SUW11m28RZEBHrpQHDSKGJHStamfOI6I
         CHZYhFuXot0RXSWGjYK9dddQvRyndWVC3bFD9D+aiqdHAeWAReHBIpE9XYB/8EbijKar
         tw1kIiiJCgtCuw9N2PF37bzPLA1/1odVnI5UANmmP8nmDtJwALNFJmONxT4IdbpnI6G7
         A2Ag==
X-Gm-Message-State: ANhLgQ1DG5uRDm0vO8BrGep2CS1q9NZHcE/VY91sZKlA+7Gk1cggz7Ux
        JiNAT38sLAh/h9EiEI+LO8mi+w==
X-Google-Smtp-Source: ADFU+vvQvrqamJpOiZ/PrfYXGY85lIbp+WER5L+9cjMJPMlJO1Ap5yHyqeha4+2wZHF6gubxcVHRhQ==
X-Received: by 2002:a02:6658:: with SMTP id l24mr1450719jaf.33.1583931522194;
        Wed, 11 Mar 2020 05:58:42 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p79sm17821112ill.66.2020.03.11.05.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 05:58:41 -0700 (PDT)
Subject: Re: [PATCH v3] block: refactor duplicated macros
To:     Matteo Croce <mcroce@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-scsi@vger.kernel.org, linux-nfs@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Song Liu <song@kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <20200311002254.121365-1-mcroce@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7e03d359-f199-29d8-a75f-20c4b7ff3031@kernel.dk>
Date:   Wed, 11 Mar 2020 06:58:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311002254.121365-1-mcroce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/10/20 6:22 PM, Matteo Croce wrote:
> The macros PAGE_SECTORS, PAGE_SECTORS_SHIFT and SECTOR_MASK are defined
> several times in different flavours across the whole tree.
> Define them just once in a common header.
> 
> While at it, replace replace "PAGE_SHIFT - 9" with "PAGE_SECTORS_SHIFT" too
> and rename SECTOR_MASK to PAGE_SECTORS_MASK.

Applied, thanks.

-- 
Jens Axboe


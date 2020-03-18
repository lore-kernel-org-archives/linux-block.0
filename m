Return-Path: <SRS0=4fFE=5D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814F4C10DCE
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 14:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B54B20752
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 14:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1NX1Nu/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCROtM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:49:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41296 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCROtM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Mar 2020 10:49:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id b1so13800167pgm.8
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2020 07:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fhrdk9eCfVGBOYbn1i1KG//svcCx8hTv2q5znLooRTc=;
        b=1NX1Nu/uu/zEd8rksTVBdkD0IWfDWNcIvKbzks+XDBZHrc2jzhuxxQw0th2Bme1W2g
         jBvULYR/YhpQZ0SEi70fdmh2QHXTNKoZwNMJxfzlS5HaJpN964lQhbB/lRHCdyz9QBs+
         J95qYH0/BKvOSE/htdFKDC9OPv9LvXywQygjZSufFDY5UgBg2wakdQvDaHQFOfxGSdFF
         iIwD4tNKWY1myueNcXJvI4it8x7E0EVA7GF5LdWUWDnCdZJStp+4iWZ9oD0upwN/zyyS
         et6ABo07ocJuPeWHzmMMwxIrfhe37OBL8QU8KrPUjrlZk9AiQCASph3XKKURx68sVKbg
         TwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fhrdk9eCfVGBOYbn1i1KG//svcCx8hTv2q5znLooRTc=;
        b=TaaOrbZNoCZ/ihjwab0ZazhLxJ26Hjr0yli8eklIgPP5iC4pWbI8KNR7NhFHh7X6lU
         +oBAL1ODwHJ0c7uM5kHWbpsap++tzwPqjKrpI9AdPXnWao349LkMXE2DUgm2WCM0YmMj
         U6oUzSO0vlRqgLL2forDmCZ+TOsk9gDnhSK6F/5dwvoIdopJ/CSfLXZxyFl+halPx+ig
         KJxkLfZaUFcmhMCspHJErObPreh6BtZmwWKrqnLi5iwZ4pGibtLvUeY5r3RvjMZzFhl8
         47bN7YbusZOM9JwR6I3egsfYw1gtXlc7qbvJ9E1g4JksV6YnXO/psxufem3o6/ngBlMX
         K72A==
X-Gm-Message-State: ANhLgQ2ZSR4+y9OfJycOHywsFOhAqmz/k9a0BeegngEu4Mwza/hHBcCB
        pbWjk8WVMWN8Ki79Yfd9LopUGCq0GabImw==
X-Google-Smtp-Source: ADFU+vvTTEzjhq7LKKHOOyrgkhnfuVzhu3C2W8R/t2I1CJk1zkAZTLuLN4fp4hAESU1dCoAfIVbemQ==
X-Received: by 2002:a63:2cce:: with SMTP id s197mr5138618pgs.184.1584542951795;
        Wed, 18 Mar 2020 07:49:11 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id h95sm2744714pjb.46.2020.03.18.07.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 07:49:11 -0700 (PDT)
Subject: Re: [PATCH] block: fix a device invalidation regression
To:     Christoph Hellwig <hch@lst.de>
Cc:     zhe.he@windriver.com, linux-block@vger.kernel.org
References: <20200318081206.1075464-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ff5a7e0-4a36-f230-5f74-13e78e4bfc86@kernel.dk>
Date:   Wed, 18 Mar 2020 08:49:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200318081206.1075464-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/18/20 2:12 AM, Christoph Hellwig wrote:
> Historically we only set the capacity to zero for devices that support
> partitions (independ of actually having partitions created).  Doing that
> is rather inconsistent, but changing it broke legacy udisks polling for
> legacy ide-cdrom devices.  Use the crude a crude check for devices that
> either are non-removable or partitionable to get the sane behavior for
> most device while not breaking userspace for this particular setup.

Applied, thanks.

-- 
Jens Axboe


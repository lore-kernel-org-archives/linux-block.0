Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44524C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 14:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348796AbhLWORz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 09:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbhLWORz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 09:17:55 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290B5C061401
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 06:17:55 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y16so7253162ioc.8
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 06:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F7r7p1EErNm4YxaJjTFbKpy+GYO9CxbmgfhS0erQfBE=;
        b=E6KQzzZQJ+f3ci+tXnkVn4cY69QbaxGmVbXXmsJfv+QG7koBsSNzzuaaAN+IqQnldP
         8n8Hk6Jz3UdEsBYnRXcgRIUIa4jrh7WFwgy7jWltSeUQJceXooA1FifO48527O9K2gX/
         EFgLgzjhGGS8UhIQAJPIZEowGmDVWq/8PTZvdVdHNch+1SoNbUWIyI/niu+xhH7lkT6z
         DQvdjrDQ5CO75bGRTF2v6Z0rfS4J1WL8lchzTlrVdsBnOg5ae1iJsLo68trkZAUmmdfi
         ZlDgWuN5sm6dDzacaSBRZaQB24yt8giVfH5iz8f7PFIdtqriUKKtmZxP1jay6tI2QXD/
         2qOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F7r7p1EErNm4YxaJjTFbKpy+GYO9CxbmgfhS0erQfBE=;
        b=vVXuTkqIrDLUdHjrk+CLS27pIDoIRcsx2+zd9l5AqxKS0pDFC1xqgfLa4Bvh8Y7jSJ
         N3tbMU4GUm9FiBLEecmKlgmC4AZpFa/Dz1+KPLr7nNIxwTtaYebR87fpuZiJZS+OHJOH
         3PD78CZdvaCTP/WOP15ThoiuX9caNcTHslG444B4Van383S91BGHOnk5Xuc4pkD74J4e
         Kp3o6coXDQtsahfWrrx4HArh78X4kDYOY+niQhM7t3HyFSkyQCaCfVhTBnonuP0N6snM
         wtJAMm3+oUfIdCUv3iBPAO2T8mgOE/KDhPVOUSKjBU9xr8ru3D9T7JwwZoTYAkMK0fd0
         UOvA==
X-Gm-Message-State: AOAM530RjUgVU1pG5qRtP6F7uSsr5sZERoS/QBeisoqCriLV2LazO0DF
        WADA8Yzb8hoaHk2tMYT0D5keDQ==
X-Google-Smtp-Source: ABdhPJw980d5Oo6+n7oGWaXfyqXyUD1eA/nVnsB+mVlrtsyE7Kv3GSFJgvSxKYZ9UlyQiu0JINuK4g==
X-Received: by 2002:a05:6638:240b:: with SMTP id z11mr1286525jat.121.1640269074504;
        Thu, 23 Dec 2021 06:17:54 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id h1sm3989811iow.31.2021.12.23.06.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 06:17:54 -0800 (PST)
Subject: Re: [RFC] remove the paride driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tim Waugh <tim@cyberelk.net>,
        Ondrej Zary <linux@rainbow-software.org>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org
References: <20211223113504.1117836-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f40e5fb7-c311-63e9-e9c7-02e2e2bc6e1d@kernel.dk>
Date:   Thu, 23 Dec 2021 07:17:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211223113504.1117836-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/23/21 4:35 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> the paride driver has been unmaintained for a while and is a significant
> maintainance burden, including the fact that it is one of the last
> users of the block layer bounce buffering code.  This patch suggest
> to remove it assuming no users complain loduly.

It really should be removed imho. To give folks a chance to pipe up,
might be more reasonable to queue it up post the 5.17 merge window. I
expect a lot of people are going to be less attentive the next few weeks
than usual, and that really isn't a lot of warning to give even with an
-rc8 planned.

-- 
Jens Axboe


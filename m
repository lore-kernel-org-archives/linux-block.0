Return-Path: <SRS0=14Po=UQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A328BC31E5B
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 15:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE522084A
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 15:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfFQPpS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:45:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36291 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfFQPpR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jun 2019 11:45:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so5910198pfl.3;
        Mon, 17 Jun 2019 08:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pv/KxcZ1ZiK/Sqm5k9mN21CuMOpUgWy/Q7SDEQvPYdc=;
        b=SUtC/4illAeoPHsmzTlYFr92uFpP1naIQNm4rOjV4WR1JHuy9Dl0xiPxhJuUCMhpBd
         avdHiTC2FxpK4jZnbjN3zb66twwHE6Jb1l+4bm7z6R4yIYe3jG/W2LjyC4NtJRV9ojAg
         /ul+a7agF/memz/+7RpvACgbLHryuMoQJ6JnRUhW3VRz5nyxsXN0ww6Wh3Gn+RHSeRHw
         BT0iHQ0oRzc+DxDNQcfUTom9n13km/3vKSnLVhvGsddN4HHqCSSJiEsz081EuF1+bWG8
         9b8vPYCOI9WvCB1ScQFz5PyRkzRIr28buXLGwL8HS2TkZHRTbN7L+wD39kmxH5Da+oRg
         x+QQ==
X-Gm-Message-State: APjAAAVHSPJoV70w78Eszo2CQlFlLDx9l8LkOmfvjf2LuwPTtrG+0TMd
        a2cReGRYbZZz8gY5EwACT+U=
X-Google-Smtp-Source: APXvYqw6a6869azyLqamePdWnR3ha+3LFBcWhYmzW60zfYR0qpLuwvWTWqISdsgUuSCMIwTV423jFw==
X-Received: by 2002:a62:b615:: with SMTP id j21mr7165832pff.190.1560786316959;
        Mon, 17 Jun 2019 08:45:16 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 10sm11631016pfh.179.2019.06.17.08.45.15
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:45:16 -0700 (PDT)
Subject: Re: [PATCH V2 0/7] block: use right accessor to read nr_setcs
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     colyli@suse.de, linux-bcache@vger.kernel.org,
        linux-btrace@vger.kernel.org, kent.overstreet@gmail.com,
        jaegeuk@kernel.org, damien.lemoal@wdc.com
References: <20190617012832.4311-1-chaitanya.kulkarni@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a7458a93-5dd2-ddd1-8466-9da95c4d3aff@acm.org>
Date:   Mon, 17 Jun 2019 08:45:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617012832.4311-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/19 6:28 PM, Chaitanya Kulkarni wrote:
> In the blk-zoned, bcache, f2fs and blktrace implementation
> block device->hd_part->number of sectors field is accessed directly
> without any appropriate locking or accessor function. There is
> an existing accessor function present in the in include/linux/genhd.h
> which should be used to read the bdev->hd_part->nr_sects.

In the subject, "nr_setcs" should probably be changed into "nr_sects"?

Bart.

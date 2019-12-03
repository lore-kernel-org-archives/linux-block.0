Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E858C432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 16:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238302073F
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 16:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BhNal5JQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLCQAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:00:07 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:34632 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfLCQAH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 11:00:07 -0500
Received: by mail-il1-f193.google.com with SMTP id w13so3642756ilo.1
        for <linux-block@vger.kernel.org>; Tue, 03 Dec 2019 08:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qj4dwG0j75epA6rpfajGwC6yH5WSVCEU+/OXjuRPxzU=;
        b=BhNal5JQ/feh6ZAsTcz6WHAIs9kn/lV99yA66qPjWjtAygLv7rJI4BZRLvgZ1XnvHy
         j8GrYVxahxrfzEhfwd/bxAQs7+AiXsAphj/2qDpxcQwJLF+j6L07C7KSGIPyOkrzuPKn
         qDq52WrD5eQJtHm9OjX5wMJ4YSyk/UtZYhYlhzFAzAhabkYLZKMoLpWctEKUQ2dxLvAN
         TpuB97CPDXVhQ9prty1PNTADjFdtIWkRYNatnpwdv6fY2a7MImUBgdxS4xSbC/QBTvvQ
         vOlPqlz3QgcZfhT2g2XD+Wg85cgDLrW2j1X5iweA0gCfdepAnSqr0NMQi+WC5lMQ3Rts
         NPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qj4dwG0j75epA6rpfajGwC6yH5WSVCEU+/OXjuRPxzU=;
        b=DIAU8PnDoflfCqOCy6zfsjky+ankbihOo0tMptN8nFqotzVbYW91pjJ/1RH7yXaVnp
         +12n8Ow4GQ+V4WzBfkk+qJq3t9F/zwuo4hgHoPpb5S7y/qYpQj/f5RHg9Bo+tgHb+M6H
         sfEoHL1y/xu+j4rcaKoMRoLQVB2BdJLBQb0dPmmwWVzPwGwzoWhWwKXEvDutpb2muiio
         hNELHsspqQtr6ZQ+3EFvfo+Ku5lx8AEZLXLMhsB83CaHAxhUupBhYv/W/JHMuhArjPXY
         kI0X6/gz/ZsFJ83MaS9AFz8GICymrSGEJ3MhfD73gqSxFnRR/AQkqRStYCH76zV4B+sB
         bXdw==
X-Gm-Message-State: APjAAAUQ5gUSSxszgcPHVvqECzUOOsPFsruqGh6zyMDTlSFvgpibjE+f
        8uHUDaqdUWX1cEktTuRK/sI01ckn4bCaBA==
X-Google-Smtp-Source: APXvYqzEzs4hl/6RqYhaEp9raiRBSvz8hIdSennCYvLGyfhyoBB1ElE84Z8LoygR26adzY8/p9kZ5w==
X-Received: by 2002:a92:4647:: with SMTP id t68mr5114283ila.18.1575388806095;
        Tue, 03 Dec 2019 08:00:06 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s64sm601382ili.56.2019.12.03.08.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 08:00:05 -0800 (PST)
Subject: Re: avoid out of bounds zone bitmap access
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
References: <20191203093908.24612-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <232deb18-4aa5-79da-3755-dcdf7e281936@kernel.dk>
Date:   Tue, 3 Dec 2019 09:00:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191203093908.24612-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/19 2:39 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series (against your for-linus branch) fixes a problem where updates
> to the zone information in the queue is not atomic, leading to a possible
> out of bounds access.  Please take a look and let me know if you think
> if this is ok for 5.5.

I think we should sneak this into 5.5, I have applied it.

-- 
Jens Axboe


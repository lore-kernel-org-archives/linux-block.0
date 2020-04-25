Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CADC55186
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 10:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FFD620724
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 10:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUDcBd7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDYKnu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:43:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59247 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726092AbgDYKnl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 06:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587811419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zenMpg+2v4nQ44+/jX7Ww4Nj5mK/XgsXmzCGzWANwV8=;
        b=XUDcBd7zzCRF7K76vJkFC+JYQ0uqD4KjzMkb9c5BWZpkUJGymFlA0+5ON2fMKo5k2fARRe
        o/cWbaz+SibhP/Q4OOMewea5L4Nx/7tA4n/jhmrtkoQG2MW9YgTlZg2tgqf8qpDTjrb7dA
        +icPqIEK3nHx6zEgdiMG2KHqdm4xeLI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-ddyTWBoyPM2F2CSmeT_oVg-1; Sat, 25 Apr 2020 06:43:38 -0400
X-MC-Unique: ddyTWBoyPM2F2CSmeT_oVg-1
Received: by mail-wr1-f69.google.com with SMTP id p2so6497646wrx.12
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 03:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zenMpg+2v4nQ44+/jX7Ww4Nj5mK/XgsXmzCGzWANwV8=;
        b=r8xhzJEqhSr0cHiharqLxxVMtlI8yaq3jG+ZlmDEvJ4Xoxrg8ACscPdJvPqt4VYj4d
         bcjuXCoOaqv5bdqz7OHRDyVPO1wN7kzIWcB3bI9CZ/RykkkPkI0N18qirPCYQx2d4ee7
         mvOcX7u9AhcJPNpVsmgSnmF1n5yCLm5flcaO4oN8199h49+me6rA4ahMxqcuKufeib5g
         OtPFyQkCuHDrYaRnin7w/rALEEsxXTDmrVKmr7G7nAhvMOS8/v0mnF58XbrHOYDy6nmW
         /yR2v57/vAnivBhbyc9KlexBr5WT8v4WsWKJ5MtiI8Rx8y4ceqfgAzVu4H07lmgDZtFx
         F8FQ==
X-Gm-Message-State: AGi0PubvNtQRgF6ZoPxLt9p812skVG4tJobCglqFjgMYTg0Z5kmMy11E
        QYNRz6P3JrUAAzjtEYNTsjd0+AptruJsQvDLDK8+Z7KJ3iMQYvwJLjXqM+zrsvo2p6lTz/LTU3t
        YU40VEetEJpgUSFfImTTk8aY=
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr16485424wmc.83.1587811417049;
        Sat, 25 Apr 2020 03:43:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypJXYCKrMGcQbWZ4dmNlA4I3N70iZVCaAGf8WxW73pnTLMz5y0M53agpbgh6ZESeAQahxD4ccA==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr16485405wmc.83.1587811416907;
        Sat, 25 Apr 2020 03:43:36 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id x132sm7007951wmg.33.2020.04.25.03.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 03:43:36 -0700 (PDT)
Subject: Re: bdi: fix use-after-free for dev_name(bdi->dev) v3
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200422073851.303714-1-hch@lst.de>
 <20200425075906.GA5250@lst.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7bac482b-7940-e6a1-6256-194bc3393063@redhat.com>
Date:   Sat, 25 Apr 2020 12:43:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200425075906.GA5250@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 4/25/20 9:59 AM, Christoph Hellwig wrote:
> Any more comments?  Are we ready to merge this now?

Merging this fine with me.

Regards,

Hans


> On Wed, Apr 22, 2020 at 09:38:42AM +0200, Christoph Hellwig wrote:
>> Hi all,
>>
>> the first three patches are my take on the proposal from Yufen Yu
>> to fix the use after free of the device name of the bdi device.
>>
>> The rest is vaguely related cleanups.
>>
>> Changes since v2:
>>   - switch vboxsf to a shorter bdi name
>>
>> Changes since v1:
>>   - use a static dev_name buffer inside struct backing_dev_info
> ---end quoted text---
> 


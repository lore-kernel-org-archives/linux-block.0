Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE2DC10F0E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 19:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C92E2171F
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 19:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OLMzTEbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDLTgB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:36:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41692 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfDLTgB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Apr 2019 15:36:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so5602537pfd.8
        for <linux-block@vger.kernel.org>; Fri, 12 Apr 2019 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8iM7HtHpZACGeFDIGTKRxtCxVrzK8xb9EqffgFfLZcQ=;
        b=OLMzTEbz8HUozrhg/Kl+lT4qzKw33bSNf6ijMX/YqtLM9GewBvwBKoODdNsQ2OFsl4
         ivrR/7yKshIkVRBraM0mfDQjaXRx7Iknzlgb0DBi6fFF2MAK3oYSAYX/DdZTYh6ySmIh
         D+yLFxFw+sV6wj5BSb+AFBy4UQJpQEYPcgwm24zGaFTNWEUT+kK95KQvlkOdy313adaz
         /bKQjpCYpwoCW7BmGJXDwBvWGMakNRdWcBC6x57bZmCTvv8ZO33qk55/RNU8ocB6KRsQ
         bUdCINbSFfKmoS8zoBCDqQmEg/jiQwUSayncg/A46JRiAE3DxvGrHTPDYU+OduOYc97O
         LM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8iM7HtHpZACGeFDIGTKRxtCxVrzK8xb9EqffgFfLZcQ=;
        b=XRHIgDIn6YA5HnrrmaVy4wq0n9pm0Hb4Tyb8LcZk+dIHcwXrtze6+x5fGBat44+w5u
         qn7QJ6lT6pcx1MYJB1nQtWPfX28pV41dxT+mxGeKodDimR/EMvRVpRCzxJokxeZoXUQp
         syKCL65lEsYhuUe95omUcz0B+x9EQ79WznD89WEULr3RC5VtN6re5YgVA4PGQbdY0QaT
         59f1r/1YIVXv3JgdcwqxRISHV76BWrwmy/Pi15q71dWd1i4/mLJpgS6XbHTnq5f6uT0i
         oBBM+zAPF0XjHDdKTWzMX0UBj+/tIF4LzxftezmXCcnlJCWMXMHan0hYSmkeUwpSdG49
         9e8g==
X-Gm-Message-State: APjAAAVJVyXgi+iclVSDgMSUd08kWfwVOS2qTqJIHefOe38pshGVesj8
        FaPUQS4yhqQOyNDDYp+BAUfcdA==
X-Google-Smtp-Source: APXvYqx9QZRIlEEn/4DrK2EdnA/7eJXROTLbAW3XLXqaVfidSiIigjMAZpUF0lvGffHzu2EmoyOqrw==
X-Received: by 2002:a63:360c:: with SMTP id d12mr52464697pga.404.1555097760390;
        Fri, 12 Apr 2019 12:36:00 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id l1sm47831927pgp.9.2019.04.12.12.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 12:35:59 -0700 (PDT)
Subject: Re: [PATCH v3 0/5] block: skip media change event handling if
 unsupported
To:     Martin Wilck <mwilck@suse.com>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <20190327135105.30893-1-mwilck@suse.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3fd0585a-d695-b0e0-dd92-1bf3cb79003d@kernel.dk>
Date:   Fri, 12 Apr 2019 13:35:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327135105.30893-1-mwilck@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/19 7:51 AM, Martin Wilck wrote:
> The block layer currently can't distinguish between gendisk devices that
> don't support any media change events, and devices that do support them,
> but only for internal purposes. Therefore the check_events() function is
> called e.g. for ordinary non-removable SCSI disks. While these devices
> are not polled under normal conditions, the check_events function is
> called on certain synchronization points, in particular while the device
> is opened, closed, or probed.
> 
> Under unfavorable conditions this can lead to processes being stalled on
> a blocked queue: a close() schedules a work item for check_events()
> which gets blocked in the work queue, and subsequent open() tries to
> flush the workqueue. The flush then stalls too, as long as the the
> blocked work item can't finish.
> 
> In principle, the gendisk->events field would make it very easy for the
> block layer to check only for events actually supported by the device.
> Currently this is impossible, because there are lots of drivers which
> don't set gendisk->events although they implement the check_events()
> method.  This was introduced in commit 7c88a168da80 ("block: don't
> propagate unlisted DISK_EVENTs to userland") and follow-up patches
> because uevent generation by these drivers was found to possibly
> generate infinite event loops between kernel and user space. A side
> effect of these patches was that the distinction between such devices
> and devices supporting no events at all was lost.
> 
> This series implements a slightly different approach to event handling
> and uevent suppression. The drivers are changed to set the events field
> again.  Whether or not uevents should be generated is controlled by a
> separate flag bit, which is only set by the drivers that are known to
> generate proper uevents (sd and sr). Once this is done, devices that
> don't support any media change events can be clearly identified, and the
> whole events checking code path can be skipped. This simplifies handling
> of non-removable SCSI disks.
> 
> I have tested this with removable and non-removable SCSI disks, SCSI
> cdrom, and ide-cd.
> 
> This patch set targets the same problem as Hannes' late submission "sd:
> skip non-removable devices in sd_check_events()".

Applied for 5.2, thanks.

-- 
Jens Axboe


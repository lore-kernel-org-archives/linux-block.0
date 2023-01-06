Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B5CC54EBD
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 18:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbjAFSDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Jan 2023 13:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbjAFSDn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jan 2023 13:03:43 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195D57CDF4;
        Fri,  6 Jan 2023 10:03:42 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d3so2392705plr.10;
        Fri, 06 Jan 2023 10:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWDaqFMcXX5TWgX/5qac+ZYspgZYWZjBytjPR/OEpdE=;
        b=Ewzi0VtBGhfV/3Ib8M1v3WCtChhF7KVlZw1ioqaD5XYElVwOrb/AWAW7lHdqfrGSUJ
         wJCrQdP6xEk6gdAuCZnjQDXPTjXg0FHoJR3l5orpl5WvfL3YiMf4jLEAj02bOJkMOsnP
         Z3in5vrXPWwdpZsv1tDew0/3NNVH80TvfrcRkR14Or1K7j63HZkvKu3j8uiYv26rLdWn
         tKmwhytA7AMiNQf1/QhprOgKB44ilfeFP7BAojVrTLQpHm7HXLsosbgrFAoBSTcA5/Pd
         qasz8QCWc89G3Cjd6KoZBepaX4Ri3mO9WUgbF+TmfKSUGLzgSvcOBC4iPE17dzt7Nxnn
         TuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWDaqFMcXX5TWgX/5qac+ZYspgZYWZjBytjPR/OEpdE=;
        b=sOwoOppeagU9iz9VQGayMsfixerMIUIpsbD7V4Q//+XfomBP5ur0X5673ezMOCYGgG
         W9BKaZ8s6VzXg/6IV6qq8QtSYNR3xk7/zC6xOwuUj8vubuTdPs07MRpqh8Eu00IKq+0r
         Dp6VSDLoW0UGWan3bEsfOxZUgJpUZygSneL6/BqFaNNJQuENIIM1Yb3C7ky+Bhr7vIEN
         5FmGKIKz28n7LIoZjnWwxjugTfLuBGpLZbXBDefBU01ZwQN70dq0yQvuW9UzxK26hJWD
         uIFlvSLtGPJVNG/tlN8zmS/Tz4omBHJakJByZzftalVRQROHZwXkDawUi9QBO0nw33aX
         iEkA==
X-Gm-Message-State: AFqh2krUKxnzPOBFziI4sOoGvmvYl2qNeKAwdkBJCrjnjv/cSatcu0Hq
        /qvX0lt90GFChkGIXtf1iwE=
X-Google-Smtp-Source: AMrXdXt3Si1Cghhk/yKA0O+DIxU+4J57vpMQfyfJD76gnF0eoT92xWESDplshrlIrVeNyzCJYiaidQ==
X-Received: by 2002:a17:902:ab85:b0:192:f469:5283 with SMTP id f5-20020a170902ab8500b00192f4695283mr9933663plr.3.1673028221366;
        Fri, 06 Jan 2023 10:03:41 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b00189af02aba4sm1294355plc.3.2023.01.06.10.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 10:03:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 6 Jan 2023 08:03:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH v7 0/7] Improve libata support for FUA
Message-ID: <Y7hiemMjV5y/ToIF@slm.duckdns.org>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
 <Y7WuEqMgySOCCTqy@slm.duckdns.org>
 <79260c74-92dd-2cdf-ad71-e70d9fa0f8a9@opensource.wdc.com>
 <Y7cT3SSssHzBYqU4@slm.duckdns.org>
 <b5c57ca5-49b0-b9c6-4a65-a8867a74e950@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5c57ca5-49b0-b9c6-4a65-a8867a74e950@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Fri, Jan 06, 2023 at 03:51:48PM +0900, Damien Le Moal wrote:
> OK. Granted. But for this particular case, scsi & nvme subsystem do not
> treat FUA as "optional". If it is supported, it will be used even though
> you are correct that we can work without it. I do not think we should
> treat ATA devices any differently.

What matters isn't that they have a featured with the same name but the
actual circumstances. e.g. for nvme, FUA has been there from the beginning
and we used it from the beginning so we know that they're safe. For ATA,
it's something added later on and we know that there are a bunch of devices
which choke on it and we don't know whether anyone else is using it at any
scale.

> > On a quick glance, there are some uses of REQ_FUA w/o REQ_PREFLUSH which
> > indicates that there can be actual gains to be had. However, ext4 AFAICS
> > always pairs PREFLUSH w/ FUA, so a lot of use cases won't see any gain while
> > taking on the possible risk of being exposed to FUA commands.
> 
> Yes. Most FSes will do PREFLUSH | FUA. For the risk, see above.

Someone should benchmark it but it's likelyt that PREFLUSH | FUA vs.
PREFLUSH | WRITE | POSTFLUSH isn't gonna show any meaningful difference in
any realistic scenario. The main gain of NCQ'd FUA is that we don't have to
drain the in-flight commands but PREFLUSH needs that anyway.

> > I feel rather uneasy about enabling FUA by default given history. We can
> > improve its chances by restricting it to newer devices and maybe even just
> > hard disks, but it kinda comes back to the root question of why. Why would
> > we want to do this? What are the benefits? Right now, there are a bunch of
> > really tricky cons and not whole lot on the pro column.
> 
> OK. But again, why treat ATA devices differently from scsi/nvme/ufs ?
> These have FUA used by default if it is supported.

This part hopefully is answered above.

> We can take a big hammer here and start with enabling only ACS-5 and
> above for now. That will represent the set of devices that are in
> development right now, and only a few already released (I have some in
> my test boxes and they are not even a few months old...).

All that said, yeah, if we restrict it to only the newest devices, they're
more likely to be well behaved and a lot more visible when they misbehave.
That sounds reasonable to me.

Thanks.

-- 
tejun

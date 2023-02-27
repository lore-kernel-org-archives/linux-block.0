Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D2FC64ED6
	for <linux-block@archiver.kernel.org>; Mon, 27 Feb 2023 14:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjB0Oqh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Feb 2023 09:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjB0Oqf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2023 09:46:35 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8645821293
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 06:46:34 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id ck15so27074996edb.0
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 06:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=GQFltn60UYfWr6jY5aZCTd+b8PT1Ca8ODzudnEpYPcY=;
        b=m7TQSykQR6U6YT7vph7hMbnGgQd5fu2/DxKjqM+j2C4F51IFy5u5aY3/Q4A7POvkB5
         jcUYngekHvb+JFrK83sAobmfwI3VrEAWbnc5Y68ajueJMvidZBoDhPS5+ohAdKXGCi/t
         wv8cGeP3xurkFOTI+EEpvq70DviOFHvo4AsgKec2Qy0e8cG742emhevTWodhJW7cm74t
         RRTjhd5MwAQ3zxM4FoNu9xSAi86bElRP5boXnrQmPY9MdLEi6fB2BmOibFeFImtPpfBw
         eBTlAlxI+MIChEg6E/DYEqHRmJaMyyn4n2G6iSUa4Qtjj6vNKBuwMQUhp29uuia59LK2
         c7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQFltn60UYfWr6jY5aZCTd+b8PT1Ca8ODzudnEpYPcY=;
        b=x2Bu4y2RJ92rl6Vggug2LWEyC2ajMQJ5x6pRgz3OmgsHwPLN1+si9Yg5/glHQr/qo0
         8kW4X6OMMkQ1ZVjrI960Y4jo7sPhKu1qVWayLdEgr++AsY86FQO8uJvMqRciGrr6L3s6
         h9Jy2r+6YERl5GxEeMSw7LridezyuanHqA3lE9KFe/de745u1svLBAEuhSyl8HZpBviN
         Iznd+DVN03s806dWinKBEq0J5HakFZYYXDon79NAYv+oSBWGxymYlZBUoh5hieBSeBMF
         9PYsRRf7W/uEbOoRUIBfQ80KGvqZxcwSN7lHY0a94aIoOyIErGCeR4/KxzYbZpn6XH8b
         KQjQ==
X-Gm-Message-State: AO0yUKU3A01uqU37aVYthVKq0Lj/EIpGYMNiHikHe2PbnQCXq+/jDZoS
        GUS/PLjeXHQR8fjRD0U0JB68LcQ/T6yASt/X
X-Google-Smtp-Source: AK7set8DMg1i1O6k0cKTPiL9cW77qM3VTfhIFNghQKx87ypEU437wJSDCBcKgtdSsTw7Eg/WkH6oJw==
X-Received: by 2002:a17:906:9f1d:b0:8e4:dd4d:7b07 with SMTP id fy29-20020a1709069f1d00b008e4dd4d7b07mr20548854ejc.15.1677509193063;
        Mon, 27 Feb 2023 06:46:33 -0800 (PST)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id m5-20020a170906234500b008d9c518a318sm3364332eja.142.2023.02.27.06.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 06:46:32 -0800 (PST)
References: <20230224200502.391570-1-nmi@metaspace.dk>
 <Y/yD1WMJ5zc7KkBz@x1-carbon> <87ttz79u8p.fsf@metaspace.dk>
 <Y/y+UFEHn1F1sg4i@x1-carbon>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Date:   Mon, 27 Feb 2023 15:41:21 +0100
In-reply-to: <Y/y+UFEHn1F1sg4i@x1-carbon>
Message-ID: <871qmb9neg.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Niklas Cassel <Niklas.Cassel@wdc.com> writes:

> On Mon, Feb 27, 2023 at 12:59:45PM +0100, Andreas Hindborg wrote:
>
> (snip)
>
>> >> +#else
>> >> +void ublk_set_nr_zones(struct ublk_device *ub);
>> >> +void ublk_dev_param_zoned_apply(struct ublk_device *ub);
>> >> +int ublk_revalidate_disk_zones(struct gendisk *disk);
>> >
>> > These are declarations, shouldn't they be dummy definitions instead?
>> 
>> I looked at how nvme host defines nvme_revalidate_zones() when I did
>> this. The functions become undefined symbols but because the call sites
>> are optimized out they go away.
>
> Looking at e.g. nvme_revalidate_zones
>
> $ git grep nvme_revalidate_zones
> drivers/nvme/host/core.c:               ret = nvme_revalidate_zones(ns);
> drivers/nvme/host/nvme.h:int nvme_revalidate_zones(struct nvme_ns *ns);
> drivers/nvme/host/zns.c:int nvme_revalidate_zones(struct nvme_ns *ns)
>
> The function is declared in nvme.h, but like you say, without any definition.
>
> zns.c provides a definition, but that file is only build if
> CONFIG_BLK_DEV_ZONED is set.
>
>
>> > https://github.com/torvalds/linux/blob/v6.2/fs/btrfs/Makefile#L39
>> > https://github.com/torvalds/linux/blob/v6.2/drivers/block/null_blk/Makefile#L11
>> >
>> > They have put the zoned stuff in a separate C file that is only compiled
>> > when CONFIG_BLK_DEV_ZONED is set.
>> >
>> > I'm not sure if a similar design is desired for ublk or not.
>> >
>> > However, if a similar design pattern was used, it could probably avoid
>> > some of these unpleasant dummy definitions altogether.
>> 
>> This is the same as I do here, except I put the declarations in the c
>> file instead of a header. I did this for two reasons 1) there is no ublk
>> header besides the uapi header (I would add a header just for this), 2)
>> the declarations need only exist inside ublk_drv.c. For btrfs, null_blk,
>> nvme, the declarations go in a header file and the functions in question
>> do not have static linkage.
>> 
>> I could move the function declarations out of the #else block, but then
>> they would need to be declared static and that gives a compiler warning
>> when the implementation is not present.
>
> I would love to hear someone else's opinion about this as well, but I do
> think that having #ifdef and #else with both a declaration and a definition
> in the C file is quite ugly.
>
> If having an internal only header (in the same directory as the C file),
> makes the C code easier to read, I'm all for it.
>
> It seems to work for nvme to only have a declaration in an internal header
> file, and only provide a definition if CONFIG_BLK_DEV_ZONED is set,
> presumably without giving a warning. Perhaps ublk can do the same?

Sure, I can do that if that is preferred. As I said the result will be
he same with he exception that the function symbols will not have static
linkage when defined in a separate file with declarations in a header.

I will let this version sit for a while to see if anyone has an opinion,
and then I will ship a new version next week.

BR Andreas

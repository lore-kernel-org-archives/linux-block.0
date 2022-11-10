Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870C7C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 18:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKJSKY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 13:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKJSKW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 13:10:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2B9B1E8
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668103764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oJpaUXZfUlB2zojhzgL365muYK2UmjxnzEXrvNOaW04=;
        b=RG5ABUQh3fDsvBZzJmhBbQ25h0od7hcTBDc1B8DXY3tdPrZrsisdAVUme8FRca/gqxY9wB
        9qoQkuPRD0B2oDeax1kTq783KNRDfZkYcUxLzLldOJrFsIHrYMymesPlwCASeDGkct6tgn
        OCkB35ZPsL+V8jUiPKfsAhEsFvvXBv4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-383-SBawsJpQNHSt4WXcrWwN6Q-1; Thu, 10 Nov 2022 13:09:23 -0500
X-MC-Unique: SBawsJpQNHSt4WXcrWwN6Q-1
Received: by mail-qk1-f197.google.com with SMTP id w13-20020a05620a424d00b006e833c4fb0dso2680084qko.2
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJpaUXZfUlB2zojhzgL365muYK2UmjxnzEXrvNOaW04=;
        b=wW829+X9z4cRujd2pqJJmZUiakRkwM3RKrrOt77AQ6jYOdmhDRcJRII4Td0n20hBQ+
         pFkorbB/m0RpRz9h6bUixVczyp95EHOzhY6ZKkOjAmGbyRcuefizaFPGoZuPGrRowKMn
         0xCBoqj7q7jVfnynYxgGZdOrUwr/324RnIweC/PgpFl4VMZy+Nfic62RgsvDrsAyjaxb
         9OqtyHe2fSHWwu5D2q/76DsBI488BPO0S7IVje4dXqEGr4DpfBlINZLG456rGWJd3BFd
         qbG5bXmnv3BuBZPlVySP9r8sAVjt0uDUKKwe73UdiDpMX9zDcGnesbBNByQcLGTkXZGf
         kWhw==
X-Gm-Message-State: ACrzQf2sB+ik3IxYk4sNaYE4kAtbvDfU1JRHTRqvVkYcSsj2qndDMuxk
        Blv2UAyRlk4O9UIIYBtstKKr9UWqiZS3cxczRa5DY6tS9j7vQiIRKh/qiIWBC0E9l5gteHp/jxt
        UkpgHIKb/QwOocjoBCpYdgQ==
X-Received: by 2002:a37:5384:0:b0:6f7:ee90:1618 with SMTP id h126-20020a375384000000b006f7ee901618mr48790843qkb.117.1668103762794;
        Thu, 10 Nov 2022 10:09:22 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5dnq6GgptC+o7e+KGZwxOthgltgisvv0Njbkvz3EcHiNSuQIJcpYvAVh8c8Ov6XGOUjvPMkQ==
X-Received: by 2002:a37:5384:0:b0:6f7:ee90:1618 with SMTP id h126-20020a375384000000b006f7ee901618mr48790823qkb.117.1668103762489;
        Thu, 10 Nov 2022 10:09:22 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id cn3-20020a05622a248300b003a5430ee366sm11477709qtb.60.2022.11.10.10.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:09:21 -0800 (PST)
Date:   Thu, 10 Nov 2022 13:09:20 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, "yukuai (C)" <yukuai3@huawei.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 5/7] dm: track per-add_disk holder relations in DM
Message-ID: <Y20+UNI0KV2VjUSi@redhat.com>
References: <20221030153120.1045101-1-hch@lst.de>
 <20221030153120.1045101-6-hch@lst.de>
 <9b5b4c2a-6566-2fb4-d3ae-4904f0889ea0@huaweicloud.com>
 <20221109082645.GA14093@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109082645.GA14093@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 09 2022 at  3:26P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Nov 09, 2022 at 10:08:14AM +0800, Yu Kuai wrote:
> >> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> >> index 2917700b1e15c..7b0d6dc957549 100644
> >> --- a/drivers/md/dm.c
> >> +++ b/drivers/md/dm.c
> >> @@ -751,9 +751,16 @@ static struct table_device *open_table_device(struct mapped_device *md,
> >>   		goto out_free_td;
> >>   	}
> >>   -	r = bd_link_disk_holder(bdev, dm_disk(md));
> >> -	if (r)
> >> -		goto out_blkdev_put;
> >> +	/*
> >> +	 * We can be called before the dm disk is added.  In that case we can't
> >> +	 * register the holder relation here.  It will be done once add_disk was
> >> +	 * called.
> >> +	 */
> >> +	if (md->disk->slave_dir) {
> > If device_add_disk() or del_gendisk() can concurrent with this, It seems
> > to me that using 'slave_dir' is not safe.
> >
> > I'm not quite familiar with dm, can we guarantee that they can't
> > concurrent?
> 
> I assumed dm would not get itself into territory were creating /
> deleting the device could race with adding component devices, but
> digging deeper I can't find anything.  This could be done
> by holding table_devices_lock around add_disk/del_gendisk, but
> I'm not that familar with the dm code.
> 
> Mike, can you help out on this?

Maybe :/

Underlying component devices can certainly come and go at any
time. And there is no DM code that can, or should, prevent that. All
we can do is cope with unavailability of devices. But pretty sure that
isn't the question.

I'm unclear about the specific race in question:
if open_table_device() doesn't see slave_dir it is the first table
load. Otherwise, the DM device (and associated gendisk) shouldn't have
been torn down while a table is actively being loaded for it. But
_where_ the code lives, to ensure that, is also eluding me...

You could use a big lock (table_devices_lock) to disallow changes to
DM relations while loading the table. But I wouldn't think it needed
as long as the gendisk's lifecycle is protected vs table loads (or
other concurrent actions like table load vs dm device removal). Again,
more code inspection needed to page all this back into my head.

The concern for race aside:
I am concerned that your redundant bd_link_disk_holder() (first in
open_table_device and later in dm_setup_md_queue) will result in
dangling refcount (e.g. increase of 2 when it should only be by 1) --
given bd_link_disk_holder will gladly just bump its holder->refcnt if
bd_find_holder_disk() returns an existing holder. This would occur if
a DM table is already loaded (and DM device's gendisk exists) and a
new DM table is being loaded.

Mike


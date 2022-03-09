Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2BFC433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 01:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiCIB1b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiCIB13 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 20:27:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F7E39A4FD
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 17:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646789180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lNIylrZM6unomlwJxnnl1YZ92D1gofy+4LkRW9aVRNU=;
        b=aCH57uVLof3GXQurEfzVgJUwCbwH22Odfd79eH7Gq+S4OxAdBgHy8yhO9s8rYs34XvphvZ
        i/0LE51umd11Hxhbtt9WImQL4opy8lehgLTVq5ZrrIBANma6pOsI2dUE6mFw2stTWSj2kB
        RxFyfc0Ray935aPskaMXldoXcvpqoO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-DxdcWgDMNOyeZNnxbyPgqw-1; Tue, 08 Mar 2022 20:14:12 -0500
X-MC-Unique: DxdcWgDMNOyeZNnxbyPgqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE9012F35;
        Wed,  9 Mar 2022 01:14:11 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 726415D986;
        Wed,  9 Mar 2022 01:13:35 +0000 (UTC)
Date:   Wed, 9 Mar 2022 09:13:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@redhat.com>, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v6 2/2] dm: support bio polling
Message-ID: <Yif/Or0s1rV87a5R@T590>
References: <20220307185303.71201-1-snitzer@redhat.com>
 <20220307185303.71201-3-snitzer@redhat.com>
 <eac88ad5-3274-389b-9d18-9b6aa16fcb98@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eac88ad5-3274-389b-9d18-9b6aa16fcb98@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 08, 2022 at 06:02:50PM -0700, Jens Axboe wrote:
> On 3/7/22 11:53 AM, Mike Snitzer wrote:
> > From: Ming Lei <ming.lei@redhat.com>
> > 
> > Support bio(REQ_POLLED) polling in the following approach:
> > 
> > 1) only support io polling on normal READ/WRITE, and other abnormal IOs
> > still fallback to IRQ mode, so the target io is exactly inside the dm
> > io.
> > 
> > 2) hold one refcnt on io->io_count after submitting this dm bio with
> > REQ_POLLED
> > 
> > 3) support dm native bio splitting, any dm io instance associated with
> > current bio will be added into one list which head is bio->bi_private
> > which will be recovered before ending this bio
> > 
> > 4) implement .poll_bio() callback, call bio_poll() on the single target
> > bio inside the dm io which is retrieved via bio->bi_bio_drv_data; call
> > dm_io_dec_pending() after the target io is done in .poll_bio()
> > 
> > 5) enable QUEUE_FLAG_POLL if all underlying queues enable QUEUE_FLAG_POLL,
> > which is based on Jeffle's previous patch.
> 
> It's not the prettiest thing in the world with the overlay on bi_private,
> but at least it's nicely documented now.
> 
> I would encourage you to actually test this on fast storage, should make
> a nice difference. I can run this on a gen2 optane, it's 10x the IOPS
> of what it was tested on and should help better highlight where it
> makes a difference.
> 
> If either of you would like that, then send me a fool proof recipe for
> what should be setup so I have a poll capable dm device.

Follows steps for setup dm stripe over two nvmes, then run io_uring on
the dm stripe dev.

1) dm_stripe.perl

#!/usr/bin/perl -w
# Create a striped device across any number of underlying devices. The device
# will be called "stripe_dev" and have a chunk-size of 128k.

my $chunk_size = 128 * 2;
my $dev_name = "stripe_dev";
my $num_devs = @ARGV;
my @devs = @ARGV;
my ($min_dev_size, $stripe_dev_size, $i);

if (!$num_devs) {
        die("Specify at least one device\n");
}

$min_dev_size = `blockdev --getsz $devs[0]`;
for ($i = 1; $i < $num_devs; $i++) {
        my $this_size = `blockdev --getsz $devs[$i]`;
        $min_dev_size = ($min_dev_size < $this_size) ?
                        $min_dev_size : $this_size;
}

$stripe_dev_size = $min_dev_size * $num_devs;
$stripe_dev_size -= $stripe_dev_size % ($chunk_size * $num_devs);

$table = "0 $stripe_dev_size striped $num_devs $chunk_size";
for ($i = 0; $i < $num_devs; $i++) {
        $table .= " $devs[$i] 0";
}

`echo $table | dmsetup create $dev_name`;


2) test_poll_on_dm_stripe.sh

#!/bin/bash

RT=40
JOBS=1
HI=1
BS=4K

set -x
dmsetup remove_all

rmmod nvme
modprobe nvme poll_queues=2

sleep 2

./dm_stripe.perl /dev/nvme0n1 /dev/nvme1n1
sleep 1
DEV=/dev/mapper/stripe_dev

echo "io_uring hipri test"

fio --bs=$BS --ioengine=io_uring --fixedbufs --registerfiles \
        --hipri=$HI --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 \
        --filename=$DEV --direct=1 --runtime=$RT --numjobs=$JOBS --rw=randread --name=test \
        --group_reporting

Thanks, 
Ming


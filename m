Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AFCC04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 20:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C1F20870
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 20:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C1F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeLJUGz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:06:55 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45500 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeLJUGz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 15:06:55 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so13770000qtr.12
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 12:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KoxciN+POSCh1IYDmDhy4a9q+LxZuKiRp8U5cOaRjE=;
        b=JK1u7yDsiYnQXjLwGH6V7x32kOVxQvyFT6yCSJQciI9CXtTpIbwQL8kaMXHgW4D8Vk
         48JwEgtv6El5e/C8QHdyD/pLT0dbHvRM1RjQG7e9cOTqbYwX3J4PV3eMkyfu7kzxUCM6
         bIAH2Ow7R2LCRAnw1DLnuFM/V1oXA2u7f//eE/k4zbQxLi+jopixQLaVAiGrtyfrPiyb
         KmJxX8NPR8vpyAFT2NnrHElNaF63aLbOsAjbl1X8PF2xeVSYuISqV2G3IYXJAR0bbyXO
         XWzQMDnt0uOL6yh+yrI32zA9R1yZkkl8M/UUQi6S7Q5WoU263tKfMWmlIFyD5Zp+SZqA
         8CSQ==
X-Gm-Message-State: AA+aEWan+h1Saal1E5Q2s4ajmsBqLJZ7oWN8GAIZqBBn5PX19iMYpCrp
        pOn/yEMEzouH/NrLUbDZOARvqxBUSpo=
X-Google-Smtp-Source: AFSGD/XhPWb7tSoVWq4A35u20iCW3peP0jf0hJ6KCxbuoaKNJMeo46l0FJ/Cf95Gq/s8V8/mnER8dw==
X-Received: by 2002:a0c:d268:: with SMTP id o37mr12987913qvh.136.1544472413630;
        Mon, 10 Dec 2018 12:06:53 -0800 (PST)
Received: from loberhel74 (035-134-022-126.static.chtrptr.net. [35.134.22.126])
        by smtp.gmail.com with ESMTPSA id w12sm6446798qkb.3.2018.12.10.12.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 12:06:53 -0800 (PST)
Message-ID: <1544472412.18488.5.camel@redhat.com>
Subject: Re: [PATCH] block: Restore tape support
From:   Laurence Oberman <loberman@redhat.com>
To:     Keith Busch <keith.busch@intel.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Todd Aiken <taiken@mvtech.ca>,
        stable@vger.kernel.org
Date:   Mon, 10 Dec 2018 15:06:52 -0500
In-Reply-To: <20181210153230.GB25206@localhost.localdomain>
References: <20181210030814.13235-1-bvanassche@acm.org>
         <20181210153230.GB25206@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2018-12-10 at 08:32 -0700, Keith Busch wrote:
> On Sun, Dec 09, 2018 at 07:08:14PM -0800, Bart Van Assche wrote:
> > According to what I found in
> > https://bugzilla.kernel.org/show_bug.cgi?id=201935 patch "block:
> > Clear
> > kernel memory before copying to user" broke tape access. Hence
> > revert
> > that patch.
> 
> Instead of reverting back to the leaking arbitrary kernel memory, why
> not just make a fix on top of it? This should do it:
> 
> ---
> diff --git a/block/bio.c b/block/bio.c
> index c4ef8aa46452..55a5386fd431 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1262,7 +1262,8 @@ struct bio *bio_copy_user_iov(struct
> request_queue *q,
>  		if (ret)
>  			goto cleanup;
>  	} else {
> -		zero_fill_bio(bio);
> +		if (bmd->is_our_pages)
> +			zero_fill_bio(bio);
>  		iov_iter_advance(iter, bio->bi_iter.bi_size);
>  	}
>  
> --
Reproduced on 4.20-rc6

# tar cvf /dev/st0 /etc
...
Showed data was written in tar
However listing is empty, data not actually written

# tar tvf /dev/st0 
#

Then:

Applied Keith Patch

# tar cvf /dev/st0 /etc
...

# tar tvf /dev/st0

Data was written and can be read

..drwxr-xr-x root/root         0 2018-10-31 08:41 etc/fwupd/
-rw-r--r-- root/root       292 2018-06-07 08:27 etc/fwupd/daemon.conf
drwxr-xr-x root/root         0 2018-10-31 08:41 etc/fwupd/remotes.d/
-rw-r--r-- root/root       181 2018-09-05 06:00
etc/fwupd/remotes.d/fwupd.conf
-rw-r--r-- root/root       327 2018-06-07 08:27
etc/fwupd/remotes.d/lvfs-testing.conf
-rw-r--r-- root/root       283 2018-09-05 06:00
etc/fwupd/remotes.d/lvfs.conf
-rw-r--r-- root/root       283 2018-09-05 06:00
etc/fwupd/remotes.d/vendor.conf
-rw-r--r-- root/root       118 2018-09-05 06:00 etc/fwupd/uefi.conf
-r--r----- root/root      4328 2018-09-25 01:57 etc/sudoers.rpmnew
-rw-r--r-- root/root      2331 2018-11-02 14:50 etc/hercules.cnf
-rw-r--r-- root/root       147 2018-11-06 17:08 etc/minirc.p2000


[   96.272548] st 2:0:0:0: [st0] Block limits 1 - 16777215 bytes.
[   96.300782] st 2:0:0:0: [st0] Mode sense. Length 11, medium 0, WBS
10, BLL 8
[   96.334985] st 2:0:0:0: [st0] Density 58, tape length: 0, drv
buffer: 1
[   96.367366] st 2:0:0:0: [st0] Block size: 0, buffer size: 4096 (1
blocks).
[   97.197209] st 2:0:0:0: [st0] Rewinding tape.
[  103.104429] st 2:0:0:0: [st0] Block limits 1 - 16777215 bytes.
[  103.133142] st 2:0:0:0: [st0] Mode sense. Length 11, medium 0, WBS
10, BLL 8
[  103.167421] st 2:0:0:0: [st0] Density 58, tape length: 0, drv
buffer: 1
[  103.199711] st 2:0:0:0: [st0] Block size: 0, buffer size: 4096 (1
blocks).
[  104.109081] st 2:0:0:0: [st0] Rewinding tape.

Tested and works fine. 
Thanks All

Tested-by: Laurence Oberman <loberman@redhat.com>



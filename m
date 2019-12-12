Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183A9C2D0C9
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 10:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E5422B48
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 10:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlV25XoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfLLK1p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:27:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54528 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728573AbfLLK1o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 05:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576146464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qU9B6VyDpHjtTgIgGRVPpWJk/W+j6466GBB3hhlYf7g=;
        b=RlV25XoGBhgTBON0WMFGqHKNzsUzYMBJ4QH0aR7wyOBWGd+uj/CrDTEuW/B6wsMqxyUGo7
        WT6/aIDvSjr89c8aMNRqudTX+QPQL1y6NRE2UHjD6V23nSKd38TcV9cQkh4VsIftM68Dc0
        yh5AkSKXV8KdTlvKIpk7bPjMQqBWxUM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-zRqKNOjeOj6m1T5SwxoDaQ-1; Thu, 12 Dec 2019 05:27:42 -0500
X-MC-Unique: zRqKNOjeOj6m1T5SwxoDaQ-1
Received: by mail-qt1-f200.google.com with SMTP id q17so1076582qtc.8
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2019 02:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qU9B6VyDpHjtTgIgGRVPpWJk/W+j6466GBB3hhlYf7g=;
        b=p6tfHighdKVQt7pGsRScdCt1NNON8N+Drd4IVw+MvMAMe1qoECtaYelloncED7bSR0
         QsimvkDcGiSXedzT/U6rHUFIaWLkJR4ublu1JlkIcYdEKs94H/lag4eqbTNt/wDhayR8
         NNCuoSPLs6rhlVe2h9Z9yvQfF057WLzUWpByUdH3yMq65TRL5jxRnNIy389i9Whqy6hX
         t8tRhEzKRZKcnJ2JyN3ySunVjvzRZjjxmvCvJx+/xK+3p5X0fJgvg1CYJcWQV8nM2J5h
         YjhLwXuDTrxPKOLaicJfZdOEy5bRQENMAtK9bevCh5dT7WHnkngjM6iEeVj35DajZNTr
         JybA==
X-Gm-Message-State: APjAAAXEqBCDKqBLQOvFY+TMdbJ0xZwN55zPrhmqsEhpoizkYzT8Rmz6
        u6XqpZCjiF+E5cUbH1pB/f6wjOGu4/GnoZI+owhgi43DBKQy1ucDQI5Q69ZymyhYG9Jnj83SFhC
        aD8ELTw8YLtXBCliNMrcPMMY=
X-Received: by 2002:a0c:fa4b:: with SMTP id k11mr7283778qvo.55.1576146461809;
        Thu, 12 Dec 2019 02:27:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxtYqnSCAa6qS7eoPNNg8Gjl2R1rf+c6pT8ccpGnyGaK+GWirzetuKwnPIwjkwnOvZt6S9U2w==
X-Received: by 2002:a0c:fa4b:: with SMTP id k11mr7283726qvo.55.1576146461280;
        Thu, 12 Dec 2019 02:27:41 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id 2sm1599671qkv.98.2019.12.12.02.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:27:40 -0800 (PST)
Date:   Thu, 12 Dec 2019 05:27:33 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jason Wang <jasowang@redhat.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/24] compat_ioctl: scsi: move ioctl handling into
 drivers
Message-ID: <20191212052649-mutt-send-email-mst@kernel.org>
References: <20191211204306.1207817-1-arnd@arndb.de>
 <20191211204306.1207817-16-arnd@arndb.de>
 <20191211180155-mutt-send-email-mst@kernel.org>
 <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 12, 2019 at 01:28:08AM +0100, Paolo Bonzini wrote:
> On 12/12/19 00:05, Michael S. Tsirkin wrote:
> >> @@ -405,6 +405,9 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
> >>  
> >>  static const struct block_device_operations virtblk_fops = {
> >>  	.ioctl  = virtblk_ioctl,
> >> +#ifdef CONFIG_COMPAT
> >> +	.compat_ioctl = blkdev_compat_ptr_ioctl,
> >> +#endif
> >>  	.owner  = THIS_MODULE,
> >>  	.getgeo = virtblk_getgeo,
> >>  };
> > Hmm - is virtio blk lumped in with scsi things intentionally?
> 
> I think it's because the only ioctl for virtio-blk is SG_IO.

Oh right, I forgot about that one ...

>  It makes
> sense to lump it in with scsi, but I wouldn't mind getting rid of
> CONFIG_VIRTIO_BLK_SCSI altogether.
> 
> Paolo


Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9571DC282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 14:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6843220874
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 14:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA6GArsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfFDOvj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:51:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38301 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfFDOvj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jun 2019 10:51:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id a186so12137229pfa.5;
        Tue, 04 Jun 2019 07:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y5m7hbwpz1G0esMTwf2Il76EE6PMim8MRb7v9V72iNk=;
        b=XA6GArsdZ8UdqjTPktHiROHkR9d4TrqE4fD1bvtRV2KUSYSvpe5NGKbPhWjptgomFO
         Dp+2M8RDi/pM6AGJD4Gque/UcWkqSTUY6MSi5jmiUSGs6KtDzWKJJnPnYdsU+yMft5uF
         XZdUryp6xYw4fyqK1OcOTb4s+U34q5WwiMZPDCcBH5kEw1VZ/Ktmw4uwPn9UcJSk8+Qk
         Lk5NN8i9uwdeOTM53/R6GfvgAETpgQI+NRBKnBHGfF+FrENJ2f8MpJOXput5JTjdn3dD
         gkgQT9AYduAIN5oivz7lYhPWNlF++1hFXwaHF0lFk9HrORzZfrL18QMePHXaHUVGbs2p
         3F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y5m7hbwpz1G0esMTwf2Il76EE6PMim8MRb7v9V72iNk=;
        b=A21YJLjhvsa+qlmPp9xX8eZdD99+biGZ9lNdVfFyM5ou4tKBHG+qL5i+coMeGBrBzY
         YchJPKNdd4qMgV9VPRwkfTq7GuxKu7sXlzGRdpUmhy12CRRggkYfjDOqBMG/IVRKMZ6g
         /R+rRa9/5qCAOE2RrDDdVaE2xyntqrZg9zA48suBNi4WzU8B3LICSFUbHWIWDMfWYtZV
         flGZ+VIde79gbM0vd6bRqomFMVyy0dUyrLCqIMvKSLImq7ql2Efb+hTufDBPR+gpXay3
         OmDqa5nwRjp4ImYQF4zcHllh/tClnCRM0pnbWlWzEJ13bkM2CAJVzN6PPqA4J8HQ4dmn
         mdcw==
X-Gm-Message-State: APjAAAW1r4FG8o5DfqxNYwL4tfJ304uR0k+erlzop02PxYwYO8zxR+4d
        00EhN94udGRicwIaa1tXRZo=
X-Google-Smtp-Source: APXvYqyhcKBrK0GMjRua/FzkAWzUqFGlFikGT6D4b0DBVhLvqpzRCNtwmzRHYIGmT0JG9gD8T+0NJw==
X-Received: by 2002:aa7:838d:: with SMTP id u13mr15914511pfm.191.1559659898666;
        Tue, 04 Jun 2019 07:51:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t25sm13815320pgv.30.2019.06.04.07.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:51:37 -0700 (PDT)
Date:   Tue, 4 Jun 2019 07:51:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH V4 3/3] scsi: core: avoid to pre-allocate big chunk for
 sg list
Message-ID: <20190604145135.GA4106@roeck-us.net>
References: <20190428073932.9898-1-ming.lei@redhat.com>
 <20190428073932.9898-4-ming.lei@redhat.com>
 <20190603204422.GA7240@roeck-us.net>
 <20190604010002.GA24432@ming.t460p>
 <cdf94e43-79a7-078e-676d-dfc736eec286@roeck-us.net>
 <20190604040946.GA27224@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604040946.GA27224@ming.t460p>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 04, 2019 at 12:10:00PM +0800, Ming Lei wrote:
> On Mon, Jun 03, 2019 at 08:49:10PM -0700, Guenter Roeck wrote:
> > On 6/3/19 6:00 PM, Ming Lei wrote:
> > > On Mon, Jun 03, 2019 at 01:44:22PM -0700, Guenter Roeck wrote:
> > > > On Sun, Apr 28, 2019 at 03:39:32PM +0800, Ming Lei wrote:
> > > > > Now scsi_mq_setup_tags() pre-allocates a big buffer for IO sg list,
> > > > > and the buffer size is scsi_mq_sgl_size() which depends on smaller
> > > > > value between shost->sg_tablesize and SG_CHUNK_SIZE.
> > > > > 
> > > > > Modern HBA's DMA is often capable of deadling with very big segment
> > > > > number, so scsi_mq_sgl_size() is often big. Suppose the max sg number
> > > > > of SG_CHUNK_SIZE is taken, scsi_mq_sgl_size() will be 4KB.
> > > > > 
> > > > > Then if one HBA has lots of queues, and each hw queue's depth is
> > > > > high, pre-allocation for sg list can consume huge memory.
> > > > > For example of lpfc, nr_hw_queues can be 70, each queue's depth
> > > > > can be 3781, so the pre-allocation for data sg list is 70*3781*2k
> > > > > =517MB for single HBA.
> > > > > 
> > > > > There is Red Hat internal report that scsi_debug based tests can't
> > > > > be run any more since legacy io path is killed because too big
> > > > > pre-allocation.
> > > > > 
> > > > > So switch to runtime allocation for sg list, meantime pre-allocate 2
> > > > > inline sg entries. This way has been applied to NVMe PCI for a while,
> > > > > so it should be fine for SCSI too. Also runtime sg entries allocation
> > > > > has verified and run always in the original legacy io path.
> > > > > 
> > > > > Not see performance effect in my big BS test on scsi_debug.
> > > > > 
> > > > 
> > > > This patch causes a variety of boot failures in -next. Typical failure
> > > > pattern is scsi hangs or failure to find a root file system. For example,
> > > > on alpha, trying to boot from usb:
> > > 
> > > I guess it is because alpha doesn't support sg chaining, and
> > > CONFIG_ARCH_NO_SG_CHAIN is enabled. ARCHs not supporting sg chaining
> > > can only be arm, alpha and parisc.
> > > 
> > 
> > I don't think it is that simple. I do see the problem on x86 (32 and 64 bit)
> > sparc, ppc, and m68k as well, and possibly others (I didn't check all because
> > -next is in terrible shape right now). Error log is always a bit different
> > but similar.
> > 
> > On sparc:
> > 
> > scsi host0: Data transfer overflow.
> > scsi host0: cur_residue[0] tot_residue[-181604017] len[8192]
> > scsi host0: DMA length is zero!
> > scsi host0: cur adr[f000f000] len[00000000]
> > scsi host0: Data transfer overflow.
> > scsi host0: cur_residue[0] tot_residue[-181604017] len[8192]
> > scsi host0: DMA length is zero!
> > 
> > On ppc:
> > 
> > scsi host0: DMA length is zero!
> > scsi host0: cur adr[0fd21000] len[00000000]
> > scsi host0: Aborting command [(ptrval):28]
> > scsi host0: Current command [(ptrval):28]
> > scsi host0:  Active command [(ptrval):28]
> > 
> > On x86, x86_64 (after reverting a different crash-causing patch):
> > 
> > [   20.226809] scsi host0: DMA length is zero!
> > [   20.227459] scsi host0: cur adr[00000000] len[00000000]
> > [   50.588814] scsi host0: Aborting command [(____ptrval____):28]
> > [   50.589210] scsi host0: Current command [(____ptrval____):28]
> > [   50.589447] scsi host0:  Active command [(____ptrval____):28]
> > [   50.589674] scsi host0: Dumping command log
> 
> OK, I did see one boot crash issue on x86_64 with -next, so could
> you share us that patch which needs to be reverted? Meantime, please
> provide me your steps for reproducing this issue? (rootfs image, kernel
> config, qemu command)
> 
The patch to be reverted is this one. I'll prepare the rest of the
information later today.

> BTW, the patch has been tested in RH QE lab, so far not see such reports
> yet.
> 
FWIW, I don't think the RE QE lab tests any of the affected configurations.

Guenter

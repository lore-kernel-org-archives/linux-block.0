Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE1CC04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 13:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55A220833
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 13:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kae8qrkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfEPNt2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 09:49:28 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:39949 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfEPNt2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 09:49:28 -0400
Received: by mail-ot1-f46.google.com with SMTP id u11so3462025otq.7;
        Thu, 16 May 2019 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sEYVbmMjnPjMeD6n0ndJNqV8hNFaASAzPiMDXfKnltE=;
        b=kae8qrkPb4xSXXlWsVC3YhTX5iEKdKKTzubF+je66J7YgvBTKCOZBxcpBUzdWdjOEN
         sC64TZzK9bebCZPBpMkYWowKf5NaK8NkenXqCcqNpWq1bnc81RIjogW94fT1++jjTTta
         IW6/61L6bwxbjGxi36eYHdXheTSb5WryrLmyj8QJQwQxGFqhVgfrqM8v6hOcuzXho8oV
         Zv+tn1ox3O4i717KF2piipgOotdI0d+HID4vCJXwZvtOq1EiLgr79GWN5FrOqfGebngb
         yED9+wRo2Ft+ikotXd5Yf0Qn1+USPvn/wPzLPoyxAbPAwFizoDrhXb4/p7dVMXQ7n7Uc
         SXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sEYVbmMjnPjMeD6n0ndJNqV8hNFaASAzPiMDXfKnltE=;
        b=TE/N/F8xVZSuBP2RSfy7RrGJhibWnrmgksP3756yKbmw/IcCjos24qQVYPS++rgIB4
         JYoj/37ew/fJYBQ7tJkdenHA6ZAl6xZRqqayW719a46zsfqqH9Zlf9Kd+5kRY3P6qXL/
         IrKfB4tJMSRcAC+V/UFZmHEMW/R1jH9IwKVEzjKmpX7ha1uPwTSqg8tHXL2Q3bd8yOr8
         PQ6M4NEX72xzAJspO9Gi9nniMqMi/K31tfSbkfz8x8V57zJdQCf8VW1TPCgIn7F/ixrr
         bBJv+AZwg/9zSnLdSOl4igMXAe/J8+qpkbrEtz7h0FRfYqPc2BPtmUQ0W9ivUOO44ugS
         zugA==
X-Gm-Message-State: APjAAAVWDCyioTVAWiI4H7v9STh6q/2mLxn3KYbYyTwoUmSwD8oQnyc3
        3U55JM4iG61GrT1SQGd//NEnsS+6piTb8RBG7JIcv+zg63Y=
X-Google-Smtp-Source: APXvYqyCTy4st8MhEjZHJ8VQnNxYRURTwP6M91x+f+q8ONkS7GBfyjef+rFPXDkmDsT6xpTKFta9gNJ6JgE/yrPGNb4=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr29608012oti.18.1558014567095;
 Thu, 16 May 2019 06:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+TYKz1o=uOn0m3tPGqmNZtw7mGdZ7_BGX0C0RH9f3wnFDpO6Q@mail.gmail.com>
 <e81e675e-e084-197a-fc13-101985bde590@suse.de>
In-Reply-To: <e81e675e-e084-197a-fc13-101985bde590@suse.de>
From:   Alibek Amaev <alibek.a@gmail.com>
Date:   Thu, 16 May 2019 16:49:15 +0300
Message-ID: <CA+TYKz1E3mJ0hDQcv19QAFgeWVA-ADLoHtGQ5hy8SFxHOfuqfQ@mail.gmail.com>
Subject: Re: Block device naming
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I have more example from IRL:
In Aug 2018 I was start server with attached storages by FC from ZS3
and ZS5 (it is Oracle ZFS Storage Appliance, not NetApp and also
export space as LUN) server use one LUN from ZS5. And recently on
server stopped all IO on this exported LUN  and io-wait is grow, in
dmesg no any errors or any changes about FC, no errors in
/var/log/kern.log* /var/log/syslog.log*, no throttling, no edac errors
or other.
But before reboot I saw:
wwn-0x600144f0b49c14d100005b7af8ee001c -> ../../sdc
I try to run partprobe or try to copy from this block device some data
to /dev/null by dd - operations wasn't finished IO is blocked
And after reboot i seen:
wwn-0x600144f0b49c14d100005b7af8ee001c -> ../../sdd
And server is run ok.

Also I have LUN exported from storage in shared mode and it accesible
for all servers by FC. Currently this LUN not need, but now I doubt it
is possible to safely remove it...


On Thu, May 16, 2019 at 3:33 PM Hannes Reinecke <hare@suse.de> wrote:
>
> On 5/16/19 2:26 PM, Alibek Amaev wrote:
> > Hi!
> >
> > I want to address the following problem:
> > On the system with hot-attached new storage volume, such as FC-switch
> > update configuration for connected FC-HBA on servers, linux kernel
> > reorder block devices and change names of block devices. Becouse
> > scsi-id, wwn-id and other is a symbol links to block device names than
> > on change block device name change path to device.
> > This causes the server to stop working.
> >
> > For example, on server present ZFS pool with attached device by scsi-id
> > # zpool status
> >    pool: pool
> >   state: ONLINE
> >    scan: scrub repaired 0 in 1h39m with 0 errors on Sun Oct  8 02:03:34=
 2017
> > config:
> >
> >      NAME                                      STATE     READ WRITE CKS=
UM
> >      pool                                      ONLINE       0     0    =
 0
> >        scsi-3600144f0c7a5bc61000058d3b96d001d  ONLINE       0     0    =
 0
> >
> > Before export new block device from storage to hba, scsi-id have next
> > path to device:
> > /dev/disk/by-id/scsi-3600144f0c7a5bc61000058d3b96d001d -> ../../sdd
> >
> > When added new block device by FC-switch, FC-HBA kernel change block
> > device names:
> > /dev/disk/by-id/scsi-3600144f0c7a5bc61000058d3b96d001d -> ../../sdf
> >
> > and ZFS can't access to device until reboot (partprobe, zpool online
> > -e pool scsi-3600144f0c7a5bc61000058d3b96d001d - may help or may not
> > help)
> >
> Hmm. That really is curious; typically existing devices will not be
> reassigned. Especially not if they are in use by something.
> And the FC layer is going into quite some lengths to prevent this from
> happening.
> So this really looks more like an issue with how exactly this 'adding
> new block device' step was done.
>
> > Is there any way to fix or change this behavior of the kernel?
> >
> As I said, this typically does not happen.
> It would need closer examination to figure out what really happened.
>
> > It may be more reasonable to immediately assign an unique persistent
> > identifier of device and linking other identifiers with it?
> >
> Which is what we try ...
>
> > Also I think this is not specific problem of ZFS. And can occur with ot=
her
> > file system modules.Moreover, I had previously encountered a similar
> > problem - NetAPP
> > storage attached to servers by FC and export multiple LUN - suddenly
> > decided to change the order of LUNs and Ext4 on servers is switch to
> > readonly mode because driver detect changes of magic number in
> > superblocks of partitions.
> >
> Suddently changing the order of LUNs is _not_ what is supposed to
> happen. This really sounds more like an issue with NetApp.
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke            Teamlead Storage & Networking
> hare@suse.de                              +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG N=C3=BCrnberg)

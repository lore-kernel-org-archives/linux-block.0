Return-Path: <SRS0=xX0B=TR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE20FC04AB4
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 11:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793AE2087E
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 11:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgUjlddV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfEQLYg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 May 2019 07:24:36 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:47069 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfEQLYg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 May 2019 07:24:36 -0400
Received: by mail-oi1-f182.google.com with SMTP id 203so4856959oid.13;
        Fri, 17 May 2019 04:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iw94FaDD9Rhkhyp+JrIv9OiLY7IOkQMnM/Sb2ugsUg4=;
        b=XgUjlddVH1B0pqMY8ppzYCKbipI4UElGWIjwpWGINwUT82gWUSYc4/21C9+JOXbI27
         Mkv0ZYLXd7r5VPy+1aF3Ak4VQYnV0S0e1nX84vrqLIRy8smtLIbUuQ+9f5YNlOOIqNMH
         ynI9DvjVYKSEADB6mv3mCz0rA9h23jjASPk0KFSI81xUSTVRGhWigDpihk/art8APHR5
         8FDxfWAIYhcnTKarcqkPpENhMJgnkZPJ0i6fNHNLOjBpDh/OTfbRu8fYXwJ6qd1lNi0t
         WjlMtQJXpK7oEh5i8L8FMiV9P+A3AAHVattsEfJKOhK5wu2ZBpRzgFVBVeVIYIiYCb0/
         SUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iw94FaDD9Rhkhyp+JrIv9OiLY7IOkQMnM/Sb2ugsUg4=;
        b=KCaCTOB7jmpGDqtLeNhHS/LB8TbpQwxUVVROuddOI1aYlVFRBTt4FpVpHw2eQX7IdT
         HCbL3M7/Arjw7yA5IIAicCjM2dxGrtizTkh3aYh4v6E/XrxXVrRSQ/tuV3RpY6QV4A0U
         KNWMILdZJT7oFJZMTBymLuepyEnpAA+B/RQH3UxlU9H92OFFXlIZbcuAtkEzgMd2Zy/e
         xcndW8UkC3TRTq/bLgmWFafm+IykQ4HCAUTCA7wi4IuKVh/scT2prEd+iN8tk6tNA43J
         qOEKV5uNTgMMmlJk3eGPpXQ3IAv98TsDoiXUxQ7wCUtRfKWO0NjOvJ/eUKkx5slIN+54
         BgGQ==
X-Gm-Message-State: APjAAAU8FUxLeNeT718jKo2HE7O3pVEOpYOTFxAICBQ//DTRfDt/AtK2
        krlXP1rb17e9u+Eal1A9i6Dy6NO5hufdnYmiCB4i+uWQ3jY=
X-Google-Smtp-Source: APXvYqzwELeIEPvkZ9hQgaCwTsvZNHaTagP4ddT9nfmpnN+e/pTHSOKuQi0lXxcAgpEc+wLkRLyYRf7bQFHl4kM/NEo=
X-Received: by 2002:aca:cfc7:: with SMTP id f190mr14357747oig.158.1558092275424;
 Fri, 17 May 2019 04:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+TYKz1o=uOn0m3tPGqmNZtw7mGdZ7_BGX0C0RH9f3wnFDpO6Q@mail.gmail.com>
 <e81e675e-e084-197a-fc13-101985bde590@suse.de> <CA+TYKz1E3mJ0hDQcv19QAFgeWVA-ADLoHtGQ5hy8SFxHOfuqfQ@mail.gmail.com>
 <680c9440-f1c9-68d1-cc5a-17aa9071fcc1@suse.de>
In-Reply-To: <680c9440-f1c9-68d1-cc5a-17aa9071fcc1@suse.de>
From:   Alibek Amaev <alibek.a@gmail.com>
Date:   Fri, 17 May 2019 14:24:24 +0300
Message-ID: <CA+TYKz14Y2D2as1xetEAL2C4tD8fuSmoz7dYnm8HxNpLZR5skQ@mail.gmail.com>
Subject: Re: Block device naming
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I understand that changing the block device name does not matter
between reboots.
But as I understood in these cases, the order of HCTL (Host: Channel:
Target: Lun) for devices is changed. Unfortunately, I did not capture
the order of HCTL before the failure and I can't provide evidence. But
if I rely on my brain, then I know that the order of the HCTL before
the failure was different in all the cases presented.
This is indirectly confirmed by how the state of the pool in zfs is
demonstrated. And it seems that it depends on how the device was added
(by scsi-id or by wwn-id).
By scsi-id (when there were messages in the dmesg about device
changes), the failure was shown as follows:
---
# zpool status
  pool: pool
 state: UNAVAIL
status: One or more devices are faulted in response to IO failures.
action: Make sure the affected devices are connected, then run 'zpool clear=
'.
   see: http://zfsonlinux.org/msg/ZFS-8000-HC
  scan: scrub repaired 0 in 1h39m with 0 errors on Sun Oct  8 02:03:34 2017
config:

    NAME                                      STATE     READ WRITE CKSUM
    pool                                      UNAVAIL      0     0
0  insufficient replicas
      scsi-3600144f0c7a5bc61000058d3b96d001d  FAULTED      3     0
0  too many errors

errors: 51 data errors, use '-v' for a list
---
Than in normal state zpool status show:
---
# zpool status
  pool: pool
 state: ONLINE
  scan: scrub repaired 0 in 1h39m with 0 errors on Sun Oct  8 02:03:34 2017
config:

    NAME                                      STATE     READ WRITE CKSUM
    pool                                      ONLINE       0     0     0
      scsi-3600144f0c7a5bc61000058d3b96d001d  ONLINE       0     0     0

errors: No known data errors
---

And in another case, when the LUN is imported by wwn-id (and now any
errors in dmesg) in error state, zpool status is:
---
# zpool status
  pool: pool1
 state: ONLINE
  scan: scrub repaired 0B in 17h30m with 0 errors on Sun Apr 14 17:54:55 20=
19
config:

NAME                                      STATE     READ WRITE CKSUM
pool1                                     ONLINE       0     0     0
  sdc                                     ONLINE       0     0     0

errors: No known data errors
---
In the status there are no errors, but show block device name from /dev/
Than in normal state zpool status show wwn-id from /dev/disk/by-id
instead of device name from /dev:
---
root@lpr11a:~# zpool status
  pool: pool1
 state: ONLINE
  scan: scrub repaired 0B in 17h30m with 0 errors on Sun Apr 14 17:54:55 20=
19
config:

NAME                                      STATE     READ WRITE CKSUM
pool1                                     ONLINE       0     0     0
  wwn-0x600144f0b49c14d100005b7af8ee001c  ONLINE       0     0     0

errors: No known data errors
---

P.S. I would also like to note /dev/disk is not reflect reality - SSD
are not disks.

On Thu, May 16, 2019 at 5:07 PM Hannes Reinecke <hare@suse.de> wrote:
>
> On 5/16/19 3:49 PM, Alibek Amaev wrote:
> > I have more example from IRL:
> > In Aug 2018 I was start server with attached storages by FC from ZS3
> > and ZS5 (it is Oracle ZFS Storage Appliance, not NetApp and also
> > export space as LUN) server use one LUN from ZS5. And recently on
> > server stopped all IO on this exported LUN  and io-wait is grow, in
> > dmesg no any errors or any changes about FC, no errors in
> > /var/log/kern.log* /var/log/syslog.log*, no throttling, no edac errors
> > or other.
> > But before reboot I saw:
> > wwn-0x600144f0b49c14d100005b7af8ee001c -> ../../sdc
> > I try to run partprobe or try to copy from this block device some data
> > to /dev/null by dd - operations wasn't finished IO is blocked
> > And after reboot i seen:
> > wwn-0x600144f0b49c14d100005b7af8ee001c -> ../../sdd
> > And server is run ok.
> >
> > Also I have LUN exported from storage in shared mode and it accesible
> > for all servers by FC. Currently this LUN not need, but now I doubt it
> > is possible to safely remove it...
> >
> It's all a bit conjecture at this point.
> 'sdc' could be show up as 'sdd' after the next reboot, with no
> side-effects whatsoever.
> At the same time, 'sdc' could have been blocked by a host of reasons,
> none of which are related to the additional device being exported.
>
> It doesn't really look like an issue with device naming; you would need
> to do proper investigation on your server to figure out why I/O stopped.
> Device renaming is typically the least likely cause here.
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Teamlead Storage & Networking
> hare@suse.de                                   +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG N=C3=BCrnberg)

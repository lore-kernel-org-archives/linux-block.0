Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EB4C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 20:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E7C64E79
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 20:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhBPUCX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Feb 2021 15:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhBPUCU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Feb 2021 15:02:20 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D3DC061574
        for <linux-block@vger.kernel.org>; Tue, 16 Feb 2021 12:01:39 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id a7so201471iok.12
        for <linux-block@vger.kernel.org>; Tue, 16 Feb 2021 12:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOqACjGFp8sKwyW9ipHj2tAPH/odX2tKu4e/iF/tp34=;
        b=IqT1E2S17KZdnYR/BShmIGNrHQ/nx0P9/fITU1iwl6RZhDGOrE4CPukuEJDKbCMrke
         zOIduNwJY3HUE16gS//s6HPFDwfGqjmXu6HckZrkngj9cWn+5IOeN8UvUgGs7kvr7HlQ
         NiITznLDoDMI1+BgZ2fxtp1PuK9nOhq7YZQBMIOfIzrzDZAlmBZBemILLeMY+5I3N3hD
         AxqeQDabn2WYTvWs46r3MGxULnvhkNQN5nrlWElHo1PgniylA3U4+Be/uDI/xAbCk4x1
         RQ89W3QIxaixGpyuBsLTMp0yI7ydWSJzJ1ugCTEzbAD32ZIZc05uO+xGXD3wKtaSmLdd
         w3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOqACjGFp8sKwyW9ipHj2tAPH/odX2tKu4e/iF/tp34=;
        b=VozBo95Cvc7Vdj+2PXjZHmMhtGVYusnbPrPzQi++5bc+gzX3L2fqPvtsePmn7IMb/R
         KOpC/k8qt9/oa+oZ8R5/F5yAZxJQbudzeGOgUWmrXGjepqsLqbTuKsbW00o3KNmbRJjj
         FQbDdBABWOG/Y609Ro4/l328gWmMsgB0+MQxePfopHTYysXZIYgdetjGiw3aue7dhEh+
         4MhONKP8QwD/SCkyM7cG91AVK4Y86Rkhd/j7Osz5WBNmdV7oszcyrwJP27PnsFVxOJTm
         jGsK/Y4yTjIrQTRRt+NQ9kuqz0tzfCvRiQVVP/RQuRjQJANkPRpM0tpALF/ptff72Wsa
         6eow==
X-Gm-Message-State: AOAM53221KAZ/1PgscpW3Qma4XUWtQnS+l4xL80DzRbVE33FTcfLtYbD
        RitdXkb3Pnw5BfJuOPbKb7mbJS1PrItHUpHHRjFPosE+9zYIbQ==
X-Google-Smtp-Source: ABdhPJykAcj/qjtmNpbGJMjXt/Li9O3N1VWhxgkEZQPRrVBFJDSEQyWeffcJRti+LzDNu58sehuY/DJGpXK29cZYgaU=
X-Received: by 2002:a02:cb4b:: with SMTP id k11mr8067447jap.10.1613505699311;
 Tue, 16 Feb 2021 12:01:39 -0800 (PST)
MIME-Version: 1.0
References: <CAARYdbiUBxFTY25VusuxgxqVzNRnoB61fFQeXcmsKyDP_d_ipQ@mail.gmail.com>
 <20210216123755.GA4608@lst.de>
In-Reply-To: <20210216123755.GA4608@lst.de>
From:   Tom Seewald <tseewald@gmail.com>
Date:   Tue, 16 Feb 2021 14:01:28 -0600
Message-ID: <CAARYdbjZgwKcJgMZx_6kvVH_CeTV04u21o8WGPprTP7mPOOYYg@mail.gmail.com>
Subject: Re: [Regression] [Bisected] Errors when ejecting USB storage drives
 since v5.10
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

Thank you for looking into this. I applied your patch to v5.11 but
unfortunately I am encountering the same errors when ejecting USB
drives.

e.g.
[   45.188575] sd 8:0:0:0: [sdc] tag#0 FAILED Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE cmd_age=0s
[   45.188584] sd 8:0:0:0: [sdc] tag#0 Sense Key : Not Ready [current]
[   45.188588] sd 8:0:0:0: [sdc] tag#0 Add. Sense: Medium not present
[   45.188592] sd 8:0:0:0: [sdc] tag#0 CDB: Read(10) 28 00 00 00 00 00
00 00 08 00
[   45.188594] blk_update_request: I/O error, dev sdc, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[   45.188601] Buffer I/O error on dev sdc, logical block 0, async page read

I am happy to test any patches you send my way.

Tom

On Tue, Feb 16, 2021 at 6:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> ... but you were using sd, not sr.
>
> Can you give this patch a spin?
>
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index a3d2d4bc4a3dcd..6671b4e1909777 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -2116,6 +2116,14 @@ static int sd_done(struct scsi_cmnd *SCpnt)
>                         }
>                 }
>                 break;
> +       case NOT_READY:
> +               /* Medium not present */
> +               if (SCpnt->device->removable && sshdr.asc == 0x3a00) {
> +                       req->rq_flags |= RQF_QUIET;
> +                       set_media_not_present(sdkp);
> +                       sdkp->capacity = 0;
> +               }
> +               break;
>         default:
>                 break;
>         }

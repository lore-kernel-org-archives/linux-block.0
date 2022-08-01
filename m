Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD470C00140
	for <linux-block@archiver.kernel.org>; Mon,  1 Aug 2022 01:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiHABgM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jul 2022 21:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiHABgL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jul 2022 21:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48A4ACE3C
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 18:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659317768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6KBPMwKZVa1dsJ4LlUl8lkVgB4Y5sRvXJ+4QRWttdgY=;
        b=JYXnaABGPU5q85S3lXCzmKDouZvQ+4acugKtKsxeS4B4ypQooB2IEu/yU/b8ZRKCul91MD
        Yy+38Ra7vjZj1JbdgIlN/bph1HivAgyFvhKOaud2DCEGOY/BvJ5zP4tBVhsN66AoSFnVwA
        Nz77MwgkMZO/vKb6aeCczyZnuYE6jFQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-JossgXFUP0imMec8ExIl5A-1; Sun, 31 Jul 2022 21:36:06 -0400
X-MC-Unique: JossgXFUP0imMec8ExIl5A-1
Received: by mail-ej1-f71.google.com with SMTP id sh10-20020a1709076e8a00b007307a683095so101711ejc.15
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 18:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KBPMwKZVa1dsJ4LlUl8lkVgB4Y5sRvXJ+4QRWttdgY=;
        b=m6JBwr8dxPmHyJOETGxuspIv3RMOOozSUdWLRmboM2LwpeiwdoaS0p8bHX9OpJVoYY
         iT+gv5V4rN0BGO1idWd0T9KcERYudIdWpsvvasw072vHbdcaFGCVTFlBMI/DHtQ3j/G9
         heXKmEWT3RMhqjjNjq+xQZ4NCYtUFGuKPHDs6MDZXuC6pvLqOoyaqXmpoWM9JvGVUd24
         +3BKL0o2zpxYj+og834g0RKtV1jDIUTuX9tJkbOKlKbpBsdo/gHIT2e0eAeorfn0Gvy0
         WfbrffykITRxlLzCQ2gQK8xXdF4MENIYDC5gYGsuXsbNcXxl8YKQpUk9U3N1UW3xCVzl
         AwgQ==
X-Gm-Message-State: AJIora+xQRtjYW0RmWqVsty0VEqZyJyGKNkH4GxfwuLIAd2RcuMR7tnu
        uJ7/P/YH4rqpRt6liP5/p3H4l3DHiECh4YTEh0tf+kg4mrmcxwGwEoD17eLS+EEz1S9VhgFDgdr
        o0diYdSjcof70l3T24VVeNpKVTATYKtAcCq1bvKE=
X-Received: by 2002:a05:6402:40d2:b0:43c:5a4d:c3b4 with SMTP id z18-20020a05640240d200b0043c5a4dc3b4mr13893877edb.95.1659317765639;
        Sun, 31 Jul 2022 18:36:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vJx1V41as4VdcjRbw8drJ1b6LxBBvfQk1B78z7VVAEowlBBfxcaoMxb78SQCzaGCPIkLGlyyE+4vRHvx4oyU8=
X-Received: by 2002:a05:6402:40d2:b0:43c:5a4d:c3b4 with SMTP id
 z18-20020a05640240d200b0043c5a4dc3b4mr13893869edb.95.1659317765469; Sun, 31
 Jul 2022 18:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220730075828.218063-1-yi.zhang@redhat.com> <20220801013038.y6napkax4w7ua7jp@shindev>
In-Reply-To: <20220801013038.y6napkax4w7ua7jp@shindev>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 1 Aug 2022 09:35:54 +0800
Message-ID: <CAHj4cs-paSYG+Tb5sLYweSMJ855+Obr91WLzvfOR84pSiQgCEw@mail.gmail.com>
Subject: Re: [PATCH v2 blktests] block/002: remove debugfs check while
 blktests is running
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 1, 2022 at 9:30 AM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> Hi Yi, thanks for this patch. I've been seeing the block/002 failure for a
> while. Happy to see it resolved.
>
> On Jul 30, 2022 / 15:58, Yi Zhang wrote:
> > See commit: 99d055b4fd4b ("block: remove per-disk debugfs files in blk_unregister_queue")
> >
> > Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> > ---
> >  tests/block/002 | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/tests/block/002 b/tests/block/002
> > index 9b183e7..15b47a6 100755
> > --- a/tests/block/002
> > +++ b/tests/block/002
> > @@ -25,9 +25,6 @@ test() {
> >       blktrace -D "$TMP_DIR" "/dev/${SCSI_DEBUG_DEVICES[0]}" >"$FULL" 2>&1 &
> >       sleep 0.5
> >       echo 1 > "/sys/block/${SCSI_DEBUG_DEVICES[0]}/device/delete"
> > -     if [[ ! -d /sys/kernel/debug/block/${SCSI_DEBUG_DEVICES[0]} ]]; then
> > -             echo "debugfs directory deleted with blktrace active"
> > -     fi
>
> Regarding the commit subject, I think the word "blktests" is to be replaced with
> "blktrace". As the removed echo command above shows, this patch removes the
> check while blktrace is running.

Agree, thanks.

>
> Also, I suggest to add one more sentence in the commit message for recording
> purpose:
>
>   This fix avoids the test case failure observed since the kernel commit
>   0a9a25ca7843 ("block: let blkcg_gq grab request queue's refcnt").
>
> If you don't mind, I will do the edits above when I apply this v2 patch.

Sure, feel free to help update the commit message when you apply it, thanks. :)

>
> --
> Shin'ichiro Kawasaki
>


-- 
Best Regards,
  Yi Zhang


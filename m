Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C227C677F1
	for <linux-block@archiver.kernel.org>; Sun, 15 Jan 2023 07:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjAOH4H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Jan 2023 02:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjAOH4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Jan 2023 02:56:06 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A67E44B1
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2023 23:56:03 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g205so1851086pfb.6
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2023 23:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7mPR+tYk06dWyheXQlcDvaKFF6VE45BY4pbiBRMyTf0=;
        b=3NkR14+qMITtW5c/bhsV3TZxEqserp/0VOuYZNP4g42CclG/xB4agcQEBFDlmIceTy
         Dnb+Gl8ZEbazw6K9BfxSDP353kv8wFoCOzjafOmUpIbb4bA7nygi/+rMVSO+5njloKYR
         CozVxIQlSZAJd9UjP1d+cle8o4s32xooYBqoBz9VDUN4Kv2V66W4gZ/lzxrzL1gZJnQp
         K0Y17q39OljeeFaoVglpyHwGXhK4Mt6LJ+78vfLmrPrS6m4q6R7Fp2b5nvw978ioGuYa
         DvfLxm5eVIN11nZKAUWWpvXXHr/Z67Zvf6tZ92vL3945LZ7OFwpYeJ/q/rEZb0zOV70O
         U5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mPR+tYk06dWyheXQlcDvaKFF6VE45BY4pbiBRMyTf0=;
        b=xWIbMEI/39GjrOcvsInH2OyD12+BgD2n5BcZWxkwNsxwAKKJUSTszkzLrg0Pe3yUM3
         HIHHb7cpGPgu0f2H9aB/gaa3KKkqIdnjklfdUGlxvqr0BTquSfDftCRDCb5QYdRXoeLn
         xBNdZ1VUS7SlUvWgaBWwWOZK8ubYvcKnoM2JYbXl/MigxZ8LnaY61FaeE9gAbG0Dbazu
         x+TJ0hukO0LNIoIfYDVIjvRC7HN05toCW0mJ4e+rUloGYRmaxvOWr1DJc7v+J4IbS0Hs
         HJbgM7E6EU6WX1ck3b8vCMdlxue7L4QR3C9zG26d4aDdv8f0BKIl1ckpjQkIxRjX6JND
         PGPg==
X-Gm-Message-State: AFqh2kp4y6dhE7d1EWwyYtGV8zXaoBBk+irF9HsLS8rhK5CNRqfroU9g
        n+mK7NMmSf9tIcz8zIunyJHC8XmF3EYM31dQ5iouETazxAvThYdN
X-Google-Smtp-Source: AMrXdXvAiyCmTWvJ9EHpfBDvUbeHLHSy+j5Yk8c2u2aPfRmZEEnLTIdJUxpu9gEHkkwwhxqg/OcINr2IlsC0dkOvol4=
X-Received: by 2002:a65:45c8:0:b0:48c:5903:2f5b with SMTP id
 m8-20020a6545c8000000b0048c59032f5bmr4778556pgr.504.1673769363038; Sat, 14
 Jan 2023 23:56:03 -0800 (PST)
MIME-Version: 1.0
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Sun, 15 Jan 2023 09:55:26 +0200
Message-ID: <CAJs=3_C+K0iumqYyKhphYLp=Qd7i6-Y6aDUgmYyY_rdnN1NAag@mail.gmail.com>
Subject: Virtio-blk extended lifetime feature
To:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, egranata@google.com,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi guys,

While trying to upstream the implementation of VIRTIO_BLK_F_LIFETIME
feature, many developers suggested that this feature should be
extended to include more cell types, since its current implementation
in virtio spec is relevant for MMC and UFS devices only.

The VIRTIO_BLK_F_LIFETIME defines the following fields:

- pre_eol_info:  the percentage of reserved blocks that are consumed.
- device_lifetime_est_typ_a: wear of SLC cells.
- device_lifetime_est_typ_b: wear of MLC cells.

(https://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html)

Following Michael's suggestion, I'd like to add to the virtio spec
with a new, extended lifetime command.
Since I'm more familiar with embedded type storage devices, I'd like
to ask you guys what fields you think should be included in the
extended command.

Thanks,

Alvaro

Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC29C3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 18:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B0222CF4
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 18:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJfj0iMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfHSSLI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:11:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36174 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfHSSLI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 14:11:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id d23so2216639qko.3;
        Mon, 19 Aug 2019 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QUo3vv/nySNtkH4c0ejok0wACVdS9AW/rtC9nJIa5ZM=;
        b=VJfj0iMxpeahYQMEN/7zlKXbBZDjF9zBVgVDxANzrksehdvUz7XgEtKf9Ea/tNl5Sr
         gZ2/6W19/E9GgzvlLV/hKct0W/NtqA2UnI3qbpeRPs902j64StagLGCGmn13bSQPLvV9
         dcPC4rpo/Y4jaUqW2LWcFO/lrd4YgLgt9d9Cjy8O4bvQzrrTFvFRdo00APQSPQDMOYdj
         06KVMu8jncjqAP8Uy3b/a2C9qcwizlFjyKqIBBmSOm/2FXn7zRdZRclOb1jiVTOLmCVn
         tknQVkPKGnMBKk4QtX/m0F8Y624pnE47/OBPKemYV01IOwa5e1iF3zJUywmUVCKKm0XH
         W1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUo3vv/nySNtkH4c0ejok0wACVdS9AW/rtC9nJIa5ZM=;
        b=T4RfC/vwTCc8D824gkVsuor9J2a8ZeVwyIrhInjnJYBttEJWAQBXnJxHf+LC1drSEf
         ULkfH8fHmTrX/TPgc5iwBfUzVNwffledudeFVbZtJP9pZmG1pkugScbZ2jmB11kkZ6zM
         7xd4kdDnFRecxtgx84tITCp+NBrPNPJiWopZFTywi5XrowoBiqMZT1AAttmTWgw+gPRG
         9O+8QBM9XLw/9RPkXqgS1EB3u4S5LipZNbqT/qBzHfdxnlVv5vEacuPnadnE4cvi2iNX
         zEJlaYj9tVbLyDqMEil6hRsyjS9stg5zYGS2lKA6JRZwu20MVAL6pWqYndGG3VoLoTQm
         c5Pw==
X-Gm-Message-State: APjAAAWSmeFUm9eF0CvhWpp0QBP4Y4GFihbepp41QiEty6lDVvG0H7cH
        N15Y3KPK2/kKKfPxGgA3RTZs9QOiML54BIKqK5k=
X-Google-Smtp-Source: APXvYqzLdH7ejeArb92iobT856dPrFHhyxu76ltyuadDWvLzMWNjn3Nho+gdzzKjbbLPdamdiOJQEobLjuXHwZdxQXs=
X-Received: by 2002:a37:a142:: with SMTP id k63mr22046145qke.487.1566238267635;
 Mon, 19 Aug 2019 11:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190816134059.29751-1-gpiccoli@canonical.com>
In-Reply-To: <20190816134059.29751-1-gpiccoli@canonical.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 19 Aug 2019 11:10:56 -0700
Message-ID: <CAPhsuW7aGze5p9DgNAe=KakJGXTNqRZpNCtvi8nKxzS2MPXrNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] md raid0/linear: Introduce new array state 'broken'
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        NeilBrown <neilb@suse.com>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 16, 2019 at 6:41 AM Guilherme G. Piccoli
<gpiccoli@canonical.com> wrote:
>
> Currently if md raid0/linear array gets one or more members removed while
> being mounted, kernel keeps showing state 'clean' in the 'array_state'
> sysfs attribute. Despite udev signaling the member device is gone, 'mdadm'
> cannot issue the STOP_ARRAY ioctl successfully, given the array is mounted.
>
> Nothing else hints that something is wrong (except that the removed devices
> don't show properly in the output of 'mdadm detail' command). There is no
> other property to be checked, and if user is not performing reads/writes
> to the array, even kernel log is quiet and doesn't give a clue about the
> missing member.
>
> This patch changes this behavior; when 'array_state' is read we introduce
> a non-expensive check (only for raid0/md-linear) that relies in the
> comparison of the total number of disks when array was assembled with
> gendisk flags of those devices to validate if all members are available
> and functional. A new array state 'broken' was added: it mimics the state
> 'clean' in every aspect, being useful only to distinguish if such array
> has some member missing. Also, we show a rate-limited warning in kernel
> log in such case.
>
> This patch has no proper functional change other than adding the
> 'clean'-like state; it was tested with ext4 and xfs filesystems. It
> requires a 'mdadm' counterpart to handle the 'broken' state.
>
> Cc: NeilBrown <neilb@suse.com>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>

If we merge this with the MD_BROKEN patch, would the code look simpler?

Thanks,
Song

Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED50C433FF
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 21:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3882067D
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 21:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5N5XV/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfGaVHz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:07:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43215 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfGaVHz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 17:07:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id w17so23646508qto.10;
        Wed, 31 Jul 2019 14:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVs/vyQ7FGVG4RTAjLbBzwKgO6T77q0zizvqZWReG4U=;
        b=h5N5XV/6OzpHcXrprkzwKaYmJNAD9E8RdEvB+YK0FrlqjphI8KIf7oYowR11IArgLk
         88GJaOD/tMG54niEk7uFAUi66JZCPn+OJkRq3zPNN/KYAmb0rsZ2FpMe6vk+5EoCmN4O
         1mUcGpSPVxXH68CKu+HAhTRbBso352YVX3klLp+TdTF2bV5QNFdIddc8hpz9Bh6ljy+M
         y8I2BKGTyIIxhGXzv/Lx5gt+riMvMtc2cTzhU3sqkrQwRS5ZlO8F2CLlDiP+F2FCiBpo
         PGUJBB+NTy/FuqG/6vALo6kpveZd09LjDljEeXZxaOGN293ojUIRuCxnAzlrO24slLk0
         6EPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVs/vyQ7FGVG4RTAjLbBzwKgO6T77q0zizvqZWReG4U=;
        b=fFDmTA0qwLdKjWIQyhLE0Rprxo0X2k+a81ppzjlM5DsXivlrdKH+1vCs7A4w7xXdTm
         ofqMAceptasUVAxu/DCbzbezWQVFTF0Xm1a+2bHsSMVBttOSm5F7LwAwpS+qa+wym88Y
         2WYW+ktMUuDchcg3T2/YymqRyJxZ9xPdhzqqH1H6ioJTK3OHjxM+KELX8/b/26gMavpN
         E9Z5YynzqkkmKhNLLAv+hbcUegp7nmYHsvRNE6HcWxjNMGSVPCTbrOLTfl8nty1PJm/3
         H7m3dA4+sP+Z2UZ4lq8dbMErJqrX0om/oImqxO3LSZZRTSN5zAJ84Eq0qTORJSSX6I/g
         6zpw==
X-Gm-Message-State: APjAAAXukP71F4/AiFBIrcB2uq9vC+WF8Kz1GCJF8wSFVjSSPgW0exWE
        k3sEpiYbTq+gAIMHCulE1JmV7d5ZUmnKoHv/5pY=
X-Google-Smtp-Source: APXvYqy4QvtrszYJsHl599Ic3SuR88R8Eufu4CdNo+IYoKhGrYyNtuaYcaEFwl3crNQGDCHIWfL5uXK87UIOeU0HklE=
X-Received: by 2002:ac8:25e7:: with SMTP id f36mr87328163qtf.139.1564607274505;
 Wed, 31 Jul 2019 14:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190702132918.114818-1-houtao1@huawei.com> <CAPhsuW6yH7np1=+e5Rgutp3m1VA0TPvtANeX=0ZdpJaRKEvBkQ@mail.gmail.com>
 <b047c187-e4a6-a82a-3177-3da7fef2f6b8@huawei.com>
In-Reply-To: <b047c187-e4a6-a82a-3177-3da7fef2f6b8@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 31 Jul 2019 14:07:43 -0700
Message-ID: <CAPhsuW5c96vQDiwbPhDvKOG8_XkPapW62bkthPAHFOum2N2VhQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] md: export internal stats through debugfs
To:     Hou Tao <houtao1@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, NeilBrown <neilb@suse.com>,
        linux-block@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        agk@redhat.com, dm-devel@redhat.com,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 26, 2019 at 10:48 PM Hou Tao <houtao1@huawei.com> wrote:
>
> Hi,
>
[...]
> >
> > Hi,
> >
> > Sorry for the late reply.
> >
> > I think these information are really debug information that we should not
> > show in /sys. Once we expose them in /sys, we need to support them
> > because some use space may start searching data from them.
> So debugfs is used to place these debug information instead of sysfs.

I don't think we should dump random information into debugfs. It is common
for the developers to carry some local patches that dumps information for
debug. We cannot get these patches upstream.

Thanks,
Song

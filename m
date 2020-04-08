Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCA1C2D0EA
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 12:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78952074F
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 12:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB6JIMCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgDHMTT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:19:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46763 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgDHMTT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 08:19:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id g74so2824222qke.13
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2020 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NVTELMYjXgVLoLs43MP5pps+p0/+MK0jceWllGzIGU0=;
        b=EB6JIMCSbVRlWPY3CVqCTRe9fznlpmwccxHBlH+nFQHqMhK1JjAM9eiASFfdwl66JD
         o12RhWfbdh+PJ6HZENbuixoYlwBys2Bkg1Nppo5Leba/ks/4OCe6q34h7g77+1KDlWud
         m6bHiw4qND5rF9Su+xb14FZOns6tTZbX2SNuDupmm4MSjAItkAsA3H4DGLfnHHfQXTa1
         wn3BRRi/gFl0LydmgS6+BWWOMiJCwL5Nm3t7FeNaLDg5IUjuVeDfRpOFtEoEcji0Y2k0
         +5FbYHSd8VM1tK+svnx0+DX9rVX5altJNoGNRTPPMipnNIF5LuxwoheqZVUW0YWcM43A
         3FBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NVTELMYjXgVLoLs43MP5pps+p0/+MK0jceWllGzIGU0=;
        b=EjtR+eRBVcDK2ogLtcCuIVBPYytxnMYJ0RlCqvrGmChdrLX/cVllYQavrT6AWo99Qq
         fPPofMj0/hd4OSZNwdIGae4o+/5nQ2AinnilwfKLXbpTPJScOrAiQS0QePVIPpQ7pQhc
         QEv50saJ7rgnZFMMVn1jBT7ZB4KJ+xqLJoJCeomMf05TFAym6RJySGdX7pqO43lsjvRu
         cpcpV6xPWE2hYtF08AVSI0q0Z8rgLTvRoYiI3N/EbPylrWVZ8NAm3NMPULX5IqIMYDoU
         KYipg2SLHF0zW/0Bq1QSd5whViEdv4ThftqAG8aGQZ3+whn8IUZhGa7nx/fAm8JjWFT9
         DhIA==
X-Gm-Message-State: AGi0PubkY6Njgj+MXYBB+QNmHV9YBjfNxZjc8Ydo21Lv2xiArv8b/LOF
        Z1UpKnToiT+dmUBig0aCTmfPN/ZXIa1lYanYQ14=
X-Google-Smtp-Source: APiQypI/JWuiuEEo2hKeVLp/oRrJOjcx2X+LRnF1IVVbyVcrMFcdmXrh9DO2iq0COwJJsxP1W6aGI55hxM6H41MKfXE=
X-Received: by 2002:a37:8b04:: with SMTP id n4mr7283548qkd.222.1586348354811;
 Wed, 08 Apr 2020 05:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200407141621.GA29060@192.168.3.9> <BYAPR04MB49657AC1B762EA5450AA178986C30@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB49657AC1B762EA5450AA178986C30@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 8 Apr 2020 20:19:03 +0800
Message-ID: <CAA70yB7Z8bkQAaPy+u8FPme4Y34O6CTw=YCXEJ+_W57M1CxzFg@mail.gmail.com>
Subject: Re: [PATCH blktest] nvme/033: add test case for nvme update hardware
 queue count
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>,
        "osandov@osandov.com" <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> =E4=BA=8E2020=E5=B9=B44=E6=
=9C=887=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8811:32=E5=86=99=E9=81=
=93=EF=BC=9A
>
Hi Chaitanya,
Thanks your review

> > +     # backup old module parameter: write_queues
> > +     file=3D/sys/module/nvme/parameters/write_queues
> > +     if [[ ! -e "$file" ]]; then
> > +             echo "$file does not exist"
> > +             return 1
> > +     fi
> can we skip the test ? I think Omar added a feature to skip the test.

What feature can be used here, I don't see any rc file "set -e".
> > +     old_write_queues=3D"$(cat $file)"
> > +
> > +     # get current hardware queue count
> > +     file=3D"$sys_dev/queue_count"
> > +     if [[ ! -e "$file" ]]; then
> > +             echo "$file does not exist"
> > +             return 1
> > +     fi
> Same here.
> > +     cur_hw_io_queues=3D"$(cat "$file")"
> > +     # minus admin queue
> > +     cur_hw_io_queues=3D$((cur_hw_io_queues - 1))
> > +
> > +     # set write queues count to increase more hardware queues
> > +     file=3D/sys/module/nvme/parameters/write_queues
> > +     echo "$cur_hw_io_queues" > "$file"
> > +
> Shouldn't we check if new queue count is set here by reading
> write_queues ?
Most of time, this parameter will not equal to io queue_count,
if really so, it will makes this test case be more complicated.

> > +     # reset controller, make it effective
> > +     file=3D"$sys_dev/reset_controller"
> > +     if [[ ! -e "$file" ]]; then
> > +             echo "$file does not exist"
> > +             return 1
> > +     fi
> I think we need to add a helper to verify all the files and skip the
> test required file doesn't exists. Also, please use different variables
> representing different files.
The reason why use same variable name $file, is that copy and paste
code(check file exist or not).

If common/rc include "set -e", all these checks can be removed.

> > +     echo 1 > "$file"
> > +
> > +     # wait nvme reinitialized
> > +     for ((m =3D 0; m < 10; m++)); do
> > +             if [[ -b "${TEST_DEV}" ]]; then
> > +                     break
> > +             fi
> > +             sleep 0.5
> > +     done
> > +     if (( m > 9 )); then
> > +             echo "nvme still not reinitialized after 5 seconds!"
> > +             return 1
> > +     fi
> > +
> > +     # read data from device (may kernel panic)
> > +     dd if=3D"${TEST_DEV}" of=3D/dev/null bs=3D4096 count=3D1 status=
=3Dnone
> > +
> This should not lead to the kernel panic. Do you have a patch to fix
> the panic ? If not can you please provide information so that we can
> fix the panic and make test a test which will not result in panic ?
>
The patch is under the review, for more detail please visit:
https://patchwork.kernel.org/patch/11476409/
> > +     # If all work well restore hardware queue to default
> > +     file=3D/sys/module/nvme/parameters/write_queues
> > +     echo "$old_write_queues" > "$file"
> > +
> > +     # reset controller
> > +     file=3D"$sys_dev/reset_controller"
> > +     echo 1 > "$file"
> > +
> > +     # read data from device (may kernel panic)
> > +     dd if=3D"${TEST_DEV}" of=3D/dev/null bs=3D4096 count=3D1 iflag=3D=
direct status=3Dnone
> > +     dd if=3D/dev/zero of=3D"${TEST_DEV}" bs=3D4096 count=3D1 oflag=3D=
direct status=3Dnone
> Just a write a helper for dd command instead of hard-coding it.
I think dd is simple enough.
> > +
> > +     echo "Test complete"
> > +}
> > diff --git a/tests/nvme/033.out b/tests/nvme/033.out
> > new file mode 100644
> > index 0000000..9648c73
> > --- /dev/null
> > +++ b/tests/nvme/033.out
> > @@ -0,0 +1,2 @@
> > +Running nvme/033
> > +Test complete
> >
>
Thanks

Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B6EC4332F
	for <linux-block@archiver.kernel.org>; Wed,  4 Jan 2023 18:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjADSNT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Jan 2023 13:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbjADSNT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2023 13:13:19 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BCF1868E
        for <linux-block@vger.kernel.org>; Wed,  4 Jan 2023 10:13:18 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v23so36926022pju.3
        for <linux-block@vger.kernel.org>; Wed, 04 Jan 2023 10:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3238GOgdzYvLUkwGduiCin/jQ5W4csnMOltJpcP5lgc=;
        b=SEks4YIcDioYNcOyvBe67wOz2RjzPmk0snfIRAGUp0ITdgC1beNvm1nyTpPAFYKFg/
         Pk0FNrmJgHH4Kz2lf/PflSIRwEOcp4MORRn0V7bmIPLiM3cbxP8Xfm6pbtJGYqP4bxyc
         gRh3LKkROZ3cCs2hhcOujcH/abZrCvT+Z3Ph0p91MNgKCt8leDDjf6YEvDnf+3mXmirF
         9s4HNyp9BADosq4hGJ6qs+mdnoKpg2Q37NvCM6aaDh2ymm0MtLDdjRPuejlml50j6Z3u
         C50tkFw2nDVgKssiwf3cqRlGhM1RlZfP8AUgjm7gVOIFujSEMBeEaJUnobJBafo/ul13
         ZBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3238GOgdzYvLUkwGduiCin/jQ5W4csnMOltJpcP5lgc=;
        b=AoKYfs1EygT3bUja2en8NgLIBGjZWg27nznvEJCFN4Af8mKdu8fPYcSdeIVAHPMjjE
         aYcfLh2ln4YVXjhigZYOINA+vSMbstinArZAYkjoYNju2w3p62kdjknQrL/tDlDxuuAr
         ZIyndmWaYrpv3iRyJU0OWfx2AY2Z/WZeURlC8eggVO2yYONzoxBCLuGS6o0GGEwX/6T+
         PNpw91sF8kSDbMXaZrKn+g+4rT9SExi7lRzJ3weFpz0xQNqBon0cec32T+R0W+wYWxzf
         ZM6SmwUtdNWfN43IGnX5ksk0BgFe9WFai11IbfuUZVJYfkyK66F5KDojCAlGZWW/dWYN
         MY8A==
X-Gm-Message-State: AFqh2krXW2LlVfCp+YChVEQ0qivyLpLrlYdXcJ4T/BlLkQZLSZKrWzvl
        DWDa/gEDV7jUq73imTCLfS0=
X-Google-Smtp-Source: AMrXdXtJcQlb/Oi65SBw7xR42PsMiDLWOGqSdNLZRC1/LO2EKPl8bMfRFGs0nk/1eTnJmvbQ1U3g1A==
X-Received: by 2002:a05:6a20:2d22:b0:b0:30d8:d48 with SMTP id g34-20020a056a202d2200b000b030d80d48mr63153453pzl.42.1672855997674;
        Wed, 04 Jan 2023 10:13:17 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id x184-20020a6363c1000000b004784cdc196dsm20855064pgb.24.2023.01.04.10.13.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jan 2023 10:13:17 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: Potential hang on ublk_ctrl_del_dev()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <Y7URsuwxaAHFmn8S@T590>
Date:   Wed, 4 Jan 2023 10:13:05 -0800
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <20EBDD77-21AD-4C39-B1F2-E9A9954FA360@gmail.com>
References: <862272BC-C6A3-4A60-A620-4C5596972D01@gmail.com>
 <Y7URsuwxaAHFmn8S@T590>
To:     Ming Lei <ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Jan 3, 2023, at 9:42 PM, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> On Tue, Jan 03, 2023 at 01:47:37PM -0800, Nadav Amit wrote:
>> Hello Ming,
>>=20
>> I am trying the ublk and it seems very exciting.
>>=20
>> However, I encounter an issue when I remove a ublk device that is =
mounted or
>> in use.
>>=20
>> In ublk_ctrl_del_dev(), shouldn=E2=80=99t we *not* wait if =
ublk_idr_freed() is false?
>> It seems to me that it is saner to return -EBUSY in such a case and =
let
>> userspace deal with the results.
>>=20
>> For instance, if I run the following (using ubdsrv):
>>=20
>> $ mkfs.ext4 /dev/ram0
>> $ ./ublk add -t loop -f /dev/ram0
>> $ sudo mount /dev/ublkb0 tmp
>> $ sudo ./ublk del -a
>>=20
>> ublk_ctrl_del_dev() would not be done until the partition is =
unmounted, and you
>> can get a splat that is similar to the one below.
>=20
> The splat itself can be avoided easily by replace wait_event with
> wait_event_timeout() plus loop, but I guess you think the sync delete
> isn't good too?

I don=E2=80=99t think the splat is the issue. The issue is the blocking =
behavior,
which is both unconditional and unbounded in time, and (worse) takes =
place
without relinquishing the locks. wait_event_timeout() is therefore not a
valid solution IMHO.

>=20
>>=20
>> What do you say? Would you agree to change the behavior to return =
-EBUSY?
>=20
> It is designed in this way from beginning, and I believe it is just =
for
> the sake of simplicity, and one point is that the device number needs
> to be freed after 'ublk del' returns.
>=20
> But if it isn't friendly from user's viewpoint, we can change to =
return
> -EBUSY. One simple solution is to check if the ublk block device
> is opened before running any deletion action, if yes, stop to delete =
it
> and return -EBUSY; otherwise go ahead and stop & delete the pair of =
devices.
> And the userspace part(ublk utility) needs update too.
>=20
> However, -EBUSY isn't perfect too, cause user has to retry the delete
> command manually.

I understand your considerations. My intuition is that just as umount
cannot be done while a file is opened and would return -EBUSY, so should
deleting the ublock while the ublk is in use.

So as I see it, there are 2 possible options for proper deletion of =
ublk,
and actually both can be implemented and distinguished with a new flag
(UBLK_F_*):

1. Blocking - similar to the way it is done today, but (hopefully) =
without
   holding locks, and with using wait_event_interruptible() instead of
   wait_event() to allow interruption (and return EINTR if interrupted).

2. Best-effort - returning EBUSY if it cannot be removed.

I can imagine use-cases for both, and it would also allow you not to
change ubdsrv if you choose so.

Does it make sense?


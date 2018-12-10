Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E35C65BAF
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 08:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A5920855
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 08:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="Zr354+pK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A5920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeLJIaM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:30:12 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46045 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLJIaL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 03:30:11 -0500
Received: by mail-vs1-f65.google.com with SMTP id v10so6098283vsv.12
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 00:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JidYYcQH8PULTMRh6flUyBj/GTbuL2/3Hm9Jr5lQHXc=;
        b=Zr354+pKkjCSnukYF6XbT2mJk3thntHAW6FuL1ecuiOGsSqhImH1sRimG5FLNRcXLw
         kPCUrmTADIBKkY6EgrTkbWxy2RGqU14tFJJX0VySdURm1a9NHFb/7gvmMdqZBu6uLewb
         N7LgSMrRaGKXkLs4Il5i67oVepB9JKLvNVqzGFf3XoTxH3Ojit8iSd/HX6FC92Jw2btj
         PtmPoACvvNr+Lrs/ZKcPcpOoNUmd35caBT5Q9pVMFssicSdZ1ZptJ2mYnlhvK3w7wVum
         G3jb0MwRpdwJiBo86JDhITltNCVkMrWTrI7pcr1vqpaI2jR2q5coqCCLEN4SvLOMBoiN
         s22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JidYYcQH8PULTMRh6flUyBj/GTbuL2/3Hm9Jr5lQHXc=;
        b=UA4T+rBhsdLFlOp6UhRE0yzPGTwqOiRMRw95IG557MJ7Jhjs/kh12utYBGKam2P+M2
         2bvXxO7HKaQt6IOCk3o19ZYvkBVazpGIUSKVLcJYvL3+ScUJzS57SGqnASNE0eQ1umzu
         /kKrBTzxNs0d3qnlUcoO4yUFGQpdWbJS++Wp5ExerbYSMWmO8UN0z1rshVj5on5qBjEl
         WBrN0hBCjMx/apJDA1s2lmO8HiCgWutBmXHsIgXKnmOxNamcwhbYQVuD5UlS1r2Gefns
         asG26xZ2JeQ/Di2iIjNW52WoUCM50n9UGUg+fEN7AASzdDd4/68p3yuhMpN2D/lQJhWn
         8ImQ==
X-Gm-Message-State: AA+aEWZjIs0lpG68KrD2mBIO5YIZa8QHsaobrKIK7HPvgKnktcwAhs+A
        yL+KoeLCdPm54Y0X8qjoLpA0iH0etMTt3YdTdKcDGw==
X-Google-Smtp-Source: AFSGD/UfARy/84P2NWeMi2NgAPvJx+2wnMXiSfjuTM/fiyOXD0okRWIDe1m0gBVyPTJq3F2Y7FSgM1/0pm0zD03J3Yw=
X-Received: by 2002:a67:24c6:: with SMTP id k189mr4888023vsk.16.1544430610144;
 Mon, 10 Dec 2018 00:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20181206154559.5642-1-igor.j.konopko@intel.com>
 <20181206154559.5642-2-igor.j.konopko@intel.com> <A790DB4E-9DD0-40CE-94D9-631E0C28D2D6@cnexlabs.com>
 <0f219bd6-fd49-5d13-f0e2-af8fe7749127@lightnvm.io> <8DCB397C-5A0E-4E85-AEDF-70A8603FC7EF@cnexlabs.com>
In-Reply-To: <8DCB397C-5A0E-4E85-AEDF-70A8603FC7EF@cnexlabs.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 10 Dec 2018 09:29:59 +0100
Message-ID: <CANr-nt2jRfJnZiUyxZPhySpJogyy4ROxWKb6BjMDk2UzMig9BA@mail.gmail.com>
Subject: Re: [PATCH 2/2] lightnvm: pblk: Ensure that bio is not freed on recovery
To:     Javier Gonzalez <javier@cnexlabs.com>
Cc:     Matias Bjorling <mb@lightnvm.io>, igor.j.konopko@intel.com,
        linux-block@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I ran a set of regression tests on one of our cards (with metadata
support) and some block stress tests in qemu(simulating a drive
without metadata) on for-4.21/core
(e805f4c9e74ab75e925927feee9887b1c6e50e8d)
All good.

Tested-by: Hans Holmberg <hans.holmber@cnexlabs.com>
On Fri, Dec 7, 2018 at 1:13 PM Javier Gonzalez <javier@cnexlabs.com> wrote:
>
>
> > On 7 Dec 2018, at 13.03, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
> >
> > On 12/07/2018 10:12 AM, Javier Gonzalez wrote:
> >>> On 6 Dec 2018, at 16.45, Igor Konopko <igor.j.konopko@intel.com> wrot=
e:
> >>>
> >>> When we are using PBLK with 0 sized metadata during recovery
> >>> process we need to reference a last page of bio. Currently
> >>> KASAN reports use-after-free in that case, since bio is
> >>> freed on IO completion.
> >>>
> >>> This patch adds addtional bio reference to ensure, that we
> >>> can still use bio memory after IO completion. It also ensures
> >>> that we are not reusing the same bio on retry_rq path.
> >>>
> >>> Reported-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >>> ---
> >>> drivers/lightnvm/pblk-recovery.c | 12 ++++++++++--
> >>> 1 file changed, 10 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk=
-recovery.c
> >>> index 009faf5db40f..3fcf062d752c 100644
> >>> --- a/drivers/lightnvm/pblk-recovery.c
> >>> +++ b/drivers/lightnvm/pblk-recovery.c
> >>> @@ -376,12 +376,14 @@ static int pblk_recov_scan_oob(struct pblk *pbl=
k, struct pblk_line *line,
> >>>             rq_ppas =3D pblk->min_write_pgs;
> >>>     rq_len =3D rq_ppas * geo->csecs;
> >>>
> >>> +retry_rq:
> >>>     bio =3D bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
> >>>     if (IS_ERR(bio))
> >>>             return PTR_ERR(bio);
> >>>
> >>>     bio->bi_iter.bi_sector =3D 0; /* internal bio */
> >>>     bio_set_op_attrs(bio, REQ_OP_READ, 0);
> >>> +   bio_get(bio);
> >>>
> >>>     rqd->bio =3D bio;
> >>>     rqd->opcode =3D NVM_OP_PREAD;
> >>> @@ -394,7 +396,6 @@ static int pblk_recov_scan_oob(struct pblk *pblk,=
 struct pblk_line *line,
> >>>     if (pblk_io_aligned(pblk, rq_ppas))
> >>>             rqd->is_seq =3D 1;
> >>>
> >>> -retry_rq:
> >>>     for (i =3D 0; i < rqd->nr_ppas; ) {
> >>>             struct ppa_addr ppa;
> >>>             int pos;
> >>> @@ -417,6 +418,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk,=
 struct pblk_line *line,
> >>>     if (ret) {
> >>>             pblk_err(pblk, "I/O submission failed: %d\n", ret);
> >>>             bio_put(bio);
> >>> +           bio_put(bio);
> >>>             return ret;
> >>>     }
> >>>
> >>> @@ -428,19 +430,25 @@ static int pblk_recov_scan_oob(struct pblk *pbl=
k, struct pblk_line *line,
> >>>
> >>>             if (padded) {
> >>>                     pblk_log_read_err(pblk, rqd);
> >>> +                   bio_put(bio);
> >>>                     return -EINTR;
> >>>             }
> >>>
> >>>             pad_distance =3D pblk_pad_distance(pblk, line);
> >>>             ret =3D pblk_recov_pad_line(pblk, line, pad_distance);
> >>> -           if (ret)
> >>> +           if (ret) {
> >>> +                   bio_put(bio);
> >>>                     return ret;
> >>> +           }
> >>>
> >>>             padded =3D true;
> >>> +           bio_put(bio);
> >>>             goto retry_rq;
> >>>     }
> >>>
> >>>     pblk_get_packed_meta(pblk, rqd);
> >>> +   bio_put(bio);
> >>> +
> >>>     for (i =3D 0; i < rqd->nr_ppas; i++) {
> >>>             struct pblk_sec_meta *meta =3D pblk_get_meta(pblk, meta_l=
ist, i);
> >>>             u64 lba =3D le64_to_cpu(meta->lba);
> >>> --
> >>> 2.17.1
> >> Both patches in this series look good, but since they are fixes to the
> >> patches you sent for this window, I would suggest that you merge them
> >> into the original set and resend. We can then test the series again an=
d
> >> make sure there are no regressions from V1.
> >> Matias: would this work for you? The current series in your branch is
> >> broken as is.
> >> Thanks,
> >> Javier
> >
> > I've applied 1 (v2) separately since it did not merge cleanly with the
> > lightnvm: pblk: add helpers for OOB metadata patch. 2 has been merged
> > with the "lightnvm: pblk: support packed metadata" patch.
>
> Cool. Thanks. We will tests if this fixes the regressions on V4.
>
> Javier

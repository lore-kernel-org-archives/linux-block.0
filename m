Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D968DC433FF
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 16:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26AD20663
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 16:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmurf-com.20150623.gappssmtp.com header.i=@cmurf-com.20150623.gappssmtp.com header.b="Ig3ZzK+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfHMQmh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:42:37 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:45777 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfHMQmh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 12:42:37 -0400
Received: by mail-lf1-f51.google.com with SMTP id a30so14150431lfk.12
        for <linux-block@vger.kernel.org>; Tue, 13 Aug 2019 09:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmurf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=9/me9AyG3+z6/xBlLhKMnSijxn45CKmb1z2Iv3P/dzo=;
        b=Ig3ZzK+fbGTSrw/5GbSSMVy9Zpdv88Boor0HPHtvGm4xnqukiJtymfGX6EEzU+bEY5
         +3UQje/xQPKXY5vwfyb+7cAx6IXN0AlPJSn4xN12tTlL2vGLSCa4zglEWXavBVRmyZLz
         DmfkPwBXmPee++bW8uSKrCBlPIKYatsIakfZ6nrz01wuoQH8oAKAYDTr9c2RspXTOn66
         5wdlxUJlYA97iSFZRPD0HdzQb8pHNN+SusaQtQyz8OZJW2sRzPXdYxk2cqgvDb48B6oi
         mMGHwt5pt8XKgdGIrJgU9dJfjO+MJrI+52GKESoxpo9cuC2sjvTjLvVCKgLPUV0+GAtM
         6S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9/me9AyG3+z6/xBlLhKMnSijxn45CKmb1z2Iv3P/dzo=;
        b=jScuDthpGY2FpzhYFttmJ/BJRGWcfx7BoeY9x76PGjGn75/7my0sfANsyDnLDFAwu1
         OKXiJiKz8HWrW0fdQ4troqNXnU43Nn1ncOyaaVNvYvjHSJX9uFd9zFWFtR20/ZxV2YsZ
         Dh+iuhJZLBchIu+I+r7ly3qhTGBa+u87DhzZuyBBeSyk7FepkTG6MjPpgv7PPJnVd0gP
         fcV9lT2x2S2olk7EKyZplkGcwOb0LAeUVnEy5qvb0S3BMER66yCbHNYbBfunpvxAWQCe
         aiC0LJlttLCtHexn6w/N9PNEY1VDF26IZ7ibqup7O2MUtU0q9H3rjeQ91TvFVGrd5F+o
         RyRg==
X-Gm-Message-State: APjAAAU6a/DlW7Vz78YQpqGL33T3P83n8M8CzwlTF6fqJmaUGPwIm1s4
        GcgHqOJm6VowkbjH7G0s0y0cCvWem8seTL9YfeYsKEO9B6YYCA==
X-Google-Smtp-Source: APXvYqw2K8dKfpIRXdKZX8OSLXlp1MPn/llit6XOxB44tETSUpS4EgaAG3Gghx+coNXEVqpLvP++tkH3h6qzlylZ7uU=
X-Received: by 2002:a19:9111:: with SMTP id t17mr23000185lfd.113.1565714554325;
 Tue, 13 Aug 2019 09:42:34 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <chris@cmurf.com>
Date:   Tue, 13 Aug 2019 10:42:23 -0600
Message-ID: <CAMN_aZAEVowMRhjrODJ1wrnMK6jejqBipciyxWSJx6i+8SmrQQ@mail.gmail.com>
Subject: [bug] segfault btrfs fi usage on seed sprout
To:     Btrfs BTRFS <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

segfault 'btrfs fi usage' on two device btrfs seed+sprout volume
https://bugzilla.kernel.org/show_bug.cgi?id=204569

kernel 5.2.8
btrfs-progs 5.2.1

'btrfs fi show' does work:
Label: 'first'  uuid: f7638175-SNIP
        Total devices 2 FS bytes used 841.10GiB
        devid    2 size 1024.00GiB used 882.00GiB path /dev/mapper/first
        devid    3 size 698.62GiB used 2.06GiB path /dev/mapper/sdc

devid2 is the seed
devid3 is the sprout

Mount options
/dev/mapper/first on /mnt/first type btrfs
(rw,noatime,seclabel,space_cache=v2,subvolid=5,subvol=/)

'btrfs fi usage /mnt/first' crashes with segmentation fault and no
other messages

dmesg shows
[126052.599013] btrfs[14847]: segfault at 7ffe5e1e1018 ip
000000000046db14 sp 00007ffe5e1df1a0 error 4 in btrfs[40c000+7c000]
[126052.599034] Code: 28 48 c7 40 08 00 00 00 00 48 8b 74 24 08 48 89
70 18 48 8b 74 24 10 48 01 70 08 48 83 c3 20 48 3b 5c 24 18 0f 84 12
ff ff ff <48> 8b 2b 41 8b 0e 85 c9 7e 95 49 8b 17 8d 41 ff 48 c1 e0 05
48 8d



-- 
Chris

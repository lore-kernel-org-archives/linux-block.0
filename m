Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6EAC678D4
	for <linux-block@archiver.kernel.org>; Wed,  1 Mar 2023 23:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjCAXeZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Mar 2023 18:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCAXeY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Mar 2023 18:34:24 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2E448E1B
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 15:34:18 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c19so16244451qtn.13
        for <linux-block@vger.kernel.org>; Wed, 01 Mar 2023 15:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aTFrKEj59EWRAdE7B9d0V6M6gJORe8geA2ShFDoI4rs=;
        b=n2TUG0mQCcusVAXCXwdjP0lPJTkG7TnYeftmG7wHkswuZ1JX2LUcveuyr82U1aw2YI
         mU751AejvD6JQT6U9SY8IJWU8zJD2LabJYeQRqT7bYFRcYp1S4reLEqCkt3eOHIHeA/a
         DrSQhx/YCZjb0XGS1rt87kwBIKgQEo1CNmDk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTFrKEj59EWRAdE7B9d0V6M6gJORe8geA2ShFDoI4rs=;
        b=vtd9OGE+66oxvh56kOtNl4BRPVhONjWGxf1j1mSJ9w609ucTgmfsEokiZw82dGPCZE
         ihrVyR2Yk6Rb7PPGJyR+j51SSechLubb6zy6juh7nLJpH3ZvK3s4o8UCvhN4xl05kOfe
         OLKu8Xb3HkD1DUTt9kpgohsY9CismwnfLrbF6TpqTUV8DcQ6cC+Kh7WR39FZ+8Q4FW09
         0B7oVcC9yzaeU4n7RRu0aQt6LAdVg5DaGbEwKf1m3FjXJ5Uro5bkds+Is/peNPMLB550
         9giiHqZtcgNzCL69cF3ohYaDpr88bN360s4wOfYM22RMezuYaHrGeSTqflP2nDuoUWot
         TdOw==
X-Gm-Message-State: AO0yUKUOd9pxCMQmZqr5Yvl92eO8V4TjyftDEVoUDZGiFG8LYEEuaYZm
        UpsqZyw5J2ejwOq1VSV6FuZwfCOO2Ei698s6
X-Google-Smtp-Source: AK7set8yR454/43rcD8ESoZ/5yRy0IUEjzmDym0WXK5ghDDuiHQQcrK4qo/ppkUGmGWWfJI7u2Z/YA==
X-Received: by 2002:a05:622a:1985:b0:3b9:ca95:da6e with SMTP id u5-20020a05622a198500b003b9ca95da6emr14296561qtc.44.1677713657164;
        Wed, 01 Mar 2023 15:34:17 -0800 (PST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id e1-20020ac86701000000b003bfb1416c2bsm9176396qtp.96.2023.03.01.15.34.16
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 15:34:16 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id d75so5441533qkg.0
        for <linux-block@vger.kernel.org>; Wed, 01 Mar 2023 15:34:16 -0800 (PST)
X-Received: by 2002:a05:620a:7f8:b0:742:6fd1:3344 with SMTP id
 k24-20020a05620a07f800b007426fd13344mr2029252qkk.12.1677713655972; Wed, 01
 Mar 2023 15:34:15 -0800 (PST)
MIME-Version: 1.0
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Wed, 1 Mar 2023 15:34:04 -0800
X-Gmail-Original-Message-ID: <CACGdZYKXqNe08VqcUrrAU8pJ=f88W08V==K6uZxRgynxi0Hyhg@mail.gmail.com>
Message-ID: <CACGdZYKXqNe08VqcUrrAU8pJ=f88W08V==K6uZxRgynxi0Hyhg@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Hybrid SMR HDDs / Zone Domains & Realms
To:     lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

HSMR HDDs are a type of SMR HDD that allow for a dynamic mixture of
CMR and SMR zones, allowing users to convert regions of the disk
between the two. The way this is implemented as specified by the SCSI
ZAC-2 specification is there=E2=80=99s a set of =E2=80=9CCMR=E2=80=9D regio=
ns and =E2=80=9CSMR=E2=80=9D
regions. These may be grouped into =E2=80=9Crealms=E2=80=9D that may, as a =
group, be
online or offline. Zone management can bring online a domain/zone and
offline any corresponding domains/zones.

I=E2=80=99d like to discuss what path makes sense for supporting these
devices, and also how to avoid potential issues specific to the =E2=80=9Cmi=
xed
CMR & SMR IO traffic=E2=80=9D use case - particularly around latency due to
potentially unneeded (from the perspective of an application) zone
management commands.

Points of Discussion
=3D=3D=3D=3D

 - There=E2=80=99s already support in the kernel for marking zones
online/offline and cmr/smr, but this is fixed, not dynamic. Would
there be hiccups with allowing zones to come online/offline while
running?

 - There may be multiple CMR =E2=80=9Czones=E2=80=9D that are contiguous in=
 LBA space.
A benefit of HSMR disks is, to a certain extent, software which is
designed for all-CMR disks can work similarly on a contiguous CMR area
of the HSMR disk (modulo handling =E2=80=9Cresizes=E2=80=9D). This may resu=
lt in IO
that can straddle two CMR =E2=80=9Czones=E2=80=9D. It=E2=80=99s not a probl=
em for writes to
span CMR zones, but it is for SMR zones, so this distinction is useful
to have in the block layer.

 - What makes sense as an interface for managing these types of
not-quite CMR and not quite SMR disks? Some of the featureset overlaps
with existing SMR support in blkdev_zone_mgmt_ioctl, so perhaps the
additional conversion commands could be added there?

 - mitigating & limiting tail latency effects due to report zones
commands / limiting =E2=80=9Cunnecessary=E2=80=9D zone management calls.

Thanks,
Khazhy

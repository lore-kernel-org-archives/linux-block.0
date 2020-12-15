Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83558C4361B
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 19:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BEBA22B2C
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 19:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbgLOTMG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 14:12:06 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51355 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731862AbgLOTL7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 14:11:59 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B1145C006C;
        Tue, 15 Dec 2020 14:11:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 15 Dec 2020 14:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:subject:message-id:mime-version:content-type; s=
        fm3; bh=EK1QHIxkYbOgCW7uVGbCDZ1p8urBhqb2EMvSkYyJh1I=; b=VTd9Ql3r
        7Hs5X4kzL3m4qvz+JA+Lp5ERIv65XIt7VKF9rRSiFKv90r+HqV1KGYvlgltIU9zN
        1yOmGHIFXg099MLL7W0pQH0Z9NfL2fDiuBY5wTWltS8Fcp9o0S1fy1Kf+EYU4vK0
        8k5oLzC2gUSXlNUZ9Fsfw6+U71iGEeKbAfhrrxa5KSBKsPIhU4yRmXO10/XOP2wY
        8U20H1laILDRo7aS6i57Z7aZPIKcdhALKf5Pitx3Hx7MlsoXo6HG4ISq09sFas98
        k2ZboyN2E3QYYgdHJuy8yTkRD7gelGiCFeJW/XlNCQDUxB5dYwHpp1+6IAwLHdFI
        tdFN14DcehMIZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=EK1QHIxkYbOgCW7uVGbCDZ1p8urBh
        qb2EMvSkYyJh1I=; b=n6hbQ1YlpZ4mN+Gu7XUcDJmdf3K50wWTGVDNGV/DhNnzl
        ksjD61E8+UVt4LmfV4BNEXXgmQ3hWxEL0fl5uQ6AF0z6NoOPWCtRLU6aJJbeBcsx
        Xj0iEZBlrj+6qjXoY5c1nnTDd+qgs61aroSuxVoyF599+x9DdDWcfri0L/akDep5
        JOjPwiOI3kCGrGcQT8mxR3KY7chI3WgwOVwf9yS/gINnHK6KMgv6Yc05n9g7CtPh
        LKhZaMuDD29JXeCvFWISxyI0yN3BejfNoovoqd4WmyXsE/JhdgX/vXTebEKEcy9x
        J1VH+zK6QchXtxRK+s+zt8xKI5+n34b17k2N4+mOA==
X-ME-Sender: <xms:TArZX5BwyYEx-b2yFMUK77BK3SqR0kMvB_KmlHru6KN6v99rm6b35Q>
    <xme:TArZX1VbxrtUt5uSv0PY2tCGMUIddeAZE8Vi-O9X5kN4n92WtytowuEpmygOktXz6
    32YzPa-1-FN5HXUdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeltddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkgggtugesthdtredttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrfgrth
    htvghrnhepiedvieelgeeuuedtfeduhfefteehhfevvdeljeetgfeugfdtledtudetvdeh
    keffnecukfhppeeijedrudeitddrvddujedrvdehtdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghlrdgu
    vg
X-ME-Proxy: <xmx:TArZX_B2IL9n5RHgmlzHTQlRZWnyJQrBmkoDNoZYa-p3coXLeS1CHw>
    <xmx:TArZXw-ShJ9YkntHHDfPgFJiVAnBk053Bi4qTy5MkFkEtkWlLIaUtw>
    <xmx:TArZX-G9ajaaDJ3eY276Xv54S0sztIJM4P_oisQ6-W5v2OFUvk6SMw>
    <xmx:TQrZXzPUcWwQxRIv0afCncI2EBJgumAwQFcZXfhjAxKfKJfdBb0xOg>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id 518D424005A;
        Tue, 15 Dec 2020 14:11:08 -0500 (EST)
Date:   Tue, 15 Dec 2020 11:11:06 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Allow use of fua to be disabled on per-device basis?
Message-ID: <20201215191106.egw3nitgmbhvgqxs@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I have a few Samsung NVMe SSDs where FUA (i.e. REQ_FUA) is a slower than
full device cache flushes (i.e. REQ_PREFLUSH). I would like to be able
to disable use of FUA for those.

As a first step, would it make sense to add write support to
/sys/block/*/queue/fua?

The biggest issue with that is that it seems like it'd be preferrable to
only allow enabling fua if the underlying device supports that, and that
that information isn't currently stored anywhere but QUEUE_FLAG_FUA.

The easiest way to deal with that would be to split QUEUE_FLAG_FUA into
QUEUE_FLAG_FUA_HW and QUEUE_FLAG_FUA_ENABLED, and have
blk_queue_write_cache() set QUEUE_FLAG_FUA_ENABLED to
QUEUE_FLAG_FUA_HW. Then the new blk-sysfs.c queue_fua_set() would only
allow setting QUEUE_FLAG_FUA_ENABLED if QUEUE_FLAG_FUA_HW is availabl.e

Does that roughly make sense?


In a second step it could be reasonable to add an nvme quirks indicating
slow FUA for those devices? But I'll leave that for later...

Greetings,

Andres Freund

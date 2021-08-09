Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AB1C4338F
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 20:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D21160F25
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 20:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhHIUbY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhHIUbY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Aug 2021 16:31:24 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F88C0613D3
        for <linux-block@vger.kernel.org>; Mon,  9 Aug 2021 13:31:02 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id C3FA0B84BDB;
        Mon,  9 Aug 2021 22:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1628541059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cMS4qo9MblMEMHUnxQHCM0iE50Iq0UeoR3Jy3Whq0r8=;
        b=VBWNQpfyUSE/G4kkuY5PoMN6sgpa1rUnOcsOU54nszAM/wZFDyo6asLDCI7UBs0JOBtMS8
        aXgaogUYwDY2t9AnE39tPqiQZT61XuitblKuxBhKI1Nxo6KSTKodCa/cE5LcDjtYZonvWb
        Y1RYjK7fe078vF6fWGvVd8SMNjVJPEY=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: return ELEVATOR_DISCARD_MERGE if possible
Date:   Mon, 09 Aug 2021 22:30:56 +0200
Message-ID: <2418399.CND23VilKT@natalenko.name>
In-Reply-To: <YQtcZHgE1cTl+KVz@T590>
References: <20210729034226.1591070-1-ming.lei@redhat.com> <YQtcZHgE1cTl+KVz@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

On =C4=8Dtvrtek 5. srpna 2021 5:35:00 CEST Ming Lei wrote:
> On Thu, Jul 29, 2021 at 11:42:26AM +0800, Ming Lei wrote:
> > When merging one bio to request, if they are discard IO and the queue
> > supports multi-range discard, we need to return ELEVATOR_DISCARD_MERGE
> > because both block core and related drivers(nvme, virtio-blk) doesn't
> > handle mixed discard io merge(traditional IO merge together with
> > discard merge) well.
> >=20
> > Fix the issue by returning ELEVATOR_DISCARD_MERGE in this situation,
> > so both blk-mq and drivers just need to handle multi-range discard.
> >=20
> > Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
>=20
> Hello Jens and Guys,
>=20
> Ping...

Ping v2 here=E2=80=A6 I'm still running a couple of affected systems with t=
his patch,=20
and the issue doesn't pop up any more.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)



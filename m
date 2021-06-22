Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C0FC2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C1F6101D
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFVHh0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 03:37:26 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:59530 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhFVHhZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 03:37:25 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 6D68AAF0331;
        Tue, 22 Jun 2021 09:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1624347308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VQY43XfF1eGOpJRIeL+dJv5ARRW165CgSB5vjpwXo2s=;
        b=Gec3eyTte4Wcs6813cr1LrK6cr43dH8FrYi9m8eETh9PynloTYNjLcYsBFtXLYkyWxtJX9
        XjtbKl2fykFNFJLxeZTUfG4uhZZ19mBilGu86xwpkVlxj4/cH9v/qrbdd3Nslib4sPP+7R
        9nYnQvhDI83w3vzHBlDoFiJl6H+SWa4=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Mariotti <mariottiluca1@hotmail.it>,
        Holger =?ISO-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Pietro Pedroni <pedroni.pietro.96@gmail.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Khazhy Kumykov <khazhy@google.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH FIXES/IMPROVEMENTS 0/7] block, bfq: preserve control, boost throughput, fix bugs
Date:   Tue, 22 Jun 2021 09:35:05 +0200
Message-ID: <8003699.Qy64SzLKsf@spock>
In-Reply-To: <2CDC43F9-9CD9-4F7F-BD36-CCEB168B5245@linaro.org>
References: <20210619140948.98712-1-paolo.valente@linaro.org> <3533087.dJKXTdksHR@spock> <2CDC43F9-9CD9-4F7F-BD36-CCEB168B5245@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

On =C3=BAter=C3=BD 22. =C4=8Dervna 2021 9:08:43 CEST Paolo Valente wrote:
> CCing also Jan and Khazhy, because in your commit log I see also the
> commit on bfq_requests_merged().
>=20
> Is this OOPS reproducible for you?

No, I haven't found a reproducer, at least yet. It took half a day of uptim=
e=20
to hit this, so might not be that easy.

=2D-=20
Oleksandr Natalenko (post-factum)



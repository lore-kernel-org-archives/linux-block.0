Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE39CC49EA2
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 17:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC81F61360
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 17:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhFVR2v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 13:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbhFVR2u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 13:28:50 -0400
X-Greylist: delayed 77447 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Jun 2021 10:26:34 PDT
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3683C061756;
        Tue, 22 Jun 2021 10:26:34 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 26F85AF15BA;
        Tue, 22 Jun 2021 19:26:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1624382793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/jl1lZ86jFUUXH/ABUzJSq4C2zlwk6QLR2iPXI/BnU=;
        b=qTB4RmxQASXEX2qWc1m2ZFYvuVScXp68rg5ykkoa08rX1UduVife2B+rgg8/OOVYjiTsXs
        Q6VJYMFNGssXOB1iqbDjiUmk9KeX8Ww3bBwtGsI9kLAmKRsj4aj8FsEXtts23KAx3ziYHd
        xYxlTflqvsSadaqWzOWAL4NjKP2fbG4=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Jan Kara <jack@suse.cz>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Mariotti <mariottiluca1@hotmail.it>,
        Holger =?ISO-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Pietro Pedroni <pedroni.pietro.96@gmail.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Khazhy Kumykov <khazhy@google.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH FIXES/IMPROVEMENTS 0/7] block, bfq: preserve control, boost throughput, fix bugs
Date:   Tue, 22 Jun 2021 19:26:31 +0200
Message-ID: <1829163.dQHRSAV4G1@spock>
In-Reply-To: <20210622162948.GJ14261@quack2.suse.cz>
References: <20210619140948.98712-1-paolo.valente@linaro.org> <8003699.Qy64SzLKsf@spock> <20210622162948.GJ14261@quack2.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ahoj.

On =C3=BAter=C3=BD 22. =C4=8Dervna 2021 18:29:48 CEST Jan Kara wrote:
> On Tue 22-06-21 09:35:05, Oleksandr Natalenko wrote:
> > On =C3=BAter=C3=BD 22. =C4=8Dervna 2021 9:08:43 CEST Paolo Valente wrot=
e:
> > > CCing also Jan and Khazhy, because in your commit log I see also the
> > > commit on bfq_requests_merged().
> > >=20
> > > Is this OOPS reproducible for you?
> >=20
> > No, I haven't found a reproducer, at least yet. It took half a day of
> > uptime to hit this, so might not be that easy.
>=20
> Hum, if you can acquire a crash dump it would be the easiest I guess. We'd
> need to find out more about the request we crash on - whether it's
> otherwise valid, in what state it is etc...

Yes, I understand that. Once (and if) I reproduce it reliably, of course.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)



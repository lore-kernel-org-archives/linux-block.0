Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A721DC001B0
	for <linux-block@archiver.kernel.org>; Mon,  7 Aug 2023 16:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjHGQFI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjHGQFH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Aug 2023 12:05:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BDCE72;
        Mon,  7 Aug 2023 09:05:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6763121BE2;
        Mon,  7 Aug 2023 16:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691424304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bZVNSk8gsvl9GSo4kwNnLBVbqlAJHs7wB7A03Nfoabw=;
        b=tLr4BsfQPa66NZGbldX+FsBuWy8uUvhq4m+aLl58MfSznsenCiXd5FpEyS4kc0k0PQs4qV
        hWNXdEB6SVgQQnAKCpwcc1eRudbynnYMp/6R1VaLjBh7tb+yC9kdm2NIvRJg8u/Iszbsxy
        qnDbvnciKsnQT4t83hLK4O0IHfEKgFQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3474013910;
        Mon,  7 Aug 2023 16:05:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cebtCzAW0WTYZgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 07 Aug 2023 16:05:04 +0000
Date:   Mon, 7 Aug 2023 18:05:02 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Li Lingfeng <lilingfeng@huaweicloud.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        yukuai3@huawei.com, linan122@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng3@huawei.com
Subject: Re: [PATCH -next] block: remove init_mutex in blk_iolatency_try_init
Message-ID: <o6nnp6jwzpchlqsiusbioqsyaml2fonxzmzi46yrycjgtq6hyb@ixqiysu6lmpe>
References: <20230804113659.3816877-1-lilingfeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="env6f55kcvztiepj"
Content-Disposition: inline
In-Reply-To: <20230804113659.3816877-1-lilingfeng@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--env6f55kcvztiepj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Fri, Aug 04, 2023 at 07:36:59PM +0800, Li Lingfeng <lilingfeng@huaweiclo=
ud.com> wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
>=20
> Commit a13696b83da4 ("blk-iolatency: Make initialization lazy") adds
> a mutex named "init_mutex" in blk_iolatency_try_init for the race
> condition of initializing RQ_QOS_LATENCY.
> Now a new lock has been add to struct request_queue by commit a13bd91be223
> ("block/rq_qos: protect rq_qos apis with a new lock"). And it has been
> held in blkg_conf_open_bdev before calling blk_iolatency_init.
> So it's not necessary to keep init_mutex in blk_iolatency_try_init, just
> remove it.

I'm looking at ioc_cost_model_write() or ioc_qos_write() where is
a similar pattern.
Could the check+init be open-coded back to iolatency_set_limit() to make
code more regular?

Michal

--env6f55kcvztiepj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZNEWLQAKCRAGvrMr/1gc
jn1dAQCk1LWQd+a/FX05jNIsP4otfvuL+JS3d6sEDyf0vMaFygEAjLDMi1OjT7uC
fEqCGPmP6loMuSnafbXji32xymoC8QQ=
=98HQ
-----END PGP SIGNATURE-----

--env6f55kcvztiepj--

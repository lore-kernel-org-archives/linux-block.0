Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D3BC61DA4
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 15:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBFPAK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 10:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFPAJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 10:00:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2984C644;
        Mon,  6 Feb 2023 07:00:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61EE73E968;
        Mon,  6 Feb 2023 15:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675695607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CHr5Q9e/qYSR9V7lQvVbstMTRujY37JvhtvhbDdNFhc=;
        b=enJco1GFYEfekNRXGEjHa1Y2bGfrnhXYglwlqDZW2Sv4Qk1qm0y4/4RCCjo+Xihi+IuVOA
        ePgWSGg1LBdHFyZfUnbe0cAI60zlC54RcqWcKG6Xrrc3Y8s61rAy4aQkl18x0CDEKO1L4L
        cUoroXDioBA0ZPiMfXdkUlPZrOoTikY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31B37138E8;
        Mon,  6 Feb 2023 15:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kZVBC/cV4WOAXAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 06 Feb 2023 15:00:07 +0000
Date:   Mon, 6 Feb 2023 16:00:05 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Ofir Gal <ofir.gal@volumez.com>
Cc:     ming.lei@redhat.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, yi.zhang@huawei.com, yukuai3@huawei.com,
        Ofir Gal <ofir@gal.software>
Subject: Re: [PATCH -next] blk-throttle: enable io throttle for root in
 cgroup v2
Message-ID: <20230206150005.GA21332@blackbody.suse.cz>
References: <YgMxjyVjMjmkMQU5@T590>
 <20230205155541.1320485-1-ofir.gal@volumez.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20230205155541.1320485-1-ofir.gal@volumez.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 05, 2023 at 05:55:41PM +0200, Ofir Gal <ofir.gal@volumez.com> w=
rote:
> I have tried to limit the SSD on Server #1, but it seems that the NVME
> target kworkers are not affected unless I use Yu Kuai's patch.
>=20
> Can you elaborate on the issues with this patch or how the scenario
> described above can be done with cgroups v2?

The issue is that if there's a client that doesn't implement
self-throttling you cannot guarantee anything on the server side.
Hence the mechanism must exist on the server side.

The NVME target should charge IO to respective blkcg's (just a generic
advice, I'm not familiar with that interface; see also
kthread_associate_blkcg() use in loop device driver).

HTH,
Michal

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCY+EV8wAKCRAkDQmsBEOq
uYzSAQC5yFq4obBPBxGW7dUITuiVPv6Svw5a8kySKrK/nZPGYAD+KRMo99VYj9Y2
xbYlmja7pXl+uBz41omMQ8YYSzDE2Ag=
=Ujhj
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

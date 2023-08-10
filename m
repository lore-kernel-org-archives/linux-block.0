Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2412BC41513
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 08:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjHJI7v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 04:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjHJI7u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 04:59:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038692115;
        Thu, 10 Aug 2023 01:59:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B4B041F749;
        Thu, 10 Aug 2023 08:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691657988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jy/YCn0JOglkNZoKf+HHCofDjT30/Uw6kt1m0VyWxSM=;
        b=aAu4rrdfNPSY9/SthNOTGY4CcP4k23StpfFeloLpGY6m0J63bPGetURM2yapPQ5RR377Sw
        un1UUxcQIlFfbIE8OayE0qBIBWs4wra2XowlN5r+AHzYeAmm+zdW5doEF8qSmj4iq/0XmX
        2l4+ypNoD3XdbgUreuByjoX5UuAXuuY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7811A138E2;
        Thu, 10 Aug 2023 08:59:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fUtwHASn1GRDcwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 10 Aug 2023 08:59:48 +0000
Date:   Thu, 10 Aug 2023 10:59:47 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Li Lingfeng <lilingfeng@huaweicloud.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        yukuai3@huawei.com, linan122@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, lilingfeng3@huawei.com
Subject: Re: [PATCH -next v3] block: remove init_mutex and open-code
 blk_iolatency_try_init
Message-ID: <5n6ti5ym5ean7nk3meul4nzpd6poimyfx5hn3mfj436k64qkz3@uzhut3yeszcu>
References: <20230810035111.2236335-1-lilingfeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hj4duincgs2uethd"
Content-Disposition: inline
In-Reply-To: <20230810035111.2236335-1-lilingfeng@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--hj4duincgs2uethd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 11:51:11AM +0800, Li Lingfeng <lilingfeng@huaweiclo=
ud.com> wrote:
> ---
>   v1->v2: open-code blk_iolatency_try_init()
>   v2->v3: add lockdep check
>  block/blk-iolatency.c | 35 +++++++++++------------------------
>  1 file changed, 11 insertions(+), 24 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

Thanks.

--hj4duincgs2uethd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZNSnAQAKCRAGvrMr/1gc
jssIAP0S+pqij21mDTM9cHk5Ner222D9hnl4pzbvxyJZSBlg2gD/V7I3A4pTZgvm
sK+hU4OXge5gDrsskiOKZkE19TZpHgM=
=CNhy
-----END PGP SIGNATURE-----

--hj4duincgs2uethd--

Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE09C31E4A
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 19:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E192133D
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 19:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfFMT6m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:58:42 -0400
Received: from sauhun.de ([88.99.104.3]:44532 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfFMT6m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 15:58:42 -0400
Received: from localhost (p5486CF99.dip0.t-ipconnect.de [84.134.207.153])
        by pokefinder.org (Postfix) with ESMTPSA id 669B74A127B;
        Thu, 13 Jun 2019 21:58:40 +0200 (CEST)
Date:   Thu, 13 Jun 2019 21:58:40 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     joro@8bytes.org, axboe@kernel.dk, ulf.hansson@linaro.org,
        wsa+renesas@sang-engineering.com, hch@lst.de,
        iommu@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [RFC PATCH v6 5/5] mmc: queue: Use bigger segments if IOMMU can
 merge the segments
Message-ID: <20190613195839.GE6863@kunai>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1560421215-10750-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Content-Disposition: inline
In-Reply-To: <1560421215-10750-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -	blk_queue_max_segments(mq->queue, host->max_segs);
> +	/* blk_queue_can_use_iommu_merging() should succeed if can_merge = 1 */
> +	if (host->can_merge &&
> +	    !blk_queue_can_use_iommu_merging(mq->queue, mmc_dev(host)))
> +		WARN_ON(1);
> +	blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));

Maybe we could use WARN here to save the comment and move the info to
the printout?

-	blk_queue_max_segments(mq->queue, host->max_segs);
+	if (host->can_merge)
+		WARN(!blk_queue_can_use_iommu_merging(mq->queue, mmc_dev(host)),
+		     "merging was advertised but not possible\n");
+	blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));


--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0Cqu8ACgkQFA3kzBSg
KbadfhAAq7Or22NlUZ69xSQh5IjO2ZwQHROwTG9rZwvQ6FkHsCRSuNihBVPuo4u/
uRaX75NEkDQYl8RjRKFluOKjLQH/TSjqSkQu3f82ZozJrgWJJ06FcWLzr7HSWfzO
Lox+7B6vk23pAjwnC5JDMNf2gBxAu5ZsZA2frkHTUYfZMS26zWxw5PKaB9INsuM7
IMzNO5J84ZMNpZitbBDb6p0MecEadseBi2SXnxFL+wTIksuLFHfZbaBRsf0sXF1/
Sy/GlZ1kQ6t8C+zjx525Y2c1rLaZSvRSQhXh0e+gaJ83U9rd+dgvyhd6xvz5Vn5k
Iqh2RS2U8iTQRUTUFXJwk/AOCYK3SkK6UdqWZESlQFLS6odUcLxub4Ux3hwve1xi
ql2C7s/EiVz7KB0HD6blLUoTvIgFnPcvL2UdxoHLGrhfU+k0tSGSh2NpIDTAuO+f
tBE8KQ3V4Mgjxm1ygYnnsdUYC7jMdxgcrz6xZHU2EwvOmyKvI8mwMDpJoIiK/xAn
BwZ7vU+IFG0QJ5X19QbRNGz4It86dWpaeQbWBvEX8kL+bg/2N2TJGtwHBaWCJgHQ
YBZjIeGm/0cM0psHWxuMyYjA2F4X2K7TQGBcBG8+CBD6hLvyV1Jgdrj8lzk1JKnk
V1tWov7zFB7ikEeybIsHBXXw6/jBx/cFz09yslcLeno79gh1Lx8=
=GBvH
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--

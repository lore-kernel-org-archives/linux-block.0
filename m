Return-Path: <SRS0=54qS=R3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005A8C43381
	for <linux-block@archiver.kernel.org>; Sun, 24 Mar 2019 09:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF2F21741
	for <linux-block@archiver.kernel.org>; Sun, 24 Mar 2019 09:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553418711;
	bh=iAzV3yUmG70CBC/tUbEk+4CM5j8K4sFFs2wduRWC3qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r0z1gbA6MQy75YL/oOvydqgyg4E2ccCIVjGKAzMJ5sr0o2ajzImktV2HnHjO7mrdK
	 F9uS2y7J07eKLubSYJ1TVwVc8232sbozmZtbm4r6ef9zaCDb97zs3R0X+DsdTWw9bz
	 aAKgS4tHxZg2UqTtz7IYTYNOpAjDnMETEfxEQqlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfCXJLu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Mar 2019 05:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfCXJLu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Mar 2019 05:11:50 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F5BD2171F;
        Sun, 24 Mar 2019 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553418709;
        bh=iAzV3yUmG70CBC/tUbEk+4CM5j8K4sFFs2wduRWC3qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C7tTZosOV3ZpF2kLFD5L4Y9p5WJAkLcfLUq5uD2pIoO8bnTz6MUnoOhPum7rSxZox
         qnt1jQgCrY+1Nb843+1Sgstj4ARh+OP27iAunn5VA7CGdxmqFGXAykp0d24LyQb6Jt
         xPqEldCm8JlDHqxe48d8VpAIwikDYdqUpVYK6By0=
Date:   Sun, 24 Mar 2019 11:11:46 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tal Gilboa <talgi@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Idan Burstein <idanb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
Message-ID: <20190324091146.GZ4823@mtr-leonro.mtl.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
 <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
 <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
 <50b3659d-fd88-85b0-755e-49565fbe98c2@mellanox.com>
 <89a41878-c88b-c0a2-64ef-4409b907ece6@mellanox.com>
 <4c7b78ff-e906-8e67-c3ad-495b858ce82c@grimberg.me>
 <226b674a-8ccb-864a-6153-be38ebcc3133@mellanox.com>
 <20190320111058.GU4823@mtr-leonro.mtl.com>
 <6599b66b-04d8-13e0-905a-9ab3862b30f5@grimberg.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vDEbda84Uy/oId5W"
Content-Disposition: inline
In-Reply-To: <6599b66b-04d8-13e0-905a-9ab3862b30f5@grimberg.me>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--vDEbda84Uy/oId5W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 20, 2019 at 11:34:27AM -0700, Sagi Grimberg wrote:
>
> > It doesn't sound reasonable that we have per-ULP feature (DIM is
> > per-ULP) to be configured globally. Especially given the fact that
> > users can find themselves running different workloads with different
> > requirements on the same system.
> >
> > Currently each ULP has some sort of tool to configure itself and I think
> > that once ULP is converted to use DIM, it should have on/off knob in the
> > tool used by their users.
>
> Its not any different than socket options that can have a global sysctl
> knob that can be overridden by individual socket consumers.

Right, but there is a major difference between socket example and
your proposal.

Combination of socket option with general knob gives you maximum
versatility in order to disable/enable/configure through program
or through some sensible default. In your proposal, you will limit
yourself to some system wide default, without any ability to override
it specifically for your load.

Thanks

--vDEbda84Uy/oId5W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcl0nSAAoJEORje4g2clinFTcQAMUh0hYQcyUcKj1te6V95YL8
qIGHGvOmYNitbN2sKijNUWfgebW4ehmQTtl62dq/zoN1Y0BYtsXnDoDHuao1rdg+
BaEz6yM6v8ut1ukZ6xnayexrYp1hHGHmXl85qHL/PGcR0yHWd2/XvZDXC2oTs8aS
SkkPay/LBYcMxZJF38c2AkFDrZhux4hukE8E2l5Xiclyj3QKccb/TRR3E/vpzTcB
GkMfg0iTV7XYLXB0REMsfT2fbsH1O3AneE9CDP6HZMwDN49/Ev6jNaXx9w8K3WLd
uV5olgk67XMpyJzbNROmJrbvWp1GaMxagVHuRuMxxb4CdMSgZWej/49qvzrtEitk
KRPC2ZEsTUrMEVFIlu/prALqud6UdNVL9T065Np86j+t+tz+AJeIVVWhqStV7WPR
qwLVfd8UjXvVJ2OgUNyw0FANLW7l9sjOK2XajVEAX4kXbATtkWB6lwssX6vDVsOV
YhwDezrYJZcZDgH1HzuwCjkuf2aTR4trmqtxFnLqpbYZeo3UlWPYJnxk5UH5u9Lb
RU5G8/ld+o52QbsdDZSQ6q+RjeFbZvrBBpVHE0sP7JPWRoX6gp8jM4KPV7GVLFER
h6MiFqSAitmwTN9nmeYzzRYPhQq9x0/zmkfAwd/0lPWBGPBBKKgLMZsbgbCZIbLQ
VA+itmD38e7U6PqLdbVe
=LeWq
-----END PGP SIGNATURE-----

--vDEbda84Uy/oId5W--

Return-Path: <SRS0=4R18=SX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A33C282DD
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 02:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F273F208C0
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 02:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfDUCMX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Apr 2019 22:12:23 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15]:17595 "EHLO
        sender4-op-o15.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDUCMX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Apr 2019 22:12:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555812738; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=iIBnsXrFbn33XxwvE7J5otEwOhqBNZuBax2v2uSUHu8NdWTuItUY5R2GOpjKKMQ15v+nfpEHl/EsB2eNog2dVAAhtCEyy8JamMzzL27U/X5yxCVMd80ATNiQrw0SSABg4YY08hFjrGVxvrgz9wXhSChdXzZCAxZz2pZoy5AJY+I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1555812738; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=kcrZnyKe+cSyy7l8Z+HyMZUwHfF1Nk1IzOz/ZH4ZuRA=; 
        b=Wr2Vhw+MfTN0GATJcmR6fC5USZ6qgcKB+fnmxOzGKv2OesjC0miMVWoQfLzo0KWjDISdbWVeAvz4EVNebMMSkITt2e5JyuccRNJS7kqGU8/Pf3o/MRLRKANxkTkb7bQDRBpJaDJo8TxYs9uNYJnPZ8umeCN3Z/PgP4DJYJ6Ahag=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from localhost (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 155581273705882.71176716925459; Sat, 20 Apr 2019 19:12:17 -0700 (PDT)
Date:   Sun, 21 Apr 2019 02:02:31 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] io_uring: fix bad free in io_sqe_files_register
Message-ID: <20190421020231.GA17831@nessie>
References: <20190421014245.17652-1-dan@dlrobertson.com>
 <20190421014245.17652-2-dan@dlrobertson.com>
 <7519f82a-3973-c092-3d65-ed7e8e6d7efc@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <7519f82a-3973-c092-3d65-ed7e8e6d7efc@kernel.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Awesome! Sorry for the noise.

Cheers,

Dan

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAly7zzcACgkQRcSmUsR+
QqURPBAAuSpn1L3qFQ/5HDfroD243Ag2f7awaxST7MYM6I9enuzNrbFv+GCC0KKE
IZrT10ELrY1RJ5IJhhtXdHH/qjd90YxsT2MbbCoGGx987JgFBUVZxy4DFMkBnmy2
75WE6s+BpJH/hZLYY1fzaKO1A15sEl852gD4lgng8Nhkl7WSTDowXsDuhjgUGUhm
PgWWezkl7Y1MTbVSD/pjpPgS1u+izc3BUZCHjvnrW8ZBgQ54vXBhcauPl5b99T8Z
pxlNAkmfGOet/QS00+Qp/Yie/hB+lRrXSuEHrJlD5UzEuOygEj3+FcsI9kEvyogq
VbuZE5BLTacbBh56XxdFu9gWAjcTeDB3CI+/h2MpZy2Em7ifwPeJGMs+w/m6a7Qm
SjRODEynvmtotm6DNxAXascaVd5za13YsJRC3ZCRtIX3BJ9W/wiLE1m//GgeO/wN
64qkD3dXcE3KLcZhrbuEQFpnDJYVnmJqj+vucMgVCd39Vi83Igpwit/YF+W/GUBI
mjPYl3CPLyYj8oATY2WcFzC4hgteZuj1LDwdPCP9ocvO1wNgM0lLM5+YAlWH3bLT
rQIPltOhGRDf9WTUSdnJhbAk9BRCGp/ZInRIYTRdUua8Qm3aEKMCbLrqJb57KNDN
2jdk1bChz54XADy2sStbWrf2neJ+lfl5UYeiqUkL9TvJscyMzjo=
=xhcu
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--


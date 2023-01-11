Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DAFC5479D
	for <linux-block@archiver.kernel.org>; Wed, 11 Jan 2023 06:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjAKGJ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Jan 2023 01:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjAKGJU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2023 01:09:20 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3630ADF35
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 22:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673417359; x=1704953359;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xCs/n9rDQqS+vdn0jPiYAiFA43IssZ/nNVsVQCyf6QU=;
  b=n63gdjszXmdZtXkt/Fzz4yurxBSpeoc49oQ4ylScSUOVYivOMcpCA6Xh
   s/8tynaTZb2QdGz46Py+QqVpUpO/ApI6YH9OqB/cjTJNechrz4L3qW+gn
   fjlQLFyYdzstxucdGzTcAUJBQm6eyLb5acivR3lO3Dv+noYKyC6vHZs9a
   oXwbK/reVOeLlbH2fHsIQhhrdksNnudtxxubVmZwZRSMW/2WHZrx8/HxY
   kpdzuSP2zPZkJrOcZxNQC/yofBMiMN5vkrmSXI6d7vipTxLwNpmZGfopm
   +2JCUX9KAWRZ4aWot6jW1hyzjygGu6vQFHQhuQxK4RWPgS+apKndwdM7w
   A==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="225557116"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2023 14:09:18 +0800
IronPort-SDR: w3ee9Q3ydOiHWRq2KabSpLM2Kd6iDCXN2CVFO7Z6Mn6jOvRFxqsv1+wnkKv4zBy51UIfbvPa+O
 skS3beBLzGPqCkxLkcoMaZbe2OopV6a6wNKSZERgijlp2WFCoMxZUpOrzVxnkqIaPJfm87/vGi
 TvC1UmtsjnXevEb++DzAnwPKTKMOBN7bVwQynamWR4KWyn7ZqISjv8FAE/s68HB4BxEDpoQtQX
 mda5cYiNUeMjN8iW294ReEJQ8dUoWHVHDRWTIQXIHKYkioS47mgmZwQ/SPJnd3+RbaJcMoyRYc
 CTA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 21:27:07 -0800
IronPort-SDR: 8ZXxIgdAk7zXV2fUy+H1uaIc4SQm1dk3bLx9l6xH7jV3e/9Gi7k72zGNUhBB9rLWYAP4i56AVs
 efNa0zkDxRFw5UmXRwFdxww0Rq8GLB2UtCU2ImtkFHV/H50KbHnEeFBhaV15wYvgkAvujHOsXK
 Bt9wF0l/TXUdMkSUKjtM9p7i9jrZn5gnmwwiCtwfF0PWqKs5b65iO+DwtSsKZitXk2AL6Tt+Td
 9I7UdcPxFcqwyeZb0Gm7iLvl/oPQEqbu4rTtJy/4iAB9GxMfSO0R5cMePsbkn0Smab4/o3hdT3
 PXY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 22:09:19 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NsHM15KXSz1RwqL
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 22:09:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673417357; x=1676009358; bh=xCs/n9rDQqS+vdn0jPiYAiFA43IssZ/nNVs
        VQCyf6QU=; b=l3XqdNtRhpr8UYKaFaem4iumwXyKQguE86M6w3P2vtgmchXK6dd
        axwg3D5ffr/pjSPiAZKmWue5QDcG4k+JSHerWFS+EdkNEa5fOjWwDUjO2wskbLLC
        qbonCxASTJ/e0/dLbvIjnku30s4BubwYE1UHsWDWTdEHmk+lWeLmVmhFwUn2wlgy
        LkKvcTKfPnysB4AoQ9MgnH9JhRsHr3GcYd7ggmVwWDWFevnZVt4JWp5/F0WTH6nr
        29HhiKupCEjlKbondGP+cj91PP30FJ7tecgu9FOZvsjefDv5AnV7EcC5tAm3kfvn
        dsvQ4ydfy1FxyqeODeTJyc/4QlFgKE9l5vQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O9n89DOEfNNN for <linux-block@vger.kernel.org>;
        Tue, 10 Jan 2023 22:09:17 -0800 (PST)
Received: from [10.225.163.17] (unknown [10.225.163.17])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NsHM03cCnz1RvLy;
        Tue, 10 Jan 2023 22:09:16 -0800 (PST)
Message-ID: <5d95dfcb-ce64-db64-046f-70376261345d@opensource.wdc.com>
Date:   Wed, 11 Jan 2023 15:09:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 1/6] block: add a sanity check for non-write flush/fua
 bios
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
References: <4a278c42-1f7b-f4c2-13c1-06d6fe52997f@opensource.wdc.com>
 <2544F354-58C0-4E90-8A1E-721AD455D6C8@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <2544F354-58C0-4E90-8A1E-721AD455D6C8@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/23 13:32, Jens Axboe wrote:
> On Jan 10, 2023, at 2:58 PM, Damien Le Moal <damien.lemoal@opensource.w=
dc.com> wrote:
>>
>> =EF=BB=BFOn 1/10/23 22:27, Damien Le Moal wrote:
>>> From: Christoph Hellwig <hch@infradead.org>
>>>
>>> Check that the PREFUSH and FUA flags are only set on write bios,
>>> given that the flush state machine expects that.
>>>
>>> [Damien] The check is also extended to REQ_OP_ZONE_APPEND operations =
as
>>> these are data write operations used by btrfs and zonefs and may also
>>> have the REQ_FUA bit set.
>>>
>>> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
>>
>> Christoph, Jens,
>>
>> Are you OK with this patch ?
>=20
> I already acked a previous version, you just didn=E2=80=99t pick it up.=
=20

I noticed your ack. But since I changed the patch, I wanted confirmation
again. Do you want me to pickup this version through the ATA tree ?
You can take it through the block tree as the block patch can go in
separately. There are no conflicts/dependencies for compile with the ATA
part. Whichever is fine with me.

>=20
> =E2=80=94=20
> Jens Axboe
>=20

--=20
Damien Le Moal
Western Digital Research


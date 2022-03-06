Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82751C433FE
	for <linux-block@archiver.kernel.org>; Sun,  6 Mar 2022 23:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiCFXzH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Mar 2022 18:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiCFXzG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Mar 2022 18:55:06 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F4D4B1D8
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 15:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646610853; x=1678146853;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WhA/830efebcsNBeP2i9bOhds10k9f1yyNnKRMTpCGY=;
  b=S1KijA5BloXaE3rOHdu2cIYd/K+1DazmjWhXcI8jGNajbziCiZYwRXRg
   7Lzj0AlrEayeW5IrqlhYicHuL/ycgfs9DSiz9qe5/RbTfxk7PnE17ZcLE
   ahBgnysHHDpDUXvnA8p4w3yIP6EjluHIDpbPZNRnWUIdRwrM6cfK+RR4i
   DUtpvXRgjZp9pCHCnbRE98YBZ/97T9/cTV9RXouT61SLW3Hx7r11ziPOp
   AgLes8ADiRWAdYbgmMncXeeifNZwj9wV7GqZli6vdGvW5rbRWnXhkjUcH
   h9jcPJ4/3s12pdkF5+IDgxOeskIawoDN4V01RYycL+B0NWwUh2KaKjvyz
   w==;
X-IronPort-AV: E=Sophos;i="5.90,160,1643644800"; 
   d="scan'208";a="298748736"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 07:54:12 +0800
IronPort-SDR: 4jxR/epqRFEMF73mKayoa8xKbhBsVRfoifzOTHQEX36LisbFaC0JiDMGE8jlFl8nMg49/t7u84
 tTBTE88zIf8jnAz+QiAiggTu6xUa58GLIB1eHyEImT/FTDI/CGr8GlkMr8EXSpMvXyGwGhSc53
 xTEYloP7CGD4I0SXIFinlyoGA3JNL64/qy2pte5ukMvWLqiCcAJOq0dRXfFem2zUR7IuZjrj8j
 9KC2kUE9McoFO4c32OstGKvPMnuIwBciqvhXmpBvmuTP52RojUsrf4jE/0ol1+13uv4pq76hFl
 7hUf4jJ5VmMATrZS+q/HzD0S
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 15:26:31 -0800
IronPort-SDR: SABmSMaOsGLkkTmTULWyeBxINJMsO60Og4DGW5OaTe8ZYdFxVv/JxxYvAXE1vlxvPl/UFBFQ/q
 sZDnoJnm/lmcR+6oWZhBnZSH21Q3PVchdMtXq89eRpfu3R77kIR+tmPjiVoYWTriUzn74lFnI6
 RmuJI5k9SWVphChPbKRtFPHGBcmQ4u7SXXF7S1t9ZboyLaWlaVq4W6NoySt27eN/SBMKCFvMwr
 7OLeIlGfnmrOdo7gyAKPup3+ttGTWRzed7U6qaIOMRCTAvNshd7B3jMI2xZgFGSsTyrlha3B0H
 7Ew=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 15:54:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KBdjH68zvz1SVp3
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 15:54:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646610850; x=1649202851; bh=WhA/830efebcsNBeP2i9bOhds10k9f1yyNn
        KRMTpCGY=; b=l74GyPy8Vr43+XfhtdT7cxs/77zBKLhfqYTMrEoy+xCMmuFroDt
        XuUC1kzyqsfRZT0mVMGtMdQpbeWFsktYqJjuIh/t24QD1LeJJPI3MVRkFLnuis00
        IPQ5v0x+vqi57KOn/4t/p87/lk1vBf/ZNT1ubKTAg0ATIHXVVV/qsxfyXbA/2Xye
        zKhsmp1Yb/P9EyC5EaQOTs1K0L1DwKfNcgqAfYoMcipjNWvbwEQ20ykvolZ3naZ4
        pakjnJvUnGtFgicoLEpT6xBpjpr5jaI1zD2jXKT6jm41cmgf0PUdQN7htdMctCxC
        8ogw1i95SzOfizH2iYwHPk+BBlsVGsgtAEA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VVzzP_hLV9Bd for <linux-block@vger.kernel.org>;
        Sun,  6 Mar 2022 15:54:10 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KBdjD0Sxxz1Rvlx;
        Sun,  6 Mar 2022 15:54:07 -0800 (PST)
Message-ID: <e7fa785a-c5f1-4654-b771-4a1ef8437082@opensource.wdc.com>
Date:   Mon, 7 Mar 2022 08:54:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
References: <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
 <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
 <CGME20220303094915uscas1p20491e1e17088cfe8acda899a77dce98b@uscas1p2.samsung.com>
 <8386a6b9-3f06-0963-a132-5562b9c93283@wdc.com>
 <20220303145551.GA7057@bgt-140510-bm01>
 <4526a529-4faa-388a-a873-3dfe92b0279b@wdc.com>
 <20220303171025.GA11082@bgt-140510-bm01>
 <BYAPR04MB4968506D0A8CAB26AC266F8DF1049@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220303201831.GC11082@bgt-140510-bm01>
 <BYAPR04MB49686E8DFFF46555915F65BAF1049@BYAPR04MB4968.namprd04.prod.outlook.com>
 <YiJyt79fELL6+/fF@bombadil.infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YiJyt79fELL6+/fF@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/22 05:12, Luis Chamberlain wrote:
> On Thu, Mar 03, 2022 at 09:33:06PM +0000, Matias Bj=C3=B8rling wrote:
>>> -----Original Message-----
>>> From: Adam Manzanares <a.manzanares@samsung.com>
>>> However, an end-user application should not (in my opinion) have to d=
eal
>>> with this. It should use helper functions from a library that provide=
s the
>>> appropriate abstraction to the application, such that the application=
s don't
>>> have to care about either specific zone capacity/size, or multiple re=
sets. This is
>>> similar to how file systems work with file system semantics. For exam=
ple, a file
>>> can span multiple extents on disk, but all an application sees is the=
 file
>>> semantics.
>>>>
>>>
>>> I don't want to go so far as to say what the end user application sho=
uld and
>>> should not do.
>>
>> Consider it as a best practice example. Another typical example is
>> that one should avoid extensive flushes to disk if the application
>> doesn't need persistence for each I/O it issues.=20
>=20
> Although I was sad to see there was no raw access to a block zoned
> storage device, the above makes me kind of happy that this is the case
> today. Why? Because there is an implicit requirement on management of
> data on zone storage devices outside of regular storage SSDs, and if
> its not considered and *very well documented*, in agreement with us
> all, we can end up with folks slightly surprised with these
> requirements.
>=20
> An application today can't directly manage these objects so that's not
> even possible today. And in fact it's not even clear if / how we'll get
> there.

See include/uapi/linux/blkzoned.h. I really do not understand what you
are talking about.

And yes, there is not much in terms of documentation under
Documentation. Patches welcome. We do have documented things here though:

https://zonedstorage.io/docs/linux/zbd-api

>=20
> So in the meantime the only way to access zones directly, if an applica=
tion
> wants anything close as possible to the block layer, the only way is
> through the VFS through zonefs. I can hear people cringing even if you
> are miles away. If we want an improvement upon this, whatever API we co=
me
> up with we *must* clearly embrace and document the requirements /
> responsiblities above.
>=20
> From what I read, the unmapped LBA problem can be observed as a
> non-problem *iff* users are willing to deal with the above. We seem to
> have disagreement on the expection from users.

Again, how can one implement an application doing raw zoned block device
accesses without managing zones correctly is unknown to me. It seems to
me that you are thinking of an application design model that I do not
see/understand. Care to elaborate ?

> Any way, there are two aspects to what Javier was mentioning and I thin=
k
> it is *critial* to separate them:
>=20
>  a) emulation should be possible given the nature of NAND

Emulation need has nothing to do with the media type. Specifications
*never* talk about a specific media type. ZBC/ZAC, similarly to ZNS, do
not mandate any requirement on zone size.

>  b) The PO2 requirement exists, is / should it exist forever?

Not necessarily. But since it is that right now, any change must ensure
that existing user-space does not break nor regress (performance).

>=20
> The discussion around these two throws drew in a third aspect:
>=20
> c) Applications which want to deal with LBAs directly on
> NVMe ZNS drives must be aware of the ZNS design and deal with
> it diretly or indirectly in light of the unmapped LBAs which
> are caused by the differences between zone sizes, zone capacity,
> how objects can span multiple zones, zone resets, etc.

That is not really special to ZNS. ZBC/ZAC SMR HDDs also need that
management since zones can go offline or read-only too (in ZNS too).
That is actually the main reason why applications *must* manage accesses
per zones. Otherwise, correct IO error recovery is impossible.

>=20
> I think a) is easier to swallow and accept provided there is
> no impact on existing users. b) and c) are things which I think
> could be elaborated a bit more at LSFMM through community dialog.
>=20
>   Luis


--=20
Damien Le Moal
Western Digital Research

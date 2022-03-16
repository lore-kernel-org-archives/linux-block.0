Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CB7C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 00:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiCPAIg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 20:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345086AbiCPAIg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 20:08:36 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B5F49FAA
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 17:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647389243; x=1678925243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0mNhWJ03+5kX0soNftPP8OL+xRQ2Y6En+2LMiYWzBOI=;
  b=Qn2BRlFtM5Tt691vai964YNR8IXS3C+Tu44ahcshzkDC6FBMOeFziXwK
   lAHzbKGhbOkSgPJI74jF4Pbpk0Cr/n5qMye6PC+pGX30Yss0H7yOX4INO
   Hz+JY4n1eb2wzBoetiOm+lmGlzm1KYU9PzRAeSTVK/mzFXu7YNYdV+mXS
   vL8PnJBqXOUQHDT2hugKWSkP3Hj6GRWM8x4tGPaDPuHiD3/n/1JHR+5dm
   1YXJYxR2OvwGr6lM6EIyf7VxOdbOJhZ2Qt/aPvZJvtDblGtUTxLgOiD/k
   E663/80trARFFW9HA5aanCu54YFCH6xMCKiGkA5ZT80kWJ882AUnXcUF2
   g==;
X-IronPort-AV: E=Sophos;i="5.90,185,1643644800"; 
   d="scan'208";a="194370197"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 08:07:22 +0800
IronPort-SDR: O9tevhhTz7R7/De9XYQ+0/4ZM9cV9yGSsg9JySh7LFUW8BQP1qtPIJJTozgL8/1OZDVxBQJcOH
 ckXgBLqimbf+6z6xqmrhG3oXhRrLR2EA43QzUzvEFUlyiGK0OtDBawzsVhtOGF6rNjek4W9HaI
 R2QTKrpV0JuV81eC6ai+aAa/z4dmQdMmnaHAzJ718IsKMFTlsnkVjD7ywIW+WoGNbKO8yQ4LKC
 osdz0ABJwVKXBDDLIq2VnUpmEYSeTXRQ53ORl7F/L9gj1FL67Lh+n/VAjirJvX1yeJW4xkdhqV
 rXJz87nCl3sOd0VJaRbRYN7p
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 16:39:28 -0700
IronPort-SDR: MNQTWKj28I4xTEh/tEfqZNZEfmNBO+WvZmsHv0CU8mkyYYuefSKWVS6bRLdtkgwz7z28UjjxJQ
 L3htQtevmLWoViXXrILMPd0f7qOC5q0/w1qklqxsi4VE/xi1A+fQGOjmCknb0v0JB5kgpspm8A
 OEFfrp0bkQiUpA+xHt9xlbhkHGj+Ax0oAfIKivhoNB0Xs2YJyThqU4+8iHoWqW5LOz6xhpIkx/
 by+9umxVafvu4xuJyGlBsoeo0S1EZzR1hNH0ZOuNnCJ57BWaeAppRae53ndhS7pKQg32pu0/t6
 H/c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 17:07:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJ9ZL47H2z1SVp4
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 17:07:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647389241; x=1649981242; bh=0mNhWJ03+5kX0soNftPP8OL+xRQ2Y6En+2L
        MiYWzBOI=; b=Py1BK1uwMGFG1c+ASHnh1ASoLrJKvw64tZE6y5q+e74n1dN2WI2
        zG5QeFjCDf598CpPKNNrU8JafIbwn/iyQBnpAGwGOaaF7uHiLHaSBVTxC68jUXl0
        kF+bclLgOHNCPo8G7NMuLZZdUbkZrgOwSpK6RLYH0Q4bVMInNsnvFyju6seKm3wm
        A8E7+orASHSQm5Vwa87H8yT9rIRQ4hKeTMeuP62RHCouLNFqV3NJ5qhcvE3YLNWf
        WWAPsJamThG8P5Og8CAJJ5DzD/zzgEF0lZS+j6j4NolJ4nyVZXIE9D2jy1Z16mNU
        iv488Cd8DPN8mLbhk4f8JAgzH4KsatfvV+g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MZK8wtE4I_Sy for <linux-block@vger.kernel.org>;
        Tue, 15 Mar 2022 17:07:21 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJ9ZH2xf2z1Rvlx;
        Tue, 15 Mar 2022 17:07:19 -0700 (PDT)
Message-ID: <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
Date:   Wed, 16 Mar 2022 09:07:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi> <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/22 02:00, Luis Chamberlain wrote:
> On Tue, Mar 15, 2022 at 02:30:52PM +0100, Christoph Hellwig wrote:
>> On Tue, Mar 15, 2022 at 02:26:11PM +0100, Javier Gonz=C3=A1lez wrote:
>>> but we do not see a usage for ZNS in F2FS, as it is a mobile
>>> file-system. As other interfaces arrive, this work will become natura=
l.
>>>
>>> ZoneFS and butrfs are good targets for ZNS and these we can do. I wou=
ld
>>> still do the work in phases to make sure we have enough early feedbac=
k
>>> from the community.
>>>
>>> Since this thread has been very active, I will wait some time for
>>> Christoph and others to catch up before we start sending code.
>>
>> Can someone summarize where we stand?
>=20
> RFCs should be posted to help review and evaluate direct NPO2 support
> (not emulation) given we have no vendor willing to take a position that
> NPO2 will *never* be supported on ZNS, and its not clear yet how many
> vendors other than Samsung actually require NPO2 support. The other
> reason is existing NPO2 customers currently cake in hacks to Linux to
> supoport NPO2 support, and so a fragmentation already exists. To help
> address this it's best to evaluate what the world of NPO2 support would
> look like and put the effort to do the work for that and review that.

And again no mentions of all the applications supporting zones assuming
a power of 2 zone size that will break. Seriously. Please stop
considering the kernel only. If this were only about the kernel, we
would all be working on patches already.

Allowing non power of 2 zone size may prevent applications running today
to run properly on these non power of 2 zone size devices. *not* nice. I
have yet to see any convincing argument proving that this is not an issue=
.

--=20
Damien Le Moal
Western Digital Research

Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B35DC433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 00:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiCPAsI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 20:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352876AbiCPAsF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 20:48:05 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389E94EA37
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 17:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647391611; x=1678927611;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZxASyb9bYrPFfJum9O2StKDc//XX+bfAePMiOUGd5Os=;
  b=Mbpwvhlq1Yn+wiSQqjUonx8iZ/zh8DIVtxu/qI/IQm2RbCN6a5TGuSYS
   RJaEnsizoRfsDixJifRzpLyeiQ9c8qYQeQk3XBQiCUeuAEtCgR6DP65MQ
   uguRLFg8MIZN0Fp7AD41VLze1ZMKzUVhGp1lCr/8z3v3eobOEn7EqzQS3
   z7gijLaP5bI+Bfas/z4RzrW1Fqo/s2s5ciocDNICir+uZ3mchfI/57LuZ
   PeQPfsxF+HgSctc6i+lO/qPrwtsipCwF+UlcQ0C3rNlxNGus8PoPKNCOr
   dhKYqFEz29/iz6D38EPFj/Qs+/ZEqSPuiUIKhBoirpragMTnj61oIOIxZ
   g==;
X-IronPort-AV: E=Sophos;i="5.90,185,1643644800"; 
   d="scan'208";a="299600449"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 08:46:50 +0800
IronPort-SDR: jOxG3KWa4w2+PQXVh+dJVBLudGFXHdb8yb4+TXGfIb6XhC66LszbTSpO8qlQ7aXum84L5r7/PK
 qKzNn21/n09vd3BiSEVaVVGoIr8d2qlPomYJms0EXk1F/7Cbgv7l1xRChZrvJNgEtH474wwnZX
 vQ99vAUFrAdVBfeuRDh5Oi4fWMLDv9e2ehGdT//SuSzMskjT9uSlK85OvrzAP2xPRKKOAd8Vsr
 79diPqMAEp5gl/psB2/+GD/lS3oJroteD6zRFTfiESKqC46bWauMAC+ZaqNjOA966C6w+mMW+4
 h1WWO2wjda3QQk2zeZr8vtaV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 17:18:56 -0700
IronPort-SDR: cKj7i6U+rLIJc+8t1A3yE2cXzput7W2048Tog4maNwXZ08E6a0y6vn9s1nkkr+ojGqvCmtkqP9
 m/nNSKnywK68H7t0rA+ZFyY6Ysuv0Zrlr3OdjWb21SV16WBRvrxIMcT91h6AD9BdNaZlUrG2ht
 qTChy2zS8qmo5BKsQwmztPXBUHBy1/JTYU/5eAuglMCeCMgfXvc00Qo/X1UjbQwu7Q2V2Nk8rI
 gbjfDIxXiJhzXz3VM4Mul+MWmxulhP93yGgmi/nkm+S/dJza/DVTULxNxH1CivL2e1UfX9W/dG
 eK0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 17:46:51 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJBRt22gZz1SVp0
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 17:46:50 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647391608; x=1649983609; bh=ZxASyb9bYrPFfJum9O2StKDc//XX+bfAePM
        iOUGd5Os=; b=dcrN10rCGSqpl7J4zjkNENl+3OjXsE8uOOdAWv9qFfjtiDZV9XI
        wr+1knOplfEuafdMSDDWj9orj34dPO2ku+oTLSMRsy4lFzusDUDmvXeL7y+Y7b+B
        HAuSqR+2HGe8mNfWOosnwiRj0FWKFURBofcJbaKfGMcfWGr9+xzOw4Q+KZ8blX4d
        liaqfvURMLsGFrR61yQ5czSlk81NGycmk2nws9zDtGHb/Nd2NTaMTSbbKaZkRnm4
        QJngUpxdb5ZF9PPpOHA0EpwVgQv16dGunuetA/wQ4pjBgn0sr4C4rqiDrGLVc9Hx
        ihq8Jq1oCCZ/lgBs+qTOOW2nuCbdHxpSJVA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1DLetdpRp8Bl for <linux-block@vger.kernel.org>;
        Tue, 15 Mar 2022 17:46:48 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJBRp3g6sz1Rvlx;
        Tue, 15 Mar 2022 17:46:46 -0700 (PDT)
Message-ID: <c3d71cd7-cf95-c290-bfc6-29d307b7b4e8@opensource.wdc.com>
Date:   Wed, 16 Mar 2022 09:46:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
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
References: <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi> <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
 <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
 <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/22 09:23, Luis Chamberlain wrote:
> On Wed, Mar 16, 2022 at 09:07:18AM +0900, Damien Le Moal wrote:
>> On 3/16/22 02:00, Luis Chamberlain wrote:
>>> On Tue, Mar 15, 2022 at 02:30:52PM +0100, Christoph Hellwig wrote:
>>>> On Tue, Mar 15, 2022 at 02:26:11PM +0100, Javier Gonz=C3=A1lez wrote=
:
>>>>> but we do not see a usage for ZNS in F2FS, as it is a mobile
>>>>> file-system. As other interfaces arrive, this work will become natu=
ral.
>>>>>
>>>>> ZoneFS and butrfs are good targets for ZNS and these we can do. I w=
ould
>>>>> still do the work in phases to make sure we have enough early feedb=
ack
>>>>> from the community.
>>>>>
>>>>> Since this thread has been very active, I will wait some time for
>>>>> Christoph and others to catch up before we start sending code.
>>>>
>>>> Can someone summarize where we stand?
>>>
>>> RFCs should be posted to help review and evaluate direct NPO2 support
>>> (not emulation) given we have no vendor willing to take a position th=
at
>>> NPO2 will *never* be supported on ZNS, and its not clear yet how many
>>> vendors other than Samsung actually require NPO2 support. The other
>>> reason is existing NPO2 customers currently cake in hacks to Linux to
>>> supoport NPO2 support, and so a fragmentation already exists. To help
>>> address this it's best to evaluate what the world of NPO2 support wou=
ld
>>> look like and put the effort to do the work for that and review that.
>>
>> And again no mentions of all the applications supporting zones assumin=
g
>> a power of 2 zone size that will break.
>=20
> What applications? ZNS does not incur a PO2 requirement. So I really
> want to know what applications make this assumption and would break
> because all of a sudden say NPO2 is supported.

Exactly. What applications ? For ZNS, I cannot say as devices have not
been available for long. But neither can you.

> Why would that break those ZNS applications?

Please keep in mind that there are power of 2 zone sized ZNS devices out
there. Applications designed for these devices and optimized to do bit
shift arithmetic using the power of 2 size property will break. What the
plan for that case ? How will you address these users complaints ?

>> Allowing non power of 2 zone size may prevent applications running tod=
ay
>> to run properly on these non power of 2 zone size devices. *not* nice.
>=20
> Applications which want to support ZNS have to take into consideration
> that NPO2 is posisble and there existing users of that world today.

Which is really an ugly approach. The kernel zone user interface is
common to all zoned devices: SMR, ZNS, null_blk, DM (dm-crypt,
dm-linear). They all have one point in common: zone size is a power of
2. Zone capacity may differ, but hey, we also unified that by reporting
a zone capacity for *ALL* of them.

Applications correctly designed for SMR can thus also run on ZNS too.
With this in mind, the spectrum of applications that would break on non
power of 2 ZNS devices is suddenly much larger.

This has always been my concern from the start: allowing non power of 2
zone size fragments userspace support and has the potential to
complicate things for application developers.

>=20
> You cannot negate their existance.
>=20
>> I have yet to see any convincing argument proving that this is not an =
issue.
>=20
> You are just saying things can break but not clarifying exactly what.
> And you have not taken a position to say WD will not ever support NPO2
> on ZNS. And so, you can't negate the prospect of that implied path for
> support as a possibility, even if it means work towards the ecosystem
> today.

Please do not bring in corporate strategy aspects in this discussion.
This is a technical discussion and I am not talking as a representative
of my employer nor should we ever dicsuss business plans on a public
mailing list. I am a kernel developer and maintainer. Keep it technical
please.


--=20
Damien Le Moal
Western Digital Research

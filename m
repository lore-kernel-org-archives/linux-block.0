Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F27CC7619A
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 22:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjC3Wuf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjC3WuK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 18:50:10 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D048E1B378
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 15:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680216537; x=1711752537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Ggj1agRsdoYVP7Sc1/qy0MLL1GV0HW83aXa1LNL+zI=;
  b=Kal/yQ/1oR5ywRyhxk4wZVzbePxU45J1r3ZwA9ODSsaYva3q1+9rGHZq
   ITU1EqRkCwsGtG4sYAluTCnBO2lvDf6iyuaEoglThI1Of6WE2dyFVwkJ2
   mxsWd/3hPA9jTVfaLF+EhO6TqvBpvIX9Q79gnLau4BpBFl9fYy+n9pBjx
   a5kjo53ANHsSznzNXosh75Cy7FAjY+/+bo9SmXQwV9OZGOhxJFwGqXKeg
   0mr6zjLj1Gd/D4PJ4NcuB0WGU+YkYEFYm9tuqdK+oz9Paru3RuKr50BAg
   /4C7iyNyFeGzf9nZkApCBXI5n06hirkOVix/vle09FYF4Er0HVPrQbAe3
   A==;
X-IronPort-AV: E=Sophos;i="5.98,306,1673884800"; 
   d="scan'208";a="339005028"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2023 06:48:21 +0800
IronPort-SDR: OKJPIF/Z4Izh4Dd1O7I3blfJ428sgMAUIqibUThLNEPiGZPuR6lkp1jPAp6tq6eGZzvWElsgd3
 9czMxieuqPO5AO/Zi6kV9jMu5qCkg6Mfa6jwZS3gt1xGEmxKHM5JyvT3SZuNvA/NPIs8H2P6CZ
 NJ58q1XWivGrMzn21bWTBHFHeOpn2yXABGcMDjRn7Qtkup9WBiHWBTPzuNkkWiXJlW5u42qT5j
 kIXHsW35mdEf9wa6NgQEATe9QQSgeoPBbSnsPZ+X8NrevjGMgJMep78K4FfB8bOyZEw+xonJdn
 xnw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 15:04:29 -0700
IronPort-SDR: wHPfCyu3tmN0Z+PIT78tLI0gfNdsdvB9iePO9TpjfPNAsp6a8L99IMw69ZfAhbTBS4wjrbvEp+
 +rKpuTmHBefex/Tjv1IFKwp9519rpH+s+I8etZY9Jdsc6xTIV96lj2fcJ3Ce/jQCPWy9+9ClrQ
 0SdxOsXP+s+2KHdQ+5jkpwdbGX+grHpgTOlZvNPv6cmJUUtJMIYZT9+/NYW+UXEnlNw5EFHloS
 +o5Dg2+o4o5con+t8r58liAX7ZI7hp70eJE5b6Ga5qHMOmsuTs8e9zmxaOk1CN1Ghyr+bOcXmM
 xJA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 15:48:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pndqn1zLRz1RtVn
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 15:48:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680216500; x=1682808501; bh=+Ggj1agRsdoYVP7Sc1/qy0MLL1GV0HW83aX
        a1LNL+zI=; b=UcV/epwiKn8OThUoTT56MkFLg3k9RSXLxTT6/MpChe8Aj/16VLD
        tcU6/btfRax/lNuJs/EYjvfTgkRb0at7ewyC/prTaUv7AWJPtmYLEbSU6eGysHil
        lk0cVAspvlrp9XNCp1aUQofwzUw9zBj3ijEz/dw07lIjTCNFkNQzXRfASuDhnwnW
        X8BtwPsySbBwWpICEdct96VZlcJyTMoXbXYyQKxG3Mfv/JoP0H+H58u29cWBCf3S
        S1PIrCm7yeKJgC3pbAOc2ExX8s4HJp34fd9z37kV05BfvrcVbdu4KImZuAkcXAQx
        UVMz+4Y3OFVi0FB9uZMPS3vRI2VkhZVqSdA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ke0QpZ1hsjHg for <linux-block@vger.kernel.org>;
        Thu, 30 Mar 2023 15:48:20 -0700 (PDT)
Received: from [10.225.163.124] (unknown [10.225.163.124])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pndql4GQSz1RtVm;
        Thu, 30 Mar 2023 15:48:19 -0700 (PDT)
Message-ID: <ad325b75-51e4-3b15-12f6-709e394ec437@opensource.wdc.com>
Date:   Fri, 31 Mar 2023 07:48:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/9] null_blk: check for valid submit_queue value
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>
References: <20230330055203.43064-1-kch@nvidia.com>
 <20230330055203.43064-3-kch@nvidia.com>
 <3e67b995-d2fd-7518-2a55-3279bc10d950@opensource.wdc.com>
 <bbe150f5-d1d5-524e-c5c7-a418a79b3b72@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <bbe150f5-d1d5-524e-c5c7-a418a79b3b72@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/23 04:01, Chaitanya Kulkarni wrote:
>=20
>> I would do this:
>>
>> +#define NULL_PARAM(_name, _min, _max)                                =
  \
>> +static int null_param_##_name##_set(const char *s,                   =
  \
>> +                                   const struct kernel_param *kp)    =
  \
>> +{                                                                    =
  \
>> +       return null_param_store_int(s, kp->arg, _min, _max);          =
  \
>> +}                                                                    =
  \
>> +                                                                     =
  \
>> +static const struct kernel_param_ops null_##_name##_param_ops =3D {  =
    \
>> +       .set    =3D null_param_##_name##_set,                         =
    \
>> +       .get    =3D param_get_int,                                    =
    \
>> +}
>> +
>>
>> And then have:
>>
>> +NULL_PARAM(submit_queues, 1, INT_MAX);
>> +NULL_PARAM(poll_queues, 1, num_online_cpus());
>> +NULL_PARAM(queue_mode, NULL_Q_BIO, NULL_Q_MQ);
>> +NULL_PARAM(gb, 1, INT_MAX);
>> +NULL_PARAM(bs, 512, 4096);
>> +NULL_PARAM(max_sectors, 1, INT_MAX);
>> +NULL_PARAM(irqmode, NULL_IRQ_NONE, NULL_IRQ_TIMER);
>> +NULL_PARAM(hw_qdepth, 1, INT_MAX);
>>
>> That can be done in a single patch and is overall a lot less code.
>>
>=20
> I did the same thing at first, however it doesn't allow us to print
> the right module parameter specific error message which I
> to add in this series especially for=C2=A0 where this patch limits it
> nr_online_cpu().

Given that your changes are checking the value ranges only, it would not =
be hard
to craft a common error message and add it to the null_param_##_name##_se=
t()
definition.

>=20
> let me send out V2 with right error messages ...
>=20
> -ck
>=20
>=20

--=20
Damien Le Moal
Western Digital Research


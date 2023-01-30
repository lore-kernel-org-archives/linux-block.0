Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851F3C61DA4
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 23:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjA3XSj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjA3XSi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 18:18:38 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9837F27D79
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 15:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675120716; x=1706656716;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vbd5tFkeprAIcq+FYPAfIxJtlFp/qJLwVv9T4su6GKg=;
  b=gJg6QVSyID2bp9rhPhecokeHm475FmYB7PpPTSYeVVOcyAwoY6eNrqea
   GbAftFFUv72wGQ4l1FlKvwIfU3+GldkOd9U05n3tKc+uPgRXnDrwUy+5o
   EaCjZjsPqGL+X6Rpx3n8yCQVcHVuYHWzngpXZr2m2jHU0szGViD1wAPsJ
   R3Epk3rIV3QW72LT6sBROKSjdbAKTqaoSx3W47C/+mcDcFhKssJcNcQQr
   MTLNOc8TIy3jWCuGIL+ZXWMsIKeYEE7y3yYwPrqd7YoGkreIO2G8ectyg
   w3HGwYUOtHh3soIgIZW3m9wQOvMcl0sIJA0lRtWebQHqKqNhFAGNRZC3l
   g==;
X-IronPort-AV: E=Sophos;i="5.97,259,1669046400"; 
   d="scan'208";a="227090615"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2023 07:18:35 +0800
IronPort-SDR: Rt21ZAQAtuxiASQop1UxzOPPKCBULNMbyFkl6XrM9JTRefuQo7+Ll+0LkAnEbvaaRYjAM0TeHg
 HDLyhaWdPq9lzz/yfpBGA2SCC2J1sV75EwTWUrFR3aGE58zdQ89u3x9+D8NRRCVOq5DY/FN9Rr
 V6ejOvqB3FaGQb5qig7su7qLRgDgWylw4hdjwDaXgoO8kLjwykRU+iZd9t9RCE3YC9BqQYIzGA
 PW1xYkxknwCtWuGKuIq2tlTKFbl/BnI2aIxoq2LGZNTtN4Hrfg5azn8pdkogKW1PLMWwNnx147
 N1s=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 14:30:17 -0800
IronPort-SDR: YtYQkwqv8I+rc65iHJzrWC7ZyZxIKcr6J5dYw3rI4VHt8rOcvox6uaQOIWlfWkIjYXjk5BoqKa
 69/YxPc3RXkTWBvnsS2Ly4SvYh52yLIA0/RSBHWSl2O8hVozQk8yJlPhs2O0G0oN6dQrgcqwdA
 Vnjq0Vq/vLF+SMXebZ77zHmgu/6TXztfVjNBxDy8aRF99Xp1i83vxQPIdDOhScWkTCEMjOm7V7
 eIdq/PosokA/22BPfCL6Kwz0NxkVnCIGvdvDk3z4HzI9fY/TobI0uUC7kFaXHXr6g+oHeP4Wbs
 100=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 15:18:37 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P5PHv3fnNz1RwqL
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 15:18:35 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675120714; x=1677712715; bh=Vbd5tFkeprAIcq+FYPAfIxJtlFp/qJLwVv9
        T4su6GKg=; b=Zop0i3VQ3u0/Kkq/wuoVylW+23K85upEkoq/q6NTalzD6owpopr
        QE/5VBD7F1seNe97EvN9SqvP5DlWDe0pksqGH0l9DUYRJBtewJycL9JczGbE866a
        W7K4aQMYIEySRX5r+nkVehAHhwdOCXNSqe01eOpAWv2Ib9S41sSRH/7lk8PIqiQy
        dv6v0ud7xbsnRcDKhfJKtf3Oydm5Gn5xK7/aYtjeMA+DCv5KCB4fWqiM5uYI3Fmb
        HqGTEfDiP7ycpXIRYkD/eCNa+mYNFvVfAGF05ppp4OjfOvNmAOXnamKkQEYQyBx3
        FCLnLLjIZi/HLJvRSePWy3ve2aWNNs+3P9Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gC8-4ScUOO-n for <linux-block@vger.kernel.org>;
        Mon, 30 Jan 2023 15:18:34 -0800 (PST)
Received: from [10.225.163.70] (unknown [10.225.163.70])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P5PHs3SlDz1RvLy;
        Mon, 30 Jan 2023 15:18:33 -0800 (PST)
Message-ID: <1ad62b40-28ed-f452-ecda-6470068b4034@opensource.wdc.com>
Date:   Tue, 31 Jan 2023 08:18:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Ondrej Zary <linux@zary.sk>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <425b5646-23e2-e271-5ca6-0f3783d39a3b@opensource.wdc.com>
 <20230123190954.5085-1-linux@zary.sk>
 <d4f7ebd5-d90d-fb96-0fad-bd129ac162dc@opensource.wdc.com>
 <e843fde8-7295-dd30-6d98-a62f63d7753c@kernel.dk>
 <20230130064815.GA31925@lst.de>
 <569cb9ba-52d6-da73-dba0-cc62c91f6db2@opensource.wdc.com>
 <7a2f5b2f-3ed9-eabb-6c9b-dcb2bfe82a08@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7a2f5b2f-3ed9-eabb-6c9b-dcb2bfe82a08@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/31/23 00:25, Jens Axboe wrote:
> On 1/30/23 12:10=E2=80=AFAM, Damien Le Moal wrote:
>> On 1/30/23 15:48, Christoph Hellwig wrote:
>>> On Sun, Jan 29, 2023 at 08:44:06PM -0700, Jens Axboe wrote:
>>>> I would prefer if we just delete it after merging this one, in the s=
ame
>>>> release. I don't think there's any point in delaying, as we're not
>>>> removing any functionality.
>>>>
>>>> You could just queue that up too when adding this patch.
>>>
>>> I'd prefer to just deprecate.  But most importantly I want this patch
>>> in ASAP in some form.
>>
>> I will queue it. But I think it needs a follow up to result in somethi=
ng
>> consistent with KConfig. So either deprecate or delete PARPORT. I can =
queue the
>> deprecate patch and delete in 6.4, even though I share Jen's opinion t=
o simply
>> delete directly. I am still fine either way.
>>
>> Jens,
>>
>> If you are OK with that, can I get your ack for the deprecate patch ? =
Unless you
>> prefer taking it through the block tree. Either way is fine with me.
>=20
> Yeah I'd be happy to ack that, did you post it? You can add my ack to t=
he
> new driver, fine with that now.

Will do. But I did not want to queue the new driver without killing (or
deprecating) the old code too. Ondrej has now sent 2 patches to remove th=
e old
code. Please ack that !

--=20
Damien Le Moal
Western Digital Research


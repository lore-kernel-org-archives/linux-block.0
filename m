Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF80C433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 08:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979A460C4B
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 08:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhKBIap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 04:30:45 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4847 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhKBIap (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 04:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635841688; x=1667377688;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6BNFMArPqUkcHX31A6B4ZL1TPKt4qt1EntfIO4YdB6k=;
  b=H4VBt4/jfLJMtUXH5iX0cAWMoTqQlMPVlyNiwxJ0jsbO+qlNVOR/bMyZ
   kRhf/OmjzYZG30PfVVhRAvFpckPgNhwkpBkrhxKr/X2qh6/UXl4QmCoN8
   AC9TzH8Zkyy7SI9NLg8hcSGnfSTkvsw+4g6wWeaipOZZvmVJcUYrEsQkK
   RB4tDg01FtIn5jsby2fMnsxmgMBSeDd861+n2VgZjo9Czfk/dgp3qlHdT
   MzVz7XYQOaG8Yi9WWGeSlPMKAANvAeC9FAA/uqQEgmflZy47M2Idrug1G
   wj/AFW90E4C3XVEgzi1B6RA21gN04OE4ie0dz7c8+KQsd+7/poYO9uc/X
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,202,1631548800"; 
   d="scan'208";a="184463408"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2021 16:28:08 +0800
IronPort-SDR: Ou9nzU7CQDULv1LZPHfCAOSYFsRiusIVskxHy40FPi7ZNkuOZADbzWwoN2kQLzVuskenLgtGBl
 Bpr3scXKj6iEu+e5pyQC+fhe8DwJeFeU6cN5FZFayEYxXTyRhbqHZluSpj7a8drkqD6RZypuwO
 dwLn3lWVd1AnZbsXN3BLe0RQyNG+lvDRqMFcysaTUlflWGnNpCMn9IhRuJ+IitjwTeuare7k0T
 Av/lgjsIQ9lwwEg0/bnDq9ZIOzvjTjMcfhpCGkZ577UWfduXEoQDA/nUV9UOtwf50eUanPlUqO
 iz4DEbv0wZzW3BGYxrjHCzmZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 01:01:58 -0700
IronPort-SDR: AzBssHQ5bmwZ4kconvL2O/P+ANmWflltJA0zYdp3OeH89h+Al3Fb8UBnEMsO0nLYFEdDNo6Qgj
 p2yOplpv86FR8PTKKJrc75CT5Oq0NykXbFWZFe2jjO5DYkck7sFkU6J5IJXP9G2wvBgy/h/esp
 BhDmHqfTTafHXkOoewDxEMbj6JvvtpreOHifZ8KSnAZ7vEACz5R5Ka8tUgUOdfkDUWDDuIHMt7
 w/S0WjVsPkhEQBsCxeALkkZTjdu57KAytYyxgGx19uhNq/oboxZASfjOXPAxQmhNWzdOoCa5UJ
 PZA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 01:28:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hk32210QPz1RtVw
        for <linux-block@vger.kernel.org>; Tue,  2 Nov 2021 01:28:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1635841689; x=1638433690; bh=6BNFMArPqUkcHX31A6B4ZL1TPKt4qt1Entf
        IO4YdB6k=; b=ueclccTtZezrM9WcEA9gba0C5TpcXmHEapyCUlGQLxpYKQ4HSqh
        J3Cc+Vq/mmjNnt+1qJMVMTj0C4uzyKlN5fuSDtgUBRZATrxG82qCu6xPMxmJvTxZ
        PUKyiySiGLldX2OCy+rC6DvFg5mjG8cSBuSZAv3cODUioegA0xibnx8b7uvaX/Jr
        3IWINneWrOmsqgJvCe/qoOPDpjICqQEBDKgA6P9Xf8h23JA1w+eBoCrhCi3lQ/Mr
        9OKxldyESpuxgbBHFFRdE+m78p1tWohLLezI0fIcrRZxKEZNoQZMIxvyIVQbNH6S
        LmHmqA4ySJTbzDZ6/lKaGCm/GdcUNL4gp0w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C41W1P0hY4d0 for <linux-block@vger.kernel.org>;
        Tue,  2 Nov 2021 01:28:09 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hk3201dMjz1RtVl;
        Tue,  2 Nov 2021 01:28:07 -0700 (PDT)
Message-ID: <4e6c0a41-b70f-bcc2-31f3-761b7c8dcd3a@opensource.wdc.com>
Date:   Tue, 2 Nov 2021 17:28:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20211101083417.fcttizyxpahrcgov@shindev>
 <30d7ccec-c798-3936-67bd-e66ae59c318b@kernel.dk>
 <f56c7b71-cef4-10be-7804-b171929cfb76@kernel.dk>
 <20211102022214.7hetxsg4z2yqafyd@shindev>
 <9e22ece3-d080-945d-5011-b0009b781798@nvidia.com>
 <20211102081929.s6eyxawq32phvufr@shindev>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211102081929.s6eyxawq32phvufr@shindev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


+linux-nvme (Keith and Christoph)


On 2021/11/02 17:19, Shinichiro Kawasaki wrote:
> On Nov 02, 2021 / 03:07, Chaitanya Kulkarni wrote:
>>
>>> The NVMe device I use is a U.2 NVMe ZNS SSD. It has a zoned name space and
>>> a regular name space, and the hang is observed with both name spaces. I have
>>> not yet tried other NVME devices, so I will try them.
> 
> I tried another NVMe device, WD Black SN750, but it did not recreate the hang.
> 
>>>
>>
>> See if you can produce this with QEMU NVMe emulation (ZNS and NON-ZNS
>> mode), if you can then it will be easier to reproduce for everyone.
> 
> Chaitanya, thank you for the advice. I have managed to reproduce the hang with
> QEMU NVMe emulation. Actually, ZNS mode is not required. I tried some device
> set up configuration with QEMU, and the hang was recreated when a single NVMe
> device has two namespaces. With single namespace in a single NVMe device, the
> hang is not observed.
> 
> So it looks like that the number of namespaces may be related to the cause. The
> WD Black SN750 without hang has single namespace. I reduced the number of
> namespaces of the U.2 NVMe ZNS SSD from 2 to 1, then the hang was not observed.
> 
> FYI, the QEMU command line options that I used was as follows. It prepares
> /dev/nvme0n1 and /dev/nvme0n2, and the block/005 run on /dev/nvme0n1 recreated
> the hang.
> 
> -device nvme,id=nvme0,serial=qemunvme,logical_block_size=4096,physical_block_size=4096 \
> -drive file=(path)/nvme0n1.img,id=nvme0n1,format=raw,if=none \
> -device nvme-ns,drive=nvme0n1,bus=nvme0,nsid=1 \
> -drive file=(path)/nvme0n2.img,id=nvme0n2,format=raw,if=none \
> -device nvme-ns,drive=nvme0n2,bus=nvme0,nsid=2
> 
> Regarding the two image files, I created them beforehand with the command below:
> 
> $ qemu-img create -f raw "${image_file_path}" 1024M
> 
> Hope this helps.
> 



-- 
Damien Le Moal
Western Digital Research

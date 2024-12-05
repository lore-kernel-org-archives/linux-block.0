Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F5212B33
	for <linux-block@vger.kernel.org>; Thu,  5 Dec 2024 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400793; cv=none; b=G7EIclg0509r0GgurH94v1CmV4IHmxHB5sF1QSzF50g9Xf0a/iddl1qdn7lZNo5I3Q0+i4lo80jYqBWH98laxERVPKNyYrm6LeXe4ezDfaOMmrvPyqLPeQoSckSD9FLdwb7ppkUgsK783gdcspYgj7HRVJjyqpQc9zIi98SQoVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400793; c=relaxed/simple;
	bh=1J4ztAGkR97mu0rXS7CUisVilusU/16YhOa82w/ptss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J27wdDQDv97twGWUTq/jDR0Q7+zOmyy3pR+2KNrJ1/HBl8tdw5Unbky07dh9FCfrs8L4J4Hq+SxBreXtp4UcZCuFaYv4G8wUD6Iw1M+0GErN62bC3E4wuS/yTze92njdLZ84ENMqEn5BHzXSq12dG1FVRTgHmh4KIe1762SoB5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tJAik-0008Hm-P7; Thu, 05 Dec 2024 13:12:38 +0100
Message-ID: <4218cdae-07ee-433c-8a68-bb07885e43ab@pengutronix.de>
Date: Thu, 5 Dec 2024 13:12:33 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Co-existence of GPT and fixed partitions (Was: Re: [PATCH v6 5/6]
 block: add support for partition table defined in OF)
To: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Daniel Golle <daniel@makrotopia.org>,
 INAGAKI Hiroshi <musashino.open@gmail.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Ming Lei <ming.lei@redhat.com>, Li Lingfeng <lilingfeng3@huawei.com>,
 Christian Heusel <christian@heusel.eu>, Avri Altman <avri.altman@wdc.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Riyan Dhiman <riyandhiman14@gmail.com>,
 Mikko Rapeli <mikko.rapeli@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Li Zhijian
 <lizhijian@fujitsu.com>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, upstream@airoha.com,
 Christoph Hellwig <hch@infradead.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Christoph Hellwig <hch@lst.de>
References: <20241002221306.4403-1-ansuelsmth@gmail.com>
 <20241002221306.4403-6-ansuelsmth@gmail.com>
 <5e9a80d6-6c89-478e-99c9-584647661f5e@pengutronix.de>
 <CA+_ehUwa69Qa96yy0=K9AiCEJbaZt9oGCRf5gJDh-0_14shbtA@mail.gmail.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <CA+_ehUwa69Qa96yy0=K9AiCEJbaZt9oGCRf5gJDh-0_14shbtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-block@vger.kernel.org

Hello Christian,

Thanks for the prompt response.

On 05.12.24 12:54, Christian Marangi (Ansuel) wrote:
>> How common are these? I never worked with a system that didn't use MBR
>> or GPT for the user partition.
>>
> 
> On router devices this is the approach for Mediatek and Airoha and also
> other vendor for anything that have an eMMC.

Good to know. Thanks.

>> barebox has for many years supported defining fixed partitions on SD/MMC
>> nodes and it's used heavily to define e.g. the location of the barebox
>> environment. Many who do so, do this either before the first partition
>> of the MBR/GPT or overlay the fixed partition to be identical to
>> an existing MBR/GPT partition.
>>
>> barebox also by default copies all fixed partitions it is aware of
>> into the kernel DT, so if the kernel now stops parsing GPT/MBR when
>> a fixed partition node is defined, this would break compatibility of
>> existing barebox-booting systems with new kernels.
>>
> 
> I'm not following... is that a downstream thing? Also fixed-partition
> in DT for SD/MMC were never supported, why the partition was
> copied in DT? Userspace tools made use of them?

The kernel isn't modified, but the barebox-state utility can parse the
fixed partitions in the DT and map it via udev to a block device partition
(if one exists) or to a block device + offset.

>> If I understand correctly, it's possible to have both partitions-boot1 and
>> a GPT on the user area with your patch, right?
>>
> 
> No, this array works by, first is found WIN. If OF_PARTITION is enabled
> and an OF partition is declared in DT, then efi partition parse is skipped.

Yes, but Boot partitions and the user area are different block devices,
so it should be possible to use OF partition for the boot partitions
and GPT for the user area, right?

>> So this only leaves the matter of dealing with both fixed-partitions and
>> GPT for the same device node.
>>
> 
> The logic is applied to skip exactly this scenario. GPT partition can
> be edited at
> runtime and change, DT is more deterministic. It's one or the other.
> 
> If downstream someone have GPT then OF_PARTITION should not
> be used at all... Eventually downstream for this special approach, an additional
> downstream patch can be added that define a special property in the node to
> disable OF parsing. (it's a 3 line patch and since everything is downstream it
> really doesn't matter)

As mentioned, the kernel itself isn't patched, but there was an implicit
assumption that MBR/GPT parsing would continue to work, even when a fixed
partition node is specified...

>> What are the thoughts on this? An easy way out would be to make of_partition
>> come later than efi_partition/mbr_partition, but I think it would be
>> nice if the kernel could consume partition info out of both of_partition
>> and efi_partition as long they don't collide.
>>
> 
> The 2 thing would conflicts and would introduce so much complexity it might
> be not worth at all. Also you would have situation where someone declare
> OF partition in the space where the GPT partition table is located, adding
> the possibility of corrupting it.

If we go this way, the implementation should of course refuse creating partitions
that conflict. The barebox implementation allows partitions only in the
unpartitioned space or to be identical to an existing GPT partition.

But I agree, this needs to be thought through thoroughly to determine how
it should interact with  runtime repartitioning.

> Again would love more explanation of your case because by the looks of it,
> you use GPT for partition parsing and just overload the DT with the additional
> info maybe for userspace usage. (and that case can be handled by just keeping
> OF_PARTITION disabled or adding a little downstream patch)

Yes, keeping OF_PARTITION disabled would be required to not break barebox
users that made use of the non-upstream binding.

I wonder though, if something can be done to reconcile Linux and barebox'
view of this and allow in the future enabling both Linux OF_PARTITION
and barebox OF partition fixups.

> Or you are telling me you had a downstream patch that declares additional
> partition in addition to a disk with a GPT partition table?
> If that's the case, I'm confused of why the additional partition can't
> be declared
> directly in GPT.

Many of the older boards supported by barebox used to place the barebox image
and the environment prior to the first partition in the unpartitioned area.

To still be able to access them, fixed partitions were used and the rest
of the system was described by MBR/GPT partitions.

This was partially made necessary by BootROMs having strange expectations
of where the bootloader needs to be placed, which partially overlapped
the MBR/GPT itself, making it difficult to define a partition for the bootloader.

For newer boards, it's more common to place the bootloader in a GPT partition
now. barebox has no DT binding for generically describing such a GPT partition
though, so boards may create a fixed-partition "alias" and use that.

Cheers,
Ahmad 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

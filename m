Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BC6196C86;
	Wed,  9 Oct 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482399; cv=none; b=BXfo5wJrAJeL9f85+ATuuga2ZtJ2tBu9AzkprIVEw6gM/Uzg7S8gkdShRyMRYbk6RLdaWEudoBrDkZDWH+jEdV9lSTKQyGAtNIkbm3VbXf/hdEES8b6EtI89pwRpPl/UQiUA98jp+ZA/BfDw6ANjhBtk+8yVcFMwH1dzCjiKd94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482399; c=relaxed/simple;
	bh=eYvQROEvvW1yDEEyLCG+OafAa2uujGTZCXesBAt3Uf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4vpinhuUT+Z9cP2QAym6a1cDzaqBe+5w2S0KzDcgebpIPzzX3fc0rcfihqu7jwYUJJGTtM9a7QEuiFSCN4ou+uRGO9ui5QaMZVEFYqR4exT6xvsRkGYYnzHJD/ybRn+oKywoFcFAq0S0JRONX3+8YSjiQvDtIy9lXbI+inJkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me; spf=pass smtp.mailfrom=bjorling.me; dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b=D+F3g5qS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i65qpZyv; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjorling.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b="D+F3g5qS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i65qpZyv"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B69EF11401D6;
	Wed,  9 Oct 2024 09:59:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 09 Oct 2024 09:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728482394;
	 x=1728568794; bh=PVGBHbIhqNvxDQEChY11ROMGXvZ7A+537QO2TTJjVlc=; b=
	D+F3g5qS3Ip3v5bIfGjdQKGnWIk3uCXdvq/cUtE7ibQeb6Y5QeaVKxjXSqflAfq8
	+n5yN8VWIBvU8qLb8MW1eNAwAuIVLU25uWltJbRV78yTGWvg2YQIK3DWfJ37/HWt
	siEAB8DoH2xGmvulLkS0dYjTav430XJMRtW/pJ5v/7yTLbtDGK3R2CLNznVA5Xwg
	oVzOf2LahJ9e05SibYDBYejVMHtJDFstGXzwGOc6LC4exdEm7CE2d+/MoiAtw1dL
	htXtrjx0t29tWh6O4DYjh7XL3iq9xbXXmFMK5HCydot1QXO5AOTDHbZBxtvATBQ0
	MLNz2ZX1lKELMNwf3VOZkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728482394; x=
	1728568794; bh=PVGBHbIhqNvxDQEChY11ROMGXvZ7A+537QO2TTJjVlc=; b=i
	65qpZyvEfMc6/4H+g7ugNEbF1uNLxJJv5G0VUcJEfG7C0FpEs3latw2c4uLzeca3
	qBP5RukCXI0FGq3ShQRdsb+fyl90VGAm5+PSS0/OccdEBo/aUYRRV7H3zRIHfsQo
	IsX+eYoZ43d/4PUHxDXIUwXmd549gZj50r5ZTz/78CcTBbuhChAVQYUcFQdwFzKA
	6DxTF/8ciyuQeppmvYbEKMaSpn7vJHaZjilH1iVgQp5lcCpXz85dcldD5kSDJuvp
	buBZgGR+wTx5NbziTVeOWVGtAIfNGgjMK4SJmU+xY35W8DHV8Alz4HfXXWrn0eA+
	16FGxuwht1lBtGXGdam2Q==
X-ME-Sender: <xms:WYwGZxWfVOt1zygoNeIYHlKeyl7x8iPNzg1N_g_burd2WtzDnlGGqQ>
    <xme:WYwGZxm2Rl9lXJlZb9w9h2_6jdHlKQrrc-lIVdqDHLu8tG-xlMXhYw_hW5rIaHbwn
    EQoVYFWkhS6I43Yj_A>
X-ME-Received: <xmr:WYwGZ9ZWIp0uYzjpap-lJV4_6ypC_7bEmmXlvrCji4arEC63Jl5tseGVgoE3CEW1Jza7rnYMG48RYke-ByEgw1THQ2as0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeforghtihgrshcuuehjpphrlhhinhhguceomhessghjohhrlhhinhhgrd
    hmvgeqnecuggftrfgrthhtvghrnhepkeefieeutddvteeguedthedvudfggfevgeevkeeg
    geefkeeufffffeelleevgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhessghjohhrlhhinhhgrdhmvgdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrrhgvsehsuhhsvgdruggvpdhrtg
    hpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehl
    shhtrdguvgdprhgtphhtthhopegulhgvmhhorghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegtrghsshgvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    nhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinh
    hugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrg
    htihgrshdrsghjohhrlhhinhhgseifuggtrdgtohhm
X-ME-Proxy: <xmx:WYwGZ0Wpzqf8BPUI7r4BIzE3-RsOhTgV71w19yC5JEv3OUzUAAeNsA>
    <xmx:WYwGZ7nU8Tx-clkD6ulhiLb8jp5kBUhZIp1a8WVPZ2jOzpIM-GM0UQ>
    <xmx:WYwGZxdliEEsrQ6druNxnMD5s7jaOI65Okn2_emRkdSA9pt3EHOfNQ>
    <xmx:WYwGZ1FGtwdkPcQT0o_-8ghy7O1owMTdDp5CxdjUbEw2eOrRnmxsFA>
    <xmx:WowGZ0ilJOmLheR48W4lgZwGSTQigPfx2IeWgkuqcGmO3lqwqkTQqfxv>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 09:59:52 -0400 (EDT)
Message-ID: <3a680224-8f45-4612-bc11-40515c30e7e8@bjorling.me>
Date: Wed, 9 Oct 2024 15:59:51 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: make independent ns identify default
To: Hannes Reinecke <hare@suse.de>, kbusch@kernel.org, hch@lst.de,
 dlemoal@kernel.org, cassel@kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241008145503.987195-2-m@bjorling.me>
 <a33f4ebe-de7d-479b-97d6-3d98e34ab94f@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <a33f4ebe-de7d-479b-97d6-3d98e34ab94f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09-10-2024 08:16, Hannes Reinecke wrote:
> On 10/8/24 16:55, Matias Bjørling wrote:
>> From: Matias Bjørling <matias.bjorling@wdc.com>
>>
>> The NVMe 2.0 specification adds an independent identify namespace
>> data structure that contains generic attributes that apply to all
>> namespace types. Some attributes carry over from the NVM command set
>> identify namespace data structure, and others are new.
>>
>> Currently, the data structure only considered when CRIMS is enabled or
>> when the namespace type is key-value.
>>
>> However, the independent namespace data structure
>> is mandatory for devices that implement features from the 2.0+
>> specification. Therefore, we can check this data structure first. If
>> unavailable, retrieve the generic attributes from the NVM command set
>> identify namespace data structure.
>>
>> Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
>> ---
>>   drivers/nvme/host/core.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 0dc8bcc664f2..9cbef6342c39 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3999,7 +3999,7 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, 
>> unsigned nsid)
>>   {
>>       struct nvme_ns_info info = { .nsid = nsid };
>>       struct nvme_ns *ns;
>> -    int ret;
>> +    int ret = 1;
>>       if (nvme_identify_ns_descs(ctrl, &info))
>>           return;
>> @@ -4015,10 +4015,9 @@ static void nvme_scan_ns(struct nvme_ctrl 
>> *ctrl, unsigned nsid)
>>        * data structure to find all the generic information that is 
>> needed to
>>        * set up a namespace.  If not fall back to the legacy version.
>>        */
>> -    if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
>> -        (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS))
>> +    if (!nvme_ctrl_limited_cns(ctrl))
>>           ret = nvme_ns_info_from_id_cs_indep(ctrl, &info);
>> -    else
>> +    if (ret > 0)
>>           ret = nvme_ns_info_from_identify(ctrl, &info);
>>       if (info.is_removed)
> 
> That is a very odd coding. 'info' will only be filled out for a non-zero
> return value of nvme_ns_info_from_cs_indep().

I may have misunderstood. Only if nvme_ns_info_from_cs_indep() return 0 
will the information be filled. Otherwise, if it is an NVMe error, 
nvme_ns_info_from_identify() is tried, otherwise it's a hard error, and 
it errors out completely.

> So why not check for that?
> But if we get an NVME status back there is a fair chance that something 
> else than 'invalid field' (or whatever indicated that the command is not 
> supported). That then would cause the device to be misdetected without 
> the admin knowning.
> Shouldn't we add a message if we fall back to nvme_ns_info_from_identify()?

Hmm, we could. Buuuut, at this point, there's more devices falling back 
to nvme_ns_info_from_identify(), than devices that implements the 
independent ns identify data structure. So I wouldn't mind it being 
silent. If we want to debug a potential misdetection, tracing could be 
enabled to track down what's happening.

> 
> Cheers,
> 
> Hannes


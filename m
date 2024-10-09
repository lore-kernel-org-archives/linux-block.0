Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F0C291E;
	Wed,  9 Oct 2024 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479364; cv=none; b=oWIzuu00fQ1UQAptLdm8R1CWdE4gtaRPbV53SOea8U1KeUmSg1n0mYbmBC8vY52Ihg7gOAxY1meSxb6BywMI37yAszupdbntj0HfJMQLoUeqx+4t4kkXK5z0TW/WWeukLz+5tUWywQcOtR/Ldm1D36nPXOFbrKnb3ZCxG6TmV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479364; c=relaxed/simple;
	bh=gFTx8ta/LiIiUJybujz06jcnpe6cybyLzDl+nWBhj7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7bHKrA+0aO2C7yFAY/3Ksv1rOWikDBpUZrvfIk+cpu+gPZUFtm0HHRTXR971PhbEo9ULqjjq9DEkyP3qiFUUX8GaufuYbUXFPA4b5CptNZBpQ+T4X0iVPrnGPX1AOsQrVkoe8KDQp7eB849Jkv1f3/d56RWViwIqLmIm2hts6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me; spf=pass smtp.mailfrom=bjorling.me; dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b=XCEDelr/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DH0ipkdn; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjorling.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b="XCEDelr/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DH0ipkdn"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 019A41380295;
	Wed,  9 Oct 2024 09:09:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 09 Oct 2024 09:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728479360;
	 x=1728565760; bh=UuTpuAalgyZbbPSGz9ViqBPTflz/LEC7APiSvX6DIwQ=; b=
	XCEDelr/hIbLQqrk7YFryLONcjWpb3oo5lMTrfNCJPl48DTQcffaO1sXseAoNzOQ
	vy5KjEMFtJPGQutNgmOSMCCcN3Sd7FogyO71QRwMLvn8Vr7A5LNvIKuFB2FcmY0/
	nlHqtJQjDXaBAxjJNec3Fq2fDRPAuXZMQRa4ykveBUrjb+Plq7ZoNMOzgmakQQ8n
	TbuhiLCGd2bdP2SIwizq271i0Pg/LI91wQ0yb/baiv/A29kI942+p1ZJGme9PFZt
	1A3v0QtNpC3vpWMn3fxjiAOOqBbjCkQg+nNImnAYDS3tllsk9b/PED2OZYKe4ab6
	U8546MpIJhyRux4fmEPp+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728479360; x=
	1728565760; bh=UuTpuAalgyZbbPSGz9ViqBPTflz/LEC7APiSvX6DIwQ=; b=D
	H0ipkdnUggfKlPyC//c0imkcy3UzneEXbkXsiLrx8cW4oL2xI8kx+tGXR+7s1TAX
	YK22/7tUgIr8xXCNeEZZ8iGNnbqTnQY/Mc5gO/Pru7kqNf+jqWVRWWnUhrToFFd2
	euDTUOJjHWTdeL+Dn8C9crRM/CjUUjWW2qP9FF+QmZSG64n+/3gqxDGZ/xEaJ0FL
	IgUT5jqYpAR2KQwkuHsDYMxQjRGcdKlMUPgMf/tDtv+3W2ZU9Q0cS1lJFZN3g3iG
	amKBERm+mj8BuEMtr+U9cUfT58fL1zG6Nun/+TCwpRTM/XlCiy5knGS/jYvpdPip
	PjQVbz7SLyjGuXfwmcgVA==
X-ME-Sender: <xms:gIAGZ2j15Y-T5wOyjuQ0PKkRJFHFPCHsd3j_aletOQyLmlUAznSn4A>
    <xme:gIAGZ3AJO5MKvv2HY-kedq54US1efCgLab4-sTsZm3zjp3IONJaXudRfGq9nHPq4n
    mUWdSj9ZfzPgpF95Zk>
X-ME-Received: <xmr:gIAGZ-H8PYUitnOb9dqZhgWirOeyV8DADJk-c-0EL_qvMKKTUQ412Up5k0DnCvuUraHoCNNnx2yuEcFkfg5gU-Z2BNPr2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeforghtihgrshcuuehjpphrlhhinhhguceomhessghjohhrlhhinhhgrd
    hmvgeqnecuggftrfgrthhtvghrnhepkeefieeutddvteeguedthedvudfggfevgeevkeeg
    geefkeeufffffeelleevgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhessghjohhrlhhinhhgrdhmvgdpnhgspghrtghpthhtohepkedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpth
    htohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegulhgvmhhorghl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghsshgvlheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmrghtihgrshdrsghjohhrlhhinhhgseifuggtrdgtoh
    hm
X-ME-Proxy: <xmx:gIAGZ_Q95u54YL5zUMZG9dntRV0LfAjlltz-YuG3SiR2AZ_xaI1P6w>
    <xmx:gIAGZzxd5YSQhD33PU0lGulNs7ppYVTzUl5NIUqZYHFWgOnU4wb5Yw>
    <xmx:gIAGZ942oyMa4Bo9mm0B5ZnmwRZsrx_YAISs_0GkYkdZhOSGOZbeDQ>
    <xmx:gIAGZwxiD1v61cCD-mDVxDxu2GMfiq3QMlw000-56wzAWtm22LMtkw>
    <xmx:gIAGZ6nfWX7rWCXINgTrD8yef7XRt9CnEMLQuAFxrpldHCe_zl4DyASP>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 09:09:19 -0400 (EDT)
Message-ID: <3191de59-16bb-4c54-87c3-110a0285ac13@bjorling.me>
Date: Wed, 9 Oct 2024 15:09:18 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: add rotational support
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, dlemoal@kernel.org, cassel@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Matias_Bj=C3=B8rling?=
 <matias.bjorling@wdc.com>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241008145503.987195-3-m@bjorling.me> <20241009074805.GC16181@lst.de>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <20241009074805.GC16181@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09-10-2024 09:48, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 04:55:03PM +0200, Matias Bjørling wrote:
>> +	if (info->is_rotational)
>> +		lim.features |= BLK_FEAT_ROTATIONAL | BLK_FEAT_ADD_RANDOM;
> 
> Entropy from block devices is pretty useless.  The only reason we still
> keep it for SCSI is because of retro-computing platforms without a proper
> platform hardware RNG.  NVMe HDDs reall should not show up in those kinds
> of environments.  Also without a add_disk_randomness in the nvme I/O
> completion handler this won't actually do anything.
> 

Thanks for the details. I'll remove it in the next revision.

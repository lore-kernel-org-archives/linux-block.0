Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADD1917E7;
	Wed,  9 Oct 2024 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480509; cv=none; b=KU7BUgO+c058lSxSaXBn43ImaPOltwAtQu0XtKts2l3RFLiOvbrIsX+8BTefbnJZmynyNgXlFw+pJCtjZ3asFvbFEq7AMPAxJ0PUe8HFvp/9XXDJp3QaS1dagIvuv871ojrQAdqZjLFH+nl2CutSlPmU1fKEMTP30+V9m82TIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480509; c=relaxed/simple;
	bh=6J+dwhRH4H4+hyB8vozo7d8DXwiis+PBfA8eN9YRoaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxpFBD6q77ENCTOpyuhRHK21/DdRUdOJHBnmSsQ+vPj2x62YzkvGq+LaP1Oz3uaI6goU8cc2vBlye/NA/vX0wHZztcXnUnTBDfH0yjVAK7Fghe8vHsHSLMQhC3oZL++toWae1yIVD0RkNZ9wMT5nWbFrdizItEt/7bfcpZOZ/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me; spf=pass smtp.mailfrom=bjorling.me; dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b=wsPmPxs0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=olThgFVl; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjorling.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b="wsPmPxs0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="olThgFVl"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD74E114019F;
	Wed,  9 Oct 2024 09:28:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 09 Oct 2024 09:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728480505;
	 x=1728566905; bh=DEfoN8Vn3gmKHWlf0jh4UtY6eytWKRkiu28dZUV0LI0=; b=
	wsPmPxs0s6gTPHrlXfQc1eQeI4BrR/8uGFItw4DIw3VqnIkjr9XIYQbO1Hks6dMh
	wItValAlhayMnjPT/FNsP0KCSaxugGmgIoSpNyZUxNHAtbAClR/b3jb2KZQFNuev
	0yg4rZCBSLXPoKpRahnewIBk7oxZhW+qbg7L6855Jbdii04jsdsZeylFuMODUeNW
	wSU43qWIQ2uN5jhKxHAXnozWyKfhvH39uZiz5H/OTnYJqNTn7iQxoqzdKEDQbyG7
	e+WkoAWk3xUxIH157xzM3RiL64tmKiF/ccpetIxmA6HlRpV6XAnxjJUT8pwNkC+o
	PfBJUUSS2KizFfwMs2cS/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728480505; x=
	1728566905; bh=DEfoN8Vn3gmKHWlf0jh4UtY6eytWKRkiu28dZUV0LI0=; b=o
	lThgFVld3jvKdHZY9P9MoSIC1ygT2EEaczAeT1MMOHuK7LZsq2bk8IG4i87dSScE
	rr3tJQQX9rnmAR79uKQ9SaETE5Mhe/k1qAmV1ItmAwdTrH8a+emZtaZuUkPM+2hC
	5pFT5KaxpjvTqNvh6cXsJ+9iVIRlnsErLVppU23kLScqWMt5w7du3dJGw7jY6KqW
	8jyxV+qvnW0zay4b8uIFGgq7AucWJmY8GbX0GMgnLRDIec8d7qJxE/ooO/Rx7sJ0
	xeq5XzLTu4fKwXBo60Q+mP/ntJEHOOAnRbkUcMP0WnOO4hWF4gRH5BV3L8tdMB1O
	9Jj/idStEyb1Kn0MzPwZA==
X-ME-Sender: <xms:-YQGZ3ITmXcXRdtzzB5I4VKvV4etPw-7_r2glJogLHg6J5VmOTtaQA>
    <xme:-YQGZ7LPs4TFIphLqyAry5QLrkZ7Q8e4iYjPIbpcsFv2-orm6BRtl143ZdZQyQZ-8
    K4yJa7b-Rsv10GDTzs>
X-ME-Received: <xmr:-YQGZ_uyodg_3YvfXy2hD-j9Poq2voqTps1deTywDMADxUIeLfP7RiB3OtcPGNaNAt8757yb-UayGTBJ64Ph-3nZC23mug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeforghtihgrshcuuehjpphrlhhinhhguceomhessghjohhrlhhinhhgrd
    hmvgeqnecuggftrfgrthhtvghrnhepkeefieeutddvteeguedthedvudfggfevgeevkeeg
    geefkeeufffffeelleevgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhessghjohhrlhhinhhgrdhmvgdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpth
    htohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegulhgvmhhorghl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghsshgvlheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmrghtihgrshdrsghjohhrlhhinhhgseifuggtrdgtoh
    hmpdhrtghpthhtohepfigrnhhghihughhuihesvgduiedqthgvtghhrdgtohhm
X-ME-Proxy: <xmx:-YQGZwYj7nGupr9G0G8JVWdMfl07SzgAtu2vbv6r9Lxs5W8GbPMSYg>
    <xmx:-YQGZ-YRqC92MmW1vo5ZQ196lZCaPgcXYToO3VqRZkiCiK0x--r_Ug>
    <xmx:-YQGZ0Dfkr85R9YTygdWV6j7RNU7u2HSUo52zqewQngr0Ub-6tUecw>
    <xmx:-YQGZ8Yfukd98v_cdpN8KphHB4oHKvVLB6yMoBOGS7S6yMKy50XAhg>
    <xmx:-YQGZ0kRigUFIhSJAyohh2qeNwYINoIdsGWCxX6oftCxUf-IVBrZL-cH>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 09:28:04 -0400 (EDT)
Message-ID: <c6e03246-57aa-41c5-90b9-261c6d6a14d1@bjorling.me>
Date: Wed, 9 Oct 2024 15:27:57 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme: add rotational support
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, dlemoal@kernel.org, cassel@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Matias_Bj=C3=B8rling?=
 <matias.bjorling@wdc.com>, Wang Yugui <wangyugui@e16-tech.com>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241009074355.GA16181@lst.de>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <20241009074355.GA16181@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09-10-2024 09:43, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 04:55:01PM +0200, Matias Bjørling wrote:
>> From: Matias Bjørling <matias.bjorling@wdc.com>
>>
>> Enable support for NVMe devices that identifies as rotational.
>>
>> Thanks to Keith, Damien, and Niklas for their feedback on the patchset.
> 
> Hmm, the only previous version I've seen was the the RFCs from
> Wang Yugui, last seen in August.
> 
> What the improvement over that version?  Note that it also came
> with basic nvmet support which is kinda nice.

Ah, I made the patches without awareness of the earlier efforts.

This version, together with Keith's nvmet patch, does not rely on 
setting/checking the CRIMS flag.

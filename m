Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0601CB528;
	Thu, 10 Oct 2024 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572553; cv=none; b=jbQROzQuAim0D6C97FhXj3yzjXHhWpIWMrKrf0R+lYI3myCt3dSgrRfZHu8Hyl0o0ObT9Dw0O7qck/orc0zGzY5Vvb6qRkTYtqp+Ro5fy6LwL2POnC7Y/Q2KQafpcVFVXsaR7DFnmT/2XyQFYOZml/rN8+fAZ3OUD8sy3T9TpXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572553; c=relaxed/simple;
	bh=l+0N738uJCBbVk2c08kZgZ7VPXycyMi0hzIG+DPeOvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KW/DDbYoC4Iv4TD6Tb41ELgHHRqJGfx+CpyTjrvF3vTKea9fXAAgjRvETsqBySy2+FyrcSwcf53QiraThGQHiahHYJL0whczoy4+qtwtlfoGt+7Q4LM/vBHc99dubbyhH0g1VoUQupFJ1yWGfwhq4z/U4FD4E3wPn3q28Tp3Er8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me; spf=pass smtp.mailfrom=bjorling.me; dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b=uqGxlpAF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pNFLBNyE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjorling.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b="uqGxlpAF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pNFLBNyE"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id DFBBE1380233;
	Thu, 10 Oct 2024 11:02:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 10 Oct 2024 11:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728572547;
	 x=1728658947; bh=0Scqs7bab56Uf9R67GJfqGE4WU4ZrJVXt3HS9FjofAE=; b=
	uqGxlpAFbIFziENMEbvM9q6Wa3dBp68bHBy8vg1teCbYgKHrdoLFECvnKt8ixkzY
	PCJrLVwdFtYnKcD4uNe4o6FQsAaAcu+CnKpFC8ooPxskWSOKwR+nyFde0CHtqvln
	YiI9Yzz7u4AgiQp6DSy0O+NXoqWszmMRn/SkfdI2YIB5+yCCH45LWFRASrWWTpi4
	Cq18iZvjsbYNZ58PadVQZlqQJUVeKJc0OanfawChsngJfRlzXzkdB1BFFrVevs+v
	Y/3xw0himovJQj/pgbfQ/32JhV2fZVETLGXpFxAevwT5oJRrekM3IUXTGcr3Tsvg
	MhbEwsEo7gK1XVNZiLZGVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728572547; x=
	1728658947; bh=0Scqs7bab56Uf9R67GJfqGE4WU4ZrJVXt3HS9FjofAE=; b=p
	NFLBNyEp6VUFW6kxGw2Xl3zafDzKtc0uQWZkB1wuxYUwiXhicrgax7z5bp3pEeco
	0XWyhu6uWuLA/HRCt/4Mk+FI4Z0M4rW+Edc62NOCoAHzeC8qxaFvxpZr7cRk/FtT
	ZsPMhykH5ww/26agthGQWN0hRZOwUwoV+gHQZAaVRLqaZBvrHZ99Fi1c9YTGVze+
	40TPkgOJDyBxYByD7KBKDCBHUszn6QvilW+rJbGX6lTH+0StJQP1gPfE5/iYBn4z
	fAEPw/bZNN/FaVNcCB+wSSw/rwTg5Iv3QKqA0xg27F2sNMUwhl7GgnK/QXXv58eP
	PdxhXxRtMF18NvzfblhlA==
X-ME-Sender: <xms:g-wHZwoOnJ2Um_JAjbZYlIoJSLNBqb6HWjhpfBw29NklS-UJYZcyxQ>
    <xme:g-wHZ2oSPTUite0sUqE4MJlOznq6Xc8izI4ZbJGJbeOYdQmE5KUZzxTUbmB_s7KUJ
    4Ef1Zqrvz61Lk42vP0>
X-ME-Received: <xmr:g-wHZ1NrpGZM8gznyUZzTMlrPme6J5cuW1mNm0PcQ8CEBPJIGFT7GinnR_9WlE9Otg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeforghtihgrshcuuehjpphrlhhinhhguceomhessghjohhrlhhinhhgrd
    hmvgeqnecuggftrfgrthhtvghrnhepkeefieeutddvteeguedthedvudfggfevgeevkeeg
    geefkeeufffffeelleevgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhessghjohhrlhhinhhgrdhmvgdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepugifrghgnhgvrhesshhushgvrdguvg
    dprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehksghushgthheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepughlvghmohgrlheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptggrshhsvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhnvhhmvgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epmhgrthhirghsrdgsjhhorhhlihhnghesfigutgdrtghomh
X-ME-Proxy: <xmx:g-wHZ36w1ZtvHQRAz6wV-bNl21yCkN0-UYnDXYniZmYs263VDuxFjA>
    <xmx:g-wHZ_4d-YqDMBDlbdNfqcFKxvP8TBlPdHR5tKcoEooXd2MTTqr9Cg>
    <xmx:g-wHZ3iVEmhoM3ph89eYyxaT6jv7J5TKSICvQuIdOH-aL8biXCfJHg>
    <xmx:g-wHZ54FcU8fX_YAbtorup20GXV-G13norbXxQutvPxj7L8kU8GoMg>
    <xmx:g-wHZ8Hsz5J32hEkD7q6M0JOexE5O-tszx8hp1zpcAQ8hDa3wOW4osxc>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 11:02:26 -0400 (EDT)
Message-ID: <535aa25d-eae0-40ad-a2f9-bdd72dbcd972@bjorling.me>
Date: Thu, 10 Oct 2024 17:02:24 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: make independent ns identify default
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
 kbusch@kernel.org
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241008145503.987195-2-m@bjorling.me> <20241009074611.GB16181@lst.de>
 <0076eb5e-6816-490e-abaf-a0a4a25a2915@bjorling.me>
 <d98d0311-b5a8-46f3-bdc2-6265ed00fb2e@flourine.local>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <d98d0311-b5a8-46f3-bdc2-6265ed00fb2e@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10-10-2024 16:47, Daniel Wagner wrote:
> On Wed, Oct 09, 2024 at 03:19:59PM GMT, Matias Bjørling wrote:
>> On 09-10-2024 09:46, Christoph Hellwig wrote:
>>> On Tue, Oct 08, 2024 at 04:55:02PM +0200, Matias Bjørling wrote:
>>>> However, the independent namespace data structure
>>>> is mandatory for devices that implement features from the 2.0+
>>>> specification. Therefore, we can check this data structure first. If
>>>> unavailable, retrieve the generic attributes from the NVM command set
>>>> identify namespace data structure.
>>>
>>> I'm not a huge fan of this.  For pre-2.0 controllers this means
>>> we'll now send a command that will fail most of them time.  And for
>>> all the cheap low-end consumer device I'm actually worried that they'll
>>> get it wrong and break something.
>>>
>>
>> It's a good point. Damien, Keith, and I were debating it during ALPSS. They
>> preferred the "send command and see if it fails" approach over writing
>> specific conditions where it would apply. Note that Keith did suggest to
>> avoid the command on 1.0 and 1.1 devices, and they were known to fail with
>> unsupported CNS ids.
> 
> FWIW, there are some devices out there which will log these attempts and
> spam their error logs. There were plenty of reports against nvme-cli
> when nvme-cli issued a command which could fail.

Got it. So, given the feedback from you, Keith, and Christoph. It's safe 
to say it needs to be a conditional check.

Would anyone object if the

  if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
      (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS))

statement would include a check for endurance group support?

The idea being that it's mandatory for a device to implement an 
endurance group in case it exposes the rotational flag. That check would 
limit the failed command check to relatively new devices.



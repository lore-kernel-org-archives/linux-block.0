Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B05A198848;
	Wed,  9 Oct 2024 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497111; cv=none; b=Eb62BDmjT6QZ2XZV6v1YcxIX+hxy5YXInxjse+NoIQio5q+NLo+fcSOLbaAFpewhx9u0MGR4Bvy5O1KyO7y8x9lomApcBul7PIDDELKS2gkcbSlmcOMYOr+1tewslfHqak2ojUnNbAvxVUB4wNVNhupjPLeQ2rlAxKXXU33ogrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497111; c=relaxed/simple;
	bh=Nz1DfZ3EqiTXqVUpq7YpEtRPgPHvy33lI4+yNFgaEzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5Hf7LSviM362TkRQs75sWfpwpvuDoUBsf19oS/skDCUU7qJYe9JcYCONtfTdAuGNeN+Ma643hjF77+VbBnuTNl+rRrJYSq6dIcYBeE6FeipcurdD1qxJAzOnirqGkh6sssuqN1jEs0wpF9ajTdog1/prvRB9svADHgCnUkWgwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me; spf=pass smtp.mailfrom=bjorling.me; dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b=gmZM5BQM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mRnslZt8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjorling.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b="gmZM5BQM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mRnslZt8"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2866F11400C3;
	Wed,  9 Oct 2024 14:05:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 09 Oct 2024 14:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728497106;
	 x=1728583506; bh=vht2RCtldo/N+YmYbXQHbMDhqc0PeROYXC3Tc/mu2ss=; b=
	gmZM5BQMZbUu6XVymNw+GVEP3tZ4ttJJEOOB0GRdvO/6fca+tpNhFwExqPozPHfu
	LyaLrp0hVEsY8G1oeGRsZQSKcOga9+S2bR0XSNy+AGLItU4OouvHHR6uIDheUT+l
	0MOO7J0r21voZnQMka2t0cwlXm36S/apMQxyitYGhkLMRLteH+fzm4KNTMTO7mSC
	cuPrWf/ixCzDha0nzxMjTcw/1IpUMSQQqmTfmAmc+ftk+qjTT2jYRvwNxx0Y9Z9F
	ZVP1JBpdGv4Qjg3DKbaL3eBUTVy3kMLwcZtMYm0ysI8YUXzgxATOKXNm0n6rmqJe
	K87HU7GDvtew3Xn9xZi0hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728497106; x=
	1728583506; bh=vht2RCtldo/N+YmYbXQHbMDhqc0PeROYXC3Tc/mu2ss=; b=m
	RnslZt8ZiNQ6Ye6HB92LzI+9y3b9p5smQ6q0O9Y/TGlKNgNOYSbBYSdLMhjRaSdH
	Trrnf234lODGMCSEf2Ai2KBNrnuKC1HMvN6nH5njbNm6e2EvX4heJXW9AdlQ7/Bt
	IwWKJd/srP42R1nDNDvzoyvFFkJwgaXxffhVk9VhQm6+PHbqkueAOPkEBUwyCLfh
	YopMeQ2jSRm3CdyklONgvVh/lQxFeOxFTQZ/G1k0M49MG8NN3b+kCh1cbsLbD9ee
	8gosnvjhVNophIaVMehHKDW13L2zT9VcFznqN00+bqZEobRTvr/HxzvmZ1D5FJmj
	TtupipBssuRQ295bz1lHA==
X-ME-Sender: <xms:0cUGZwKnKrmy1kSLjuK2FuTo1nwc7LcdNDp4zStPc44YJymARe3BTA>
    <xme:0cUGZwIEAyMxX3IeyQyb_IWayszvIowTFjlUHf8wBGM2gdq_xacwr43IAhMw9l3e0
    usfIXTFUZPyy0HABG4>
X-ME-Received: <xmr:0cUGZwvZGgMKRBITnrtVjr_B-xJJ0gMsRsjoxDnK4Lpl2oak7pewpYY0foprhSYUBsaACkzgt7CKNcg8Yz9eK6YNHpPVFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepofgrthhirghsuceujhpprhhlihhnghcuoehmsegsjhhorhhlihhngh
    drmhgvqeenucggtffrrghtthgvrhhnpeekfeeiuedtvdetgeeutdehvddugffgveegveek
    geegfeekueffffefleelveeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmsegsjhhorhhlihhnghdrmhgvpdhnsggprhgtphhtthhopeel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtohepfigrnhhghihu
    ghhuihesvgduiedqthgvtghhrdgtohhmpdhrtghpthhtohepughlvghmohgrlheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheptggrshhsvghlsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhnvhhmvgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhgrthhirghsrdgsjhhorhhlihhnghesfigutgdrtghomh
X-ME-Proxy: <xmx:0cUGZ9a3dVYooglZuYfmU9Kj2hR_zWL3t0f2h_5qDdxnw3BLde_1Yg>
    <xmx:0cUGZ3ZO1dy4ik5nRJ7CKxTej3QwAfurNycbnbWZYblsljaE3F6lbw>
    <xmx:0cUGZ5AI_9RkowdtJX4Yn_a0KFTDJMC5tAxEcfcNpdqfc3YSkdwXHA>
    <xmx:0cUGZ9aWpQkMNWTgH4ixg5gxYXjE_WTZAf6HG5nCYtguS-Lh00iVaw>
    <xmx:0sUGZxl6YIl9OZYMlgmceaW9WczSnPqK9pkM3Dk5UIVC-5rWLXHqpODG>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 14:04:49 -0400 (EDT)
Message-ID: <3d817578-41ef-45e9-ac65-a9ba45e2e637@bjorling.me>
Date: Wed, 9 Oct 2024 20:04:36 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme: add rotational support
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Wang Yugui <wangyugui@e16-tech.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241009074355.GA16181@lst.de> <ZwajykF81QLOkObY@kbusch-mbp>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <ZwajykF81QLOkObY@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09-10-2024 17:39, Keith Busch wrote:
> On Wed, Oct 09, 2024 at 09:43:55AM +0200, Christoph Hellwig wrote:
>> On Tue, Oct 08, 2024 at 04:55:01PM +0200, Matias Bjørling wrote:
>>> From: Matias Bjørling <matias.bjorling@wdc.com>
>>>
>>> Enable support for NVMe devices that identifies as rotational.
>>>
>>> Thanks to Keith, Damien, and Niklas for their feedback on the patchset.
>>
>> Hmm, the only previous version I've seen was the the RFCs from
>> Wang Yugui, last seen in August.
> 
> Oops, that slipped by me as well. I think the right thing to do is bring
> that one forward and retain the original credit. I agree with Matias
> that we ought to be able to query the independent identification without
> relying on CRWMS, though.

Works for me. Yugui, are you okay with me posting the updated patch 
serie with your patch?

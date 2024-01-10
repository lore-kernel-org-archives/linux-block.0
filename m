Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033C83E49A
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Axc6g8es";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NrSwF+fC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OoU71H+W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tGovVv4Y"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E06B62214B;
	Wed, 10 Jan 2024 09:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704878676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shVU0m4moDmOSpr1u9h0CO3UTZ+XlWfI4Y2TIRvg04Y=;
	b=Axc6g8esdeiu2+c1b6vbKSkoFBszqSnmOf9PxThM2t6IAZWUlCHu3newDsgrnkDqOM69Lb
	5m2Q8fJE50tOPYVm8LF1WDunnQsBxARg42AJ4oY4MojFaBVEpkB34BsU/HHb0nTgwofnTL
	Y4dqqwwTWyWsQ+YcOmwafLfrfnkat8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704878676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shVU0m4moDmOSpr1u9h0CO3UTZ+XlWfI4Y2TIRvg04Y=;
	b=NrSwF+fCvGXEQ/xPcuJ7b+LNknsZfvSUaTLpdOa/Xw+GNvvW195Ua4PeL+vJlraJvSpIHd
	YidMZD/20jqT4yAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704878675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shVU0m4moDmOSpr1u9h0CO3UTZ+XlWfI4Y2TIRvg04Y=;
	b=OoU71H+W2yjpJ7v0Ryhf0KnvtE7hF2HYeFga2xn/BBoodmQVYVD8C96Ves9Go1h9KEbtdk
	tY9NJRdAc2oTZTbJMdp+M93SJ918LCAxBjvTRcvcDziLFHA6NTCvq+Sbm50o7PmCcpdl4T
	nXHH8mqFmoxYuvwlvDnwTKt1EAsl1fI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704878675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shVU0m4moDmOSpr1u9h0CO3UTZ+XlWfI4Y2TIRvg04Y=;
	b=tGovVv4YXAlHZqHpwHj1QmgKtpWBAvEqSKv/s+7IRvbg/HJkmGXrg7MjD5EltPIgC//Woy
	Ydijj8pHvFZrGFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1EB013786;
	Wed, 10 Jan 2024 09:24:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JkVGLlNinmX/DwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Jan 2024 09:24:35 +0000
Message-ID: <74c67758-3b27-4840-a8e3-63eb8f5e5257@suse.de>
Date: Wed, 10 Jan 2024 10:24:35 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Nitesh Shetty <nj.shetty@samsung.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
References: <20240110035756.9537-1-kch@nvidia.com>
 <CGME20240110062350epcas5p351f5b4f8e27b3c57545b49509d2a48b6@epcas5p3.samsung.com>
 <20240110061719.kpumbmhoipwfolcd@green245>
 <b09c8885-9907-4616-bf80-68ca145a1eea@nvidia.com>
 <20240110075429.4hqt2znulpnoq35h@green245>
 <aa82e427-a599-4cef-80bc-fac5bc517335@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aa82e427-a599-4cef-80bc-fac5bc517335@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E06B62214B
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OoU71H+W;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tGovVv4Y
X-Spam-Score: -4.48
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.48 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.98)[99.91%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]

On 1/10/24 09:12, Chaitanya Kulkarni wrote:
> 
>>>>
>>>> Should this be TEST_DEV instead ?
>>>
>>> why ?
>>>
>> My understanding of blktests is, add device which we want to test in
>> config files under TEST_DEV (except null-blk and nvme-fabrics loopback
>> devices, which are usually populated inside the tests).
>> In this case, if someone do not want to disturb nvme0n1 device,
>> this test doesn't allow it.
>>
>> Regards,
>> Nitesh Shetty
>>
> 
> it is clearly stated in the documentation that blktests are destructive
> to the entire system and including any devices you have, if your
> system has sensitive data then _don't run these tests_ simple, when
> you are running blktests you are bound to disturb system you can't
> prevent that by using TEST_DEV.
> 
I don't think this is the direction we want to go.
NVMe for internal drives is becoming more and more prevalent (especially
on laptops), making them unusable for running blktests.

We have been putting quite some effort into nvme-cli to ensure that
blktest _can_ run concurrently with other NVMe drives, so really we
should not hard-code any device names.

Or we discuss this at LSF/MM; Daniel or me will be happy to give an
overview about concurrent NVMe-oF management applications on the same
system (nvme-cli, nvme-stas, blktests all running at the same time).

Cheers,

Hannes


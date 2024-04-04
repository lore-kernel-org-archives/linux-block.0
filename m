Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9367A101E6
	for <linux-block@vger.kernel.org>; Thu,  4 Apr 2024 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219352; cv=none; b=kcdiktKnC/8AaRnqyaxN41rI3ABzyOqm1egthN9BYa1+4PxtcE8k9qFPc4gtYLvSCd3OdfakRCM+A138wG13LqWE3ch4LLcDnDCv2Fv8eOTnNF+jzMGsAcdQ35YhqDSQ6JlAlxvIbYSmCGPefs9POyPXv6tnj+oO+Olz7covGOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219352; c=relaxed/simple;
	bh=6nwarV4e5MDKSB4SPAyX/nhToz0kRKlU/5c8o6FRUuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ui2o2nlZIUsxx3TTSo278OWveUgwTjdFKiRBdN77bUB8KPB6Y8fvsW1spNGCVNOQ21g0nZAnyGMvHDYffQQ9yGoH3vk+Od6jgmkf57Bp6eOj/9T985+QUOP2fSEoFXyTy3Xs07kMocgWaW/Y25mluJ0X2JYW4Iv94R7JPtu9QmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uidFzKy6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=91gAsNjj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uidFzKy6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="91gAsNjj"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D8B8B37712;
	Thu,  4 Apr 2024 08:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712219348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aOCHfZV2to3mP9ulNHVH8wnZcCwje64b6rHU6KARrEU=;
	b=uidFzKy6N75OzaBZMpY/shM1UkBze+Ow1P07dBbgPdMN+Elvcii0FzCPbKVfd+E8K8gEZ3
	XaFbq1qR0BJTyqpllvW44b3IMyiN8BzBOhnux7F+5O04nWKm5rxpOyyricIy9HemgD45fu
	5KMHAXEIMnThLMdAPCfhluCLFYfWv8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712219348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aOCHfZV2to3mP9ulNHVH8wnZcCwje64b6rHU6KARrEU=;
	b=91gAsNjjmgvrTqfsJjCpkTX2w9dnMBSUNMW2b/Q4nnK8cblm/E0GvN5gynshjiE58fK9e6
	9JDM9rpv5/rwCiAA==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C686A13298;
	Thu,  4 Apr 2024 08:29:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id PekAL9RkDmbyDwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 08:29:08 +0000
Date: Thu, 4 Apr 2024 10:29:08 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 0/3] add blkdev type environment variable
Message-ID: <j47jtsnraylush4xlxu6sng5frrawim5j2vjwt7zgei7jwi7ke@7ga6dd5sssur>
References: <20240402100322.17673-1-dwagner@suse.de>
 <mqpuf2a7obybtw42ydte2wq7ktema5odvc3dqm32hknjmamgdb@rbo3i6lqqkld>
 <j6awxljufwg6r5rs5kojwsnatfb4aj3vnqsq43hkuuhgvcflvh@u6l5cf2ponaw>
 <w2eaegjopbah5qbjsvpnrwln2t5dr7mv3v4n2e63m5tjqiochm@uonrjm2i2g72>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w2eaegjopbah5qbjsvpnrwln2t5dr7mv3v4n2e63m5tjqiochm@uonrjm2i2g72>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.996];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, Apr 04, 2024 at 07:43:28AM +0000, Shinichiro Kawasaki wrote:
> Actually, similar feature is implemented in the common code so that some
> test case can be run twice, once for regular the block device, and one more
> time for the zoned block device. You can find test cases with CAN_BE_ZONED=1
> flag. They are run twice when RUN_ZONED_TESTS is set in the config.
> 
>    To be precise, this applies to the test cases with test() function.
>    CAN_BE_ZONED has different meaning for test cases with test_device().
> 
> Now we want to run some of test cases twice for the two nvmet block device
> types. This is essentially common feature as the repeated runs for the
> CAN_BE_ZONED test cases. I think it's time to generalize these two uses cases
> and support "repeated test case runs with different test conditions".

Sounds reasonable.

> > requires() = {
> > 
> >  _nvmet_setup_target
> > }
> 
> Hmm, I think this abuses the hook. IMO, it's the better to introduce a new hook.

Indeed :)

> >
> > What do you think about this idea?
> 
> It sounds an interesting idea :) I prototyped the common code change based on
> the idea and shared it on GitHub [*]. It introduces two new config arrays
> NVMET_BLKDEV_TYPES and NVMET_TR_TYPES. When these two are set in config file as
> follows,
> 
>   NVMET_BLKDEV_TYPES=(device file)
>   NVMET_TR_TYPES=(loop rdma tcp)
> 
> it will run a single test case as follows. 2 x 3 = 6 times repeptitions.
> 
> $ sudo ./check nvme/006
> nvme/006(nvmet dev=device tr=loop)(create an NVMeOF target)  [passed]
>     runtime  0.090s  ...  0.091s
> nvme/006(nvmet dev=device tr=rdma)(create an NVMeOF target)  [passed]
>     runtime  0.310s  ...  0.305s
> nvme/006(nvmet dev=device tr=tcp)(create an NVMeOF target)   [passed]
>     runtime  0.149s  ...  0.153s
> nvme/006(nvmet dev=file tr=loop)(create an NVMeOF target)    [passed]
>     runtime  0.138s  ...  0.135s
> nvme/006(nvmet dev=file tr=rdma)(create an NVMeOF target)    [passed]
>     runtime  0.300s  ...  0.305s
> nvme/006(nvmet dev=file tr=tcp)(create an NVMeOF target)     [passed]
>     runtime  0.141s  ...  0.147s
> 
> I hope this meets your needs.

Yes, this is very useful.

> [*] https://github.com/kawasaki/blktests/tree/conditions

 I quickly looked into the changes. The only thing I'd say it looks a
 bit hard to extend if we have yet another variable. But maybe I'd make
 it too complex. I don't think we have to be too future proof here,
 because we can change this part without problems, it is all 'under the
 hood' and doesn't change the 'user interface'.

Great stuff!

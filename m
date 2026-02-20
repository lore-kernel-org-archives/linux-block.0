Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919992BD030
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771572783; cv=none; b=pst6dTyutBh7SVos0YjOj04soa0n7mC+lIkGTmcX6OiiFX13y/zprz8wzO4u75NM2QzD3g4JLKG+v92at+ZVY1QMtv52XLMG1Ne+p6ZcPXLELf4wa21Vz9q+4Fz/B8WnPqu9F3M0Xptv/cfGaE/iXVT8ETsm99rKjxE6oEYcApo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771572783; c=relaxed/simple;
	bh=ShijvS74Dp0udN0DD2xP01/6Fx2XHFOSEdxxxLq0uzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKVjG4LZZ1sARMfDpWkb4NpBUR9C2kB8Q1nFV5fPVHyhdPtRJm2ef9tHDpZuj0zvF9J7TdwcmrLMx2p6Pt/IgjB5KMo0eU7Q7wHOTBeeyJGeWCAlJZHhzDny1bczumr32M1maNDpWRsi8yE6luUXmdGIM1Nw30EJQabo9NtNTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ohTmzI4X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GJQ88BaO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ohTmzI4X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GJQ88BaO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ohTmzI4X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GJQ88BaO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ohTmzI4X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GJQ88BaO"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C761B5BCC2;
	Fri, 20 Feb 2026 07:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771572780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIjWXI1/cESIY/VFaxvEasuKStXiVBToPesiQs88cgI=;
	b=ohTmzI4XrVG6hPJ5FVSjLEVQNceSOLbmtINp6Ij1B5ZEH1Bfan2zZueqiyb33id7aEEmYi
	Rnz+JznsPKUe3cFQR79pj4m/ImPKtaNHuymP1TFHicXsWxLPWLMkXI6+qktEBKDuLxgSe4
	3mKNt9rgKsInY94wIomn2v6LXqvXkfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771572780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIjWXI1/cESIY/VFaxvEasuKStXiVBToPesiQs88cgI=;
	b=GJQ88BaO6mAtLrehcgjVu6i/i91JXAeGr7x2m3R8x7Shn2BsxEnc5yI5sC/8K21TKUwdP9
	UICA/BTaEVl0PyAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771572780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIjWXI1/cESIY/VFaxvEasuKStXiVBToPesiQs88cgI=;
	b=ohTmzI4XrVG6hPJ5FVSjLEVQNceSOLbmtINp6Ij1B5ZEH1Bfan2zZueqiyb33id7aEEmYi
	Rnz+JznsPKUe3cFQR79pj4m/ImPKtaNHuymP1TFHicXsWxLPWLMkXI6+qktEBKDuLxgSe4
	3mKNt9rgKsInY94wIomn2v6LXqvXkfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771572780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIjWXI1/cESIY/VFaxvEasuKStXiVBToPesiQs88cgI=;
	b=GJQ88BaO6mAtLrehcgjVu6i/i91JXAeGr7x2m3R8x7Shn2BsxEnc5yI5sC/8K21TKUwdP9
	UICA/BTaEVl0PyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9162B3EA65;
	Fri, 20 Feb 2026 07:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ajorISwOmGkMcQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Feb 2026 07:33:00 +0000
Message-ID: <39e35ba1-a2bd-4bfb-b900-84b5f0a5d475@suse.de>
Date: Fri, 20 Feb 2026 08:33:00 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: persistent device links
To: Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20260216122730.144092-1-hare@kernel.org>
 <aZfpCf5Vv0OaW7jN@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aZfpCf5Vv0OaW7jN@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 2/20/26 05:54, Ming Lei wrote:
> On Mon, Feb 16, 2026 at 01:27:30PM +0100, Hannes Reinecke wrote:
>> Implement a 'uuid' parameter to export a device UUID in a sysfs
>> attribute 'uuid'. This allows udev to create persistent device
>> links for ublk devices:
>>
>> KERNEL=="ublkb*", ATTRS{uuid}=="?*", SYMLINK+="disk/by-id/ublk-$attr{uuid}"
> 
> uuid is passed from ublk server, so the uniqueness has to be provided by
> ublk server.
> 
Correct.

> So far, the ublk device ID is guaranteed to be unique, can we export ublk
> device id instead?
> 
The device id is unique, but not persistent across reboots.
(Note the subject: _persistent_ device links ...)

If you have to reference the ublk device from some configuration tool
or automation framework (eg the nvmet json configuration) you have to
have a persistent ID to reference the device.
The UUID serves that purpose.
With the additional benefit that you can update the ublk target driver
to pick up an UUID defined on the target side, allowing for better
identification.
I was actually thinking of adding a 'serial' field with 256 bytes
in addtion to the UUID; then we could expose target identifications
(like the IQN for the iscsi target, or the NQN for nvme) directly.
But that seemed excessive.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE611EA7FC
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854413; cv=none; b=PbZN7nR4OJ4wp6BasMMwNUjEVPuZYPyIHTiOX5wCBCVqqAt022lfnl53bPurMU/id8DoB5TFzfXH4sZ9PCtLESkg6qvxlQLk6QlltKu8WqTHIC8hScVTf0xcSsTdTKH1WF1EjcIIZh/8e6RW7ddj0lzXLpOECmZbhWzEA/X+IVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854413; c=relaxed/simple;
	bh=UX7iuUz+BhSDRbPOJ+MIVjqIvQane5u90ZqV2Kqq6Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIRc/0l3JfSCpyC4XXanP9Bwrmp7FFwAkJF/t5YjBrKeHIvm6d4R4MiiqzQ9Pjv5rss7CeY5OTKtqJ7glQGuZzCpwZcOoqBb1uLHJ84Bm23V/TJx7tjquDXQhhiJhPGdCe2tqvSM0eXdpWTk3JXffXFWbGrciVhqcgD/dAq2lxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s6QPuZxW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OrN/xvZk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lO+RGv9j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p7lzEVQv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s6QPuZxW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OrN/xvZk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lO+RGv9j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p7lzEVQv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3EEF921180;
	Thu, 13 Mar 2025 08:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741854404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcLcvqz+uR00yB+iIZnLWaLpAp+lGE5SfqURGDDmPrA=;
	b=s6QPuZxWDIOzrqZCj80mMOsICwGCd64xmqDq9AwGpTUk//qO3epEzVzgY5eiwH7TomoCTm
	OoWzTAA1Prq5SkStEfdyFh5R61o6ggLrzIw6ADucfP8SO+DnXK6Sf428+FD0OGtTFOEFeo
	UhjsmZAdTbwkOnNAAemENHDssQXHMwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741854404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcLcvqz+uR00yB+iIZnLWaLpAp+lGE5SfqURGDDmPrA=;
	b=OrN/xvZk/mMIAC02EHTezyPLfw81X+qspMZRCqj08a7WG2wPEF2eMh2SfHonZXmDK4Y+NZ
	B4nqO8fZlm1CZ2CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741854403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcLcvqz+uR00yB+iIZnLWaLpAp+lGE5SfqURGDDmPrA=;
	b=lO+RGv9jt7oNdjCbhv+PsTmQELCQs1+GTFqaOaJKaVqCR6+4PgrqzB3chyPwC5qeM3mXV+
	Xxofj+/d+jYTItxJgpBd7gQz+pRJgxbr8vxNavvB1ECEqMXnzjxmmgny0ULX1cAwvQMspf
	W1Bx6FGFZVUAbnBArOXzIzQTF9LRaIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741854403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcLcvqz+uR00yB+iIZnLWaLpAp+lGE5SfqURGDDmPrA=;
	b=p7lzEVQvqtOpfSHWJvDLhXzhIQGfh2xLbwFS5riaYavSoM18lw7jAMxS8NmDPcORS4wwhL
	OAQObUjSG6mR5uCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 017B413797;
	Thu, 13 Mar 2025 08:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UehAOsGW0mdGJQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 13 Mar 2025 08:26:41 +0000
Message-ID: <5fd7a0de-d496-4430-a099-4c29e3c3f111@suse.de>
Date: Thu, 13 Mar 2025 09:26:41 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: add BLK_FEAT_LBS to check for PAGE_SIZE limit
To: Li Wang <liwang@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org,
 willy@infradead.org, david@fromorbit.com, djwong@kernel.org,
 kbusch@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 ltp@lists.linux.it, lkp@intel.com, oliver.sang@intel.com,
 oe-lkp@lists.linux.dev, gost.dev@samsung.com, p.raghav@samsung.com,
 da.gomez@samsung.com, kernel@pankajraghav.com
References: <20250312050028.1784117-1-mcgrof@kernel.org>
 <20250312052155.GA11864@lst.de> <Z9Edl05uSrNfgasu@bombadil.infradead.org>
 <20250312054053.GA12234@lst.de> <Z9EfKXH6w8C0arzb@bombadil.infradead.org>
 <CAEemH2du_ULgnX19YnCiAJnCNzAURW0R17Tgxpdy9tg-XzisHQ@mail.gmail.com>
 <20250312135912.GB12488@lst.de>
 <CAEemH2c_S_KMMQcyAp702N0DDBWrqOVxgz6GeS=RfVrUCJFE1Q@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAEemH2c_S_KMMQcyAp702N0DDBWrqOVxgz6GeS=RfVrUCJFE1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,fromorbit.com,oracle.com,gmail.com,vger.kernel.org,lists.linux.it,intel.com,lists.linux.dev,samsung.com,pankajraghav.com];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,linux.it:url]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 3/13/25 03:54, Li Wang wrote:
> 
> 
> On Wed, Mar 12, 2025 at 9:59 PM Christoph Hellwig <hch@lst.de 
> <mailto:hch@lst.de>> wrote:
> 
>     On Wed, Mar 12, 2025 at 05:19:36PM +0800, Li Wang wrote:
>      > Well, does that patch for ioctl_loop06 still make sense?
>      > Or any other workaround?
>      > https://lists.linux.it/pipermail/ltp/2025-March/042599.html
>     <https://lists.linux.it/pipermail/ltp/2025-March/042599.html>
> 
>     The real question is what block sizes we want to support for the
>     loop driver.  Because if it is larger than the physical block size
>     it can lead to torn writes.  But I guess no one cared about those
>     on loop so far, so why care about this now..
> 
> 
> That's because the kernel test-robot reports a LTP/ioctl_loop06 test
> fail in kernel commit:
>    47dd67532303803  ("block/bdev: lift block size restrictions to 64k")
> 
> The ioctl_loop06 is a boundary testing and always fail with
> LOOP_SET_BLOCK_SIZE set a value larger than PAGE_SIZE.
> But now it's set successfully unexpectedly.
> 
> If you all believe the boundary test for loopback driver is redundant,
> I can help remove that from LTP code.
> 
I would remove it.
Yes, we might incur torn writes, but previously we hadn't cared about 
that. And if we cared we should have a dedicated test for that; there's
no guarantee that we cannot have torn writes even with 4k blocks.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

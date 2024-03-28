Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1A4381B8
	for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615504; cv=none; b=GobG7+s8NMSJKMvsUfEEHdq++cGEUaDsIQAde1T88wAAqjPzQcoyPlo/rZH/RymDU7aQec8nZNJTTIb+iSo+0YnwsMXfFqYvb9aheOAnjuSP9OeYhKJrQnpAkDzMtKkTbweBO1Ydl+USDQy1wnSUeLT0ZZNxWCRZ2zb49QCEeTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615504; c=relaxed/simple;
	bh=QKx4lvGTWdM9+DUt6HhjW8b1FOxsYTLDmhNmQWsa3FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgVZ9sGaFQ8OTSmvC66DW77U3EfZmUK5QDQtI1Vdq/TpZxPl3a0DqXkSY7qksC0x0xcp1GBR8v8xGr/vFHLeBmHCWU42PLek0cXo5Vp+p7IR5CJh0XDRGy7CzZ3pDVDKnyk/AIu/QOGXK9o534LyWgqGPuoF6LKw1eT2sTeX0jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sDkWEKgP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W22wfyJw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sDkWEKgP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W22wfyJw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sDkWEKgP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W22wfyJw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sDkWEKgP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W22wfyJw"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D36C922C35;
	Thu, 28 Mar 2024 08:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711615500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McjNzVbWLVcLMxAv9J45iM+3v24Kb1Qbrj8kZmKwJbU=;
	b=sDkWEKgPoWPM6iPzsp6NxY7riDSaDf7gKl7PiUgFWKY0Ot73XKYsgXZEfWSbqpJbH+ZLjk
	6UWSqA9iMynSSZSJ0SWtbCVzMiDnZ3e579ywcNeivgJx2jgk9cbe2cydKInX2GlutAT1HZ
	LQtZ7ITSXOjDvRhMzvk/UDH/z0GhPz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711615500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McjNzVbWLVcLMxAv9J45iM+3v24Kb1Qbrj8kZmKwJbU=;
	b=W22wfyJwT/Fgk21CCM5gvBoGM7ichP3k53BVwxb5icZByBSNySyjih53s9CYiHQMVeK7ud
	kdeRLkpaCwWyK9Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711615500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McjNzVbWLVcLMxAv9J45iM+3v24Kb1Qbrj8kZmKwJbU=;
	b=sDkWEKgPoWPM6iPzsp6NxY7riDSaDf7gKl7PiUgFWKY0Ot73XKYsgXZEfWSbqpJbH+ZLjk
	6UWSqA9iMynSSZSJ0SWtbCVzMiDnZ3e579ywcNeivgJx2jgk9cbe2cydKInX2GlutAT1HZ
	LQtZ7ITSXOjDvRhMzvk/UDH/z0GhPz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711615500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McjNzVbWLVcLMxAv9J45iM+3v24Kb1Qbrj8kZmKwJbU=;
	b=W22wfyJwT/Fgk21CCM5gvBoGM7ichP3k53BVwxb5icZByBSNySyjih53s9CYiHQMVeK7ud
	kdeRLkpaCwWyK9Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BEA1713AB3;
	Thu, 28 Mar 2024 08:45:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tJ8SLQwuBWbpYAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 28 Mar 2024 08:45:00 +0000
Date: Thu, 28 Mar 2024 09:45:00 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, axboe@fb.com, 
	Gregory Joyce <gjoyce@ibm.com>
Subject: Re: [Bug Report] nvme-cli commands fails to open head disk node and
 print error
Message-ID: <j37ytzci46pqr4n7juugxyykd3w6jlwegwhfduh6jlp3lgmud4@xhlvuquadge4>
References: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
X-Spam-Score: -2.47
X-Spamd-Result: default: False [-2.47 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.67)[92.93%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Thu, Mar 28, 2024 at 12:00:07PM +0530, Nilay Shroff wrote:
> From the above output it's evident that nvme-cli attempts to open the disk node /dev/nvme0n3
> however that entry doesn't exist. Apparently, on 6.9-rc1 kernel though head disk node /dev/nvme0n3
> doesn't exit, the relevant entries /sys/block/nvme0c0n3 and /sys/block/nvme0n3 are present. 

I assume you are using not latest version of nvme-cli/libnvme. The
latest version does not try to open any block devices when scanning the
sysfs topology.

What does `nvme version` say?

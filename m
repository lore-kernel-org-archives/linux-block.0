Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637A13A250
	for <linux-block@vger.kernel.org>; Mon, 26 Aug 2024 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659142; cv=none; b=kGDWaD05PhR++xWFI8ldlHrhF8RachP9fBMpA6ZGjOhqHTIwrnvsnjvGfgYCis0kIp3cW4xdEY59bNVDJAkry+lmAKXEkXiPKP5Ev6fOFUTkKcbzUrgQmpDo7xsDnKFcN4o0Nc32M9f9LWZAjjLYkf8x0Nc6fVCE1D53Ic8ZvZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659142; c=relaxed/simple;
	bh=mpl+4dk1lTIMG1sUQ9PCAlKzWtVwLt3AQ/wWblfdjUo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F/PapVDWmSL2mVKn9wUvUEkq6wXmCu8pQlCxP6SPtcUuWRXNuhEZI25PZPlzErB0jhBqSHSNWlXNZcJCIgr8zCb1NY02q0ej0rEBZxexRFqlgtyNO3/1uJAGJGInwXU03AMq48BYxF05N6N6J5/bM2NHRPY6SPCirTYk5oMRRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YRBXdrIc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YRBXdrIc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YRBXdrIc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YRBXdrIc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 136521F842;
	Mon, 26 Aug 2024 07:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724659139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpl+4dk1lTIMG1sUQ9PCAlKzWtVwLt3AQ/wWblfdjUo=;
	b=YRBXdrIcgiGQUV7IV/Spqygo9MS0w1xp1sh9UpfkC1Sww12hNwu8vY5gWVHFSxHKd0jQX+
	/YyMJ5FqfWmNhpQPhfhiYKI2EDdxRNHe76RqgllPl81uUHQjITeBIrxQ8muPD/39Tuq9Gg
	NnHl35j3p+NrPqrPByJqhIoErSrZnng=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YRBXdrIc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724659139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpl+4dk1lTIMG1sUQ9PCAlKzWtVwLt3AQ/wWblfdjUo=;
	b=YRBXdrIcgiGQUV7IV/Spqygo9MS0w1xp1sh9UpfkC1Sww12hNwu8vY5gWVHFSxHKd0jQX+
	/YyMJ5FqfWmNhpQPhfhiYKI2EDdxRNHe76RqgllPl81uUHQjITeBIrxQ8muPD/39Tuq9Gg
	NnHl35j3p+NrPqrPByJqhIoErSrZnng=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C71341398D;
	Mon, 26 Aug 2024 07:58:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P6EFL8I1zGajUgAAD6G6ig
	(envelope-from <mwilck@suse.com>); Mon, 26 Aug 2024 07:58:58 +0000
Message-ID: <3be250bbaede895861092d055d9f49a71566a78f.camel@suse.com>
Subject: Re: [PATCH v2 3/3] nvme: add test for controller rescan under I/O
 load
From: Martin Wilck <mwilck@suse.com>
To: Nilay Shroff <nilay@linux.ibm.com>, Shin'ichiro Kawasaki
	 <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke
 <hare@suse.de>, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Date: Mon, 26 Aug 2024 09:58:58 +0200
In-Reply-To: <2a550653-89b4-4c3c-840a-a905152adb5f@linux.ibm.com>
References: <20240823200822.129867-1-mwilck@suse.com>
	 <20240823200822.129867-3-mwilck@suse.com>
	 <2a550653-89b4-4c3c-840a-a905152adb5f@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 136521F842
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

On Mon, 2024-08-26 at 11:07 +0530, Nilay Shroff wrote:
> >=20
> The "rand()" function in 'awk' returns a floating point value between
> 0 and 1 (i.e. [0, 1]). So it's possible to have sleep for some cases
> go
> upto ~5.1 seconds. So if the intention is to sleep between 0.1 and 5=20
> seconds precisely then we may want to use,
> =C2=A0
> sleep(0.1 + 4.9 * rand());
>=20

Yes, I know. I thought it didn't really matter as the 5s limit was
arbitrary anyway.

> However this is not a major problem and we may ignore.=20
> Otherwise, code looks good to me.
> =C2=A0=C2=A0=C2=A0=20
> Reviewed-by: Nilay Shroff (nilay@linux.ibm.com)
>=20

Thanks!
Martin


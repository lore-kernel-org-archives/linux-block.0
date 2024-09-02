Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2E19C540
	for <linux-block@vger.kernel.org>; Mon,  2 Sep 2024 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725285185; cv=none; b=SrrRHqMUi333dCfRLjM6HsPf0yNPvDyp2z689NaLSnmY+qzioWijcTYx3Rb/W8ihmLxXXo7rpFpADV4CbWcI5StLSwArtWC5ashtyUzbH2hEX+HnshdtnTLVNugrflPUq1rGvSfYpFr8hbaqLKAFvHuIDyI6mXSoT7xdk4werbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725285185; c=relaxed/simple;
	bh=qCAWccdUbVFfRk9YDDEmksSbeL0vVojk58srJkBL0v4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UL9I0mdp/qj58yZtksI6ORaZ0Lz6/CxeumZOgTYF85sS49Ev7Gt0tHv2FYMreF6lSnKpHxMa5o7ENl5Fj2CQiXIRHzMqr0rRe833461uI0x/C0MZjX5znTrxSO1W41TuU9DgjouOQZtm0Jm3qc8vornh2FYVY7v6TalhS2LdwZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sdJRRD30; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sdJRRD30; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sdJRRD30";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sdJRRD30"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 35A82219A6;
	Mon,  2 Sep 2024 13:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725285181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCAWccdUbVFfRk9YDDEmksSbeL0vVojk58srJkBL0v4=;
	b=sdJRRD30ESfyOEaPKriII3WhIU+0NMRi3uINbmjfeYn3skKJJ8F3MaxzIEKGGdu5/dhMvg
	PSxLBZh4JwRqwV+RYlSD1aYP9pur9FZhb7R+Nf0t/V89iN7uUEsAhR0CIY8na9nTBQ2wpX
	EQpghivvcMb7FCkyOe7j8Xd/BZv4riM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sdJRRD30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725285181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCAWccdUbVFfRk9YDDEmksSbeL0vVojk58srJkBL0v4=;
	b=sdJRRD30ESfyOEaPKriII3WhIU+0NMRi3uINbmjfeYn3skKJJ8F3MaxzIEKGGdu5/dhMvg
	PSxLBZh4JwRqwV+RYlSD1aYP9pur9FZhb7R+Nf0t/V89iN7uUEsAhR0CIY8na9nTBQ2wpX
	EQpghivvcMb7FCkyOe7j8Xd/BZv4riM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E82B913A7C;
	Mon,  2 Sep 2024 13:53:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hEqPNjzD1WZPKgAAD6G6ig
	(envelope-from <mwilck@suse.com>); Mon, 02 Sep 2024 13:53:00 +0000
Message-ID: <fa79e577a8883548d12a8932b7769af1db80c8b8.camel@suse.com>
Subject: Re: [PATCH v2 3/3] nvme: add test for controller rescan under I/O
 load
From: Martin Wilck <mwilck@suse.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>, 
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke
 <hare@suse.de>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Date: Mon, 02 Sep 2024 15:53:00 +0200
In-Reply-To: <57yxf7o7zcp4j34cfgk3glhmfag4ukvedzqgtr7fbqdmy2gvsq@t573offeg3kg>
References: <20240823200822.129867-1-mwilck@suse.com>
	 <20240823200822.129867-3-mwilck@suse.com>
	 <57yxf7o7zcp4j34cfgk3glhmfag4ukvedzqgtr7fbqdmy2gvsq@t573offeg3kg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 35A82219A6
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

On Thu, 2024-08-29 at 07:36 +0000, Shinichiro Kawasaki wrote:


> Shellcheck reports a warning here:
>=20
> =C2=A0 tests/nvme/053:47:9: warning: Prefer mapfile or read -a to split
> command output (or quote to avoid splitting). [SC2207]
>=20
> It is a bit lengthy, but let's replace the line above with this:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while read -r line ; do ctrls+=
=3D("$line"); done <
> <(_nvme_get_ctrl_list)

Thanks for the review. If you don't mind, I'll just use "mapfile -t",
as suggested by shellcheck.

Martin


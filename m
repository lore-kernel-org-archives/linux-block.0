Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5DC1865F7
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376044; cv=none; b=KYFFvvBg0UJmE0xb62piEK37nwxiG0qDlPYk09toBjuJTtUMKlVouvGTm7gi18StmVfdMBhQExgZKBXnYZzgIQ/lG5sKiauyYXjhW/ftqfyNTMF4SxymS6KV3DLJnDMLwyWLYzsOXf/ScPtKDSiZxoQnnISqt4oM5ZlVy44PC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376044; c=relaxed/simple;
	bh=Y7RoZE/XtO+/zqV0UBhHuKQpZuhqw8db3qylHm2cCFg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ELoCJoH7OUOLlHqxpEwPusAdrgqBBQlY3KrYKLqye12qCeYTbULx7UdWR8sJQbEBQGRtlXyzvHd219wzs7kZfOso7Vp1jVaDqOB9XX9K13ItPasa+GQhMOhpmgqDMuMWC4gbHW5DNAx++QNNBW8tAnsasS2ArUQiDmZV49hhwwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dzBsg3A0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dzBsg3A0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dzBsg3A0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dzBsg3A0"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AA1121A79;
	Tue,  3 Sep 2024 15:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725376040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7RoZE/XtO+/zqV0UBhHuKQpZuhqw8db3qylHm2cCFg=;
	b=dzBsg3A0RaHzbV8MtSeSAWNGaGaWe49+bjD7L5vMB/niwlU5HO1trSc1jtcUFaHh414m6n
	AYDOjLlKzu0Zd5dxYXrHR7esIOr3MA0qffc0VR9d/DwpcE/kJe1cmBRJlyW8jEBGosAE22
	52dZk0Ou0loHxb1i8AX9+MJkJaHcg8I=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dzBsg3A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725376040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7RoZE/XtO+/zqV0UBhHuKQpZuhqw8db3qylHm2cCFg=;
	b=dzBsg3A0RaHzbV8MtSeSAWNGaGaWe49+bjD7L5vMB/niwlU5HO1trSc1jtcUFaHh414m6n
	AYDOjLlKzu0Zd5dxYXrHR7esIOr3MA0qffc0VR9d/DwpcE/kJe1cmBRJlyW8jEBGosAE22
	52dZk0Ou0loHxb1i8AX9+MJkJaHcg8I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DA6113A80;
	Tue,  3 Sep 2024 15:07:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8Xl5DSgm12YCaAAAD6G6ig
	(envelope-from <mwilck@suse.com>); Tue, 03 Sep 2024 15:07:20 +0000
Message-ID: <2cf0066ad278cfa740d8c50f604ca686b0e3cfae.camel@suse.com>
Subject: Re: [PATCH v2 3/3] nvme: add test for controller rescan under I/O
 load
From: Martin Wilck <mwilck@suse.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>, 
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke
 <hare@suse.de>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Date: Tue, 03 Sep 2024 17:07:19 +0200
In-Reply-To: <vq34kiz6wkjmea6z2p2amqcypixattafudkjmiqh63atmsh2e7@tgz7tjdcvlbu>
References: <20240823200822.129867-1-mwilck@suse.com>
	 <20240823200822.129867-3-mwilck@suse.com>
	 <57yxf7o7zcp4j34cfgk3glhmfag4ukvedzqgtr7fbqdmy2gvsq@t573offeg3kg>
	 <fa79e577a8883548d12a8932b7769af1db80c8b8.camel@suse.com>
	 <vq34kiz6wkjmea6z2p2amqcypixattafudkjmiqh63atmsh2e7@tgz7tjdcvlbu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7AA1121A79
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

On Tue, 2024-09-03 at 00:16 +0000, Shinichiro Kawasaki wrote:
> On Sep 02, 2024 / 15:53, Martin Wilck wrote:
> > On Thu, 2024-08-29 at 07:36 +0000, Shinichiro Kawasaki wrote:
> >=20
> >=20
> > > Shellcheck reports a warning here:
> > >=20
> > > =C2=A0 tests/nvme/053:47:9: warning: Prefer mapfile or read -a to
> > > split
> > > command output (or quote to avoid splitting). [SC2207]
> > >=20
> > > It is a bit lengthy, but let's replace the line above with this:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while read -r line ; do ct=
rls+=3D("$line"); done <
> > > <(_nvme_get_ctrl_list)
> >=20
> > Thanks for the review. If you don't mind, I'll just use "mapfile -
> > t",
> > as suggested by shellcheck.
>=20
> The reason I did not suggest the "mapfile -t" solution was that
> SC2207
> recommends it for bash versions 4.4+ [1]. On the other hand, blktests
> README.md
> requires bash version >=3D 4.2. So I assume that some blktests users
> use bash
> version 4.2 or 4.3. I took a glance in the bash change history [2],
> and there
> are some mpafile related bug fixes between bash version v4.2 an v4.4.
> So I think
> it's the better to not use "mpafile -t" in blktests.

Sorry, I forgot the requirement to be compatible with bash 4.2.

> Do you have any specific reason to use "mapfile -t"?

Just the fact that the code looks simpler and more elegant.

Side note: as we know that _nvme_get_ctrl_list() prints paths from
sysfs, and that these won't contain spaces or glob characters, we might
as well just ignore SC2207 here.

Anyway, I agree that it's better to be on the safe side.
I'll send a new version.

Thanks,
Martin


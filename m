Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798FC1384B3
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395324; cv=none; b=u2fhqKaQnh3Pj1/RzLUxTbE+EcfzW0wj0BIm53OMuYNxUsBXiVc9PmGfTBbZWYuHMQUvT7ep/GSVA8nJfY/XAjUHAvjFKFaWT/lQTp+ADl91E5u8x08lEJDDsfAXoQ5FuOsIhTjkvYqev9FKYpYXCfYOyLo5IYQxbaKU865wNyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395324; c=relaxed/simple;
	bh=0Q6iC8AAEM6x8U5QUheuyg/0emm3wJXxHcffJBGTlUY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=McUjqEG6ScwQ2EnM9Y5I5FhooJ9fl/EtOIWurGWPAGxF6YdC1V9xHT6Smkq0jFUToY44AndKG/q85rqHjoElcottcJ5gmKMGXe/5Xff5SEmKi1K8Asr7lz+0r8WknRV4NkmMfL3/4ZM5T+5Res0CCX5FTVZe9iO9uykvpjeUKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ghtvD1RC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ghtvD1RC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ghtvD1RC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ghtvD1RC"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A3B6422604;
	Fri, 23 Aug 2024 06:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724395320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O76gv6Qm5vxd2udzUhSMYLJpK7PFfsoQ6kT5Sis+XBY=;
	b=ghtvD1RCQxUMGQ+XwwMoWWbzcjbyagAY1AIYWJgjgLsjG9VGM2A24gHDxlu93zFSYsfGTz
	ZiYjZBClNKO45U35oDtzn62XP12fUad0y1iD76dzrSueLYRpv8QD7rlOqyDCWB6zjPyX56
	bd8IbkccP7Hl+vAkLR6I6RHv9ddhQSE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724395320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O76gv6Qm5vxd2udzUhSMYLJpK7PFfsoQ6kT5Sis+XBY=;
	b=ghtvD1RCQxUMGQ+XwwMoWWbzcjbyagAY1AIYWJgjgLsjG9VGM2A24gHDxlu93zFSYsfGTz
	ZiYjZBClNKO45U35oDtzn62XP12fUad0y1iD76dzrSueLYRpv8QD7rlOqyDCWB6zjPyX56
	bd8IbkccP7Hl+vAkLR6I6RHv9ddhQSE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67ABF1333E;
	Fri, 23 Aug 2024 06:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wHxaFzgvyGZWagAAD6G6ig
	(envelope-from <mwilck@suse.com>); Fri, 23 Aug 2024 06:42:00 +0000
Message-ID: <1106fb07918468cb8cacb35ef0448573ec7be156.camel@suse.com>
Subject: Re: [PATCH 1/3] blktests: nvme: skip passthru tests on multipath
 devices
From: Martin Wilck <mwilck@suse.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni
	 <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Date: Fri, 23 Aug 2024 08:41:59 +0200
In-Reply-To: <d1282549-f037-4556-93f7-adb3d890db82@flourine.local>
References: <20240822193814.106111-1-mwilck@suse.com>
	 <d1282549-f037-4556-93f7-adb3d890db82@flourine.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -8.30
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 2024-08-23 at 08:35 +0200, Daniel Wagner wrote:
> On Thu, Aug 22, 2024 at 09:38:12PM GMT, Martin Wilck wrote:
> > +_require_test_dev_is_nvme_no_mpath() {
> > +	if [[ "$(readlink -f "$TEST_DEV_SYSFS/device")" =3D~ /nvme-
> > subsystem/ ]]; then
> > +		SKIP_REASONS+=3D("$TEST_DEV is a NVMe multipath
> > device")
> > +		return 1
> > +	fi
> > +	return 0
> > +}
>=20
> Just a nit: what about _require_test_dev_is_native_multipath?

The intention was to require a device that is _not_ a native multipath
device. Change it to "_require_test_dev_is_not_native_multipath"?

Thanks,
Martin


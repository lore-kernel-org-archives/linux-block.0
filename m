Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C735757F3
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823470; cv=none; b=kjJrg3Vc/MMCPFGxMoyW7D7F0iJMQf2VugQyML6WCqCTO25Z9m91JxiHkgXFlM+fimvFHMzCV4HGVbMxck3tOF6rYBSSREDOKHOvdGp5bw275gWzLKGBNTSRbCQLY1Y+ggf4+DeMgTRGfm8B/dyC9fTv7VkBFuCEeKgcijkLP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823470; c=relaxed/simple;
	bh=CBKhA5PauHnrq6Jwvq87pavmzFkosbPL4h5v2t/lqHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UzH772C0lb4qlZITSDfYWenG5Dp2D1S1coopaSsRryADRg0SsMhJY2/Hi2OOHPOdbGnXKW0d/1mWdeaxQxAihVfslql27XFrUfzNVGx8+10Ugepf6zQaVvCIOag/jzUgQKuIygI9BZBS+lh+KIthdzdVs1kwDzWooOvN5otCrCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ky2aX3Gj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lkT65Wv2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sPUWS3oY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xs5IvIOv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ky2aX3Gj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lkT65Wv2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sPUWS3oY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xs5IvIOv"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3F3721236;
	Mon, 28 Apr 2025 06:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745823467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgNTpla/eVTSK3c6+t4N5PhYKXLrFDZGLkic6/+ymk0=;
	b=Ky2aX3GjunwBFROHQ07ljMuqpLZ3anL17G2qsVNR0hfO+nTN3D9DEZPumhbkn00CrfB9HC
	DLfzNyQyy82+gDqfWqo5bKVPpHKuYxisjL3n0plKwN14QhmRbHUfbeuihzGHVBDuOgHsuX
	tBYWmIL3EDbW8qOr3ZCNYVTvzWv/Jgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745823467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgNTpla/eVTSK3c6+t4N5PhYKXLrFDZGLkic6/+ymk0=;
	b=lkT65Wv2t/lpzhzuaXwv3zWLgs6UBFbak0XiObdSmbj8J1EVD8G4QxNDUgLy6JuG8Gdhmi
	DdvC5m/5qDL8eABg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sPUWS3oY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Xs5IvIOv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745823466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgNTpla/eVTSK3c6+t4N5PhYKXLrFDZGLkic6/+ymk0=;
	b=sPUWS3oYU4Lqh544BmyK5LVrgjw9y/0EcxKqCTFsy11h+pcWOSCS8JMLqMmg1xQuzxXCIi
	KHSN+vPMB6Z1UGlve3nxMqaKspTWuxt4inJW+fgpcJgH1B+fUA7K9SjNk8QNj3oC3nEVAW
	nCp/UuX0HvpZWnveuw+DlGDk9C4+V3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745823466;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgNTpla/eVTSK3c6+t4N5PhYKXLrFDZGLkic6/+ymk0=;
	b=Xs5IvIOvvg/S5ghaB96ZVKyWIMfP5VIMuyMtTpFMko59L80xb3YyQgXJRoWzXAacFvaefM
	SAuPiuIfOWcP2eAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76C6F13A25;
	Mon, 28 Apr 2025 06:57:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id deLoGuomD2jXYgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 28 Apr 2025 06:57:46 +0000
Message-ID: <38a93938-8a9c-4d6a-9f74-af1aa957fd74@suse.de>
Date: Mon, 28 Apr 2025 08:57:41 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 2/3] nvme: introduce multipath_head_always module
 param
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, jmeneghi@redhat.com,
 axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250425103319.1185884-1-nilay@linux.ibm.com>
 <20250425103319.1185884-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250425103319.1185884-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E3F3721236
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/25/25 12:33, Nilay Shroff wrote:
> Currently, a multipath head disk node is not created for single-ported
> NVMe adapters or private namespaces. However, creating a head node in
> these cases can help transparently handle transient PCIe link failures.
> Without a head node, features like delayed removal cannot be leveraged,
> making it difficult to tolerate such link failures. To address this,
> this commit introduces nvme_core module parameter multipath_head_always.
> 
> When this param is set to true, it forces the creation of a multipath
> head node regardless NVMe disk or namespace type. So this option allows
> the use of delayed removal of head node functionality even for single-
> ported NVMe disks and private namespaces and thus helps transparently
> handling transient PCIe link failures.
> 
> By default multipath_head_always is set to false, thus preserving the
> existing behavior. Setting it to true enables improved fault tolerance
> in PCIe setups. Moreover, please note that enabling this option would
> also implicitly enable nvme_core.multipath.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/multipath.c | 70 +++++++++++++++++++++++++++++++----
>   1 file changed, 63 insertions(+), 7 deletions(-)
> 
I really would model this according to dm-multipath where we have the
'fail_if_no_path' flag.
This can be set for PCIe devices to retain the current behaviour
(which we need for things like 'md' on top of NVMe) whenever the
this flag is set.

And it might be an idea to rename this flag to 'multipath_always_on',
so 'multipath_head_always' might be confusing for people not familiar
with the internal layout of the nvme multipath driver.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

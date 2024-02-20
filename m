Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460F55C5F1
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416193; cv=none; b=XoadKpcbM1pxG5ybqNkwcZQ2BK0Peh+cVMsnTFkDtgBzbfhTmYl7fVAaBjznJKnMHA+5PjFf76QPSK0TV4IEUBzRl1MVOU6pONEXh10Ay1On1O39ADhkaf5pS74hoLCxI05yruqN4yFBRDM83a8R3AzLhL/jutWihEbDuqS1Rjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416193; c=relaxed/simple;
	bh=mr21xhkG3qgRO9+utKyBGmCXh7jSmpXUVcw0cocXVMI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=OTIbRQAiU+5Jg3+IS01/Nla/jEhSdD946DfKRoHfMajMCGMGzgBhqUxJQKtrZg464fLOXAVZohWO8/tykOcf5BwcnKua4KYcrMw1pBHNhCpkZ+IvpoeKzpf7qIrdB7R4zGDj1RIHJAm3UplyYwTiLOt3hI5KO79/SnOAxxWXUek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=awqG6s9r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/kU5xjhf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=awqG6s9r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/kU5xjhf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="awqG6s9r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/kU5xjhf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="awqG6s9r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/kU5xjhf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6661D21FB3;
	Tue, 20 Feb 2024 08:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708416189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IuVcZkBm2zR7uVQ9DesXBwScKqqzvrFVA/hmHbxat2M=;
	b=awqG6s9ri3OEw53aD2NGrCB1sGs77GBG57p7jlFvmH+ogALyHzJKLhQ4KIBaZH//YzyrGm
	6tVJa/YMcLjTWbO+54qfFc+mGDXzrmTH19QwzgxqbbbCsaJk2q6c5BgO6ONIPvJdTfVcRn
	lNSatLPEaTCGPqx5dxzu5S6ixopRwtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708416189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IuVcZkBm2zR7uVQ9DesXBwScKqqzvrFVA/hmHbxat2M=;
	b=/kU5xjhfck9TmdzklGGlKPgRRu4tDyKbWSPeqs1uQ8XeAORqAs+oR6GO+OG6t7Vxf4zuCq
	HbJCkspv/atQhMCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708416189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IuVcZkBm2zR7uVQ9DesXBwScKqqzvrFVA/hmHbxat2M=;
	b=awqG6s9ri3OEw53aD2NGrCB1sGs77GBG57p7jlFvmH+ogALyHzJKLhQ4KIBaZH//YzyrGm
	6tVJa/YMcLjTWbO+54qfFc+mGDXzrmTH19QwzgxqbbbCsaJk2q6c5BgO6ONIPvJdTfVcRn
	lNSatLPEaTCGPqx5dxzu5S6ixopRwtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708416189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IuVcZkBm2zR7uVQ9DesXBwScKqqzvrFVA/hmHbxat2M=;
	b=/kU5xjhfck9TmdzklGGlKPgRRu4tDyKbWSPeqs1uQ8XeAORqAs+oR6GO+OG6t7Vxf4zuCq
	HbJCkspv/atQhMCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03777134E4;
	Tue, 20 Feb 2024 08:03:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RhaPObxc1GXRUAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 20 Feb 2024 08:03:08 +0000
Message-ID: <1817f06c-5b56-4646-b631-9887cd28aba4@suse.de>
Date: Tue, 20 Feb 2024 09:03:08 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM BPF TOPIC] NUMA topology metrics for NVMe-oF
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=awqG6s9r;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/kU5xjhf"
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[43.88%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 TO_DN_EQ_ADDR_ALL(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.30
X-Rspamd-Queue-Id: 6661D21FB3
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

Hi all,

having recently played around with CXL I started to wonder which 
impllication that would have for NVMe-over-Fabrics, and how the path 
selection would play out on such a system.

Thing is, with heavy NUMA systems we really should have a look at
the inter-node latencies, especially as the HW latencies are getting
closer to the NUMA latencies: for an Intel two socket node I'm seeing
latencies of around 200ns, and it's not unheard of getting around 5M 
IOPS from the device, which results in a latency of 2000ns.
And that's on PCI4.0. With PCI5 or CXL one expects the latency to 
decrease even further.

So I think that we should need to look at factor in the NUMA topology
for PCI devices, too. We do have a NUMA I/O policy, but that only looks
at the latency between nodes.
What we're missing is a NUMA latency for the PCI devices themselves.

So this discussion would be around how we could model (or even measure)
the PCI latency, and how we could modify the NVMe-oF iopolicies to take 
the NUMA latencies into account when selecting the 'best' path.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

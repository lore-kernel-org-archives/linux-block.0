Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236598;
	b=yE62+Y4+NlWx9OLiNkwejxYSdgNNo9qwxUUdAF6yFEP1zwnHdGOa4SrAJ1oq+K+mb7x9
	 IYQlfiZSvek1w+k7Z7BY75Jx5lnsn/4i21U+JZ+aLKMcSCjpKveOEaoa0x73A4wEZpHq2
	 ZMm+LiAzwf8TuHvA3+KIM7WESRodq7AUQo5+I5UCGT5J0+piAbOlbgu4aeSSi7C+CfQfD
	 jCg6uD8jFD8ZM8ldTWymjJTT6xs9G10AKQjJqU+9TCjbhk4GLPMZdTbor2faWtY91JjY9
	 NpSCj/Ep9X92UOGT59n4YI/WcEm8gCpsfkktKGlrUaXPOnzQAUxjuEjxva67KpacD8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236598;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=zL34hpemwJ/qzvEYRIvykQ1ao1Jd830rA1cvrqq9dGk=;
	b=rn4r2svL4ncAFKFo0Rv7CB7CiAUWxgSsVUwnre7CZWrWOyWcC/cRB4jxl0qSW5ThCauc
	 SqAcPl+m+awFj33ojt6dboAptm4seCxonXv7UrzVxAnQ9mw1I/UsNQs/LV4wgXythHZzR
	 6MRHe63DkBHqcxmSZzWB3TCHMOpwNRw3gKrQ9xKh2YQI246Iv3cHfY6uLcqCfblVXT/bv
	 G7kqFhb1rf5pH6y4gWRDdPt3xDXPiFyPXMYkuHWPk6l4NVWnpSr3ORnxo6zh+Nf3bNNkR
	 OqKYPmKIBTNXBn++KJPV4eTQqscEkc5J3Q/INivlr16N/K86udmsUKXWOytlyGwVfDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ftuNy+gd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="o6WhJ4/r";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ftuNy+gd;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="o6WhJ4/r";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CEB606A333
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 15:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72CEB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ftuNy+gd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=o6WhJ4/r;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ftuNy+gd;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=o6WhJ4/r
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E6131FACA
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794236595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zL34hpemwJ/qzvEYRIvykQ1ao1Jd830rA1cvrqq9dGk=;
	b=ftuNy+gdqMn+kJH8jq56ktPG5QzSGsGfLS9pszazxsIh0vDkPEYxFEZsYl7L376e3wrgD8
	Yi1kbCh7//seRNNHUeXmJ1PHlysoQ7YhD2y6pIc54xqAm6RucO3+oCg9UCZtIAJ2gUbwiz
	ifH5ozMOscpnh0EoKVzj5n6LC3LbE2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794236595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zL34hpemwJ/qzvEYRIvykQ1ao1Jd830rA1cvrqq9dGk=;
	b=o6WhJ4/rvazCPTzvrgYx8o8WGLH7ymiHZ74LQpCXx6dK+Mj6mds6K/hpRpWHLVNWkqEbFm
	BASpgcbGlSiAy3Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ftuNy+gd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="o6WhJ4/r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794236595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zL34hpemwJ/qzvEYRIvykQ1ao1Jd830rA1cvrqq9dGk=;
	b=ftuNy+gdqMn+kJH8jq56ktPG5QzSGsGfLS9pszazxsIh0vDkPEYxFEZsYl7L376e3wrgD8
	Yi1kbCh7//seRNNHUeXmJ1PHlysoQ7YhD2y6pIc54xqAm6RucO3+oCg9UCZtIAJ2gUbwiz
	ifH5ozMOscpnh0EoKVzj5n6LC3LbE2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794236595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zL34hpemwJ/qzvEYRIvykQ1ao1Jd830rA1cvrqq9dGk=;
	b=o6WhJ4/rvazCPTzvrgYx8o8WGLH7ymiHZ74LQpCXx6dK+Mj6mds6K/hpRpWHLVNWkqEbFm
	BASpgcbGlSiAy3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48B7713302
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 15:03:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FDZACbPg8WrFDgAAD6G6ig
	(envelope-from <hare@suse.de>)
	for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 15:03:15 +0000
Message-ID: <991e263b-4513-4cba-927c-94ff725806a1@suse.de>
Date: Mon, 9 Nov 2026 16:03:14 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Automated commit blacklisting
To: linux-block@vger.kernel.org
References: <94510397-fef7-4856-a8cf-c9f5d9dd0ed8@suse.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <94510397-fef7-4856-a8cf-c9f5d9dd0ed8@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E6131FACA
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-block@vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50

On 11/9/26 3:45 PM, Hannes Reinecke wrote:
> Hey all,
> 
Sheesh.

Sorry.

Was not meant for this list (obviously).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
